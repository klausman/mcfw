// Unit Markers for Specialists

params ["_unitName", "_mkrType", "_mkrText", "_mkrColor"]; 

// DECLARE PRIVATE VARIABLES
private ["_unit","_mkrName","_mkr", "_ldr", "_pos", "_posX", "_posY"];

// SET KEY VARIABLES
// Using variables passed to the script instance, we will create some local
// variables:
// TODO(klausman) Very suspect code
call compile format ["
if(!isnil '%1') then {
    _unit = %1;
};
",_unitName];

_mkrName = format ["mkr_%1",_unitName];

// WAIT FOR UNIT TO EXIST IN-MISSION
// We wait for the unit to exist before creating the marker.
if (isNil "_unit") then {
    call compile format ["
        waitUntil {
        sleep 3;
        !isnil '%1'
        };
        _unit = %1;
    ",_unitName];
};

// EXIT FOR DEAD UNITS (PART I)
// If the unit is dead, this script exits.
if (!alive _unit) exitWith {};

// CREATE MARKER
_ldr = leader _unit;
_pos = getPos _ldr;
_posX = _pos select 0;
_posY = _pos select 1;

_mkr = createMarkerLocal [_mkrName,[_posX, _posY]];
// Depending on the value of _mkrType a different type of marker is created.
switch (_mkrType) do {
    // Medics
    case 0: {
        _mkr setMarkerShapeLocal "ICON";
        _mkrName setMarkerTypeLocal "b_med";
        _mkrName setMarkerColorLocal _mkrColor;
        _mkrName setMarkerSizeLocal [0.5, 0.5];
        _mkrName setMarkerTextLocal _mkrText;
    };
    // UAV Operator
    case 1: {
        _mkr setMarkerShapeLocal "ICON";
        _mkrName setMarkerTypeLocal "b_uav";
        _mkrName setMarkerColorLocal _mkrColor;
        _mkrName setMarkerSizeLocal [0.5, 0.5];
        _mkrName setMarkerTextLocal _mkrText;
    };
};

// UPDATE MARKER POSITION
// As long as certain conditions are met (the unit is alive) the marker
// position is updated periodically. This only happens locally - so as not to
// burden the server.
while {alive _unit} do {
    _ldr = leader _unit;
    _pos = getPos _ldr;
    _posX = _pos select 0;
    _posY = _pos select 1;
    _mkrName setMarkerPosLocal [_posX, _posY];
    sleep 6;
};

// RESET MARKER FOR RESPAWNING UNITS
// If respawn is enabled we need to reset the marker should the unit die

// Sleep for the set respawn delay plus a small grace period
sleep (getNumber (missionconfigfile >> "RespawnDelay")) + 3;

// Re-compile the unit variable using the initially passed string
call compile format ["
        waitUntil {
        sleep 0.1;
        !isnil '%1'
        };
        _unit = %1;

    ",_unitName];

// Check again if the unit is alive, if yes restart the marker function
if (alive _unit) exitWith {
    [_unitName, _mkrType, _mkrText, _mkrColor] spawn f_fnc_localSpecialistMarker;
};

// vim: sts=-1 ts=4 et sw=4
