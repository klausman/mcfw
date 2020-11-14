// Near Player Function
params ["_cPos", "_distance"];

// DECLARE VARIABLES AND FUNCTIONS
private ["_pos","_players","_countP"];

if (_cPos in allMapMarkers) then {
    _pos = getMarkerPos _cPos;
} else {
    if (typeName _cPos == "ARRAY") then {
        _pos = _cPos;
    } else {
        _pos = getPosATL _cPos;
    };
};

// Create a list of all players
_players = [];

{
   if (isPlayer _x) then {
       _countP = true;
       if (surfaceiswater getpos _x) then {
           if (getposasl _x select 2 > 30) then {
               if (count crew vehicle _x < 3) then {
                   if (!(vehicle _x iskindof "Steerable_Parachute_F")) then {
                       _countP = false;
                   };
               };
           };
       } else {
           if (getposatl _x select 2 > 30) then {
               if (count crew vehicle _x < 3) then {
                   if (!(vehicle _x iskindof "Steerable_Parachute_F")) then {
                       _countP = false;
                   };
               };
           };
       };
       //
       if (_countP) then {
            _players = _players + [_x]
       };
   };
} forEach playableUnits;

// Check whether a player is in the given distance - return true if yes
if (({_x distance _pos < _distance} count _players) > 0) exitWith {true};

false
