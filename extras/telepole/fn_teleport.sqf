// Teleport script

private ["_leader", "_lpos", "_tgt", "_caller", "_lalt", "_lvic", "_debug"];

_leader = _this select 0;
_caller = _this select 1;

_lpos = getPos _leader;
_lalt = _lpos select 2;
_lvic = vehicle _leader;

switch(true) do {
    // Leader is not in a vehicle and close to the ground/walkable surfave
    case (_lalt<=2 && (_lvic == _leader)): {
        ["telepole",
         "%1 is on/near the ground and not in a vehicle, direct teleport",
         _leader
        ] call mc_fnc_rptlog;
        _tgt = _lpos findEmptyPosition [1, 10];
       _caller setPos _tgt;
    };

    // Leader is in a vehicle, and it's not a parachute
    case (_lvic != _leader && !(_lvic iskindof "Steerable_Parachute_F")): {
        if (_lvic emptyPositions "cargo" == 0) then {
            private _vicname = getText (configFile >> "CfgVehicles" >>
                typeOf _lvic >> "displayName");
            hintSilent format [
                "No more room in %1's vehicle (%2), try again later",
                name _leader, _vicname
            ];
        } else {
            _caller moveincargo _lvic;
        };
    };
    // Leader's vic is a steerable parachute
    case (_lvic != _leader && _lvic iskindof "Steerable_Parachute_F"): {
        if (_lvic emptyPositions "cargo" == 0) then {
            hintSilent format [
                "%1 is parachuting. Not teleporting for safety reasons.",
                _leader
            ];
        };
    };
    // Leader is falling from > 2m 
    case (_lvic == _leader && _lalt>2): {
        if (_lvic emptyPositions "cargo" == 0) then {
            hintSilent format [
                "%1 is %2m above ground and not in a vehicle. Not teleporting for safety reasons.",
                _leader, _lalt
            ];
        };
    };

    default {
        // Can't-happen catchall.
        private _vicname = getText (
            configFile >> "CfgVehicles" >> typeOf _lvic >> "displayName");
        ["telepole", "Dunno what to do! leader: %1 lalt: %2, lvic: %3 vicname: %4",
             _leader, _lalt, _lvic, _vicname] call mc_fnc_rptlog;
        hintSilent format [
            "Teleport script broke! Take a screenshot and send it to klausman. leader: %1 caller: %2 lpos: %3 lalt: %4 lvic: %5 vicname: %6",
            _leader, _caller, _lpos, _lalt, _lvic, _vicname
        ];
    };
};
// vim: sts=-1 ts=4 et sw=4
