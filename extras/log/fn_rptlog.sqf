// Logging helpers: mc_fnc_rptlog
//
// Usage:
// [tag, formatstring, arguments...] call mc_fnc_rptlog;
//
// Will log a message to both the RPT file on the machien the script is running
// on.
//
// tag: an ideally short string that identifies the message's origin.
// formatstring: A format string for the message, uses the same syntax as
//     BIS's vanilla format function: https://community.bistudio.com/wiki/format
// arguments: arguments for the format string (see BIS wikipage above)
//
// Examples:
//
// private _foo = 1;
// ["xyz, "Current value of _foo: %1", _foo] call mc_fnc_rptlog;
//     This will log:
//     "14:42:54 (0:00:00) xyz - Current value of _foo: 1"
//
// The first timestamp is the computer's local time.
// The second timestamp is Hours:Minutes:Seconds since mission start.
//
// This function uses CBA functions to do the actual logging.
private _logset = [false, true, false];
params  ["_tag", "_fmt"];

private _rest = _this select [2, 999];

[format ([_fmt] + _rest), _tag, _logset] call CBA_fnc_debug;

// vim: sts=-1 ts=4 et sw=4
