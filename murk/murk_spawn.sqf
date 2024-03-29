// File: murk_spawn.sqf
// Function: To allow for simple trigger based spawning using editor placed
// units and waypoints. The script deletes all units when the mission start and
// the recreate them on command.
//
// Parameters:
//  _this select 0: OBJECT - unit name (this)
//      _this select 1: BOOL - use F3 assigngear?
//      _this select 2: STRING - spawn type ("once","repeated","wave" and "reset")
//      _this select 3 (optional): NUMBER - spawn lives (the amount of time the
//                     unit respawns, or wave number)
//      _this select 4 (optional): NUMBER - spawn delay
//      _this select 5 (optional): STRING - init string called for the leader
//                     of the group
//      _this select 6 (optional): NUMBER-  will start removal sequence of all
//                     dead group members after X seconds (default 120)
//      _this select 7 (optional): NUMBER-  will auto-delete units when
//                     waypoint reached if no player is within X distance
//                     (default 0 = DISABLED)
// Usage:
//  Example
//
//  Trigger:
//  Anybody Once (or whatever you want),
//  onActivation: triggername setVariable ["murk_spawn",true,true];
//
//  Unit (leader of group):
//  nul = [this,F3GEAR,"SPAWNTYPE",LIVES,DELAY,"SL INIT",DEADDELETETIME,NOPLAYERDELETEDIST] execVM "murk\murk_spawn.sqf";
//
// Example:
//  nul = [this,true,"once"] execVM "murk\murk_spawn.sqf";
//  Will spawn the editor unit once based on the trigger
//
//  nul = [this,true,"repeated",4,30] execVM "murk\murk_spawn.sqf";
//  Will spawn the editor unit based on the trigger, then respawn it 4 times
//  with a 30 second delay upon death
//
//  nul = [this,true,"wave",5,60] execVM "murk\murk_spawn.sqf";
//  Will spawn the editor unit once based on the trigger, then respawn the
//  entire group (regardless of deaths) 5 times with 60 seconds between
//
//  nul = [this,true,"reset",5] execVM "murk\murk_spawn.sqf";
//  Will spawn the editor unit once based on the trigger, then reset the
//  trigger after a preset time (15 seconds default). The unit will be created
//  when trigger is true again, maximum number of lives.
//
//  nul = [this,true,"repeated",4,90,"",120,300] execVM "murk\murk_spawn.sqf";
//  Same as example 2, but will automatically delete units when last waypoint
//  is reached and no players are within 300m. IF players return, squad
//  respawns from their beginning.
// -----------------------------------------------------------------------------
// V10 (klausman)
// - Massive reformat and overhaul
// - Added HC-awareness
// V9.PA_1 (Captainblaffer)
// - Changes for PA
// V9.? Working Build (Wulfy Wulf)
// - Change: unitInfoArray handles uniforms, vests, backpacks, and objects
//   within now
// - Fix: Some RPT errors from incorrect conditions not entering or terminating
//   properly
// - Fix: Some RPT errors from spawnUnit initializing to Object- uses null now
// V9 (Murklor again :p)
// - Note: Initial Arma 3 test script. Note that some functionality from V8/V7
//   has been taken out because my brain is too foggy to understand everything,
//   this is simplified. Sort of.
// - Fix: setVehicleInit has been removed from A3, testing another way
// - Add: New example mission on Stratis
// - Change: The trigger variable is held in the object that is synchronized to
//   the group for improved WYSIWYG. This means that the trigger argument is no
//   longer needed.
// - Change: Updated this readme to reflect the changes
// V8 (ArmAIIholic)
// - Waypoints are also remembered -- no dummy groups at all!!!
// - You get the output on Clipboard you can paste and execute. Added loader
//   for Clipboard missions.
// V7 (ArmAIIholic)
// - Added GameLogic center to reduce number of dummy groups at the beginning,
//   and in modes repeated and reset
// - Changed beginning scope to isServer, rather than using exitWith
// - Shortened initializing trigger part in init.sqf
// - Added original instructions and examples, adapted for v7
// - SQM is from v5 with some groups added
// V6
// - See older versions

// This script is serverside
if(!isServer) exitwith{};

params [
    "_unit",
    "_f3Gear",
    "_spawntype",
    ["_spawnlives", 1],
    ["_spawndelay", 1],
    ["_initstring", ""],
    ["_bodyremove", 360],
    ["_autoDeleteDist", 0]
];

private ["_countWaypoints", "_debug", "_waitingPeriod", "_waypointsArray"];

scriptName "murk/murk_spawn.sqf";

// Init
_waitingPeriod = 8;  // Waiting period between script refresh
_debug = false;

// The object (trigger, whatever) the unit is synchronized to hold the trigger
// variable
private _triggerObject = (synchronizedObjects _unit) select 0;

if (isnil "_triggerObject") then {
    // Always log, ...
    ["Murk-Spawn", "The trigger object for %1 is not defined.", _unit] call mc_fnc_bothlog;
    // ... but only mark things on the map if debugging is on
    if (_debug) exitWith {
        private _mname = format ["mstestmrk_%1",_unit];
        // From the Biki:
        // - local commands avoid network messages
        // - using a global command makes a marker global, with all local
        //   attributes broadcast in one network message.
        // So do everything local and then use one global command to broadcats
        // the whole thing.
        createMarkerLocal [_mname,(position _unit)];
        _mname setMarkerColorLocal "ColorRed";
        _mname setMarkerShapeLocal "ICON";
        _mname setMarkerTypeLocal "mil_dot";
        _mname setMarkerText format ["Missing trigger for %1", _unit];
    };
};
_triggerObject setVariable ["murk_spawn", false, false];

// Delete the unit (this is always done ASAP)
private _unitArray = [];
private _unitGroup = group _unit;
private _unitsInGroupAdd = [];
private _side = side _unitGroup;
private _grpHCBL = _unitGroup getVariable ["acex_headless_blacklist", false];
["Murk-Spawn", "Murk'd group %1 has HCBL status %2", _unitGroup, _grpHCBL] call mc_fnc_rptlog;

while { count units _unitGroup > 0 } do {
    // The currently worked on unit
    private _unitsInGroup = units _unitGroup;
    private _unit = _unitsInGroup select 0;
    ["Murk-Spawn", "Handling unit %1, units left: %2", _unit, count units _unitGroup
        ] call mc_fnc_rptlog;
    // Check if it's a vehicle
    if ( (vehicle _unit) isKindOf "LandVehicle" OR (vehicle _unit) isKindOf "Air") then {
        private _vcl = vehicle _unit;
        if (!(_vcl in _unitsInGroupAdd) AND (typeOf _vcl != "")) then {
            _unitsInGroupAdd set [count _unitsInGroupAdd, _vcl];
            private _unitCrewArray = [];
            private _crew = crew _vcl;
            {
                _unitCrewArray set [count _unitCrewArray, typeOf _x];
            } forEach _crew;

            private _unitInfoArray = [
                typeOf _vcl,
                getPos _vcl,
                getDir _vcl,
                vehicleVarName _vcl,
                skill _vcl,
                rank _vcl,
                _unitCrewArray,
                weapons _vcl,
                assignedItems _vcl,
                uniform _vcl,
                uniformItems _vcl,
                vest _vcl,
                vestItems _vcl,
                backpack _vcl,
                backpackItems _vcl,
                headgear _vcl,
                goggles _vcl,
                face _vcl,
                _vcl getVariable["acex_headless_blacklist", false]
            ];
            _unitArray set [count _unitArray, _unitInfoArray];
            deleteVehicle _vcl;
            { deleteVehicle _x; } forEach _crew;
        };
    } else {
        // Otherwise it's infantry
        private _unitInfoArray = [
            typeOf _unit,
            getPos _unit,
            getDir _unit,
            vehicleVarName _unit,
            skill _unit,
            rank _unit,
            [],
            weapons _unit,
            assignedItems _unit,
            uniform _unit,
            uniformItems _unit,
            vest _unit,
            vestItems _unit,
            backpack _unit,
            backpackItems _unit,
            headgear _unit,
            goggles _unit,
            face _unit,
            _unit getVariable["acex_headless_blacklist", false]
        ];

        _unitArray set [count _unitArray, _unitInfoArray];
        deleteVehicle _unit;
    };
    sleep 0.01;
};

// Gathering waypoints
_countWaypoints = 0;
_waypointsArray = [];
_countWaypoints = count(waypoints _unitGroup);

for "_i" from 0 to _countWaypoints do {
    private _wppos =  waypointPosition [_unitGroup, _i];
    if (_wppos isEqualTo [0,0,0]) then {
        ["Murk-Spawn", "Group %1 waypoint %2 is 000, dropping", _unitGroup, _i
            ] call mc_fnc_rptlog;
    } else {
        private _waypointsEntry = [
            waypointPosition [_unitGroup, _i],
            waypointHousePosition [_unitGroup, _i],
            waypointBehaviour [_unitGroup, _i],
            waypointCombatMode [_unitGroup, _i],
            waypointCompletionRadius [_unitGroup, _i],
            waypointDescription [_unitGroup, _i],
            waypointFormation [_unitGroup, _i],
            waypointScript [_unitGroup, _i],
            waypointShow [_unitGroup, _i],
            waypointSpeed [_unitGroup, _i],
            waypointStatements [_unitGroup, _i],
            waypointTimeout [_unitGroup, _i],
            waypointType [_unitGroup, _i],
            waypointName [_unitGroup, _i]
        ];
        _waypointsArray pushBack _waypointsEntry;
    };
};

if (_debug) then {
    ["Murk-Spawn", "Waypoints: %1", _waypointsArray] call mc_fnc_rptlog;
};

deleteGroup _unitGroup;

// Functions

// *WARNING* BIS FUNCTION RIPOFF - Taken from fn_returnConfigEntry as its
// needed for turrets and shortened a bit
private _fnc_returnConfigEntry = {
    params ["_config", "_entryname"];
    private ["_entry", "_value"];
    _entry = _config >> _entryName;
    // If the entry is not found and we are not yet at the config root, explore
    // the class' parent.
    if (((configName (_config >> _entryName)) == "") && (!((configName _config) in ["CfgVehicles", "CfgWeapons", ""]))) then {
        [inheritsFrom _config, _entryName] call _fnc_returnConfigEntry;
    } else {
        if (isNumber _entry) then {
            _value = getNumber _entry;
        } else {
            if (isText _entry) then {
                 _value = getText _entry;
            };
        };
    };
    // Make sure returning 'nil' works.
    if (isNil "_value") exitWith {nil};
    _value;
};

// *WARNING* BIS FUNCTION RIPOFF - Taken from fn_fnc_returnVehicleTurrets and
// shortened a bit
private _fnc_returnVehicleTurrets = {
    params ["_entry"];
    private ["_turrets", "_turretIndex"];
    _turrets = [];
    _turretIndex = 0;
    // Explore all turrets and sub-turrets recursively.
    for "_i" from 0 to ((count _entry) - 1) do {
        private ["_subEntry"];
        _subEntry = _entry select _i;
        if (isClass _subEntry) then {
            private ["_hasGunner"];
            _hasGunner = [_subEntry, "hasGunner"] call _fnc_returnConfigEntry;
            // Make sure the entry was found.
            if (!(isNil "_hasGunner")) then {
                if (_hasGunner == 1) then {
                    _turrets pushBack _turretIndex;
                    // Include sub-turrets, if present.
                    if (isClass (_subEntry >> "Turrets")) then {
                        // This recursive call may retunr either a turret, or
                        // an array of them, so we can't use pushBack easily.
                        _turrets = _turrets + [[_subEntry >> "Turrets"] call _fnc_returnVehicleTurrets];
                    } else {
                        _turrets pushBack [];
                    };
                };
            };
            _turretIndex = _turretIndex + 1;
        };
    };
    _turrets;
};

private _fnc_moveInTurrets = {
    params ["_turrets", "_path", "_currentCrewMember", "_crew", "_spawnUnit"];
    private _i = 0;
    while {_i < (count _turrets) AND _currentCrewMember < count _crew} do {
        private _turretIndex = _turrets select _i;
        private _thisTurret = _path + [_turretIndex];
        (_crew select _currentCrewMember) moveInTurret [_spawnUnit, _thisTurret];
        _currentCrewMember = _currentCrewMember + 1;
        // Spawn units into subturrets.
        [_turrets select (_i + 1), _thisTurret, _currentCrewMember, _crew, _spawnUnit] call _fnc_moveInTurrets;
        _i = _i + 2;
    }
};

// This is the general cleanup function running in the background for the
// group, replaces the removebody eventhandler and delete group in V5
private _fnc_cleanGroup = {
    params ["_group", "_sleep"];
    private _unitsGroup = units _group;
    // Hold until the entire group is dead
    while { ({alive _x} count _unitsGroup) > 0 } do { sleep 5; };
    sleep _sleep;
    {
        private _origPos = getPos _x;
        private _z = _origPos select 2;
        private _desiredPosZ = if ( (vehicle _x) iskindOf "Man") then {
             (_origPos select 2) - 0.5
        } else {
            (_origPos select 2) - 3
        };
        if ( vehicle _x == _x ) then {
            _x enableSimulation false;
            while { _z > _desiredPosZ } do {
                _z = _z - 0.01;
                _x setPos [_origPos select 0, _origPos select 1, _z];
                sleep 0.1;
            };
        };
        deleteVehicle _x;
        sleep 5;
    } forEach _unitsGroup;
    // Now we know that all units are deleted
    deleteGroup _group
};

 // This deletes group when waypoint reached and no players nearby
private _fnc_autoDeleteGroup = {
    params ["_group", "_sleep", "_dist", "_wpPos", "_triggerObject"];
    private["_unitsGroup", "_nearWP", "_pNear"];
    _unitsGroup = units _group;
    _nearWP = false;
    _pNear = true;
    // Hold until the entire group is dead
    while { ({alive _x} count _unitsGroup) > 0 } do {
        sleep 5;
        if (_wpPos distance (Getpos leader _group)<125) then {
            _nearWP = true;
        };
        if (_nearWP) then {
            _pNear = [leader _group, _dist] call f_fnc_nearPlayer;
        };
        if (!_pNear) exitWith {_sleep = 0;};// no players near? delete group!
    };
    sleep _sleep;
    _sleep = 5;
    if (!_pNear) then {_sleep = 0};
    {
        private _origPos = getPos _x;
        private _z = _origPos select 2;
        private _desiredPosZ = if ( (vehicle _x) iskindOf "Man") then {
            (_origPos select 2) - 0.5
        } else {
            (_origPos select 2) - 3
        };
        if ( (vehicle _x == _x) && _pNear ) then {
            _x enableSimulation false;
            while { _z > _desiredPosZ } do {
                _z = _z - 0.01;
                _x setPos [_origPos select 0, _origPos select 1, _z];
                sleep 0.1;
            };
        };
        deleteVehicle _x;
        sleep _sleep;
    } forEach _unitsGroup;
    // Now we know that all units are deleted
    _triggerObject setVariable ["murk_spawn",false,false];
    deleteGroup _group;
};

private _fnc_spawnUnit = {
    // We need to pass the old group so we can copy waypoints from it, the rest
    // we already know
    params ["_oldgroup", "_side", "_waypointsArray","_grpHCBL"];
    private _newGroup = createGroup _side;
    // Disable ACEX Headless messing with this group until we're done
    ["Murk-Spawn", "Adding new group %1 to ACEX Headless blacklist during setup", _newgroup
        ] call mc_fnc_rptlog;
    _newGroup setVariable ["acex_headless_blacklist", true];
    // If the old group doesnt have any units in it its a spawned group rather
    // than respawned
    if ( count (units _oldGroup) == 0) then {
        deleteGroup _oldGroup;
    };

    {
        // TODO(klausman): Wouldn't it be possible to use get/setUnitLoadout
        // here?
        private _spawnUnit = nil;
        private _unitType = _x select 0;
        private _unitPos  = _x select 1;
        private _unitDir  = _x select 2;
        private _unitName = _x select 3;
        private _unitSkill = _x select 4;
        private _unitRank = _x select 5;
        private _unitCrew = _x select 6;
        private _unitWeapons = _x select 7;
        private _unitItems = _x select 8;
        private _unitUniform = _x select 9;
        private _unitUniformItems = _x select 10;
        private _unitVest = _x select 11;
        private _unitVestItems = _x select 12;
        private _unitBackpack = _x select 13;
        private _unitBackpackItems = _x select 14;
        private _unitHeadgear = _x select 15;
        private _unitGoggles = _x select 16;
        private _unitFace = _x select 17;
        private _unitHCBL = _x select 18; // Headless Client blacklist
        // Check if the unit has a crew, if so we know its a vehicle
        if (count _unitCrew > 0) then {
            if (_unitPos select 2 >= 10) then {
                _spawnUnit = createVehicle [_unitType,_unitPos, [], 0, "FLY"];
                _spawnUnit setPos _unitPos;
                _spawnUnit setVelocityModelSpace [0, 150, 0];
            } else {
                _spawnUnit = _unitType createVehicle _unitPos;
            };
            _spawnUnit setVariable ["acex_headless_blacklist", _unitHCBL];
            ["Murk-Spawn", "New vehicle %1 HCBL status: %2", _spawnUnit, _unitHCBL] call mc_fnc_rptlog;
            // Create the entire crew
            private _crew = [];
            {
                private _unit = _newGroup createUnit [_x, getPos _spawnUnit, [], 0, "NONE"];
                _crew set [count _crew, _unit];
            } forEach _unitCrew;
            // We assume that all vehicles have a driver, the first one of the crew
            (_crew select 0) moveInDriver _spawnUnit;
            // Count the turrets and move the men inside
            private _turrets = [configFile >> "CfgVehicles" >> _unitType >> "turrets"] call _fnc_returnVehicleTurrets;
            [_turrets, [], 1, _crew, _spawnUnit] call _fnc_moveInTurrets;
        } else {
            // Otherwise its infantry
            _spawnUnit = _newGroup createUnit [_unitType,_unitPos, [], 0, "NONE"];
            _spawnUnit setVariable ["acex_headless_blacklist", _unitHCBL];
            ["Murk-Spawn", "New unit %1 HCBL status: %2", _spawnUnit, _unitHCBL] call mc_fnc_rptlog;
            removeAllWeapons _spawnUnit;
            removeAllItems _spawnUnit;
            removeAllAssignedItems _spawnUnit;
            removeUniform _spawnUnit;
            removeVest _spawnUnit;
            removeBackpack _spawnUnit;
            removeHeadgear _spawnUnit;
            removeGoggles _spawnUnit;

            _spawnUnit forceAddUniform _unitUniform;
            {_spawnUnit addItemToUniform _x} forEach _unitUniformItems;

            _spawnUnit addVest _unitVest;
            {_spawnUnit addItemToVest _x} forEach _unitVestItems;

            _spawnUnit addBackpack _unitBackpack;
            {_spawnUnit addItemToBackpack _x} forEach _unitBackpackItems;

            _spawnUnit addHeadgear _unitHeadgear;
            _spawnUnit addGoggles _unitGoggles;
            {_spawnUnit linkItem _x} forEach _unitItems;

            {_spawnUnit addWeapon _x} forEach _unitWeapons;
            _spawnUnit selectWeapon (primaryWeapon _spawnUnit);

            _spawnUnit setFace _unitFace;
        };
        // Set all the things common to the spawned unit
        _spawnUnit triggerDynamicSimulation false;
        _spawnUnit setDir _unitDir;
        _spawnUnit setSkill _unitSkill;
        _spawnUnit setUnitRank _unitRank;
        // disable ACE unconsciousness
        [_spawnUnit] spawn {
            params ["_spawnUnit"];
            _spawnUnit setvariable [
             "ace_medical_enableUnconsciousnessAI", 0, false];
        };
        if (!isNil _unitName AND (_spawntype == "once" OR _spawntype == "repeated")) then {
            _spawnUnit call compile format ["%1= _this; _this setVehicleVarName '%1'; PublicVariable '%1';",_unitName];
        };
    } forEach _unitArray;
    if (_f3gear) then {
        units _newGroup execVM "f\assignGear\f_assignGear_AI.sqf";
    };

    private _i = 0;

    // Delete all existing waypoints
    // This fixes the "Mysterious [0,0] (bottom left corner of the map) WP
    // from nowhere" bug
    while {(count (waypoints _newGroup)) > 0} do {
        deleteWaypoint ((waypoints _newGroup) select 0);
    };

    // Let's return them their waypoints
    {
        //diag_log format ["All data : %1",_x];
        _newGroup addWaypoint [(_x select 0),0,_i];
        [_newGroup, _i] setWaypointHousePosition (_x select 1);
        [_newGroup, _i] setWaypointBehaviour (_x select 2);
        [_newGroup, _i] setWaypointCombatMode (_x select 3);
        [_newGroup, _i] setWaypointCompletionRadius (_x select 4);
        [_newGroup, _i] setWaypointDescription (_x select 5);
        [_newGroup, _i] setWaypointFormation (_x select 6);
        [_newGroup, _i] setWaypointScript (_x select 7);
        [_newGroup, _i] showWaypoint (_x select 8);
        [_newGroup, _i] setWaypointSpeed (_x select 9);
        [_newGroup, _i] setWaypointStatements (_x select 10);
        [_newGroup, _i] setWaypointTimeout (_x select 11);
        [_newGroup, _i] setWaypointType (_x select 12);
        [_newGroup, _i] setWaypointName (_x select 13);

        _i = _i + 1;

    } forEach _waypointsArray;

    (vehicle (leader _newGroup)) call compile format ["%1",_initString];

    // Run the cleanup function for this group
    if (_autoDeleteDist > 0) then {
        [_newGroup, _bodyRemove,_autoDeleteDist,(_waypointsArray select (count _waypointsArray - 1) select 0),_triggerObject] spawn _fnc_autoDeleteGroup;
    } else {
        [_newGroup, _bodyRemove] spawn _fnc_cleanGroup;
    };
    // Enable ACEX Headless for this group and trigger a rebalance pass
    // But *only* if the MM has not put the group on the HC blacklist.
    if (mc_murk_headless == 1 && ! _grpHCBL) then {
        ["Murk-Spawn", "Removing group %1 from ACEX HC blacklist and triggering rebalance",
            _newgroup] call mc_fnc_rptlog;
        _newGroup setVariable ["acex_headless_blacklist", false];
        [false] call acex_headless_fnc_rebalance;
    };
    if (_grpHCBL) then {
        ["Murk-Spawn", "Group %1 was put on ACEX HC blacklist by MM, leaving it there",
            _newgroup] call mc_fnc_rptlog;
    };

    // Have to return the new group
    _newGroup;
};

// Waiting period
while { !(_triggerObject getVariable "murk_spawn") } do { sleep _waitingPeriod; };


// Spawn Modes

// REPEAT MODE, i.e. basic respawn based on lives
if (_spawntype == "repeated") then {
    while { _spawnlives > 0 } do {
        private _unitGroup = [_unitGroup,_side,_waypointsArray,_grpHCBL] call _fnc_spawnUnit;
        _spawnlives = _spawnlives - 1;
        private _unitsGroup = units _unitGroup;
        while { ({alive _x} count _unitsGroup) > 0 } do { sleep 2; };
        sleep _spawndelay;
        if (!(_triggerObject getVariable "murk_spawn")) then {
            // murk spawn is set to false if units are autodeleted, dont spawn
            // new units until trigger gets activated again
            _spawnlives = _spawnlives + 1;
            while { !(_triggerObject getVariable "murk_spawn") } do {
                sleep _waitingPeriod;
            };
        };
    };
};

// WAVE MODE, this is fairly simple, just sleep a while then respawn.
// Spawnlives in this case is number of waves
if (_spawntype == "wave") then {
    while { _spawnlives > 0 } do {
        private _unitGroup = [_unitGroup,_side,_waypointsArray,_grpHCBL] call _fnc_spawnUnit;
        ["mc_murk_spawned", [_unitGroup]] call CBA_fnc_serverEvent;
        _spawnlives = _spawnlives - 1;
        sleep _spawndelay;
        if (!(_triggerObject getVariable "murk_spawn")) then {
            // murk spawn is set to false if units are autodeleted, dont spawn
            // new units until trigger gets activated again
            _spawnlives = _spawnlives + 1;
            while { !(_triggerObject getVariable "murk_spawn") } do {
                sleep _waitingPeriod;
            };
        };
    };
};

// RESET MODE, sleep a while then set the variable to false (even if you set it
// like 50 times over). Spawn lives is used to tick how many times its possible
// to reset.
if (_spawntype == "reset") then {
    while { _spawnlives > 0 } do {
        private _unitGroup = [_unitGroup,_side,_waypointsArray,_grpHCBL] call _fnc_spawnUnit;
        ["mc_murk_spawned", [_unitGroup]] call CBA_fnc_serverEvent;
        _spawnlives = _spawnlives - 1;
        sleep 15;
        _triggerObject setVariable ["murk_spawn",false,false];
        while { !(_triggerObject getVariable "murk_spawn") } do {
            sleep _waitingPeriod;
        };
    };
};

// ONCE MODE
if (_spawntype == "once") then {
    private _unitGroup = [_unitGroup,_side,_waypointsArray,_grpHCBL] call _fnc_spawnUnit;
    ["Murk-Spawn", "Spawned group %1", _unitGroup] call mc_fnc_rptlog;
    ["mc_murk_spawned", [_unitGroup]] call CBA_fnc_serverEvent;
};

// vim: sts=-1 ts=4 et sw=4
