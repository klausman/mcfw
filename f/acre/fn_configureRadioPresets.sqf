// ACRE integration for MCFW, by Bubbus.

params ["_role", "_unit", "_faction"];

_presetName = switch (side group _unit) do
{
	case west: {"default2"};
	case east: {"default3"};
	case resistance: {"default4"};
	default {"default"};
};

if (f_radios_settings_acre2_disableFrequencySplit) then
{
	_presetName = "default";
};

["Setting ACRE radios preset to '%1' for player '%2'.", _presetName, _unit] call mc_fnc_bothlog;

["ACRE_PRC343", _presetName] call acre_api_fnc_setPreset;
["ACRE_PRC148", _presetName] call acre_api_fnc_setPreset;
["ACRE_PRC152", _presetName] call acre_api_fnc_setPreset;
["ACRE_PRC117F", _presetName] call acre_api_fnc_setPreset;
["ItemRadio", _presetName] call acre_api_fnc_setPreset;