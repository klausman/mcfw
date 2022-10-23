// klausman's simplified assignGear - AAF (IND_F) Faction

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
    _newLoadout = [["arifle_Mk20C_ACO_F","","","optic_ACO_grn",["30rnd_556x45_stanag",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",8],[],""],["U_I_OfficerUniform",[["FirstAidKit",1],["30rnd_556x45_stanag",3,30],["SmokeShellGreen",1,1]]],["V_BandollierB_oli",[["9Rnd_45ACP_Mag",2,8],["SmokeShellOrange",1,1],["SmokeShellPurple",1,1],["Chemlight_green",2,1]]],[],"H_MilCap_dgtl","",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]];
  };

  // 2IC and Squad leaders
  case "dc": {
    _newLoadout = [["arifle_Mk20_MRCO_pointer_F","","acc_pointer_IR","optic_MRCO",["30rnd_556x45_stanag",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",8],[],""],["U_I_CombatUniform_shortsleeve",[["FirstAidKit",1],["30rnd_556x45_stanag",3,30],["I_IR_Grenade",2,1],["Chemlight_green",1,1]]],["V_PlateCarrierIA2_dgtl",[["30Rnd_556x45_Stanag_Tracer_Yellow",2,30],["9Rnd_45ACP_Mag",2,8],["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellOrange",1,1],["SmokeShellPurple",1,1],["Chemlight_green",1,1]]],[],"H_HelmetIA","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]];
  };

  // Medic
  case "m": {
    _newLoadout = [["arifle_Mk20_pointer_F","","acc_pointer_IR","",["30rnd_556x45_stanag",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",8],[],""],["U_I_CombatUniform_shortsleeve",[["FirstAidKit",1],["30rnd_556x45_stanag",3,30],["SmokeShell",1,1]]],["V_PlateCarrierIA2_dgtl",[["30rnd_556x45_stanag",2,30],["9Rnd_45ACP_Mag",2,8],["SmokeShellGreen",1,1],["SmokeShellOrange",1,1],["SmokeShellPurple",1,1],["Chemlight_green",2,1]]],["I_Fieldpack_oli_Medic",[["Medikit",1],["FirstAidKit",10]]],"H_HelmetIA","UK3CB_BAF_G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]];
  };

  // Fire Team Leader
  case "ftl": {
    _newLoadout = [["arifle_Mk20_GL_MRCO_pointer_F","","acc_pointer_IR","optic_MRCO",["30rnd_556x45_stanag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",8],[],""],["U_I_CombatUniform",[["FirstAidKit",1],["30rnd_556x45_stanag",3,30]]],["V_PlateCarrierIAGL_dgtl",[["30Rnd_556x45_Stanag_Tracer_Yellow",2,30],["9Rnd_45ACP_Mag",2,8],["MiniGrenade",2,1],["1Rnd_HE_Grenade_shell",5,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellOrange",1,1],["SmokeShellPurple",1,1],["Chemlight_green",2,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1],["1Rnd_SmokePurple_Grenade_shell",1,1]]],[],"H_HelmetIA","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]];
  };

  // Automatic Rifleman
  case "ar": {
    _newLoadout = [["LMG_Mk200_LP_BI_F","","acc_pointer_IR","",["200Rnd_65x39_cased_Box",200],[],"bipod_03_F_blk"],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",8],[],""],["U_I_CombatUniform_shortsleeve",[["FirstAidKit",1],["9Rnd_45ACP_Mag",2,8],["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1]]],["V_PlateCarrierIA2_dgtl",[["200Rnd_65x39_cased_Box",2,200],["Chemlight_green",2,1]]],[],"H_HelmetIA_camo","G_Lowprofile",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]];
  };

  // Assistant Automatic Rifleman
  case "aar": {
    _newLoadout = [["arifle_Mk20_ACO_pointer_F","","acc_pointer_IR","optic_ACO_grn",["30rnd_556x45_stanag",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",8],[],""],["U_I_CombatUniform_tshirt",[["FirstAidKit",1],["30rnd_556x45_stanag",3,30],["I_IR_Grenade",2,1],["Chemlight_green",1,1]]],["V_Chestrig_oli",[["30rnd_556x45_stanag",4,30],["9Rnd_45ACP_Mag",2,8],["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_TacticalPack_oli_AAR",[["optic_tws_mg",1],["bipod_03_F_blk",1],["muzzle_snds_H",1],["200Rnd_65x39_cased_Box",3,200],["200Rnd_65x39_cased_Box_Tracer",1,200]]],"H_HelmetIA","",["Rangefinder","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]];
  };

  // Rifleman (AT)
  case "rat": {
    _newLoadout = [["rhs_weap_m4a1_blockII","","","RKSL_optic_EOT552",["rhs_mag_30Rnd_556x45_M855_PMAG_Tan_Tracer_Red",30],[],""],["launch_MRAWS_olive_F","","","",["MRAWS_HEAT_F",1],[],""],["hlc_pistol_P229R_357Combat","","","",["hlc_10Rnd_357SIG_B_P229",10],[],""],["MNP_CombatUniform_Germany",[["ACE_fieldDressing",15],["ACE_morphine",10],["SmokeShell",1,1],["Chemlight_green",1,1],["hlc_12Rnd_357SIG_B_P226",2,12]]],["MNP_Vest_Germany_2",[["SmokeShellGreen",1,1],["Chemlight_green",1,1],["rhs_mag_30Rnd_556x45_M855_PMAG_Tan_Tracer_Red",8,30],["hlc_12Rnd_357SIG_B_P226",2,12]]],["TRYK_B_Carryall_wood",[["ACE_EntrenchingTool",1],["rhs_mag_an_m8hc",4,1],["HandGrenade",6,1],["Laserbatteries",1,1],["MRAWS_HEAT_F",3,1]]],"MNP_Helmet_Germany","",[],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]];
  };

  // Designated Marksman
  case "dm": {
    _newLoadout = [["srifle_EBR_MRCO_LP_BI_F","","acc_pointer_IR","optic_MRCO",["20Rnd_762x51_Mag",20],[],"bipod_03_F_blk"],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",8],[],""],["U_I_CombatUniform",[["FirstAidKit",1],["20Rnd_762x51_Mag",2,20]]],["V_PlateCarrierIA1_dgtl",[["20Rnd_762x51_Mag",5,20],["9Rnd_45ACP_Mag",2,8],["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],[],"H_HelmetIA","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]];
  };

  // This block is executed if the unit assignGear was called on does
  // not have a known type. So do nothing except warn the MM about this
  default {
    // the if (true) is necessary due to the way exitWith works
    ["Unit:%1. Gear template %2 does not exist, loadout not changed.", _unit, _typeofunit
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
