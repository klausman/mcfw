// Telelpole - global re-init of all poles (e.g. when unit dies)
// (C) 2020 T. Klausmann

["telepole", "Re-init of all poles"] call mc_fnc_rptlog;

scriptName "fn_telepole_reinit.sqf";

private _poles = missionNameSpace getVariable["telepole_poles", []];
// sort -u for arrays, basically
// see https://community.bistudio.com/wiki/arrayIntersect
_poles = _poles arrayIntersect _poles;
missionNameSpace setVariable["telepole_poles", _poles, true];

["Found %1 poles in global list: %2", count _poles, _poles] call mc_fnc_rptlog;

{
    private _obj = _x select 0;
    private _side = _x select 1;
    ["Re-initializing pole '%1' for side %2", _obj, _side] call mc_fnc_rptlog;
    // The EH may run anywhere (typically on a player's machine. Make sure
    // we re-init the pole where it is local.
    [[_obj, _side, true, false]] remoteExec ["call mc_fnc_telepole", _obj];
} foreach _poles;

// vim: sts=-1 ts=4 et sw=4
