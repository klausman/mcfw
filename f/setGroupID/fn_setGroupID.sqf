// Set Group ID Function

// DECLARE VARIABLES
private ["_grp","_name"];

// Check first if the group exists
if(!isnil (_this select 0)) then {
    // Compile a variable from the parsed string
    _grp = call compile format ["%1",_this select 0];
    _name = _this select 1;
    _grp setGroupId [format ["%1",_name],"GroupColor0"];
};

// vim: sts=-1 ts=4 et sw=4
