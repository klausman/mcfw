scriptName "mc_fnc_stats_handleRespawn";

params [
    ["_uid", nil, [""]],
    ["_name", nil, [""]],
    ["_role", nil, [""]],
    ["_skipTicketLoss", false, [true]]
];

if (!isServer) exitWith {};

// Exclude the server from the stats
if (isNil "_uid") exitwith {};

// Retrieve this player's stats
private _playerStats = missionNamespace getVariable ["mc_stats_player_" + _uid, nil];
if (isNil "_playerStats") then {
    _playerStats = [
        _name,
        0, // respawn count
        [] // roles
    ];
};

_playerStats params ["_playerName", "_respawnCount", "_roles"];

// Increase respawn count by one
if (!_skipTicketLoss) then {
    _respawnCount = _respawnCount + 1;
    _playerStats set [1, _respawnCount];
};

// Add the role to the list (if it's not already in it)
_roles pushBackUnique _role;
_playerStats set [2, _roles];

// Store updated stats for this player
missionNamespace setVariable ["mc_stats_player_" + _uid, _playerStats];

// Stores this player's UID for a later use
mc_stats_players pushBackUnique _uid;

// Write player's stats to the RPT file
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

if (f_var_debugMode == 1) then {
    ["StatsOnRespawn", "_playerStats = %1", str _playerStats] call mc_fnc_bothlog;
};
