// Logging helpers: mc_fnc_bothlog
//
// Usage:
// [formatstring, arguments...] call mc_fnc_bothlog;
//
// Will log a message to both the RPT file and the global chat.
//
// formatstring: A format string for the message, uses the same syntax as
//     BIS's vanilla format function: https://community.bistudio.com/wiki/format
// arguments: arguments for the format string (see BIS wikipage above)
//
// Examples:
//
// private _foo = 1;
// ["Current value of _foo: %1", _foo] call mc_fnc_bothlog;
//     This will log:
//     "14:42:54 (0:00:00) F_fnc_LocalFTMarkerSync.sqf - Current value of _foo: 1"
//
//     assuming the call comes from F_fnc_LocalFTMarkerSync.sqf
//
// The timestamp is Hours:Minutes:Seconds since mission start.
//
// This function uses CBA functions to do the actual logging.
private ["_cat"];

if (_fnc_scriptNameParent == _fnc_scriptName) then {
    // If they are the same, it means Arma can't tell us the name of the
    // calling script
    _cat = "UnknownScript-useScriptName";
} else {
    _cat = _fnc_scriptNameParent;
};

[format _this, _cat, [true, true, false]] call CBA_fnc_debug;

// vim: sts=-1 ts=4 et sw=4
