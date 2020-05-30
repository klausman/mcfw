// File: murk_building.sqf
// Function: To allow for simple dynamic spawning using editor placed units.
// The script deletes all units when the mission start and the recreate them
// when players are near.
//
// Parameters:
//      _this select 0: OBJECT - unit name (this)
//      _this select 1: BOOL - use F3 assigngear? (true/false)
//      _this select 2: NUMBER - spawn distance
//      _this select 3 (optional): NUMBER - once x units are remaining have
//                     them move out and patrol outside
//      _this select 4 (optional): STRING - init string called for the leader of the group

// Usage:
//      Unit (leader of group):
//      nul = [this,F3GEAR,SPAWNDISTANCE,REMAININGTOATTACK,"SL INIT"] execVM "murk\murk_building.sqf";
//
// Example:
//
// nul = [this,true,300,5] execVM "murk\murk_building.sqf";
//
// Will spawn the editor units when players get within 300m of group's center,
// units will hold position until 5 soldiers remaining. then start patrolling.

// V1 release - captainblaffer

// TODO(klausman): This script currently has 0 support for custom loadouts.
// Once murkspawn.sqf has been refactored to use get/setUnitLoadout, we should
// port that functionality here.

// This script is serverside
if(!isServer) exitWith{};

private ["_countThis","_waitingPeriod","_unit","_spawndistance","_remainingtoattack","_initString","_centerpos","_posarray","_unitArray","_unitGroup","_unitsInGroup","_unitsInGroupAdd","_side", "_f3gear"];

// Init
_countThis = count _this;
_waitingPeriod = 8;  // Waiting period between script refresh

// Parameters
_unit = _this select 0;
_f3gear = _this select 1;
_spawndistance = _this select 2;
_remainingtoattack = if (_countThis >= 4) then { _this select 3; } else { 0 };
_initString = if (_countThis >= 5) then { _this select 4; } else { "" };
// Some mission makers prefer using nil over ""
if (isNil "_initString") then {
    _initstring = "";
};
_centerpos = [0,0,0];
_posarray = [];

// Delete the unit (this is always done ASAP)
_unitArray = [];
_unitGroup = group _unit;
_unitsInGroup = units _unitGroup;
_unitsInGroupAdd = [];
_side = side _unitGroup;

while { count units _unitGroup > 0 } do {
    // The currently worked on unit
    _unitsInGroup = units _unitGroup;
    private _unit = _unitsInGroup select 0;

    // Check if it is a vehicle
    if ( (vehicle _unit) isKindOf "LandVehicle" OR (vehicle _unit) isKindOf "Air") then {
        private _vcl = vehicle _unit;
        _posarray pushback (getpos _vcl);

        if (!(_vcl in _unitsInGroupAdd) AND (typeOf _vcl != "")) then {
            _unitsInGroupAdd set [count _unitsInGroupAdd, _vcl];
            private _unitCrewArray = [];
            private _crew = crew _vcl;
            { _unitCrewArray set [count _unitCrewArray, typeOf _x]; } forEach _crew;

            private _unitInfoArray = [
                typeOf _vcl,
                getPosatl _vcl,
                getDir _vcl,
                vehicleVarName _vcl,
                skill _vcl,
                rank _vcl,
                _unitCrewArray
            ];
            _unitArray set [count _unitArray, _unitInfoArray];
            deleteVehicle _vcl;
            { deleteVehicle _x; } forEach _crew;
        };
    }
    // Otherwise its infantry
    else {
        _posarray pushback (getpos _unit);
        private _unitInfoArray = [
            typeOf _unit,
            getPosatl _unit,
            getDir _unit,
            vehicleVarName _unit,
            skill _unit,
            rank _unit,
            []
        ];
        _unitArray set [count _unitArray, _unitInfoArray];
        deleteVehicle _unit;
    };
    sleep 0.01;
};

deleteGroup _unitGroup;

// Functions

// *WARNING* BIS FUNCTION RIPOFF - Taken from fn_returnConfigEntry as it is
// needed for turrets and shortened a bit
private _fnc_returnConfigEntry = {
    private ["_config", "_entryName","_entry", "_value"];
    _config = _this select 0;
    _entryName = _this select 1;
    _entry = _config >> _entryName;
    // If the entry is not found and we are not yet at the config root, explore
    // the class' parent.
    if (((configName (_config >> _entryName)) == "") && (!((configName _config) in ["CfgVehicles", "CfgWeapons", ""]))) then {
        [inheritsFrom _config, _entryName] call _fnc_returnConfigEntry;
    }
    else {
        if (isNumber _entry) then {
            _value = getNumber _entry;
        } else {
            if (isText _entry) then {
                _value = getText _entry;
            };
        };
    };
    if (isNil "_value") exitWith {nil};
    _value;
};

// *WARNING* BIS FUNCTION RIPOFF - Taken from fn_fnc_returnVehicleTurrets and
// shortened a bit
private _fnc_returnVehicleTurrets = {
    private ["_entry","_turrets", "_turretIndex"];
    _entry = _this select 0;
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
                        _turrets pushBack [_subEntry >> "Turrets"] call _fnc_returnVehicleTurrets; }
                    else {
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
    private _turrets = _this select 0;
    private _path = _this select 1;
    private _currentCrewMember = _this select 2;
    private _crew = _this select 3;
    private _spawnUnit = _this select 4;
    private _i = 0;
    while {_i < (count _turrets) AND _currentCrewMember < count _crew} do {
        private _turretIndex = _turrets select _i;
        private _thisTurret = _path + [_turretIndex];
        (_crew select _currentCrewMember) moveInTurret [_spawnUnit, _thisTurret]; _currentCrewMember = _currentCrewMember + 1;
        // Spawn units into subturrets.
        [_turrets select (_i + 1), _thisTurret, _currentCrewMember, _crew, _spawnUnit] call _fnc_moveInTurrets;
        _i = _i + 2;
    };
};

private _fnc_spawnUnit = {
    // We need to pass the old group so we can copy waypoints from it, the rest
    // we already know
    private _oldGroup = _this select 0;
    private _newGroup = createGroup (_this select 1);
    // Disable ACEX Headless messing with this group until we're done
    _newGroup setVariable ["acex_headless_blacklist", true];
    // If the old group doesn't have any units in it its a spawned group rather
    // than respawned
    if ( count (units _oldGroup) == 0) then {
        deleteGroup _oldGroup;
    };
    {
        private _spawnUnit = nil;
        private _unitType = _x select 0;
        private _unitPos  = _x select 1;
        private _unitDir  = _x select 2;
        private _unitName = _x select 3;
        private _unitSkill = _x select 4;
        private _unitRank = _x select 5;
        private _unitCrew = _x select 6;
        // Check if the unit has a crew, if so we know its a vehicle
        if (count _unitCrew > 0) then {
            if (_unitPos select 2 >= 10) then {
                // If it's more than 10m off the ground, it probably needs to fly
                _spawnUnit = createVehicle [_unitType,_unitPos, [], 0, "FLY"];
                _spawnUnit setVelocity [50 * (sin _unitDir), 50 * (cos _unitDir), 0];
            }
            else {
                _spawnUnit = _unitType createVehicle _unitPos;
                _spawnUnit setfuel 0;
            };
            // Create the entire crew
            private _crew = [];
            {
                _unit = _newGroup createUnit [_x, getPos _spawnUnit, [], 0, "NONE"];
                 _crew set [count _crew, _unit];
            } forEach _unitCrew;
            // We assume that all vehicles have a driver, the first one of the crew
            (_crew select 0) moveInDriver _spawnUnit;
            // Count the turrets and move the men inside
            private _turrets = [configFile >> "CfgVehicles" >> _unitType >> "turrets"] call _fnc_returnVehicleTurrets;
            [_turrets, [], 1, _crew, _spawnUnit] call _fnc_moveInTurrets;
        }
        // Otherwise its infantry
        else {
            _spawnUnit = _newGroup createUnit [_unitType,_unitPos, [], 0, "NONE"];
            commandstop _spawnUnit;
        };
        // Set all the things common to the spawned unit
        _spawnUnit triggerDynamicSimulation false;
        _spawnUnit setFormDir _unitDir;
        _spawnUnit setDir _unitDir;
        _spawnUnit setposatl _unitPos;
        _spawnUnit setSkill _unitSkill;
        _spawnUnit setUnitRank _unitRank;

        _spawnUnit allowfleeing 0;
        _spawnUnit forceSpeed 0;
        dostop _spawnUnit;
        //_spawnUnit disableAI "TARGET"; // why was this even here?
        _spawnUnit enableAI "PATH"; // why was this even here?
        commandstop _spawnUnit;
        //disable ACE unconcious
        _spawnUnit setvariable ["ace_medical_enableUnconsciousnessAI",0,false];
        if (!isNil _unitName) then {
            _spawnUnit call compile format ["%1= _this; _this setVehicleVarName '%1'; PublicVariable '%1';",_unitName];
        };
    } forEach _unitArray;

    // leader _newGroup enableAttack false; // why was this even here?
    [units _newGroup] spawn {
        sleep 10;
        { _x setUnitPos "UP"; } foreach (_this select 0);
    };
    if (_f3gear) then {
        units _newGroup execVM "f\assignGear\f_assignGear_AI.sqf";
    };

    (vehicle (leader _newGroup)) call compile format ["%1",_initString];

    //counter attack if few are remaining
    if (_remainingtoattack > 0) then {
        _newGroup setvariable ["remainingtoattack", _remainingtoattack];
        {
            _x addEventHandler ["killed", {_this select 0 execVM "murk\leaveBuilding.sqf";}];
        } foreach units _newGroup;
    };
    // Enable ACEX Headless for this group and trigger a rebalance pass
    if (mc_murk_headless == 1) then {
        _newGroup setVariable ["acex_headless_blacklist", false];
        [false] call acex_headless_fnc_rebalance;
    };

    // Have to return the new group
    _newGroup;
};


// finding group center
_xpos = 0;
_ypos = 0;
{
    _xpos = _xpos + (_x select 0);
    _ypos = _ypos + (_x select 1);
} foreach _posarray;

_xpos = (_xpos / (count _posarray));
_ypos = (_ypos / (count _posarray));
_centerpos = [_xpos, _ypos, 0];

// Waiting period
while {!([_centerpos, _spawndistance] call murk_fnc_nearPlayerGround)} do {
    sleep _waitingPeriod;
};

// Spawn Modes

// ONCE MODE
_unitGroup = [_unitGroup,_side] call _fnc_spawnUnit;

// delete and re-cache when no players near
[_unitGroup,_f3gear,_spawndistance,_remainingtoattack,_initString,_centerpos,_waitingPeriod] spawn {
    private _unitGroup = _this select 0;
    private _f3gear = _this select 1;
    private _spawndistance = _this select 2;
    private _remainingtoattack = _this select 3;
    private _initString = _this select 4;
    private _centerpos = _this select 5;
    private _waitingPeriod = _this select 6;
    private _alivedudes = [];
    private _uncachedistance = _spawndistance + 100 + (0.33 * _spawndistance);

    while {([_centerpos, _uncachedistance] call murk_fnc_nearPlayerGround)} do {
        sleep _waitingPeriod;
    };

    {
        if (!(alive _x)) then {
            deletevehicle _x;
        } else {
            _alivedudes pushback _x;
        };
    } foreach (units _unitGroup);

    if (count _alivedudes > _remainingtoattack) then {
        private _unit = _alivedudes select 0;
        [_unit,_f3gear,_spawndistance,_remainingtoattack,_initString] execVM "murk\murk_building.sqf";
    } else {
        //delete group if they already started to leavebuilding.
        {
            deletevehicle _x;
        } foreach (_alivedudes);
        deletegroup _unitGroup;
    };
};
// vim: sts=-1 ts=4 et sw=4
