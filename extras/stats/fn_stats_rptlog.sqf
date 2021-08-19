scriptName "mc_fnc_stats_rptlog";

if (!isServer) exitWith {};

[
    "============================================",
    "MC_STATS",
    [false, true, false]
] call CBA_fnc_debug;

{
    if (isNil "_x") exitWith {};

    private _playerStats = missionNamespace getVariable ["mc_stats_player_" + _x, nil];
    if (isNil "_playerStats") exitwith {
        if (f_var_debugMode == 1) then {
            ["%1 does not exist in missionNamespace", "mc_stats_player_" + _x] call mc_fnc_bothlog;
        };
    };
    _playerStats params ["_playerName", "_respawnCount", "_roles"];

    [
        format [
            "%1 - Respawns: %2 - Roles: %3",
            _playerName,
            _respawnCount,
            str _roles
        ],
        "MC_STATS",
        [false, true, false]
    ] call CBA_fnc_debug;
} forEach (mc_stats_players);

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
