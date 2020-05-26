// Near Player Function

// DECLARE VARIABLES AND FUNCTIONS
private ["_distance","_pos","_players"];
_pos = getPosATL (_this select 0);
_distance = _this select 1;

// Create a list of all players
_players = [];
{if (isPlayer _x) then {_players pushBack _x};} forEach playableUnits;

// Check whether a player is in the given distance - return true if yes
if (({_x distance _pos < _distance} count _players) > 0) exitWith {true};

false

// vim: sts=-1 ts=4 et sw=4
