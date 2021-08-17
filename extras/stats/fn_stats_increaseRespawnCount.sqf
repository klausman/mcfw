scriptName "mc_fnc_stats_increaseRespawnCount";

params ["_unit"];

private _name = name _unit;

if (!isServer || _name == "__SERVER__") exitwith {};

private _playerStatsHash = missionNamespace getVariable ["mc_stats_players", createHashMap];

if (!(_name in _playerStatsHash)) exitWith {};

// Get current player's stats
private _stats = _playerStatsHash get _name;

// Increment respawn count
private _respawnCount = _stats select 0;
_stats set [0, _respawnCount + 1];

// Set new stats values
_playerStatsHash set [_name, _stats];

missionNamespace setVariable ["mc_stats_players", _playerStatsHash];
