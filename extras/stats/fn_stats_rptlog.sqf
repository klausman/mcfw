scriptName "mc_fnc_stats_rptlog";

if (!isServer) exitWith {};

[
    "============================================",
    "MC_STATS",
    [false, true, false]
] call CBA_fnc_debug;

private _index = 0;
{
    // _x = player name
    // _y = stats<respawn, []>

    [
        format [
            "%1 - Respawns: %2 - Roles: %3",
            _x,
            _y select 0,
            str (_y select 1)
        ],
        "MC_STATS",
        [false, true, false]
    ] call CBA_fnc_debug;
} forEach (missionNamespace getVariable ["mc_stats_players", createHashMap]);

[
    "============================================",
    "MC_STATS",
    [false, true, false]
] call CBA_fnc_debug;

if (f_var_debugMode == 1) then {
    [
        "Players stats dumped into server's RPT file",
        "MC_STATS",
        [true, false, true]
    ] call CBA_fnc_debug;
};
