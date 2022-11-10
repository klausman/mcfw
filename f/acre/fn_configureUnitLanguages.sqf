// ACRE integration for MCFW, by Bubbus

private _performLanguageAssignment = 
{
	params ["_role", "_unit", "_faction"];

	_languages = switch (side group _unit) do
	{
		case blufor: {f_radios_settings_acre2_language_blufor};
		case opfor: {f_radios_settings_acre2_language_opfor};
		case independent: {f_radios_settings_acre2_language_indfor};
		default {f_radios_settings_acre2_language_indfor};
	};

	["Setting languages for player '%1' to %2.", _unit, _languages] call mc_fnc_bothlog;

	_languages call acre_api_fnc_babelSetSpokenLanguages;
	[_languages select 0] call acre_api_fnc_babelSetSpeakingLanguage;
};


// Ensure languages array is initialised before continuing.
if ((!isNil 'acre_sys_core_languages') and {(count acre_sys_core_languages) > 0}) then
{
	_this call _performLanguageAssignment;
}
else
{
	[
		{
			(!isNil 'acre_sys_core_languages') and {(count acre_sys_core_languages) > 0}
		},
		_performLanguageAssignment,
		_this

	] call CBA_fnc_waitUntilAndExecute;
};