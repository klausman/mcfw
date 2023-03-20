// ACRE integration for MCFW, by Bubbus

params ["_role", "_unit", "_faction"];

if !(isPlayer _unit) exitWith {};

if !([] call acre_api_fnc_isInitialized) exitWith
{
	[
		{
			[] call acre_api_fnc_isInitialized
		},
		f_fnc_configureUnitAcreRadios,
		_this
	] call CBA_fnc_waitUntilAndExecute;
};

["Configuring ACRE for player '%1'.", _unit] call mc_fnc_bothlog;

_this call f_fnc_configureRadioPresets;
_this call f_fnc_configureUnitLanguages;
[_unit] call f_fnc_copyGroupRadioChannelsToUnit;
_this call f_fnc_applyUnitRadioOverrides;
