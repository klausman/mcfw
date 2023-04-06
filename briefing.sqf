// Briefing

// Make sure the player initializes properly
if (!isDedicated && (isNull player)) then {
    waitUntil {sleep 0.1; !isNull player};
};

// Declare variables and functions
private ["_unitSide"];

waitUntil {!isnil "f_var_debugMode"};

// Detect player faction
// The following code detects what side the player's slot belongs to, and
// stores it in the private variable _unitSide
_unitSide = side player;

if (f_var_debugMode == 1) then {
    ["Briefing", "Player faction: %1",str _unitSide] call mc_fnc_rptlog;
};

// Briefing: admin
// The following block of code executes only if the player is the current host
// it automatically includes a file which contains the appropriate briefing
// data.

if (serverCommandAvailable "#kick") then {
#include "f\briefing\f_briefing_admin.sqf"
    if (f_var_debugMode == 1) then {
        ["Briefing", "Briefing for host selected."] call mc_fnc_rptlog;
    };
};

// Briefing: WEST
// The following block of code executes only if the player is in a BLU slot;
// it automatically includes a file which contains the appropriate briefing
// data.
if (_unitSide == west) exitwith {
    #include "f\briefing\f_briefing_west.sqf";
    true;
};

// Briefing: EAST
// The following block of code executes only if the player is in a OPF slot;
// it automatically includes a file which contains the appropriate briefing
// data.
if (_unitSide == east) exitwith {
    #include "f\briefing\f_briefing_east.sqf";
    true;
};

// Briefing: INDEPENDENT
// The following block of code executes only if the player is in a GUER slot;
// it automatically includes a file which contains the appropriate briefing
// data.
if (_unitSide == resistance) exitwith {
    #include "f\briefing\f_briefing_resistance.sqf";
    true;
};

// Briefing: CIVILIAN
// The following block of code executes only if the player is in a CIVILIAN
// slot; it automatically includes a file which contains the appropriate
// briefing data.
if (_unitSide == civilian) exitwith {
    #include "f\briefing\f_briefing_civ.sqf";
    true;
};

// This is a special case for "Logic" entities, e.g. captive Zeus slots,
// mostly here to make the error message below more useful.
if (_unitSide == sideLogic) exitwith {};

// Error checking
// If the faction of the unit cannot be defined, the script exits with an
// error.
["Briefing", "Side %1 has no briefing defined.", str _unitSide] call mc_fnc_rptlog;

// vim: sts=-1 ts=4 et sw=4
