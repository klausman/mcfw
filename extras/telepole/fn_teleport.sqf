// Teleport script
// (C) 2020 T. Klausmann

params ["_leader", "_caller"];
private ["_lpos", "_tgt", "_lalt", "_lvic", "_keep_going",
         "_leaderfn", "_callerfn", "_mindist"];
scriptName "fn_teleport.sqf";

_mindist = 100; // meters

// These are only used for logging or messages. E.g.:
// Corey Harris (UnitNATO_A1_AR)
_leaderfn = format ["%1 (%2)", name _leader, _leader];
_callerfn = format ["%1 (%2)", name _caller, _caller];

_keep_going = true;

// If the *leader* respawns, we have to teleport them to someone in their
// squad. We prefer the closest (to the player) unit as a TP location, since
// that is the most likely to not be under fire, but they have to be at least
// _mindist meters away (in case multiple people of the same unit respawn at
// the same time).
if (_leader == _caller) then {
    ["%1 (%2) is a leader, looking for a distant squad member",
        _callerfn, _caller] call mc_fnc_rptlog;
    private _seenmin = 10000000; // 10'000 km
    private _found = false;

    {
        private _dst = _x distance2d _caller;
        if (_dst > _mindist && _dst < _seenmin) then {
            ["Best candidate so far: %1 (%2) is %3m from caller",
                name _x, _x, _dst] call mc_fnc_rptlog;
            _leader = _x;
            _leaderfn = format ["%1 (%2)", name _leader, _leader];
            _seenmin = _dst;
            _found = true;
        };
    } foreach units _caller;

    if (_found) then {
        ["%1 is closest to %1, using as TP location",
            _leaderfn, _callerfn, _seenmin] call mc_fnc_rptlog;
    } else {
        hintSilent "All members of this squad are close to you, not teleporting.";
        _keep_going = false;
    };
};

if (!_keep_going) exitWith{};

_lpos = getPos _leader;
_lalt = _lpos select 2;
_lvic = vehicle _leader;

["Leader is %1, vic is %2, alt is %4", _leader, _lvic, _lalt
    ] call mc_fnc_rptlog;

switch(true) do {
    // Leader is not in a vehicle and close to the ground/a walkable surface
    case (_lalt<=2 && (_lvic == _leader)): {
        ["%1 is on/near the ground and not in a vehicle, direct teleport",
            _leaderfn] call mc_fnc_rptlog;
        _tgt = _lpos findEmptyPosition [1, 10];
        _caller setPos _tgt;
    };

    // Leader is in a vehicle, and it's not a parachute
    case (_lvic != _leader && !(_lvic iskindof "Steerable_Parachute_F")): {
        private _succ = _caller moveInAny _lvic;
        if (!_succ) then {
            hintSilent format [
                "No more room in %1's vehicle, try again later",
                _leaderfn];
        };
    };
    // Leader's vic is a steerable parachute
    case (_lvic != _leader && _lvic iskindof "Steerable_Parachute_F"): {
        hintSilent format [
           "%1 is parachuting. Not teleporting for safety reasons.", _leaderfn];
    };
    // Leader is falling from > 2m
    case (_lvic == _leader && _lalt>2): {
        if (_lvic emptyPositions "cargo" == 0) then {
            hintSilent format [
                "%1 is %2m above ground and not in a vehicle. Not teleporting for safety reasons.",
                _leaderfn, _lalt];
        };
    };

    default {
        // Can't-happen catchall.
        ["Dunno what to do! leader: %1 lalt: %2, lvic: %3",
            _leader, _lalt, _lvic] call mc_fnc_rptlog;
        hintSilent format [
            "Teleport script broke! Take a screenshot and send it to klausman. leader: %1 caller: %2 lpos: %3 lalt: %4 lvic: %5",
            _leaderfn, _caller, _lpos, _lalt, _lvic
        ];
    };
};
// vim: sts=-1 ts=4 et sw=4
