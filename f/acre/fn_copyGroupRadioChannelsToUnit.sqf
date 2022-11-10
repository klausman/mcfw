// ACRE integration for MCFW, by Bubbus

params ["_unit"];

if !([_unit] call acre_api_fnc_isInitialized) exitWith
{
	[
		{
			[_this#0] call acre_api_fnc_isInitialized
		},
		f_fnc_copyGroupRadioChannelsToUnit,
		_this
	] call CBA_fnc_waitUntilAndExecute;
};

private _group = group _unit;
private _groupId = groupId _group;

private _sideName = switch (side _group) do 
{
	case west: {"blufor"};
	case east: {"opfor"};
	default {"indfor"};
};

private _srConfig = missionNamespace getVariable [format ["f_radios_settings_acre2_sr_groups_%1", _sideName], []];
private _lrConfig = missionNamespace getVariable [format ["f_radios_settings_acre2_lr_groups_%1", _sideName], []];
private _xlrConfig = missionNamespace getVariable [format ["f_radios_settings_acre2_xlr_groups_%1", _sideName], []];

private _groupChannelIndex = _srConfig findIf {((_x#1) findIf {(toLower _x) isEqualTo (toLower _groupId)}) >= 0};
private _groupLRChannelIndex = _lrConfig findIf {((_x#1) findIf {(toLower _x) isEqualTo (toLower _groupId)}) >= 0};
private _groupXLRChannelIndex = _xlrConfig findIf {((_x#1) findIf {(toLower _x) isEqualTo (toLower _groupId)}) >= 0};

[
	"Setting ACRE radio channels for player '%1' in group '%2'.  Radio indices: [%3, %4, %5]", 
	_unit, _groupId, _groupChannelIndex, _groupLRChannelIndex, _groupXLRChannelIndex
] call mc_fnc_bothlog;

[_unit, _groupChannelIndex, _groupLRChannelIndex, _groupXLRChannelIndex] call f_fnc_setUnitRadioChannels;