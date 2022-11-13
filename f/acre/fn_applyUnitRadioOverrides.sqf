// ACRE integration for MCFW, by Bubbus

params ["_role", "_unit", "_faction"];

if (isNil "f_map_acre_forcedRoles") exitWith {};

private _group = group _unit;
private _groupId = groupId _group;
private _sideName = switch (side _group) do 
{
	case west: {"blufor"};
	case east: {"opfor"};
	default {"indfor"};
};

private _key = format ["%1::%2", toUpper _groupId, toUpper _role];
private _channelOverrides = f_map_acre_forcedRoles getOrDefault [_key, ["", "", ""]];

private _srConfig = missionNamespace getVariable [format ["f_radios_settings_acre2_sr_groups_%1", _sideName], []];
private _lrConfig = missionNamespace getVariable [format ["f_radios_settings_acre2_lr_groups_%1", _sideName], []];
private _xlrConfig = missionNamespace getVariable [format ["f_radios_settings_acre2_xlr_groups_%1", _sideName], []];

private _groupChannelIndex = _srConfig findIf {((toLower (_x#0)) isEqualTo (toLower (_channelOverrides#0)))};
private _groupLRChannelIndex = _lrConfig findIf {((toLower (_x#0)) isEqualTo (toLower (_channelOverrides#1)))};
private _groupXLRChannelIndex = _xlrConfig findIf {((toLower (_x#0)) isEqualTo (toLower (_channelOverrides#2)))};

if ((_groupChannelIndex < 0) and (_groupLRChannelIndex < 0) and (_groupXLRChannelIndex < 0)) exitWith {};

[
	"Setting ACRE radio channels for player '%1' via override key %2.  Radio indices: [%3, %4, %5]", 
	_unit, _key, _groupChannelIndex, _groupLRChannelIndex, _groupXLRChannelIndex
] call mc_fnc_bothlog;

[_unit, _groupChannelIndex, _groupLRChannelIndex, _groupXLRChannelIndex] call f_fnc_setUnitRadioChannels;