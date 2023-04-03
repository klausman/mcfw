// Near Player Function
scriptName "nearPlayer.sqf";

params ["_target", "_distance", ["_checkGround", false]];

// DECLARE VARIABLES AND FUNCTIONS
private ["_pos", "_players"];

// Get target position
if (_target in allMapMarkers) then {
    _pos = getMarkerPos _target;
} else {
    if (typeName _target == "ARRAY") then {
        _pos = _target;
    } else {
        _pos = getPosATL _target;
    };
};

// List all matching players (except logic slots)
_players = [];
{
    if (isPlayer _x) then {
        private _addPlayer = true;

        if (_checkGround) then {
            // Add player only if:
            // - they don't have more than 2 squad mates
            // - they aren't in a steerable parachute
            // - they are 30m above water or terrain (ASL/ATL)
            if (count crew vehicle _x < 3) then {
                if (!(vehicle _x isKindOf "Steerable_Parachute_F")) then {
                    if (surfaceIsWater getPos _x) then {
                        if (getPosASL _x select 2 > 30) then {
                            _addPlayer = false;
                        };
                    }
                    else {
                        if (getPosATL _x select 2 > 30) then {
                            _addPlayer = false;
                        };
                    };
                };
            };
        };

        if (_addPlayer) then {
            _players pushBack _x;
        };
    };
} forEach playableUnits;

// Check whether a player is in the given distance - return true if yes
if (({_x distance _pos < _distance} count _players) > 0) exitWith {true};

false

// vim: sts=-1 ts=4 et sw=4
