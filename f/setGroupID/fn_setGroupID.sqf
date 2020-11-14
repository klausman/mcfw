// Set Group ID Function
params ["_g", "_n"];
// DECLARE VARIABLES
private ["_grp"];

// Check first if the group exists
if(!isnil "_g") then {
    // Compile a variable from the parsed string
    _grp = call compile format ["%1",_g];
    _grp setGroupId [format ["%1",_n],"GroupColor0"];
};

// vim: sts=-1 ts=4 et sw=4
