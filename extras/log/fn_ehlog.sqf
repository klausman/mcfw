// Logging helpers: mc_fnc_rptlog
//
// Usage:
// [formatstring, arguments...] call mc_fnc_rptlog;
//
// Will log a message to the RPT file.
//
// category: String that describes where the log message is from (e.g. a
//     subsystem like assignGear. If nil, use the calling script's name.
// formatstring: A format string for the message, uses the same syntax as
//     BIS's vanilla format function: https://community.bistudio.com/wiki/format
// arguments: arguments for the format string (see BIS wikipage above)
//
// Examples:
//
// private -foo = 1;
// ["Current value of _foo: %1", _foo] call mc_fnc_bothlog;
//     This will log:
//     "14:42:54 (0:00:00) F_fnc_LocalFTMarkerSync.sqf - Current value of _foo: 1"
//     assuming the call comes from F_fnc_LocalFTMarkerSync
//
// The timestamp is Hours:Minutes:Seconds since mission start.
//
// This function uses CBA functions to do the actual logging.
private ["_cat"];

_cat = _this select 0;
_fmts = _this select [1, 999];

[format _fmts, _cat, [false, true, false]] call CBA_fnc_debug;

// vim: sts=-1 ts=4 et sw=4