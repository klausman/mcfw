// Common Local Variables

waitUntil {!isnil "f_var_debugMode"};

// All units and vehicles
f_var_units = allUnits + vehicles;

// Variables of all units per side 
f_var_units_BLU = [];
f_var_units_OPF = [];
f_var_units_RES = [];
f_var_units_CIV = [];
{
    switch side _x do {
        case west: {
            f_var_units_BLU pushBack _x;
        };
        case east: {
            f_var_units_OPF pushBack _x;
        };
        case resistance: {
            f_var_units_RES pushBack _x;
        };
        case civilian: {
            f_var_units_CIV pushBack _x;
        };
    
    }
} forEach f_var_units;

// All men (infantry) in the mission
f_var_men = [];
{
    if ((_x isKindOf "CAManBase")) then {
        f_var_men pushBack _x;
    };
} forEach f_var_units;

// All units that are players
f_var_men_players = [];
{
    if (isPlayer _x) then {
        f_var_men_players pushBack _x;
    };
} foreach f_var_men;

// All men per side
f_var_men_BLU = [];
f_var_men_OPF = [];
f_var_men_RES = [];
f_var_men_CIV = [];
{
    switch side _x do {
        case west: {
            f_var_men_BLU pushBack _x;
        };
        case east: {
            f_var_men_OPF pushBack _x;
        };
        case resistance: {
            f_var_men_RES pushBack _x;
        };
        case civilian: {
            f_var_men_CIV pushBack _x;
        };
        if (isPlayer _x) then {
            f_var_men_players pushBack _x
        };
    }
} forEach f_var_men;

// All groups
f_var_groups = allGroups;

// All Groups, per side.
f_var_groups_BLU = [];
f_var_groups_OPF = [];
f_var_groups_RES = [];
f_var_groups_CIV = [];
{
    switch side _x do {
        case west: {
            f_var_groups_BLU pushBack _x;
        };
        case east: {
            f_var_groups_OPF pushBack _x;
        };
        case resistance: {
            f_var_groups_RES pushBack _x;
        };
        case civilian: {
            f_var_groups_CIV pushBack _x;
        };
    }
} foreach f_var_groups;

// All groups with players in them
f_var_groups_players = [];
{
    private _units = units _x;
    if ({isPlayer _x} count _units >= 1) then {
        f_var_groups_players set [count f_var_groups_players,_x];
    };
} forEach f_var_groups;

// All vehciles
f_var_vehicles = vehicles;

// vehicles per side
f_var_vehicles_BLU = [];
f_var_vehicles_OPF = [];
f_var_vehicles_RES = [];
f_var_vehicles_CIV = [];
{
    switch side _x do {
        case west: {
            f_var_vehicles_BLU pushBack _x;
        };
        case east: {
            f_var_vehicles_OPF pushBack _x;
        };
        case resistance: {
            f_var_vehicles_RES pushBack _x;
        };
        case civilian: {
            f_var_vehicles_CIV pushBack _x;
        };
    };
} forEach f_var_vehicles;

// DEBUG
if (f_var_debugMode == 1) then {
    ["f_setLocalVars.sqf", "f_var_units = %1", str f_var_units] call mc_fnc_bothlog;
    ["f_setLocalVars.sqf", "f_var_units_BLU = %1", str f_var_units_BLU] call mc_fnc_bothlog;
    ["f_setLocalVars.sqf", "f_var_units_RES = %1", str f_var_units_RES] call mc_fnc_bothlog;
    ["f_setLocalVars.sqf", "f_var_units_OPF = %1", str f_var_units_OPF] call mc_fnc_bothlog;
    ["f_setLocalVars.sqf", "f_var_units_CIV = %1", str f_var_units_CIV] call mc_fnc_bothlog;

    ["f_setLocalVars.sqf", "f_var_men = %1", str f_var_men] call mc_fnc_bothlog;
    ["f_setLocalVars.sqf", "f_var_men_BLU = %1", str f_var_men_BLU] call mc_fnc_bothlog;
    ["f_setLocalVars.sqf", "f_var_men_RES = %1", str f_var_men_RES] call mc_fnc_bothlog;
    ["f_setLocalVars.sqf", "f_var_men_OPF = %1", str f_var_men_OPF] call mc_fnc_bothlog;
    ["f_setLocalVars.sqf", "f_var_men_CIV = %1", str f_var_men_CIV] call mc_fnc_bothlog;
    ["f_setLocalVars.sqf", "f_var_men_players = %1", str f_var_men_players] call mc_fnc_bothlog;

    ["f_setLocalVars.sqf", "f_var_groups_BLU = %1", str f_var_groups_BLU] call mc_fnc_bothlog;
    ["f_setLocalVars.sqf", "f_var_groups_RES = %1", str f_var_groups_RES] call mc_fnc_bothlog;
    ["f_setLocalVars.sqf", "f_var_groups_OPF = %1", str f_var_groups_OPF] call mc_fnc_bothlog;
    ["f_setLocalVars.sqf", "f_var_groups_CIV = %1", str f_var_groups_CIV] call mc_fnc_bothlog;
    ["f_setLocalVars.sqf", "f_var_groups = %1", str f_var_groups] call mc_fnc_bothlog;
    ["f_setLocalVars.sqf", "f_var_groups_players = %1", str f_var_groups_players] call mc_fnc_bothlog;

    ["f_setLocalVars.sqf", "f_var_vehicles = %1",  str f_var_vehicles] call mc_fnc_bothlog;
    ["f_setLocalVars.sqf", "f_var_vehicles_BLU = %1", str f_var_vehicles_BLU] call mc_fnc_bothlog;
    ["f_setLocalVars.sqf", "f_var_vehicles_RES = %1", str f_var_vehicles_RES] call mc_fnc_bothlog;
    ["f_setLocalVars.sqf", "f_var_vehicles_CIV = %1", str f_var_vehicles_CIV] call mc_fnc_bothlog;
};

// vim: sts=-1 ts=4 et sw=4
