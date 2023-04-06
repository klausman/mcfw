// klausman's simplified assignGear - NATO Faction

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
    _newLoadout = [["arifle_MXC_ACO_F","","","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_Pistol_heavy_01_MRD_F","","","optic_MRD",["11Rnd_45ACP_Mag",11],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["SmokeShell",1,1],["Chemlight_green",1,1]]],["V_BandollierB_rgr",[["30Rnd_65x39_caseless_mag",1,30],["11Rnd_45ACP_Mag",2,11],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],[],"H_MilCap_mcamo","",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]];
  };

  // 2IC and Squad leaders
  case "dc": {
    _newLoadout = [["arifle_MXC_ACO_F","","","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_Pistol_heavy_01_MRD_F","","","optic_MRD",["11Rnd_45ACP_Mag",11],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["SmokeShell",1,1],["Chemlight_green",1,1]]],["V_BandollierB_rgr",[["30Rnd_65x39_caseless_mag",1,30],["11Rnd_45ACP_Mag",2,11],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],[],"H_MilCap_mcamo","",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]];
  };

  // Medic
  case "m": {
    _newLoadout = [["arifle_MX_pointer_F","","acc_pointer_IR","",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",17],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30]]],["V_PlateCarrierSpec_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,17],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",2,1]]],["B_AssaultPack_rgr_Medic",[["Medikit",1],["FirstAidKit",10]]],"H_HelmetB_light_desert","rhs_googles_orange",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]];
  };

  // Fire Team Leader
  case "ftl": {
    _newLoadout = [["arifle_MX_GL_Hamr_pointer_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",17],[],""],["U_B_CombatUniform_mcam_vest",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30]]],["V_PlateCarrierGL_rgr",[["30Rnd_65x39_caseless_mag",1,30],["30Rnd_65x39_caseless_mag_Tracer",2,30],["16Rnd_9x21_Mag",2,17],["MiniGrenade",2,1],["1Rnd_HE_Grenade_shell",5,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",2,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeBlue_Grenade_shell",1,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1]]],[],"H_HelmetSpecB","UK3CB_BAF_G_Tactical_Clear",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]];
  };

  // Automatic Rifleman
  case "ar": {
    _newLoadout = [["arifle_MX_SW_pointer_F","","acc_pointer_IR","",["100Rnd_65x39_caseless_mag",100],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",17],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",1],["SmokeShell",1,1],["HandGrenade",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["V_PlateCarrier2_rgr",[["100Rnd_65x39_caseless_mag",5,100],["16Rnd_9x21_Mag",2,17],["Chemlight_green",1,1]]],[],"H_HelmetB_grass","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]];
  };

  // Assistant Automatic Rifleman
  case "aar": {
    _newLoadout = [["arifle_MX_ACO_pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",17],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30]]],["V_Chestrig_rgr",[["30Rnd_65x39_caseless_mag",5,30],["16Rnd_9x21_Mag",2,17],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],["B_Kitbag_rgr_AAR",[["optic_tws_mg",1],["bipod_01_F_snd",1],["muzzle_snds_338_sand",1],["muzzle_snds_H",1],["100Rnd_65x39_caseless_mag",2,100],["100Rnd_65x39_caseless_mag_Tracer",2,100],["130Rnd_338_Mag",2,130]]],"H_HelmetB_light","UK3CB_BAF_G_Tactical_Black",["Rangefinder","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]];
  };

  // Rifleman (AT)
  case "rat": {
    _newLoadout = [["arifle_MX_ACO_pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],["launch_NLAW_F","","","",[],[],""],["hgun_P07_F","","","",["16Rnd_9x21_Mag",17],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30]]],["V_PlateCarrier2_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,17],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],["B_AssaultPack_rgr_LAT",[["NLAW_F",2,1]]],"H_HelmetB_sand","rhs_googles_orange",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]];
  };

  // Designated Marksman
  case "dm": {
    _newLoadout = [["arifle_MXM_Hamr_LP_BI_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",17],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30]]],["V_PlateCarrier1_rgr",[["30Rnd_65x39_caseless_mag",5,30],["16Rnd_9x21_Mag",2,17],["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],[],"H_HelmetB_grass","UK3CB_BAF_G_Tactical_Grey",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]];
  };

  // This block is executed if the unit assignGear was called on does
  // not have a known type. So do nothing except warn the MM about this
  default {
    // the if (true) is necessary due to the way exitWith works
    ["AssignGear-NATO", "Unit:%1. Gear template %2 does not exist, used Rifleman instead.", _unit,_typeofunit
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
