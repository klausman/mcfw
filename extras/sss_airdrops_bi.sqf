// Custom Airdrops for Simplex Support Services
// Author: klausman
// License: Apache 2 (https://www.apache.org/licenses/LICENSE-2.0)
//
// There is no need to edit this file. For more info see sss_airdrops.sqf or
// https://www.misfit-company.com/arma3/mission_making/sss_custom_airdrop/

params ["_box", "_boxidx", "_boxes", "_stuff"];
private ["_boxdef", "_markers"];

scriptName "sss_airdrops_bi.sqf";

_boxdef = _boxes select _boxidx;

["SAD-Boxinit", "Initizializing box %1 (type %2, %3)", _box, _boxidx, _boxdef
    ] call mc_fnc_rptlog;

_stuff = _boxdef select 4;

clearItemCargoGlobal     _box;
clearWeaponCargoGlobal   _box;
clearMagazineCargoGlobal _box;
clearBackpackCargoGlobal _box;

{
  private _thing = _x select 0;
  private _count = _x select 1;
  private _isBackpack = [_thing] call ace_backpacks_fnc_isBackpack;
  private _itemType = ([_thing] call ace_common_fnc_getItemType) select 0;

  switch (true) do {
      case (_isBackpack): {
      _box addBackpackCargoGlobal [_thing, _count];
      };
      case (_itemType == "weapon"): {
      _box addWeaponCargoGlobal [_thing, _count];
      };
      case (_itemType == "magazine"): {
      _box addMagazineCargoGlobal [_thing, _count];
      };
      default {
      _box addItemCargoGlobal [_thing, _count]; //default "item"
      };
  };
} foreach _stuff;

_markers =  _boxdef select 3;
if (count _markers > 0) then {
  [
   // Condition
   {isNull (_this select 0)|| {getPos (_this select 0) select 2 < 2}},
   // Code
   {params ["_pos", "_smks"];
    ["SAD-Boxinit", "Popping markers at %1 (one each of %2)", _pos, _smks ] call mc_fnc_rptlog;
    {_x createVehicle _pos;} foreach _smks;
   },
   // Params
   [_box, _markers]
  ] call CBA_fnc_waitUntilAndExecute;
};

// vim: sts=-1 ts=4 et sw=4
