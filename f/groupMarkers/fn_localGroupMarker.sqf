// Group Markers
params ["_grpName", "_mkrType", "_mkrText", "_mkrColor"];
// DECLARE PRIVATE VARIABLES
private ["_grp","_mkrName","_mkr", "_ldr", "_pos", "_posX", "_posY"];

// TODO(klausman) This code is very, very suspect
call compile format ["
if(!isnil '%1') then {
    _grp = %1;
};
",_grpName];

_mkrName = format ["mkr_%1",_grpName];

// WAIT FOR GROUP TO EXIST IN-MISSION
sleep 3;

// EXIT FOR EMPTY GROUPS (PART I)
// If the group is empty, this script exits.

if (isnil "_grp") exitWith {};

private _ldr = leader _grp;
private _pos = getPos _ldr;
private _posX = _pos select 0;
private _posY = _pos select 1;

// CREATE MARKER
_mkr = createMarkerLocal [_mkrName,[_posX, _posY]];
// Set Marker attrs
// Depending on the value of _mkrType a different type of marker is created.
switch (_mkrType) do {
    // Platoon HQ
    case 0: {
        _mkr setMarkerShapeLocal "ICON";
        _mkrName setMarkerTypeLocal "b_hq";
        _mkrName setMarkerColorLocal _mkrColor;
        _mkrName setMarkerSizeLocal [0.8, 0.8];
        _mkrName setMarkerTextLocal _mkrText;
    };
    // Fireteam
    case 1: {
        _mkr setMarkerShapeLocal "ICON";
        _mkrName setMarkerTypeLocal  "b_inf";
        _mkrName setMarkerColorLocal _mkrColor;
        _mkrName setMarkerSizeLocal [0.8, 0.8];
        _mkrName setMarkerTextLocal _mkrText;
    };
    // Machineguns (MMG, HMG)
    case 2: {
        _mkr setMarkerShapeLocal "ICON";
        _mkrName setMarkerTypeLocal  "b_support";
        _mkrName setMarkerColorLocal _mkrColor;
        _mkrName setMarkerSizeLocal [0.8, 0.8];
        _mkrName setMarkerTextLocal _mkrText;
    };
    // Launchers (MAT, HAT, SAM)
    case 3: {
        _mkr setMarkerShapeLocal "ICON";
        _mkrName setMarkerTypeLocal  "b_motor_inf";
        _mkrName setMarkerColorLocal _mkrColor;
        _mkrName setMarkerSizeLocal [0.8, 0.8];
        _mkrName setMarkerTextLocal _mkrText;
    };
    // Sniper Team
    case 4: {
        _mkr setMarkerShapeLocal "ICON";
        _mkrName setMarkerTypeLocal  "b_recon";
        _mkrName setMarkerColorLocal _mkrColor;
        _mkrName setMarkerSizeLocal [0.8, 0.8];
        _mkrName setMarkerTextLocal _mkrText;
    };
    // Mortar Team
    case 5: {
        _mkr setMarkerShapeLocal "ICON";
        _mkrName setMarkerTypeLocal  "b_mortar";
        _mkrName setMarkerColorLocal _mkrColor;
        _mkrName setMarkerSizeLocal [0.8, 0.8];
        _mkrName setMarkerTextLocal _mkrText;
    };
    // Engineers
    case 6: {
        _mkr setMarkerShapeLocal "ICON";
        _mkrName setMarkerTypeLocal  "b_maint";
        _mkrName setMarkerColorLocal _mkrColor;
        _mkrName setMarkerSizeLocal [0.8, 0.8];
        _mkrName setMarkerTextLocal _mkrText;
    };
    // IFVs and APCs
    case 7: {
        _mkr setMarkerShapeLocal "ICON";
        _mkrName setMarkerTypeLocal  "b_mech_inf";
        _mkrName setMarkerColorLocal _mkrColor;
        _mkrName setMarkerSizeLocal [0.8, 0.8];
        _mkrName setMarkerTextLocal _mkrText;
    };
    // Tanks
    case 8: {
        _mkr setMarkerShapeLocal "ICON";
        _mkrName setMarkerTypeLocal  "b_armor";
        _mkrName setMarkerColorLocal _mkrColor;
        _mkrName setMarkerSizeLocal [0.8, 0.8];
        _mkrName setMarkerTextLocal _mkrText;
    };
    // Transport and Attack Helos
    case 9: {
        _mkr setMarkerShapeLocal "ICON";
        _mkrName setMarkerTypeLocal  "b_air";
        _mkrName setMarkerColorLocal _mkrColor;
        _mkrName setMarkerSizeLocal [0.8, 0.8];
        _mkrName setMarkerTextLocal _mkrText;
    };
    // Planes and jets
    case 10: {
        _mkr setMarkerShapeLocal "ICON";
        _mkrName setMarkerTypeLocal  "b_plane";
        _mkrName setMarkerColorLocal _mkrColor;
        _mkrName setMarkerSizeLocal [0.8, 0.8];
        _mkrName setMarkerTextLocal _mkrText;
    };
    // Artillery
    case 11: {
        _mkr setMarkerShapeLocal "ICON";
        _mkrName setMarkerTypeLocal  "b_art";
        _mkrName setMarkerColorLocal _mkrColor;
        _mkrName setMarkerSizeLocal [0.8, 0.8];
        _mkrName setMarkerTextLocal _mkrText;
    };
};

// UPDATE MARKER POSITION
// As long as certain conditions are met (the group exists) the marker
// position is updated periodically. This only happens locally - so as not to
// burden the server.

while {{!isNull _x} count units _grp > 0} do {
    _ldr = leader _grp;
    _pos = getPos _ldr;
    _posX = _pos select 0;
    _posy = _pos select 1;
    _mkrName setMarkerPosLocal [_posX, _posY];
    sleep 6;
};

// vim: sts=-1 ts=4 et sw=4
