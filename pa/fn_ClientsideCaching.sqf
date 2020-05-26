/*
//player caching
    _units = ["UnitNATO_CO_P1","UnitNATO_CO_P2","UnitNATO_CO_P3","UnitNATO_CO_PC","UnitNATO_CO","UnitNATO_CO_EN","UnitNATO_CO_FAC"] select {isNil _x};
    _sNeeds = (player in _units);
    [{[_this select 0] call cb_fnc_playerCaching;}, 5, _sNeeds] call CBA_fnc_addPerFrameHandler;
*/

//todo:
//deal with slingroping vehicles
//deal with dragging crate/putting in car?
//if someone enters a cached car, uncache it
//

// The player's set viewdistance should guide our caching
private _checkDist = getObjectViewDistance select 0;

// cache dead stuff
{
    if (_x distance2D player < _checkDist) then {
        _x hideobject false;
        _x enablesimulation true;
    } else {
        _x hideobject true;
        _x enablesimulation false;
    };
} foreach alldead; //alldeadmen; //playableunits - [player] +

{
    if (!isplayer leader _x) then { // don't cache player groups
        private _cached = _x getvariable ["c_cached", false];
        // always uncache leader in case the old leader died
        leader _x hideobject false;
        leader _x enablesimulation true;

        if (leader _x distance2D player < _checkDist) then {
            if (_cached) then {
                _x setvariable ["c_cached", false];
                {
                    _x hideobject false;
                    _x enablesimulation true;
                } foreach units _x - [leader _x];
            };
        } else {
            if (!_cached) then {
                _x setvariable ["c_cached", true];
                {
                    _x hideobject true; _x enablesimulation false;
                } foreach units _x - [leader _x];
            };
        };

    };
} foreach pa_AIGroups;

// vim: sts=-1 ts=4 et sw=4
