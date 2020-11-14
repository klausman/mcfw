// Assign Gear Script - NATO
params ["_typeOfUnit", "_unit"];

private ["_attach1","_attach2","_silencer1","_silencer2","_scope1","_scope2","_scope3","_bipod1","_bipod2","_attachments","_silencer","_hg_silencer1","_hg_scope1","_hg_attachments","_rifle","_riflemag","_riflemag_tr","_carbine","_carbinemag","_carbinemag_tr","_smg","_smgmag","_smgmag_tr","_diverWep","_diverMag1","_diverMag2","_glrifle","_glriflemag","_glriflemag_tr","_glmag","_glsmokewhite","_glsmokegreen","_glsmokered","_glflarewhite","_glflarered","_glflareyellow","_glflaregreen","_pistol","_pistolmag","_grenade","_Mgrenade","_smokegrenade","_smokegrenadegreen","_nvg","_uavterminal","_chemgreen","_chemred","_chemyellow","_chemblue","_bagsmall","_bagmedium","_baglarge","_bagmediumdiver","_baguav","_baghmgg","_baghmgag","_baghatg","_baghatag","_bagmtrg","_bagmtrag","_baghsamg","_baghsamag","_AR","_ARmag","_ARmag_tr","_MMG","_MMGmag","_MMGmag_tr","_Tracer","_DMrifle","_DMriflemag","_RAT","_RATmag","_MAT","_MATmag1","_MATmag2","_HAT","_HATmag1","_HATmag2","_SAM","_SAMmag","_SNrifle","_SNrifleMag","_ATmine","_satchel","_APmine1","_APmine2","_light","_heavy","_diver","_pilot","_crew","_ghillie","_specOp","_baseUniform","_baseHelmet","_baseGlasses","_lightRig","_mediumRig","_heavyRig","_diverUniform","_diverHelmet","_diverRig","_diverGlasses","_pilotUniform","_pilotHelmet","_pilotRig","_pilotGlasses","_crewUniform","_crewHelmet","_crewRig","_crewGlasses","_ghillieUniform","_ghillieHelmet","_ghillieRig","_ghillieGlasses","_sfuniform","_sfhelmet","_sfRig","_sfGlasses","_typeofUnit","_unit","_isMan","_backpack","_typeofBackPack","_loadout","_COrifle","_mgrenade","_DCrifle","_FTLrifle","_armag","_ratmag","_typeofunit", "_lrradio", "_srradio", "_debug"];

_debug=false;
// DEFINE EQUIPMENT TABLES
// The blocks of code below identifies equipment for this faction
//
// Defined loadouts:
//      co          - commander
//      dc          - deputy commander / squad leader
//      m           - medic
//      ftl         - fire team leader
//      ar          - automatic rifleman
//      aar         - assistant automatic rifleman
//      rat         - rifleman (AT)
//      dm          - designated marksman
//      mmgg        - medium mg gunner
//      mmgag       - medium mg assistant
//      matg        - medium AT gunner
//      matag       - medium AT assistant
//      hmgg        - heavy mg gunner (deployable)
//      hmgag       - heavy mg assistant (deployable)
//      hatg        - heavy AT gunner (deployable)
//      hatag       - heavy AT assistant (deployable)
//      mtrg        - mortar gunner (deployable)
//      mtrag       - mortar assistant (deployable)
//      msamg       - medium SAM gunner
//      msamag      - medium SAM assistant gunner
//      hsamg       - heavy SAM gunner (deployable)
//      hsamag      - heavy SAM assistant gunner (deployable)
//      sn          - sniper
//      sp          - spotter (for sniper)
//      vc          - vehicle commander
//      vg          - vehicle gunner
//      vd          - vehicle driver (repair)
//      pp          - air vehicle pilot / co-pilot
//      pcc         - air vehicle co-pilot (repair) / crew chief (repair)
//      pc          - air vehicle crew
//      eng         - engineer (demo)
//      engm        - engineer (mines)
//      uav         - UAV operator"
//      div         - divers
//
//      r           - rifleman
//      car         - carabineer
//      smg         - submachinegunner
//      gren        - grenadier
//
//      v_car       - car/4x4
//      v_tr        - truck
//      v_ifv       - ifv
//      v_hel       - helo
//
//      crate_small - small ammocrate
//      crate_med   - medium ammocrate
//      crate_large - large ammocrate
//
// ==========================================================================

// GENERAL EQUIPMENT USED BY MULTIPLE CLASSES

// ATTACHMENTS - PRIMARY
_attach1 = "acc_pointer_IR";    // IR Laser
_attach2 = "acc_flashlight";    // Flashlight

_silencer1 = "muzzle_snds_M";   // 5.56 suppressor
_silencer2 = "muzzle_snds_H";   // 6.5 suppressor

_scope1 = "optic_Holosight";    // Holosight
_scope2 = "optic_MRCO";         // MRCO Scope - 1x - 6x
_scope3 = "optic_SOS";          // SOS Scope - 18x - 75x

_bipod1 = "bipod_01_F_snd";     // Default bipod
_bipod2 = "bipod_02_F_blk";     // Black bipod

// Default setup
// The default attachment set for most units, overwritten in the individual
// unitType
_attachments = [_attach1,_scope1];

// [] = remove all
// [_attach1,_scope1,_silencer] = remove all, add items assigned in _attach1,
// _scope1 and _silencer1
// [_scope2] = add _scope2, remove rest
// false = keep attachments as they are

// ==========================================================================

// ATTACHMENTS - HANDGUN
_hg_silencer1 = "muzzle_snds_acp";  // .45 suppressor

_hg_scope1 = "optic_MRD";           // MRD

// Default setup
// The default attachment set for handguns, overwritten in the individual
// unitType
_hg_attachments= [];

// ==========================================================================

// WEAPON SELECTION

// Standard Riflemen ( MMG Assistant Gunner, Assistant Automatic Rifleman, MAT
// Assistant Gunner, MTR Assistant Gunner, Rifleman)
_rifle = "arifle_MX_pointer_F";
_riflemag = "30Rnd_65x39_caseless_mag";
_riflemag_tr = "30Rnd_65x39_caseless_mag_Tracer";

// Standard Carabineer (Medic, Rifleman (AT), MAT Gunner, MTR Gunner,
// Carabineer)
_carbine = "arifle_MXC_F";
_carbinemag = "30Rnd_65x39_caseless_mag";
_carbinemag_tr = "30Rnd_65x39_caseless_mag_Tracer";

// Standard Submachine Gun/Personal Defence Weapon (Aircraft Pilot,
// Submachinegunner)
_smg = "SMG_01_F";
_smgmag = "30Rnd_45ACP_Mag_SMG_01";
_smgmag_tr = "30Rnd_45ACP_Mag_SMG_01_tracer_green";

// Diver
_diverWep = "arifle_SDAR_F";
_diverMag1 = "30Rnd_556x45_Stanag";
_diverMag2 = "20Rnd_556x45_UW_mag";

// Rifle with GL and HE grenades (CO, DC, FTLs)
_glrifle = "arifle_MX_GL_F";
_glriflemag = "30Rnd_65x39_caseless_mag";
_glriflemag_tr = "30Rnd_65x39_caseless_mag_Tracer";
_glmag = "1Rnd_HE_Grenade_shell";

// Smoke for FTLs, Squad Leaders, etc
_glsmokewhite = "1Rnd_Smoke_Grenade_shell";
_glsmokegreen = "1Rnd_SmokeGreen_Grenade_shell";
_glsmokered = "1Rnd_SmokeRed_Grenade_shell";

// Flares for FTLs, Squad Leaders, etc
_glflarewhite = "3Rnd_UGL_FlareWhite_F";
_glflarered = "3Rnd_UGL_FlareRed_F";
_glflareyellow = "3Rnd_UGL_FlareYellow_F";
_glflaregreen = "3Rnd_UGL_FlareGreen_F";

// Pistols (CO, DC, Automatic Rifleman, Medium MG Gunner)
_pistol = "hgun_Pistol_heavy_01_F";
_pistolmag = "11Rnd_45ACP_Mag";

// Grenades
_grenade = "HandGrenade";
_Mgrenade = "MiniGrenade";
_smokegrenade = "SmokeShell";
_smokegrenadegreen = "SmokeShellGreen";

// Night Vision Goggles (NVGoggles)
_nvg = "NVGoggles";

// UAV Terminal
_uavterminal = "B_UavTerminal";   // BLUFOR - FIA

// Chemlights
_chemgreen =  "Chemlight_green";
_chemred = "Chemlight_red";
_chemyellow =  "Chemlight_yellow";
_chemblue = "Chemlight_blue";

// Backpacks
_bagsmall = "B_AssaultPack_mcamo";      // carries 120, weighs 20
_bagmedium = "B_FieldPack_khk";         // carries 240, weighs 30
_baglarge =  "B_Carryall_mcamo";        // carries 320, weighs 40
_bagmediumdiver =  "B_AssaultPack_blk"; // used by divers
_baguav = "B_UAV_01_backpack_F";        // used by UAV operator
_baghmgg = "B_HMG_01_weapon_F";         // used by Heavy MG gunner
_baghmgag = "B_HMG_01_support_F";       // used by Heavy MG assistant gunner
_baghatg = "B_AT_01_weapon_F";          // used by Heavy AT gunner
_baghatag = "B_HMG_01_support_F";       // used by Heavy AT assistant gunner
_bagmtrg = "B_Mortar_01_weapon_F";      // used by Mortar gunner
_bagmtrag = "B_Mortar_01_support_F";    // used by Mortar assistant gunner
_baghsamg = "B_AA_01_weapon_F";         // used by Heavy SAM gunner
_baghsamag = "B_HMG_01_support_F";      // used by Heavy SAM assistant gunner

// ==========================================================================

// UNIQUE, ROLE-SPECIFIC EQUIPMENT

// Automatic Rifleman
_AR = "arifle_MX_SW_F";
_ARmag = "100Rnd_65x39_caseless_mag";
_ARmag_tr = "100Rnd_65x39_caseless_mag_Tracer";

// Medium MG
_MMG = "MMG_02_sand_F";
_MMGmag = "130Rnd_338_Mag";
_MMGmag_tr = "130Rnd_338_Mag";

// NON-DLC ALTERNATIVE:
// _MMG = "LMG_Zafir_F";
// _MMGmag = ""150Rnd_762x54_Box"";
// _MMGmag_tr = ""150Rnd_762x54_Box"_Tracer";

// Marksman rifle
_DMrifle = "srifle_DMR_03_tan_F";
_DMriflemag = "20Rnd_762x51_Mag";

// MAR-10
//_DMrifle = "srifle_DMR_02_F";
//_DMriflemag = "10Rnd_338_Mag";

// Rifleman AT
_RAT = "launch_NLAW_F";
_RATmag = "NLAW_F";

// Medium AT
_MAT = "launch_NLAW_F";
_MATmag1 = "NLAW_F";
_MATmag2 = "NLAW_F";

// Surface Air
_SAM = "launch_B_Titan_F";
_SAMmag = "Titan_AA";

// Heavy AT
_HAT = "launch_B_Titan_short_F";
_HATmag1 = "Titan_AT";
_HATmag2 = "Titan_AP";

// Sniper
_SNrifle = "srifle_LRR_F";
_SNrifleMag = "7Rnd_408_Mag";

// Engineer items
_ATmine = "ATMine_Range_Mag";
_satchel = "DemoCharge_Remote_Mag";
_APmine1 = "APERSBoundingMine_Range_Mag";
_APmine2 = "APERSMine_Range_Mag";

// ==========================================================================

// CLOTHES AND UNIFORMS

// Define classes. This defines which gear class gets which uniform
// "medium" vests are used for all classes if they are not assigned a specific
// uniform

_light = [];
_heavy =  ["eng","engm"];
_diver = ["div"];
_pilot = ["pp","pcc","pc"];
_crew = ["vc","vg","vd"];
_ghillie = ["sn","sp"];
_specOp = [];

// Basic clothing
// The outfit-piece is randomly selected from the array for each unit
_baseUniform = ["U_B_CombatUniform_mcam","U_B_CombatUniform_mcam_vest"];
_baseHelmet = ["H_HelmetB","H_HelmetB_plain_mcamo"];
_baseGlasses = [];

// Vests
_lightRig = ["V_BandollierB_cbr","V_BandollierB_khk"];
// "medium" is the default for all infantry classes
_mediumRig = ["V_PlateCarrier1_rgr","V_PlateCarrier2_rgr"];
_heavyRig = ["V_PlateCarrier3_rgr"];

// Diver
_diverUniform =  ["U_B_Wetsuit"];
_diverHelmet = [];
_diverRig = ["V_RebreatherB"];
_diverGlasses = ["G_Diving"];

// Pilot
_pilotUniform = ["U_B_HeliPilotCoveralls"];
_pilotHelmet = ["H_PilotHelmetHeli_B"];
_pilotRig = ["V_TacVest_blk"];
_pilotGlasses = [];

// Crewman
_crewUniform = ["U_B_CombatUniform_mcam_vest"];
_crewHelmet = ["H_HelmetCrew_B"];
_crewRig = ["V_TacVest_blk"];
_crewGlasses = [];

// Ghillie
// DLC alternatives:
// ["U_B_FullGhillie_lsh","U_B_FullGhillie_ard","U_B_FullGhillie_sard"];
_ghillieUniform = ["U_B_GhillieSuit"];
_ghillieHelmet = [];
_ghillieRig = ["V_Chestrig_rgr"];
_ghillieGlasses = [];

// Spec Op
_sfuniform = ["U_B_SpecopsUniform_sgg"];
_sfhelmet = ["H_HelmetSpecB","H_HelmetSpecB_paint1","H_HelmetSpecB_paint2","H_HelmetSpecB_blk"];
_sfRig = ["V_PlateCarrierSpec_rgr"];
_sfGlasses = [];

// ==========================================================================

// RADIOS

_srradio = "TFAR_anprc152";
_lrradio = "TFAR_rt1523g";

// ==========================================================================

// INTERPRET PASSED VARIABLES
// The following inrerprets formats what has been passed to this script
// element
_isMan = _unit isKindOf "CAManBase";

if (_debug) then {
    ["f\\assignGear\\f_assignGear_nato.sqf",
     "Unit '%1' is a '%2' (man: %3)",
     _unit, _typeofUnit, _isman] call mc_fnc_rptlog;
};

// ==========================================================================

// This block needs only to be run on an infantry unit
if (_isMan) then {

    // PREPARE UNIT FOR GEAR ADDITION
    // The following code removes all existing weapons, items, magazines and
    // backpacks
    removeBackpack _unit;
    removeAllWeapons _unit;
    removeAllItemsWithMagazines _unit;
    removeAllAssignedItems _unit;

    // HANDLE CLOTHES
    // Handle clothes and helmets and such using the include file called next.
    #include "f_assignGear_clothes.sqf";

    // ADD UNIVERSAL ITEMS
    // Add items universal to all units of this faction
    _unit linkItem _nvg;            // Night vision goggles
    _unit linkItem "ItemMap";       
    _unit linkItem "ItemCompass";   
    _unit linkItem "ItemWatch";
    // If you don't want everyone to have a SR radio, comment this line and
    // add lines like this to the individual units below.
    _unit linkItem _srradio;        
    //_unit linkItem "ItemGPS";     
};


// ==========================================================================

// SETUP BACKPACKS
// Include the correct backpack file for the faction

_backpack = {
    private _typeofBackPack = _typeOfUnit;
    private _loadout = f_param_backpacks;
    switch (_typeofBackPack) do {
        #include "f_assignGear_nato_b.sqf";
    };
};

// ==========================================================================

// DEFINE UNIT TYPE LOADOUTS
// The following blocks of code define loadouts for each type of unit (the
// unit type is passed to the script in the first variable)

switch (_typeofUnit) do {

    // COMMANDER
    case "co": {
        _unit addmagazines [_glriflemag,7];
        _unit addmagazines [_glriflemag_tr,2];
        _unit addmagazines [_glmag,3];
        _unit addmagazines [_glsmokewhite,4];
        _unit addweapon _glrifle;                       //_COrifle
        _unit addmagazines [_pistolmag,2];
        _unit addweapon _pistol;
        _unit addmagazines [_grenade,1];
        _unit addmagazines [_mgrenade,1];
        _unit addmagazines [_smokegrenade,2];
        _unit addmagazines [_smokegrenadegreen,2];
        _unit addWeapon "Rangefinder";
        _unit linkItem "ItemGPS";
        ["co"] call _backpack;
    };

    // DEPUTY COMMANDER AND SQUAD LEADER
    case "dc": {
        _unit addmagazines [_glriflemag,7];
        _unit addmagazines [_glriflemag_tr,2];
        _unit addmagazines [_glmag,3];
        _unit addmagazines [_glsmokewhite,4];
        _unit addweapon _glrifle;                       //_DCrifle
        _unit addmagazines [_pistolmag,2];
        _unit addweapon _pistol;
        _unit addmagazines [_grenade,1];
        _unit addmagazines [_mgrenade,1];
        _unit addmagazines [_smokegrenade,2];
        _unit addmagazines [_smokegrenadegreen,2];
        _unit addWeapon "Rangefinder";
        _unit linkItem "ItemGPS";
        ["dc"] call _backpack;
    };

    // MEDIC
    case "m": {
        _unit addmagazines [_carbinemag,7];
        _unit addweapon _carbine;
        _unit addmagazines [_smokegrenade,4];
        _unit linkItem "ItemGPS";
        ["m"] call _backpack;
    };

    // FIRE TEAM LEADER
    case "ftl": {
        _unit addmagazines [_glriflemag,7];
        _unit addmagazines [_glriflemag_tr,2];
        _unit addmagazines [_glmag,5];
        _unit addmagazines [_glsmokewhite,4];
        _unit addweapon _glrifle;                       //_FTLrifle
        _unit addmagazines [_grenade,1];
        _unit addmagazines [_mgrenade,1];
        _unit addmagazines [_smokegrenade,2];
        _unit addmagazines [_smokegrenadegreen,2];
        _unit addWeapon "Rangefinder";
        _unit linkItem "ItemGPS";
        ["g"] call _backpack;
    };


    // AUTOMATIC RIFLEMAN
    case "ar": {
        _unit addmagazines [_ARmag,4];
        _unit addweapon _AR;
        _unit addmagazines [_grenade,1];
        _unit addmagazines [_mgrenade,1];
        _unit addmagazines [_smokegrenade,2];
        _unit addmagazines [_pistolmag,4];
        _unit addweapon _pistol;
        ["ar"] call _backpack;
        _attachments pushback (_bipod1);
    };

    // ASSISTANT AUTOMATIC RIFLEMAN
    case "aar": {
        _unit addmagazines [_riflemag,7];
        _unit addmagazines [_riflemag_tr,2];
        _unit addweapon _rifle;
        _unit addmagazines [_grenade,2];
        _unit addmagazines [_mgrenade,2];
        _unit addmagazines [_smokegrenade,2];
        _unit addWeapon "Binocular";
        ["aar"] call _backpack;
    };

    // RIFLEMAN (AT)
    case "rat": {
        _unit addmagazines [_carbinemag,7];
        _unit addmagazines [_carbinemag_tr,2];
        _unit addweapon _carbine;
        _unit addmagazines [_grenade,1];
        _unit addmagazines [_mgrenade,1];
        _unit addmagazines [_smokegrenade,2];
        ["rat"] call _backpack;
        (unitBackpack _unit) addMagazineCargoGlobal [_RATmag,1];
        _unit addweapon _RAT;
    };

    // DESIGNATED MARKSMAN
    case "dm": {
        _unit addmagazines [_DMriflemag,7];
        _unit addweapon _DMrifle;
        _unit addmagazines [_grenade,2];
        _unit addmagazines [_mgrenade,2];
        _unit addmagazines [_smokegrenade,2];
        _unit addmagazines [_pistolmag,3];
        _unit addweapon _pistol;
        ["dm"] call _backpack;
        _attachments = [_attach1,_scope2];
    };

    // MEDIUM MG GUNNER
    case "mmgg": {
        _unit addmagazines [_MMGmag,1];
        _unit addweapon _MMG;
        _unit addmagazines [_MMGmag,2];
        _unit addmagazines [_smokegrenade,2];
        _unit addmagazines [_pistolmag,4];
        _unit addweapon _pistol;
        ["mmg"] call _backpack;
        _attachments pushback (_bipod1);
    };

    // MEDIUM MG ASSISTANT GUNNER
    case "mmgag": {
        _unit addmagazines [_riflemag,7];
        _unit addmagazines [_riflemag_tr,2];
        _unit addweapon _rifle;
        _unit addWeapon "Rangefinder";
        _unit addmagazines [_grenade,2];
        _unit addmagazines [_mgrenade,2];
        _unit addmagazines [_smokegrenade,2];
        ["mmgag"] call _backpack;
    };

    // HEAVY MG GUNNER
    case "hmgg": {
        _unit addmagazines [_carbinemag,7];
        _unit addmagazines [_carbinemag_tr,2];
        _unit addweapon _carbine;
        _unit addmagazines [_grenade,1];
        _unit addmagazines [_mgrenade,1];
        _unit addmagazines [_smokegrenade,1];
        ["hmgg"] call _backpack;
    };

    // HEAVY MG ASSISTANT GUNNER
    case "hmgag": {
        _unit addmagazines [_carbinemag,7];
        _unit addmagazines [_carbinemag_tr,2];
        _unit addweapon _carbine;
        _unit addWeapon "Rangefinder";
        _unit addmagazines [_grenade,1];
        _unit addmagazines [_mgrenade,1];
        _unit addmagazines [_smokegrenade,1];
        ["hmgag"] call _backpack;
    };

    // MEDIUM AT GUNNER
    case "matg": {
        ["matg"] call _backpack;
        _unit addmagazines [_carbinemag,7];
        _unit addmagazines [_carbinemag_tr,2];
        _unit addmagazines [_smokegrenade,2];
        _unit addweapon _carbine;
        _unit addweapon _MAT;
    };

    // MEDIUM AT ASSISTANT GUNNER
    case "matag": {
        _unit addmagazines [_carbinemag,7];
        _unit addmagazines [_carbinemag_tr,2];
        _unit addweapon _carbine;
        _unit addWeapon "Rangefinder";;
        _unit addmagazines [_grenade,1];
        _unit addmagazines [_mgrenade,1];
        _unit addmagazines [_smokegrenade,2];
        ["matag"] call _backpack;
    };

    // HEAVY AT GUNNER
    case "hatg": {
        _unit addmagazines [_carbinemag,7];
        _unit addweapon _carbine;
        ["hatg"] call _backpack;
        _unit addWeapon _HAT;
    };

    // HEAVY AT ASSISTANT GUNNER
    case "hatag": {
        _unit addmagazines [_carbinemag,7];
        _unit addmagazines [_carbinemag_tr,2];
        _unit addweapon _carbine;
        _unit addWeapon "Rangefinder";
        _unit addmagazines [_grenade,1];
        _unit addmagazines [_mgrenade,1];
        _unit addmagazines [_smokegrenade,1];
        ["hatag"] call _backpack;
    };

    // MORTAR GUNNER
    case "mtrg": {
        _unit addmagazines [_carbinemag,7];
        _unit addmagazines [_carbinemag_tr,2];
        _unit addweapon _carbine;
        _unit addmagazines [_grenade,1];
        _unit addmagazines [_mgrenade,1];
        _unit addmagazines [_smokegrenade,1];
        ["mtrg"] call _backpack;
    };

    // MORTAR ASSISTANT GUNNER
    case "mtrag": {
        _unit addmagazines [_carbinemag,7];
        _unit addmagazines [_carbinemag_tr,2];
        _unit addweapon _carbine;
        _unit addmagazines [_grenade,1];
        _unit addmagazines [_mgrenade,1];
        _unit addmagazines [_smokegrenade,1];
        _unit addWeapon "Rangefinder";
        ["mtrag"] call _backpack;
    };

    // MEDIUM SAM GUNNER
    case "msamg": {
        ["msamg"] call _backpack;
        _unit addmagazines [_carbinemag,7];
        _unit addmagazines [_carbinemag_tr,2];
        _unit addweapon _carbine;
        _unit addmagazines [_smokegrenade,1];
        _unit addmagazines [_grenade,1];
        _unit addweapon _SAM;
    };

    // MEDIUM SAM ASSISTANT GUNNER
    case "msamag": {
        _unit addmagazines [_carbinemag,7];
        _unit addmagazines [_carbinemag_tr,2];
        _unit addweapon _carbine;
        _unit addWeapon "Rangefinder";
        _unit addmagazines [_grenade,1];
        _unit addmagazines [_smokegrenade,1];
        ["msamag"] call _backpack;
    };

    // HEAVY SAM GUNNER
    case "hsamg": {
        _unit addmagazines [_carbinemag,7];
        _unit addmagazines [_carbinemag_tr,2];
        _unit addweapon _carbine;
        _unit addmagazines [_grenade,1];
        _unit addmagazines [_mgrenade,1];
        _unit addmagazines [_smokegrenade,1];
        ["hsamg"] call _backpack;
    };

    // HEAVY SAM ASSISTANT GUNNER
    case "hsamag": {
        _unit addmagazines [_carbinemag,7];
        _unit addmagazines [_carbinemag_tr,2];
        _unit addweapon _carbine;
        _unit addWeapon "Rangefinder";
        _unit addmagazines [_grenade,1];
        _unit addmagazines [_mgrenade,1];
        _unit addmagazines [_smokegrenade,1];
        ["hsamag"] call _backpack;
    };

    // SNIPER
    case "sn": {
        _unit addmagazines [_SNrifleMag,9];
        _unit addweapon _SNrifle;
        _unit addmagazines [_pistolmag,4];
        _unit addweapon _pistol;
        _unit addmagazines [_smokegrenade,2];
        _attachments = [_scope3];
    };

    // SPOTTER
    case "sp": {
        _unit addmagazines [_glriflemag,7];
        _unit addmagazines [_glriflemag_tr,2];
        _unit addmagazines [_glmag,3];
        _unit addmagazines [_glsmokewhite,4];
        _unit addweapon _glrifle;                       //_COrifle
        _unit addmagazines [_smokegrenade,2];
        _unit addWeapon "Rangefinder";
        _unit linkItem "ItemGPS";
    };

    // VEHICLE COMMANDER
    case "vc": {
        _unit addmagazines [_smgmag,5];
        _unit addweapon _smg;
        _unit addmagazines [_smokegrenade,2];
        _unit addItem "ItemGPS";
        _unit assignItem "ItemGPS";
        _unit addWeapon "Rangefinder";
    };

    // VEHICLE DRIVER
    case "vd": {
        _unit addmagazines [_smgmag,5];
        _unit addweapon _smg;
        _unit addmagazines [_smokegrenade,2];
        _unit addItem "ItemGPS";
        _unit assignItem "ItemGPS";
        ["cc"] call _backpack;
    };

    // VEHICLE GUNNER
    case "vg": {
        _unit addmagazines [_smgmag,5];
        _unit addweapon _smg;
        _unit addmagazines [_smokegrenade,2];
        _unit addItem "ItemGPS";
        _unit assignItem "ItemGPS";
    };

    // AIR VEHICLE PILOTS
    case "pp": {
        _unit addmagazines [_smgmag,5];
        _unit addweapon _smg;
        _unit addmagazines [_smokegrenade,2];
        _unit addItem "ItemGPS";
        _unit assignItem "ItemGPS";
    };

    // AIR VEHICLE CREW CHIEF
    case "pcc": {
        _unit addmagazines [_smgmag,5];
        _unit addweapon _smg;
        _unit addmagazines [_smokegrenade,2];
        ["cc"] call _backpack;
    };

    // AIR VEHICLE CREW
    case "pc": {
        _unit addmagazines [_smgmag,5];
        _unit addweapon _smg;
        _unit addmagazines [_smokegrenade,2];
    };

    // ENGINEER (DEMO)
    case "eng": {
        _unit addmagazines [_carbinemag,7];
        _unit addweapon _carbine;
        _unit addmagazines [_smokegrenade,2];
        _unit addmagazines [_grenade,1];
        _unit addmagazines [_mgrenade,1];
        _unit addmagazines [_satchel,2];
        _unit addItem "MineDetector";
        ["eng"] call _backpack;
    };

    // ENGINEER (MINES)
    case "engm": {
        _unit addmagazines [_carbinemag,7];
        _unit addweapon _carbine;
        _unit addmagazines [_smokegrenade,2];
        _unit addmagazines [_grenade,1];
        _unit addmagazines [_mgrenade,1];
        _unit addmagazines [_APmine2,2];
        _unit addItem "MineDetector";
        ["engm"] call _backpack;
    };

    // UAV OPERATOR
    case "uav": {
        _unit addmagazines [_smgmag,5];
        _unit addweapon _smg;
        _unit addmagazines [_smokegrenade,2];
        _unit addmagazines [_grenade,1];
        _unit addmagazines [_mgrenade,1];
        _unit linkItem _uavterminal;
        ["uav"] call _backpack;
        _unit addMagazines ["Laserbatteries",4];
    };

    // Diver
    case "div": {
        _unit addmagazines [_diverMag1,4];
        _unit addmagazines [_diverMag2,3];
        _unit addweapon _diverWep;
        _unit addmagazines [_grenade,3];
        _unit addmagazines [_mgrenade,3];
        _unit addmagazines [_smokegrenade,3];
        _attachments = [_attach1,_scope1,_silencer1];
        ["div"] call _backpack;
    };

    // RIFLEMAN
    case "r": {
        _unit addmagazines [_riflemag,7];
        _unit addmagazines [_riflemag_tr,2];
        _unit addweapon _rifle;
        _unit addmagazines [_grenade,3];
        _unit addmagazines [_mgrenade,3];
        _unit addmagazines [_smokegrenade,3];
        ["r"] call _backpack;
    };

    // CARABINEER
    case "car": {
        _unit addmagazines [_carbinemag,7];
        _unit addmagazines [_carbinemag_tr,2];
        _unit addweapon _carbine;
        _unit addmagazines [_grenade,3];
        _unit addmagazines [_mgrenade,3];
        _unit addmagazines [_smokegrenade,3];
        ["car"] call _backpack;
    };

    // SUBMACHINEGUNNER
    case "smg": {
        _unit addmagazines [_smgmag,7];
        _unit addweapon _smg;
        _unit addmagazines [_grenade,3];
        _unit addmagazines [_mgrenade,3];
        _unit addmagazines [_smokegrenade,3];
        ["smg"] call _backpack;
    };

    // GRENADIER
    case "gren": {
        _unit addmagazines [_glriflemag,7];
        _unit addmagazines [_glriflemag_tr,2];
        _unit addweapon _glrifle;
        _unit addmagazines [_glmag,6];
        _unit addmagazines [_glsmokewhite,2];
        _unit addmagazines [_grenade,3];
        _unit addmagazines [_mgrenade,3];
        _unit addmagazines [_smokegrenade,2];
        ["g"] call _backpack;
    };

    // CARGO: CAR - room for 10 weapons and 50 cargo items
    case "v_car": {
        clearWeaponCargoGlobal _unit;
        clearMagazineCargoGlobal _unit;
        clearItemCargoGlobal _unit;
        clearBackpackCargoGlobal _unit;
        _unit addWeaponCargoGlobal [_carbine, 2];
        _unit addMagazineCargoGlobal [_riflemag, 8];
        _unit addMagazineCargoGlobal [_glriflemag, 8];
        _unit addMagazineCargoGlobal [_carbinemag, 10];
        _unit addMagazineCargoGlobal [_armag, 5];
        _unit addMagazineCargoGlobal [_ratmag, 1];
        _unit addMagazineCargoGlobal [_grenade, 4];
        _unit addMagazineCargoGlobal [_smokegrenade, 4];
        _unit addMagazineCargoGlobal [_smokegrenadegreen, 2];
        _unit addMagazineCargoGlobal [_glmag, 4];
        _unit addMagazineCargoGlobal [_glsmokewhite, 4];
    };

    // CARGO: TRUCK - room for 50 weapons and 200 cargo items
    case "v_tr": {
        clearWeaponCargoGlobal _unit;
        clearMagazineCargoGlobal _unit;
        clearItemCargoGlobal _unit;
        clearBackpackCargoGlobal _unit;
        _unit addWeaponCargoGlobal [_carbine, 10];
        _unit addMagazineCargoGlobal [_riflemag, 40];
        _unit addMagazineCargoGlobal [_glriflemag, 40];
        _unit addMagazineCargoGlobal [_carbinemag, 40];
        _unit addMagazineCargoGlobal [_armag, 22];
        _unit addMagazineCargoGlobal [_ratmag, 6];
        _unit addMagazineCargoGlobal [_grenade, 12];
        _unit addmagazineCargoGlobal [_mgrenade,12];
        _unit addMagazineCargoGlobal [_smokegrenade, 12];
        _unit addMagazineCargoGlobal [_smokegrenadegreen, 4];
        _unit addMagazineCargoGlobal [_glmag, 12];
        _unit addMagazineCargoGlobal [_glsmokewhite, 12];
    };

    // CARGO: IFV - room for 10 weapons and 100 cargo items
    case "v_ifv": {
        clearWeaponCargoGlobal _unit;
        clearMagazineCargoGlobal _unit;
        clearItemCargoGlobal _unit;
        clearBackpackCargoGlobal _unit;
        _unit addWeaponCargoGlobal [_carbine, 4];
        _unit addMagazineCargoGlobal [_riflemag, 20];
        _unit addMagazineCargoGlobal [_glriflemag, 20];
        _unit addMagazineCargoGlobal [_carbinemag, 20];
        _unit addMagazineCargoGlobal [_armag, 8];
        _unit addMagazineCargoGlobal [_ratmag, 2];
        _unit addMagazineCargoGlobal [_grenade, 8];
        _unit addmagazineCargoGlobal [_mgrenade,8];
        _unit addMagazineCargoGlobal [_smokegrenade, 8];
        _unit addMagazineCargoGlobal [_smokegrenadegreen, 2];
        _unit addMagazineCargoGlobal [_glmag, 8];
        _unit addMagazineCargoGlobal [_glsmokewhite, 4];
    };

    // CARGO: HELO -
    case "v_hel": {
        clearWeaponCargoGlobal _unit;
        clearMagazineCargoGlobal _unit;
        clearItemCargoGlobal _unit;
        clearBackpackCargoGlobal _unit;
        _unit addbackpackCargoGlobal ["B_Parachute",4];
        _unit addWeaponCargoGlobal [_carbine, 1];
        _unit addMagazineCargoGlobal [_riflemag, 4];
        _unit addMagazineCargoGlobal [_glriflemag, 4];
        _unit addMagazineCargoGlobal [_carbinemag, 4];
        _unit addMagazineCargoGlobal [_armag, 2];
        _unit addMagazineCargoGlobal [_ratmag, 1];
        _unit addMagazineCargoGlobal [_grenade, 2];
        _unit addMagazineCargoGlobal [_smokegrenade, 2];
        _unit addMagazineCargoGlobal [_smokegrenadegreen, 2];
        _unit addMagazineCargoGlobal [_glmag, 2];
        _unit addMagazineCargoGlobal [_glsmokewhite, 2];
    };

    // CRATE: Small, ammo for 1 fireteam
    case "crate_small": {
        clearWeaponCargoGlobal _unit;
        clearMagazineCargoGlobal _unit;
        clearItemCargoGlobal _unit;
        clearBackpackCargoGlobal _unit;
        _unit addMagazineCargoGlobal [_riflemag, 5];
        _unit addMagazineCargoGlobal [_glriflemag, 5];
        _unit addMagazineCargoGlobal [_armag, 5];
        _unit addMagazineCargoGlobal [_carbinemag, 5];
        _unit addMagazineCargoGlobal [_glmag, 5];
        _unit addMagazineCargoGlobal [_glsmokewhite, 4];
        _unit addMagazineCargoGlobal [_ratmag, 2];
        _unit addMagazineCargoGlobal [_grenade, 8];
        _unit addMagazineCargoGlobal [_mgrenade, 8];
        _unit addMagazineCargoGlobal [_smokegrenade, 8];
        _unit addMagazineCargoGlobal [_smokegrenadegreen, 2];
};

    // CRATE: Medium, ammo for 1 squad
    case "crate_med": {
        clearWeaponCargoGlobal _unit;
        clearMagazineCargoGlobal _unit;
        clearItemCargoGlobal _unit;
        clearBackpackCargoGlobal _unit;
        _unit addMagazineCargoGlobal [_riflemag, 15];
        _unit addMagazineCargoGlobal [_glriflemag, 20];
        _unit addMagazineCargoGlobal [_armag, 15];
        _unit addMagazineCargoGlobal [_carbinemag, 20];
        _unit addMagazineCargoGlobal [_glmag, 20];
        _unit addMagazineCargoGlobal [_glsmokewhite,16];
        _unit addMagazineCargoGlobal [_ratmag, 6];
        _unit addMagazineCargoGlobal [_grenade, 25];
        _unit addMagazineCargoGlobal [_mgrenade, 25];
        _unit addMagazineCargoGlobal [_smokegrenade, 25];
        _unit addMagazineCargoGlobal [_smokegrenadegreen, 6];
};

    // CRATE: Large, ammo for 1 platoon
    case "crate_large": {
        clearWeaponCargoGlobal _unit;
        clearMagazineCargoGlobal _unit;
        clearItemCargoGlobal _unit;
        clearBackpackCargoGlobal _unit;
        _unit addMagazineCargoGlobal [_riflemag, 45];
        _unit addMagazineCargoGlobal [_glriflemag, 60];
        _unit addMagazineCargoGlobal [_armag, 45];
        _unit addMagazineCargoGlobal [_carbinemag, 60];
        _unit addMagazineCargoGlobal [_glmag, 60];
        _unit addMagazineCargoGlobal [_glsmokewhite,50];
        _unit addMagazineCargoGlobal [_ratmag, 20];
        _unit addMagazineCargoGlobal [_grenade, 75];
        _unit addMagazineCargoGlobal [_mgrenade, 75];
        _unit addMagazineCargoGlobal [_smokegrenade, 75];
        _unit addMagazineCargoGlobal [_smokegrenadegreen, 20];
};

    // DEFAULT/UNDEFINED (use RIFLEMAN)
   default {
        _unit addmagazines [_riflemag,7];
        _unit addweapon _rifle;

        _unit selectweapon primaryweapon _unit;

        if (true) exitwith {
            ["f\\assignGear\\f_assignGear_nato.sqf",
             "Unit:%1. Gear template %2 does not exist, used Rifleman instead.",
             _unit, _typeofunit] call mc_fnc_bothlog;
        }
   };
// END SWITCH FOR DEFINE UNIT TYPE LOADOUTS
};

// ==========================================================================

// If this isn't run on an infantry unit we can exit
if !(_isMan) exitWith {};

// ==========================================================================

// Handle weapon attachments
#include "f_assignGear_attachments.sqf";

// ==========================================================================

// ENSURE UNIT HAS CORRECT WEAPON SELECTED ON SPAWNING
_unit selectweapon primaryweapon _unit;

// vim: sts=-1 ts=4 et sw=4
