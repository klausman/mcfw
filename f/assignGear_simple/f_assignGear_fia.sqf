// klausman's simplified assignGear - FIA (IND_G_F etc) Faction

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
//    _unit setUnitLoadout [[...stuff...]];
// };
//
// Then the unit will get the "stuff" loadout. This way, you can have
// multiple different types of Automatic Rifleman, for example.
params ["_typeOfUnit", "_unit"];

// Remove everything
removeBackpack _unit;
removeAllWeapons _unit;
removeAllItemsWithMagazines _unit;
removeAllAssignedItems _unit;

// Depending on _typeofUnit, give them a loadout exported from the ACE Arsenal
switch (_typeofUnit) do {
  // Commanding Officer
  case "co": {
    _unit setUnitLoadout [["arifle_TRG21_MRCO_F","","","optic_MRCO",["30rnd_556x45_stanag",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",8],[],""],["U_IG_Guerilla2_3",[["FirstAidKit",1],["30rnd_556x45_stanag",2,30],["Chemlight_blue",1,1]]],["V_Chestrig_oli",[["30rnd_556x45_stanag",1,30],["9Rnd_45ACP_Mag",1,8],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellRed",1,1],["SmokeShellBlue",1,1],["Chemlight_blue",1,1]]],[],"H_Watchcap_blk","",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]];
  };

  // 2IC and Squad leaders
  case "dc": {
    _unit setUnitLoadout [["arifle_TRG20_ACO_F","","","optic_ACO_grn",["30rnd_556x45_stanag",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",8],[],""],["U_IG_leader",[["FirstAidKit",1],["30rnd_556x45_stanag",3,30],["SmokeShell",1,1]]],["V_Chestrig_blk",[["30Rnd_556x45_Stanag_Tracer_Yellow",2,30],["9Rnd_45ACP_Mag",1,8],["HandGrenade",1,1],["MiniGrenade",1,1],["SmokeShellGreen",1,1],["SmokeShellRed",1,1],["SmokeShellBlue",1,1],["Chemlight_blue",2,1]]],[],"H_Watchcap_blk","G_Squares_Tinted",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]];
  };

  // Medic
  case "m": {
    _unit setUnitLoadout [["arifle_Mk20_F","","","",["30rnd_556x45_stanag",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",8],[],""],["U_IG_Guerilla2_3",[["FirstAidKit",1],["30rnd_556x45_stanag",2,30],["Chemlight_blue",1,1]]],["V_TacVest_blk",[["30rnd_556x45_stanag",3,30],["9Rnd_45ACP_Mag",1,8],["MiniGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellRed",1,1],["SmokeShellBlue",1,1],["Chemlight_blue",1,1]]],["G_FieldPack_Medic",[["Medikit",1]]],"H_Cap_oli","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]];
  };

  // Fire Team Leader
  case "ftl": {
    _unit setUnitLoadout [["arifle_Mk20_GL_ACO_F","","","optic_ACO_grn",["30rnd_556x45_stanag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",8],[],""],["U_IG_leader",[["FirstAidKit",1],["30rnd_556x45_stanag",3,30]]],["V_TacVest_blk",[["30Rnd_556x45_Stanag_Tracer_Yellow",2,30],["9Rnd_45ACP_Mag",1,8],["HandGrenade",1,1],["MiniGrenade",1,1],["1Rnd_HE_Grenade_shell",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeRed_Grenade_shell",1,1],["1Rnd_SmokeBlue_Grenade_shell",1,1]]],[],"H_Booniehat_khk","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]];
  };

  // Automatic Rifleman
  case "ar": {
    _unit setUnitLoadout [["LMG_Mk200_BI_F","","","",["200Rnd_65x39_cased_Box",200],[],"bipod_03_F_blk"],[],[],["U_IG_Guerilla2_1",[["FirstAidKit",1],["MiniGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1]]],["V_TacVest_blk",[["200Rnd_65x39_cased_Box",2,200]]],[],"H_Bandanna_khk","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]];
  };

  // Assistant Automatic Rifleman
  case "aar": {
    _unit setUnitLoadout [["arifle_TRG20_F","","","",["30rnd_556x45_stanag",30],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["30rnd_556x45_stanag",2,30],["Chemlight_blue",1,1]]],["V_Chestrig_oli",[["30rnd_556x45_stanag",9,30],["HandGrenade",1,1],["MiniGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",1,1]]],["G_Carryall_Ammo",[["FirstAidKit",4],["30rnd_556x45_stanag",8,30],["200Rnd_65x39_cased_Box",1,200],["RPG32_F",1,1],["HandGrenade",2,1],["MiniGrenade",2,1],["1Rnd_HE_Grenade_shell",6,1],["20Rnd_762x51_Mag",3,20],["SmokeShell",2,1],["SmokeShellGreen",1,1],["SmokeShellRed",1,1],["SmokeShellBlue",1,1]]],"H_Booniehat_khk","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]];
  };

  // Rifleman (AT)
  case "rat": {
    _unit setUnitLoadout [["arifle_TRG21_F","","","",["30rnd_556x45_stanag",30],[],""],["launch_RPG32_F","","","",["RPG32_F",1],[],""],[],["U_IG_Guerrilla_6_1",[["FirstAidKit",1],["30rnd_556x45_stanag",2,30],["Chemlight_blue",1,1]]],["V_TacVest_blk",[["30rnd_556x45_stanag",3,30],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",1,1]]],["G_FieldPack_LAT",[["RPG32_F",2,1],["RPG32_HE_F",1,1]]],"H_Bandanna_khk","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]];
  };

  // Designated Marksman
  case "dm": {
    _unit setUnitLoadout [["arifle_Mk20_MRCO_F","","","optic_MRCO",["30rnd_556x45_stanag",30],[],""],[],[],["U_IG_Guerilla3_1",[["FirstAidKit",1],["30rnd_556x45_stanag",4,30],["MiniGrenade",1,1]]],["V_BandollierB_khk",[["30rnd_556x45_stanag",3,30],["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1]]],[],"H_Shemag_olive","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]];
  };

  // This block is executed if the unit assignGear was called on does
  // not have a known type. So do nothing except warn the MM about this
  default {
    // the if (true) is necessary due to the way exitWith works
    if (true) exitwith {
         ["Unit:%1. Gear template %2 does not exist, used Rifleman instead.",
            _unit,_typeofunit] call mc_fnc_bothlog;
    };
  };
// End of loadouts
};

// Make sure the primary weapon is in the unit's hands.
_unit selectweapon primaryweapon _unit;

// vim: sts=-1 ts=4 et sw=4
