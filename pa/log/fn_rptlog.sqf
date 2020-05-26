// PA logging helpers: pa_fnc_rptlog
// TODO: rename
//
// Usage:
// [category, formatstring, arguments...] call pa_fnc_rptlog;
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
// [nil, "Current value of _foo: %1", _foo] call pa_fnc_bothlog;
//     This will log: 
//     "14:42:54 (0:00:00) F_fnc_LocalFTMarkerSync - Current value of _foo: 1"
//     assuming the call comes from F_fnc_LocalFTMarkerSync
//
// ["assignGear Early init", "Initializing"]  call pa_fnc_bothlog;
// 	This will log:
// 	"14:42:54 (0:00:00) assignGear Early init - Initializing"
// 	assuming the same call from above
//
// The timestamp is Hours:Minutes:Seconds since mission start.
//
// This function uses CBA functions to do the actual logging.

private _cat = _this select 0;
private _fmtargs = _this select [1,999];
/* diag_log text "fooey Args:";
diag_log text format ["fooey _cat: %1", _cat];
diag_log text format ["fooey _fmtargs: %1", _fmtargs];
diag_log text "fooey :EndArgs";
diag_log text format ["fooey %1", _this];*/

if (isNil "_cat") then {
    if (_fnc_scriptNameParent == _fnc_scriptName) then {
        // If they are the same, it means Arma can't tell us the name of the
        // calling script
        _cat = "UNK: fix calling script!";
    } else {
        _cat = _fnc_scriptNameParent;
    };
};
[format _fmtargs, _cat, [false, true, false]] call CBA_fnc_debug;

// vim: sts=-1 ts=4 et sw=4
