scriptName "mc_fnc_stats_registerPlayerRole";

params ["_name", "_role"];

if (!isServer || _name == "__SERVER__") exitWith {};

private _playerStatsHash = missionNamespace getVariable ["mc_stats_players", createHashMap];

if (!(_name in _playerStatsHash)) exitWith {};

// Get current player's stats
private _stats = _playerStatsHash get _name;

// Add role if it does not already exist
private _roles = _stats select 1;
_roles pushBackUnique _role;
_stats set [1, _roles];

// Set new stats values
_playerStatsHash set [_name, _stats];

missionNamespace setVariable ["mc_stats_players", _playerStatsHash];
