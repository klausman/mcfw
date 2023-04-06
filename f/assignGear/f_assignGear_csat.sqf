// klausman's simplified assignGear - CSAR (OPF_F) Faction

// List of commonly-used types of units:
//  co  - commander
//  dc  - deputy commander / squad leader
//  m   - medic
//  ftl - fire team leader
//  ar  - automatic rifleman
//  aar - assistant automatic rifleman
//  rat - rifleman (AT)
//  dm  - designated marksman
//  mmgg    - medium mg gunner
//  mmgag   - medium mg assistant
//  matg    - medium AT gunner
//  matag   - medium AT assistant
//  hmgg    - heavy mg gunner (deployable)
//  hmgag   - heavy mg assistant (deployable)
//  hatg    - heavy AT gunner (deployable)
//  hatag   - heavy AT assistant (deployable)
//  mtrg    - mortar gunner (deployable)
//  mtrag   - mortar assistant (deployable)
//  msamg   - medium SAM gunner
//  msamag  - medium SAM assistant gunner
//  hsamg   - heavy SAM gunner (deployable)
//  hsamag  - heavy SAM assistant gunner (deployable)
//  sn  - sniper
//  sp  - spotter (for sniper)
//  vc  - vehicle commander
//  vg  - vehicle gunner
//  vd  - vehicle driver (repair)
//  pp  - air vehicle pilot / co-pilot
//  pcc - air vehicle co-pilot (repair) / crew chief (repair)
//  pc  - air vehicle crewman
//  eng - engineer (demo)
//  engm    - engineer (mines)
//  uav - UAV operator
//  div - diver
//  r   - rifleman
//  car - carabineer
//  smg - submachinegunner
//  gren    - grenadier

// NOTE: Those strings are abritrary. That is, if you want to have any
// random name for unit types, you can make them up. E.g., if you have
// a placed unit with this in its init function:
//
// ["herpderp",this] call f_fnc_assignGear;
//
// and in the switch statement below, a section like this:
//
// case "herpderp": {
//    _newLoadout = [[...stuff...]];
// };
//
// Then the unit will get the "stuff" loadout. This way, you can have
// multiple different types of Automatic Rifleman, for example.
params ["_typeOfUnit", "_unit"];

//       NOTE
//     ========
//
// CBA/ACE changed what is exported from the Arsenal in v3.15.2. Before that version, the
// export function in the ACE Arsenal would give you a unit loadout that could be directly
// used with Arma's setUnitLoadout function. After that, the exported string is meant to
// be used with CBA's CBA_fnc_setLoadout. The difference is that the latter function expects
// a wrapped version of the base game loadout. Specifically, a "classic" loadout looks like
// this:
//
//   [["arifle_MXC_ACO_F","","","",["30Rnd_65x39_caseless_mag",30] ... ,"ItemWatch",""]]
//
// whereas the CBA wrapped version of that loadout is
//
//  [[["arifle_MXC_ACO_F","","","",["30Rnd_65x39_caseless_mag",30] ... ,"ItemWatch",""]], []]
//
// So the easiest way of distinguishing the two is whether or not it starts with two square
// brackets ([[ - base game format) or three ([[[ - CBA extended format).
//
// IMPORTANT: This script, as is, will support _both_ formats.


// First, save the original extended loadout in case none of the switch branches below
// actually matches, in essence not changing the loadout.
private _newLoadout = [_unit] call CBA_fnc_getLoadout;

// Depending on _typeofUnit, give them a loadout exported from the ACE Arsenal
switch (_typeofUnit) do {
  // Commanding Officer
  case "co": {
    _newLoadout = [["arifle_Katiba_C_ACO_F","","","optic_ACO_grn",["30Rnd_65x39_caseless_green",30],[],""],[],["hgun_Pistol_heavy_02_Yorris_F","","","optic_Yorris",["6Rnd_45ACP_Cylinder",6],[],""],["U_O_OfficerUniform_ocamo",[["FirstAidKit",1],["30Rnd_65x39_caseless_green",2,30],["Chemlight_red",1,1]]],["V_BandollierB_khk",[["30Rnd_65x39_caseless_green",1,30],["6Rnd_45ACP_Cylinder",2,6],["SmokeShell",1,1],["SmokeShellRed",1,1],["Chemlight_red",1,1]]],[],"H_Beret_ocamo","",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]];
  };

  // 2IC and Squad leaders
  case "dc": {
    _newLoadout = [["arifle_Katiba_ARCO_pointer_F","","acc_pointer_IR","optic_Arco_blk_F",["30Rnd_65x39_caseless_green",30],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["U_O_CombatUniform_ocamo",[["FirstAidKit",1],["30Rnd_65x39_caseless_green",2,30]]],["V_TacVest_khk",[["30Rnd_65x39_caseless_green",1,30],["30Rnd_65x39_caseless_green_mag_Tracer",2,30],["16Rnd_9x21_Mag",2,17],["HandGrenade",2,1],["O_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellRed",1,1],["SmokeShellOrange",1,1],["SmokeShellYellow",1,1],["Chemlight_red",2,1]]],[],"H_HelmetLeaderO_ocamo","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]];
  };

  // Medic
  case "m": {
    _newLoadout = [["arifle_Katiba_pointer_F","","acc_pointer_IR","",["30Rnd_65x39_caseless_green",30],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["U_O_CombatUniform_ocamo",[["FirstAidKit",1],["30Rnd_65x39_caseless_green",2,30]]],["V_TacVest_khk",[["30Rnd_65x39_caseless_green",3,30],["16Rnd_9x21_Mag",2,17],["SmokeShell",1,1],["SmokeShellRed",1,1],["SmokeShellOrange",1,1],["SmokeShellYellow",1,1],["Chemlight_red",2,1]]],["B_FieldPack_ocamo_Medic",[["Medikit",1],["FirstAidKit",10]]],"H_HelmetO_ocamo","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]];
  };

  // Fire Team Leader
  case "ftl": {
    _newLoadout = [["arifle_Katiba_GL_ARCO_pointer_F","","acc_pointer_IR","optic_Arco_blk_F",["30Rnd_65x39_caseless_green",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["U_O_CombatUniform_ocamo",[["FirstAidKit",1],["30Rnd_65x39_caseless_green",2,30]]],["V_HarnessOGL_brn",[["30Rnd_65x39_caseless_green",1,30],["30Rnd_65x39_caseless_green_mag_Tracer",2,30],["16Rnd_9x21_Mag",2,17],["MiniGrenade",2,1],["1Rnd_HE_Grenade_shell",5,1],["SmokeShell",1,1],["SmokeShellRed",1,1],["SmokeShellOrange",1,1],["SmokeShellYellow",1,1],["Chemlight_red",2,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeRed_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1],["1Rnd_SmokeYellow_Grenade_shell",1,1]]],[],"H_HelmetLeaderO_ocamo","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]];
  };

  // Automatic Rifleman
  case "ar": {
    _newLoadout = [["LMG_Zafir_pointer_F","","acc_pointer_IR","",["150Rnd_762x54_Box",150],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["U_O_CombatUniform_ocamo",[["FirstAidKit",1],["16Rnd_9x21_Mag",2,17],["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellRed",1,1]]],["V_HarnessO_brn",[["150Rnd_762x54_Box",3,150],["Chemlight_red",2,1]]],[],"H_HelmetO_ocamo","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]];
  };

  // Assistant Automatic Rifleman
  case "aar": {
    _newLoadout = [["arifle_Katiba_ACO_pointer_F","","acc_pointer_IR","optic_ACO_grn",["30Rnd_65x39_caseless_green",30],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["U_O_CombatUniform_ocamo",[["FirstAidKit",1],["30Rnd_65x39_caseless_green",2,30]]],["V_Chestrig_khk",[["30Rnd_65x39_caseless_green",5,30],["16Rnd_9x21_Mag",2,17],["HandGrenade",2,1],["O_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellRed",1,1],["Chemlight_red",2,1]]],["B_Carryall_ocamo_AAR",[["optic_tws_mg",1],["bipod_02_F_hex",1],["muzzle_snds_93mmg",1],["150Rnd_762x54_Box",1,150],["150Rnd_762x54_Box_Tracer",1,150],["150Rnd_93x64_Mag",2,150]]],"H_HelmetO_ocamo","",["Rangefinder","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]];
  };

  // Rifleman (AT)
  case "rat": {
    _newLoadout = [["arifle_Katiba_ACO_F","","","optic_ACO_grn",["30Rnd_65x39_caseless_green",30],[],""],["launch_RPG32_F","","","",["RPG32_F",1],[],""],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["U_O_CombatUniform_ocamo",[["FirstAidKit",1],["30Rnd_65x39_caseless_green",2,30]]],["V_TacVest_khk",[["30Rnd_65x39_caseless_green",3,30],["16Rnd_9x21_Mag",2,17],["SmokeShell",1,1],["SmokeShellRed",1,1],["Chemlight_red",2,1]]],["B_FieldPack_cbr_LAT",[["RPG32_F",2,1],["RPG32_HE_F",2,1]]],"H_HelmetO_ocamo","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]];
  };

  // Designated Marksman
  case "dm": {
    _newLoadout = [["srifle_DMR_01_DMS_BI_F","","","optic_dms",["10Rnd_762x54_Mag",10],[],"bipod_02_F_blk"],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",17],[],""],["U_O_CombatUniform_ocamo",[["FirstAidKit",1],["10Rnd_762x54_Mag",3,10],["SmokeShell",1,1]]],["V_TacVest_khk",[["10Rnd_762x54_Mag",6,10],["16Rnd_9x21_Mag",2,17],["HandGrenade",2,1],["SmokeShellRed",1,1],["Chemlight_red",2,1]]],[],"H_HelmetO_ocamo","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]];
  };

  // This block is executed if the unit assignGear was called on does
  // not have a known type. So do nothing except warn the MM about this
  default {
    ["AssignGear-CSAT", "Unit:%1. Gear template %2 does not exist, loadout not changed.", _unit, _typeofunit
        ] call mc_fnc_bothlog;
  };
// End of loadouts
};

if (count _newLoadout == 10) then {
    // Base game loadout
    _unit setUnitLoadout _newLoadout;
} else {
    // CBA extended loadout
    // We use "false" for the "refill mags" bool since the mission maker may have
    // given players partial magazines intentionally.
    [_unit, _newLoadout, false] call CBA_fnc_setLoadout;
};

// vim: sts=-1 ts=4 et sw=4
