// Custom Airdrops for Simplex Support Services
// Author: klausman
// License: Apache 2 (https://www.apache.org/licenses/LICENSE-2.0)
//
// Full documentation at:
// https://www.misfit-company.com/arma3/mission_making/sss_custom_airdrop/
//
// Quick Usage:
// - Add this script and the two companion scripts (sss_airdrops_bi.sqf and
//   sss_airdrops_gl.sqf) to your mission in a subfolder called `extras`
// - edit box contents as indicated below, then add a SSS Logistics
//   Airdrop module to your mission and add this line in `List function`:
//   ["gl"] call compile preprocessFileLineNumbers "extras\sss_airdrops.sqf"
//
params["_mode", "_box", "_boxidx", "_boxes"];

scriptName "sss_airdrops.sqf";

["Called in mode %1", _mode] call mc_fnc_rptlog;

// BOX DEFINITIONS START

// FORMAT
// This should be an array of box definitions. Each Box definition has these
// components:
//
// [
//  "In-game Label",
//  "Box Classname",
//  "Icon",
//  ["Smoke", "Chemlight"],
//  [
//   ["some object class", N],
//   ["some other object class", N]
//  ]
// ]
//
// Label is what the players see in the logistics menu
// Box Classname is the box type, e.g. Box_NATO_Ammo_F. Vehicles work
//   the same way as boxes (including setting their inventory).
// Icon is used in the logistics menu and optional
// The Smoke or Chemlight list is a list of throwables that will be
//   spawned once the box hits the ground. Leave as [] for no markers.
// The next line sets the contents of the box. Note these are arrays of
//   classnames and numbers, setting the object and count of them (N).
//
// Example (two boxes of the same type, but with different contents,
// with the second getting a orange smoke shell on touchdown):
_boxes = [
  ["Rifle Ammo", "Box_NATO_Ammo_F", "", [],
   [
    ["rhs_mag_30Rnd_556x45_M855_PMAG_Tan_Tracer_Red", 50],
    ["U_B_CombatUniform_mcam", 10]
   ]
  ],
  ["AR Ammo", "B_supplyCrate_F", "", ["SmokeShellOrange"],
   [
    ["rhsusf_200Rnd_556x45_M855_mixed_soft_pouch", 10],
    ["hlc_lmg_mk46mod1", 2],
    ["ACE_fieldDressing", 100],
    ["ACE_bloodIV_500", 30]
   ]
  ]
];

// BOX DEFINITIONS END -- no need to edit below this line

if (_mode == "bi") exitWith {
    [_box, _boxidx, _boxes] call
    compile preprocessFileLineNumbers "extras\sss_airdrops_bi.sqf";
};

if (_mode == "gl") exitWith {
    [_boxes] call
    compile preprocessFileLineNumbers "extras\sss_airdrops_gl.sqf";
};

// vim: sts=-1 ts=4 et sw=4
