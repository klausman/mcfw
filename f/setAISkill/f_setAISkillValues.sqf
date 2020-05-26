// Set AI Skill Values

// CHECK ACTIVATED PARAMETERS
// Depending on enabled parameters, the skill level for each side are set up

if (isNil "f_param_AISkill_BLUFOR") then {f_param_AISkill_BLUFOR = 99};
if (isNil "f_param_AISkill_OPFOR") then {f_param_AISkill_OPFOR = 99};
if (isNil "f_param_AISkill_INDP") then {f_param_AISkill_INDP = 99};

// SELECT BLUFOR AI SKILLS
// Using the value of f_param_AISkill_BLUFOR, a value for _skillSideBLUFOR is
// set.

if (isNil "f_var_skillBlu") then {
    f_var_skillBlu =
    switch (f_param_AISkill_BLUFOR) do {
        case 0: {_superSkill;};
        case 1: {_highSkill;};
        case 2: {_mediumSkill;};
        case 3: {_lowSkill;};
        default {99;};
    };
    publicVariable "f_var_skillBlu";
};

// SELECT OPFOR AI SKILLS
// Using the value of f_param_AISkill_OPFOR, a value for _skillSideOPFOR is
// set.

if (isNil "f_var_skillOpf") then {
    f_var_skillOpf =
    switch (f_param_AISkill_OPFOR) do {
        case 0: {_superSkill;};
        case 1: {_highSkill;};
        case 2: {_mediumSkill;};
        case 3: {_lowSkill;};
        default {99;};
    };
    publicVariable "f_var_skillOpf";
};

// SELECT INDEPENDENT AI SKILLS
// Using the value of f_param_AISkill_INDP, a value for _skillSideOPFOR is
// set.

if (isNil "f_var_skillRes") then {
    f_var_skillRes =
    switch (f_param_AISkill_INDP) do {
        case 0: {_superSkill;};
        case 1: {_highSkill;};
        case 2: {_mediumSkill;};
        case 3: {_lowSkill;};
        default {99;}; 
    };
    publicVariable "f_var_skillRes";
};

// SELECT CIVILIAN AI SKILLS
// If the civilian side variable is enabled, their level will be set
// accordingly

f_var_skillCiv = 99;
if (!isNil "f_var_civAI") then {
    f_var_skillCiv =
    switch (f_var_civAI) do {
        case west: {f_var_skillBlu};
        case blufor: {f_var_skillBlu};
        case east: {f_var_skillOpfor};
        case opfor: {f_var_skillOpfor};
        case independent: {f_var_skillRes};
        case resistance: {f_var_skillRes};
        default {99};
    };
    publicVariable "f_var_skillCiv";
};

// DEBUG
if (f_var_debugMode == 1) then {
    ["f\\setAISkill\\f_setAISkillValues.sqf",
     "f_var_skillBLU=%1 f_var_skillOpf=%2 f_var_skillRes=%3 f_var_skillCiv=%4",
     f_var_skillBlu, f_var_skillOpf, f_var_skillRes, f_var_skillCiv] call pa_fnc_bothlog;
};

// vim: sts=-1 ts=4 et sw=4
