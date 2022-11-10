// ACRE2 Settings
// Modified from the original F3_CA ACRE configuration, by the CAFE team.
// Credits: Please see the CAFE repository (https://github.com/CombinedArmsGaming/CAFE3/graphs/contributors)
//
// Modified again for use in MCFW by Bubbus.
// ====================================================================================

// RADIO STRUCTURE

// By default, radio channels are separated for each side.  If this setting is enabled, all sides will share the same radio net.
// TRUE = Disable frequency seperation across sides.
f_radios_settings_acre2_disableFrequencySplit = FALSE;

// Standard Short
// REMEMBER - IN ACRE, an ItemRadio will be automatically turned into an ACRE_PRC343!
f_radios_settings_acre2_standardSHRadio = "ACRE_PRC343";

// Standard Long-range
f_radios_settings_acre2_standardLRRadio = "ACRE_PRC152";

// 'Extra' LR radio
f_radios_settings_acre2_extraRadio = "ACRE_PRC148";

// Backpack Radio
f_radios_settings_acre2_BackpackRadio = "ACRE_PRC117F";


// ====================================================================================
// BABEL API

// Defines the languages that exist in the mission.
// string id, displayname
f_radios_settings_acre2_languages =
[
    ["blu", "Friendlese"],
    ["ind", "Foreignese"],
    ["opf", "Enemese"]
];

// defines the language that a player can speak.
// can define multiple
f_radios_settings_acre2_language_blufor = ["blu"];
f_radios_settings_acre2_language_opfor = ["ind"];
f_radios_settings_acre2_language_indfor = ["opf"];


// ====================================================================================
// Short-range channels.
// These are normally used for communication within a team or group.
// Examples: A1 net composed of FTL, Riflemen, Medic etc.  Partisan/guerrilla comms for localised coordination.
f_radios_settings_acre2_sr_groups_blufor =
[
    ["1PLT ALPHA",    ["1PLT ALPHA"]],
    ["1PLT BRAVO",    ["1PLT BRAVO"]],
    ["1PLT CHARLIE",  ["1PLT CHARLIE"]],
    ["2PLT ALPHA",    ["2PLT ALPHA"]],
    ["2PLT BRAVO",    ["2PLT BRAVO"]],
    ["2PLT CHARLIE",  ["2PLT CHARLIE"]]
];

f_radios_settings_acre2_sr_groups_opfor = f_radios_settings_acre2_sr_groups_blufor;
f_radios_settings_acre2_sr_groups_indfor = f_radios_settings_acre2_sr_groups_blufor;


// Long-range channels.
// These channels are shared with 'extra' long-range (XLR) radios and backpack radios.  You should duplicate these channels in the XLR list.
//
// These channels are normally used for squad-level communication.
// Examples: Alpha net composed of ASL, A1, A2.  Section net composed of ASL, A2IC, AMED.  Mechanised team composed of ASL, A-Vic.
f_radios_settings_acre2_lr_groups_blufor =
[
    ["1PLT NET",     ["1PLT ALPHA", "1PLT BRAVO", "1PLT CHARLIE", "1PLT HQ"]],
    ["2PLT NET",     ["2PLT ALPHA", "2PLT BRAVO", "2PLT CHARLIE", "2PLT HQ"]],
    ["COY NET",      ["COY HQ"]],
    ["AIR NET",      ["CONDOR", "HAWK", "RAVEN", "VULTURE"]],
    ["HOTLINE ZEUS", ["ZEUS"]]
];

f_radios_settings_acre2_lr_groups_opfor = f_radios_settings_acre2_lr_groups_blufor;
f_radios_settings_acre2_lr_groups_indfor = f_radios_settings_acre2_lr_groups_blufor;


// 'Extra' long-range & backpack channels.
// These are shared with long-range (LR) radios and backpack radios.  You should duplicate these channels in the LR list.
// 
// These channels are normally used for platoon-level communication or higher.
// Examples: Ground command net composed of CO, ASL, BSL, CSL.  Vehicle net composed of XO/VC, A-Vic, B-Vic, CAS.  Liason net composed of CO, INDFOR CO.
f_radios_settings_acre2_xlr_groups_blufor =
[
    ["1PLT NET",     []],
    ["2PLT NET",     []],
    ["COY NET",      ["1PLT HQ", "2PLT HQ", "ZEUS"]],
    ["AIR NET",      []],
    ["HOTLINE ZEUS", []]
];

f_radios_settings_acre2_xlr_groups_opfor = f_radios_settings_acre2_xlr_groups_blufor;
f_radios_settings_acre2_xlr_groups_indfor = f_radios_settings_acre2_xlr_groups_blufor;


// Role overrides per group.  Overrides are ["SR Label", "LR Label", "XLR Label"].
// Empty overrides have no effect - assignments from above will remain in place for these.
["jtac", "1PLT HQ", ["", "", "AIR NET"]] call f_fnc_forceRadioChannelsForRoleInGroup;
["jtac", "2PLT HQ", ["", "", "AIR NET"]] call f_fnc_forceRadioChannelsForRoleInGroup;
["jtac", "COY HQ", ["", "", "AIR NET"]] call f_fnc_forceRadioChannelsForRoleInGroup;


// Notes for radio ownership in upcoming op:
// CO, PltCO, SL, Pilot, Zeus - ACRE_PRC152
// PltCO, JTAC, Zeus - ACRE_PRC148 or ACRE_PRC117F (either of).
// SL, All other inf team members - ACRE_PRC343


// ====================================================================================
// DO NOT EDIT UNDER THIS LINE.  Framework code acting upon the configuration above.

[] call f_fnc_initialiseRadioPresets;

{
    _x call acre_api_fnc_babelAddLanguageType;
} foreach f_radios_settings_acre2_languages;

// Used by other components to determine when all radio settings have been populated.
f_radios_loadedSettings = true;
