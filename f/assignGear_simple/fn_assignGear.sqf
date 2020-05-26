// klausman's simple assignGear

// DECLARE VARIABLES AND FUNCTIONS
private ["_faction","_typeofUnit","_unit","_ff"];

// The unit's faction is defined by the base game (or the mod) and
// can be an arbitrary string, though "BLU_F" and OPF_F" are
// common values
_typeofUnit = toLower (_this select 0);
_unit = _this select 1;
_ff = false; // Track if we have found a script for this unit's faction

_faction = toLower (faction _unit);

// faction was explicitly specified in the init call of the unit, e.g.
// [_this, "ar", "blu_f"] call f_fnc_assignGear;
if(count _this > 2) then {
    _faction = toLower (_this select 2);
};

// This block will give units insignia on their uniforms, i.e.
// "CO" or "A1" or the like, from the insignia subdirectory.
[_unit,_typeofUnit] spawn {
    [_this select 0, _this select 1] call compile preprocessFileLineNumbers "f\assignGear_simple\f_assignInsignia.sqf";
};

// Only run once, where the unit is local
if !(local _unit) exitWith {};

// This public (global) variable is used in the respawn component.
_unit setVariable ["f_var_assignGear",_typeofUnit,true];

// This variable simply tracks the progress of the gear assignation process,
// for other scripts to reference.
_unit setVariable ["f_var_assignGear_done", false, true];

if (f_var_debugMode == 1) then {
    [nil, "Unit faction: %1",_faction] call pa_fnc_bothlog;
};

// Any unit with a faction of "blu_f" gets a NATO loadout.
// NOTE: if you use units of other factions, you can specify the faction to
// assume in the assignGear init call, like so:
// [_this, "ar", "blu_f"] call f_fnc_assignGear;
if (_faction == "blu_f") then {
    [_typeOfUnit, _unit] call compile preprocessFileLineNumbers "f\assignGear_simple\f_assignGear_nato.sqf";
    _ff = true;
};

// OPF_F -> CSAT
if (_faction == "opf_f") then {
    [_typeOfUnit, _unit] call compile preprocessFileLineNumbers "f\assignGear_simple\f_assignGear_csat.sqf";
    _ff = true;
};

// INDEPEDENT -> AAF
if(_faction == "ind_f") then {
    [_typeOfUnit, _unit] call compile preprocessFileLineNumbers "f\assignGear_simple\f_assignGear_aaf.sqf";
    _ff = true;
};

// FIA units can be BLUFOR, OPFOR or INDEPENDENT, the "g"
// in the faction strings probably stands for guerrilla.
if (_faction in ["blu_g_f","opf_g_f","ind_g_f"]) then {
    [_typeOfUnit, _unit] call compile preprocessFileLineNumbers "f\assignGear_simple\f_assignGear_fia.sqf";
    _ff = true;
};

if (!_ff) then {
    [nil, "Faction '%1' is not known, unit '%2' left untouched.", _faction, _unit] call pa_fnc_bothlog;
};

// vim: sts=-1 ts=4 et sw=4
