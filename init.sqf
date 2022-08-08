diag_log "MC Framework v0.4.0 starting init.sqf";

// Disable Saving and Auto Saving
enableSaving [false, false];

// Mute Orders and Reports
enableSentences false;

// Briefing
f_script_briefing = [] execVM "briefing.sqf";

// Group IDs
f_script_setGroupIDs = [] execVM "f\setGroupID\f_setGroupIDs.sqf";

// Buddy Team Colours
f_script_setTeamColours = [] execVM "f\setTeamColours\f_setTeamColours.sqf";

// Fireteam Member Markers Comment out this line to disable Fireteam-level map
// markers (small triangles). The BLUFOR tracker (BFT) is configure in Addons
// settings > ACE Map
// Also see https://www.misfit-company.com/arma3/mission_making/new_bft/
[] spawn f_fnc_SetLocalFTMemberMarkers;

// Casualties Cap
// [[GroupName or SIDE],100,1] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";
// [[GroupName or SIDE],100,{code}] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";

// BLUFOR
// [BLUFOR,100,1] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";

// OPFOR
// [OPFOR,100,1] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";

// INDEPENDENT
// [INDEPENDENT,100,1] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";

// Assign Gear AI
// Uncomment this line if you want to run assignGear for _all_ AI.
// [] execVM "f\assignGear\f_assignGear_AI.sqf";

// ORBAT Notes (in Briefing/Map)
[] execVM "f\briefing\f_orbatNotes.sqf";

// Loadout Notes (in Briefing/Map)
[] execVM "f\briefing\f_loadoutNotes.sqf";

// Mission Timer/Safe Start
[] execVM "f\safeStart\f_safeStart.sqf";

// Clientside caching
if (!isserver && hasInterface) then {
    //run on all player clients incl. player host and excl. headless clients
    []spawn {
    waitUntil {sleep 0.1; !isNull player};
    waitUntil{!isNil "mc_param_cscaching"};
        if (mc_param_cscaching == 1) then {
            handle_pacaching2 = [{[] call mc_fnc_CscGroupmanagement;}, 30] call CBA_fnc_addPerFrameHandler;
            waitUntil{!isNil "mc_AIGroups"};
            handle_pacaching1 = [{[] call mc_fnc_ClientsideCaching;}, 6] call CBA_fnc_addPerFrameHandler;
        };
    };
};

// Thermals
// Disable thermal sights for everything, including A3TI
//[] execVM "extras\disableThermals.sqf";

// PabstMirror - Mission Intro
// Credits: PabstMirror
[] execVM "extras\PM_missionIntro.sqf";

// WS - AI Flashlights
// Credits: Wolfenswan
// [] execVM "extras\forceFlashlightAI.sqf";

// ASL - Advanced Sling Loading
// https://www.armaholic.com/page.php?id=30334
//
// NOTE: To enable: either use the mission parameters at mission time, or
// change the default in description.ext
[] execVM "extras\fn_advancedSlingLoadingInit.sqf";

// DSL - Simple Sling Load
// Credits: Dagger
//
// NOTE: To enable: either use the mission parameters at mission time, or
// change the default in description.ext
[] execVM "extras\fn_simpleSlingLoadingInit.sqf";

// AT - Advanced Towing
// https://github.com/sethduda/AdvancedTowing/
//
// NOTE: To enable: either use the mission parameters at mission time, or
// change the default in description.ext
[] execVM "extras\fn_advancedTowingInit.sqf";

// Respawn, teleport and sundry handling
// Add two event handlers:
// - The first quickly removes a player's body upon death or respawn
// - The second runs on respawn, checks if the unit has an associated
//   assignGear loadout, and if so, re-runs assignGear.
if (hasInterface) then {
    []spawn {
        waitUntil {sleep 1; !isNull player};

        player addEventHandler [
            "killed",
            "params ['_unit', '_killer', '_instigator', '_useEffects'];
             [_unit] spawn {
                private _corpse = _this select 0;
                sleep 3;
                hideBody _corpse;
                sleep 10;
                deleteVehicle _corpse;
             };"];

        player addEventHandler [
            "respawn",
             "_this spawn {
                waitUntil {sleep 1; !isNull player};
                ['mc_playerRespawned', [
                    getPlayerUID player,
                    name player,
                    roleDescription player
                ]] call CBA_fnc_serverEvent;
                if (missionNamespace getVariable ['mc_respawnTickets', -1] >= 0) then {
                    _this remoteExecCall ['mc_fnc_handlePlayerRespawn', 2];
                };
                private _loadout = player getVariable ['f_var_assignGear', 'NO_LOADOUT'];
                if (_loadout!='NO_LOADOUT') then {
                    player setVariable ['f_var_assignGear_done',false,true];
                    [_loadout, player] call f_fnc_assignGear;
                } else {
                    ['respawnEH', 'Unit %1 had no aG loadout, doing nothing'] call mc_fnc_ehlog;
                };
                sleep 5;
                call mc_fnc_telepole_reinit;
             };"];
    };

    ["mc_playerSpawned", [
        getPlayerUID player,
        name player,
        roleDescription player
    ]] call CBA_fnc_serverEvent;
};

// Vehicle Saver
// Prevents vehicles placed in "Hide Terrain Objects" area from blowing up due
// to randomness of initialization order.
//
// On mission start, disable damage on all vehicles in the mission. This
// happens on the map screen. The spawned script re-enables both aspects and
// only starts running when the mission starts, no matter how much time was
// spent on the map screen.
private _editedVicsAD = [];
private _editedVicsES = [];
private _edCount = 0;

["vicsaver", "Making vehicles inert"] call mc_fnc_ehlog;
{
    if (simulationEnabled _x || isDamageAllowed _x) then {
        _edCount = _edCount+1;
    };
    if (isDamageAllowed _x) then {
        _x allowDamage false;
        _editedVicsAD pushBack _x;
        _edCount = _edCount+1;
    };
    if (simulationEnabled _x) then {
        _x enableSimulationGlobal false;
        _editedVicsES pushBack _x;
    };
} foreach vehicles;
["vicsaver", "Made %1 vehicles inert", _edCount] call mc_fnc_ehlog;

[_editedVicsAD, _editedVicsES] spawn {
    sleep 2; // This only starts ticking once in-mission
    ["vicsaver", "Enabling simulation on vehicles"] call mc_fnc_ehlog;
    private _editedVicsAD = _this select 0;
    private _editedVicsES = _this select 1;
    {_x allowDamage true} foreach _editedVicsAD;
    {_x enableSimulationGlobal true} foreach _editedVicsES;
    ["vicsaver", "Enabling simulation on vehicles complete"] call mc_fnc_ehlog;
};

if (isServer) then {
    private _ticketCount = -1;
    if (!isNil "mc_respawnTicket_initialValue") then {
        _ticketCount = mc_respawnTicket_initialValue;
    };
    missionNamespace setVariable ["mc_respawnTickets", _ticketCount, true];

    // Globally declared variable containing player UIDs
    mc_stats_players = [];

    ["mc_playerSpawned", {
        params ["_uid", "_name", "_role"];
        ["mc_playerSpawned", "%1", _name] call mc_fnc_ehlog;

        [_uid, _name, _role, true] remoteExecCall ["mc_fnc_stats_handleRespawn", 2];
    }] call CBA_fnc_addEventHandler;

    ["mc_playerRespawned", {
        params ["_uid", "_name", "_role"];
        ["mc_playerRespawned", "%1", _name] call mc_fnc_ehlog;

        _this remoteExecCall ["mc_fnc_stats_handleRespawn", 2];
    }] call CBA_fnc_addEventHandler;

    // Dumps player stats into server's RPT file
    addMissionEventHandler ["MPEnded", {
        [] remoteExecCall ["mc_fnc_stats_rptlog", 2];
    }];
    addMissionEventHandler ["Ended", {
        [] remoteExecCall ["mc_fnc_stats_rptlog", 2];
    }];
};

// Fix for unconscious state bug
// https://github.com/acemod/ACE3/issues/7453#issuecomment-615167752
_id = ["ace_unconscious",{ 
    params ["_unit","_state"]; 
	if ( !(local _unit) || !(isPlayer _unit) ) exitWith {};
	if (_state) then { [_unit,true] remoteExecCall ["setUnconscious",0]; };
	if !(_state) then { [_unit,false] remoteExecCall ["setUnconscious",0]; };
}] call CBA_fnc_addEventHandler;

// vim: sts=-1 ts=4 et sw=4
