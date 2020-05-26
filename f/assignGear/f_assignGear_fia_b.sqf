// DEFINE BACKPACK CONTENTS
// The following blocks of code define different backpack loadouts. These are
// then called from the role loadouts.

// Set up long-range radios for CO and DCs (2IC, SL)
case "co": {
    _unit addBackpack _lrradio;
    clearMagazineCargoGlobal (unitBackpack _unit);
    (unitBackpack _unit) addMagazineCargoGlobal [_glriflemag, 4];
    (unitBackpack _unit) addMagazineCargoGlobal [_glmag, 2];
    (unitBackpack _unit) addMagazineCargoGlobal [_glsmokewhite, 2];
    (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 2];
    (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 2];
    (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 2];
};

case "dc": {
    _unit addBackpack _lrradio;
    clearMagazineCargoGlobal (unitBackpack _unit);
    (unitBackpack _unit) addMagazineCargoGlobal [_glriflemag, 4];
    (unitBackpack _unit) addMagazineCargoGlobal [_glmag, 2];
    (unitBackpack _unit) addMagazineCargoGlobal [_glsmokewhite, 2];
    (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 2];
    (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 2];
    (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 2];
};

// MEDIC
case "m": {
    // MEDIUM
    if (_loadout <= 1) then {
        _unit addBackpack _bagsmall;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 4];
    };
    // HEAVY
    if (_loadout == 2) then {
        _unit addBackpack _bagmedium;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 6];
    };
};

// GRENADIER (CO/DC/SL/FTL/G)
case "g": {
    // LIGHT
    if (_loadout == 0) then {
        _unit addmagazines [_glriflemag,2];
        _unit addmagazines [_glmag,1];
        _unit addmagazines [_glsmokewhite,1];
        _unit addmagazines [_grenade,1];_unit addmagazines [_mgrenade,1];
        _unit addmagazines [_smokegrenade,2];
    };
    // MEDIUM
    if (_loadout == 1) then {
        _unit addBackpack _bagsmall;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_glriflemag, 4];
        (unitBackpack _unit) addMagazineCargoGlobal [_glmag, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_glsmokewhite, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 2];
    };
    // HEAVY
    if (_loadout == 2) then {
        _unit addBackpack _bagmedium;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_glriflemag, 6];
        (unitBackpack _unit) addMagazineCargoGlobal [_glmag, 4];
        (unitBackpack _unit) addMagazineCargoGlobal [_glsmokewhite, 4];
        (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 4];
        (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 4];
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 2];
    };
};

// AR
case "ar": {
    // LIGHT
    if (_loadout == 0) then {
        _unit addmagazines [_ARmag_Tr,1];
    };
    // MEDIUM
    if (_loadout == 1) then {
        _unit addBackpack _bagsmall;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_ARmag, 1];
        (unitBackpack _unit) addMagazineCargoGlobal [_ARmag_Tr, 1];
        (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 1];
        (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 1];
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 1];
    };
    // HEAVY
    if (_loadout == 2) then {
        _unit addBackpack _bagmedium;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_ARmag, 3];
        (unitBackpack _unit) addMagazineCargoGlobal [_ARmag_Tr, 3];
        (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 2];
    };
};

// AAR
case "aar": {
    // LIGHT
    if (_loadout == 0) then {
        _unit addmagazines [_ARmag,1];
        _unit addmagazines [_grenade,1];_unit addmagazines [_mgrenade,1];
        _unit addmagazines [_smokegrenade,1];
    };
    // MEDIUM
    if (_loadout == 1) then {
        _unit addBackpack _bagsmall;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_riflemag, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_ARmag, 2];
    };
    // HEAVY
    if (_loadout == 2) then {
        _unit addBackpack _bagmedium;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_riflemag, 3];
        (unitBackpack _unit) addMagazineCargoGlobal [_ARmag, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_ARmag_tr, 1];
        (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 2];
    };
};

// RIFLEMAN AT (RAT)
case "rat": {
    // LIGHT
    if (_loadout == 0) then {
        _unit addBackpack _bagsmall;
        clearMagazineCargoGlobal (unitBackpack _unit);
    };
    // MEDIUM
    if (_loadout == 1) then {
        _unit addBackpack _bagsmall;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_riflemag, 4];
        (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_RATmag, 1];
    };
    // HEAVY
    if (_loadout == 2) then {
        _unit addBackpack _bagmedium;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_riflemag, 4];
        (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_RATmag, 2];
    };
};

// DESIGNATED MARKSMAN (DM)
case "dm": {
    // LIGHT
    if (_loadout == 0) then {
        _unit addBackpack _bagsmall;
        clearMagazineCargoGlobal (unitBackpack _unit);
    };

    // MEDIUM
    if (_loadout == 1) then {
        _unit addBackpack _bagsmall;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_DMriflemag, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 2];

    };
    // HEAVY
    if (_loadout == 2) then {
        _unit addBackpack _bagmedium;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_DMriflemag, 4];
        (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 4];
        (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 4];
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 4];
    };
};

// RIFLEMAN (R)
case "r": {
    // LIGHT
    if (_loadout == 0) then {
        _unit addmagazines [_riflemag,2];
        _unit addmagazines [_grenade,1];_unit addmagazines [_mgrenade,1];
        _unit addmagazines [_smokegrenade,2];
    };
    // MEDIUM
    if (_loadout == 1) then {
        _unit addBackpack _bagsmall;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_riflemag, 4];
        (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 2];
    };
    // HEAVY
    if (_loadout == 2) then {
        _unit addBackpack _bagmedium;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_riflemag, 8];
        (unitBackpack _unit) addMagazineCargoGlobal [_riflemag_tr, 4];
        (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 4];
        (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 4];
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 2];
    };
};

// CARABINEER (CAR)
case "car": {
    // LIGHT
    if (_loadout == 0) then {
        _unit addmagazines [_carbinemag,2];
        _unit addmagazines [_grenade,1];_unit addmagazines [_mgrenade,1];
        _unit addmagazines [_smokegrenade,2];
    };
    // MEDIUM
    if (_loadout == 1) then {
        _unit addBackpack _bagsmall;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_carbinemag, 4];
        (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 2];
    };
    // HEAVY
    if (_loadout == 2) then {
        _unit addBackpack _bagmedium;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_carbinemag, 8];
        (unitBackpack _unit) addMagazineCargoGlobal [_carbinemag_tr, 4];
        (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 4];
        (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 4];
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 2];
    };
};

// MMG GUNNER (MMG)
case "mmg": {
    // LIGHT
    if (_loadout == 0) then {
        _unit addmagazines [_MMGmag,1];
        _unit addmagazines [_grenade,1];_unit addmagazines [_mgrenade,1];
        _unit addmagazines [_smokegrenade,1];
    };
    // MEDIUM
    if (_loadout == 1) then {
        _unit addBackpack _bagsmall;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_MMGmag, 2];
            (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 1];
        (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 1];
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 1];
    };
    // HEAVY
    if (_loadout == 2) then {
        _unit addBackpack _bagmedium;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_MMGmag, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_MMGmag_tr, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 2];
    };
};

// HEAVY MG GUNNER (HMGG)
case "hmgg": {
    _unit addBackpack _baghmgg;
};

// HEAVY MG ASSISTANT GUNNER (HMGAG)
case "hmgag": {
    _unit addBackpack _baghmgag;
};

// MMG ASSISTANT GUNNER (MMGAG)
case "mmgag": {
    // LIGHT
    if (_loadout == 0) then {
        _unit addmagazines [_MMGmag,1];
        _unit addmagazines [_grenade,1];_unit addmagazines [_mgrenade,1];
        _unit addmagazines [_smokegrenade,1];
    };
    // MEDIUM
    if (_loadout == 1) then {
        _unit addBackpack _bagmedium;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_riflemag, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_riflemag_tr, 1];
        (unitBackpack _unit) addMagazineCargoGlobal [_MMGmag, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_MMGmag_tr, 1];
        (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 1];
        (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 1];
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 1];
    };
    // HEAVY
    if (_loadout == 2) then {
        _unit addBackpack _baglarge;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_riflemag, 4];
        (unitBackpack _unit) addMagazineCargoGlobal [_riflemag_tr, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_MMGmag, 3];
        (unitBackpack _unit) addMagazineCargoGlobal [_MMGmag_tr, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 2];
    };
};

// MAT GUNNER (MATG)
case "matg": {
    // LIGHT
    if (_loadout == 0) then {
        _unit addBackpack _bagsmall;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_MATmag1, 1];
        (unitBackpack _unit) addMagazineCargoGlobal [_MATmag2, 1];
        (unitBackpack _unit) addMagazineCargoGlobal [_carbinemag, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 1];
        (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 1];
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 1];
    };
    // MEDIUM
    if (_loadout == 1) then {
        _unit addBackpack _bagmedium;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_MATmag1, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_MATmag2, 1];
        (unitBackpack _unit) addMagazineCargoGlobal [_carbinemag, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 1];
        (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 1];
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 1];
    };
    // HEAVY
    if (_loadout == 2) then {
        _unit addBackpack _bagmedium;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_MATmag1, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_MATmag2, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_carbinemag, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 1];
        (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 1];
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 1];
    };
};

// MAT ASSISTANT (MATAG)
case "matag": {
    // LIGHT
    if (_loadout == 0) then {
        _unit addBackpack _bagsmall;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_MATmag1, 1];
        (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 1];
        (unitBackpack _unit) addMagazineCargoGlobal [_carbinemag, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 1];
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 1];
    };
    // MEDIUM
    if (_loadout == 1) then {
        _unit addBackpack _bagmedium;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_MATmag1, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_MATmag2, 1];
        (unitBackpack _unit) addMagazineCargoGlobal [_carbinemag, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 2];
    };
    // HEAVY
    if (_loadout == 2) then {
        _unit addBackpack _baglarge;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_MATmag1, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_MATmag2, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_carbinemag, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 3];
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 3];
    };
};

// HEAVY AT GUNNER (HATG)
case "hatg": {
    _unit addBackpack _bagsmall;
    clearMagazineCargoGlobal (unitBackpack _unit);
    (unitBackpack _unit) addMagazineCargoGlobal [_HATmag1, 2];
};

// HEAVY AT ASSISTANT GUNNER (HATAG)
case "hatag": {
    _unit addBackpack _bagmedium;
    clearMagazineCargoGlobal (unitBackpack _unit);
    (unitBackpack _unit) addMagazineCargoGlobal [_HATmag1, 2];
};

// MORTAR GUNNER (MTRG)
case "mtrg": {
    _unit addBackpack _bagmtrg;
};

// MORTAR ASSISTANT GUNNER (MTRAG)
case "mtrag": {
    _unit addBackpack _bagmtrag;
};

// MEDIUM SAM GUNNER (MSAMG)
case "msamg": {
    _unit addBackpack _bagmedium;
    clearMagazineCargoGlobal (unitBackpack _unit);
    (unitBackpack _unit) addMagazineCargoGlobal [_SAMmag, 2];
};

// MEDIUM SAM ASSISTANT GUNNER (MSAMAG)
case "msamag": {
    _unit addBackpack _bagmedium;
    clearMagazineCargoGlobal (unitBackpack _unit);
    (unitBackpack _unit) addMagazineCargoGlobal [_SAMmag, 2];
};

// HEAVY SAM GUNNER (HSAMG)
case "hsamg": {
    _unit addBackpack _baghsamg;
};

// HEAVY SAM ASSISTANT GUNNER (HSAMAG)
case "hsamag": {
    _unit addBackpack _baghsamag;
};

// ENGINEER (DEMO)
case "eng": {
    // LIGHT
    if (_loadout == 0) then {
        _unit addBackpack _bagsmall;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addItemCargoGlobal ["ToolKit",1];
    };
    // MEDIUM
    if (_loadout == 1) then {
        _unit addBackpack _baglarge;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addItemCargoGlobal ["ToolKit",1];
        (unitBackpack _unit) addItemCargoGlobal [_satchel,2];
    };
    // HEAVY
    if (_loadout == 2) then {
        _unit addBackpack _baglarge;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addItemCargoGlobal ["ToolKit",1];
        (unitBackpack _unit) addItemCargoGlobal [_satchel,4];
    };
};

// ENGINEER (MINES)
case "engm": {
    // LIGHT
    if (_loadout == 0) then {
        _unit addBackpack _bagsmall;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addItemCargoGlobal ["ToolKit",1];
    };
    // MEDIUM
    if (_loadout == 1) then {
        _unit addBackpack _baglarge;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addItemCargoGlobal ["ToolKit",1];
        (unitBackpack _unit) addMagazineCargoGlobal [_ATmine,1];
    };
    // HEAVY
    if (_loadout == 2) then {
        _unit addBackpack _baglarge;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addItemCargoGlobal ["ToolKit",1];
        (unitBackpack _unit) addMagazineCargoGlobal [_ATmine,2];
    };
};

// SUBMACHINEGUNNER (SMG)
case "smg": {
    // LIGHT
    if (_loadout == 0) then {
        _unit addmagazines [_smgmag,2];
        _unit addmagazines [_grenade,1];_unit addmagazines [_mgrenade,1];
        _unit addmagazines [_smokegrenade,2];
    };
    // MEDIUM
    if (_loadout == 1) then {
        _unit addBackpack _bagsmall;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_smgmag, 4];
        (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 2];
    };
    // HEAVY
    if (_loadout == 2) then {
        _unit addBackpack _bagmedium;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_smgmag, 8];
        (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 4];
        (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 4];
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 4];
    };
};

// DIVER (DIV)
case "div": {
    // MEDIUM
    if (_loadout == 1) then {
        _unit addBackpack _bagmediumdiver;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_diverMag1, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_diverMag2, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 2];
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 2];
    };
    // HEAVY
    if (_loadout == 2) then {
        _unit addBackpack _bagmediumdiver;
        clearMagazineCargoGlobal (unitBackpack _unit);
        (unitBackpack _unit) addMagazineCargoGlobal [_diverMag1, 4];
        (unitBackpack _unit) addMagazineCargoGlobal [_diverMag2, 4];
        (unitBackpack _unit) addMagazineCargoGlobal [_grenade, 4];
        (unitBackpack _unit) addMagazineCargoGlobal [_mgrenade, 4];
        (unitBackpack _unit) addMagazineCargoGlobal [_smokegrenade, 4];
    };
};

// UAV
case "uav": {
    _unit addBackpack _baguav;
};

// CREW CHIEFS & VEHICLE DRIVERS
case "cc": {
    _unit addBackpack _bagsmall;
    clearMagazineCargoGlobal (unitBackpack _unit);
    (unitBackpack _unit) addItemCargoGlobal ["ToolKit",1];
};

// vim: sts=-1 ts=4 et sw=4
