// Custom Airdrops for Simplex Support Services
// Author: klausman
// License: Apache 2 (https://www.apache.org/licenses/LICENSE-2.0)
//
// There is no need to edit this file. For more info see sss_airdrops.sqf or
// https://www.misfit-company.com/arma3/mission_making/sss_custom_airdrop/

params ["_boxes"];

private ["_l", "_idx", "_bt", "_bl", "_bi", "_code"];

_idx = 0;
_l = [];
{
  _bl = _x select 0;  // Type (class)
  _bt = _x select 1;  // Label (as shown to players)
  _bi = _x select 2;  // Icon

  // BI SQF nested strings are f'ing Czech Voodoo
  _code = format ["[""bi"", _this, %1] call compile preprocessFileLineNumbers ""extras\sss_airdrops.sqf""; ", _idx];

  _l pushBack [_bt, _bl, _bi, compile _code];
  _idx = _idx + 1;
} foreach _boxes;

_l; // DO NOT REMOVE THIS LINE!
