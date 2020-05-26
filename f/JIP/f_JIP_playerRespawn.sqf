// Respawn INIT

// Only run this for players
if (isDedicated) exitWith{};

// MAKE SURE THE PLAYER INITIALIZES PROPERLY
if (!isDedicated && (isNull player)) then {
    waitUntil {sleep 0.1; !isNull player};
};

// DECLARE VARIABLES AND FUNCTIONS
private ["_unit","_corpse"];

// SETUP KEY VARIABLES
// The Respawn eventhandler passes two parameters: the unit a player has
// respawned in and the corpse of the old unit.
_unit = _this select 0;
_corpse = _this select 1;

//if there is spectate and a corpse exit out
if ((getArray (missionconfigfile >> "RespawnTemplates") find "f_spectator") > -1 && !(isNull _corpse)) exitWith {};

//Remove blackout, spectate script related
[]spawn {uiSleep 2; ["F_ScreenSetup"] call BIS_fnc_blackIn;};

// Exit if the unit doesn't exist (can occur when JIPing into missions with no
// respawn)
if (isNil "_unit") exitWith {};

// CHECK FOR GLOBAL VARIABLES
// Check if the global variables have been initialized, if not, do so with the
// default values.
if (isNil "f_var_JIP_JIPMenu") then {f_var_JIP_JIPMenu = true};
if (isNil "f_var_JIP_RespawnMenu") then {f_var_JIP_RespawnMenu = false};
if (isNil "f_var_JIP_RemoveCorpse") then {f_var_JIP_RemoveCorpse = false};

// CHECK FOR FIRST TIME SPAWN
// if not a JIP exit out
if (time < 10 && isNull _corpse) exitWith {};
// If no corpse exists the player is spawned for the first time.
if (!f_var_JIP_JIPMenu && isNull _corpse) exitWith {};

// CHECK FOR GEAR
// If gear selection is disabled and the unit uses the loadout assigned by the
// assign Gear component or it's default loadout.
if (!(isNull _corpse)) then { //reset gear if respawning
    if (typeName (_unit getVariable "f_var_assignGear") == typeName "") then {
        private _loadout = (_unit getVariable "f_var_assignGear");
        _unit setVariable ["f_var_assignGear_done",false,true];
        [_loadout,player] call f_fnc_assignGear;
        if(alive _unit) then {
            // JIP'd player that is alive, disable spectator chat
            [_unit, false] call TFAR_fnc_forceSpectator;
        } else {
            // JIP'd player that is not alive, force spectator chat
            [_unit, true] call TFAR_fnc_forceSpectator;
        };
    };
};

// REMOVE CORPSE
// If activated and respawn is allowed, the old corpse will be sink into the
// ground and is then removed from the game
if (typeof _unit != "seagull" && {f_var_JIP_RemoveCorpse && !isNull _corpse}) then {
    _corpse spawn {
        hideBody _this;
        sleep 60;
        deleteVehicle _this;
    };
};

// ADD JIP MENU TO PLAYER
// Check if player already has the JIP Menu. If not, add it.
// do respawning players get menu?
if (!f_var_JIP_RespawnMenu && !(isNull _corpse)) exitWith {};
sleep 5;
if (isNil "F3_JIP_reinforcementOptionsAction") then {
    [player] execVM "f\JIP\f_JIP_addReinforcementOptionsAction.sqf";
};

// vim: sts=-1 ts=4 et sw=4
