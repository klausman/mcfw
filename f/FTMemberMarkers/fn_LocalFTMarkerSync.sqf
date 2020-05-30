//  Fireteam Marker Team Color Synchronization
//  Description: Sync the groups teamcolors to other players in the group.
//  Parameters
//      0: Group
//      1: Unit
//  Returns:
//      Nothing
//  Example:
//      [grp,unit] call f_fnc_LocalFTMarkerSync;
//
// ==========================================================================

private ["_grp","_unit","_colorTeam"];
_grp = _this select 0;
_unit = _this select 1;
waitUntil {!isnil "f_var_debugMode"};

// ==========================================================================

// BEGIN SYNCHRONIZATION
// if he is still alive and groupLeader

while{_unit == (leader _grp) && alive _unit} do {
    {
        // if unit in my group is alive lets check his teamColor
        if(alive _x) then {
            _colorTeam = [assignedTeam _x] call f_fnc_GetMarkerColor;
            // if _colorTeam is not equal to whatever is set on the unit we
            // must update the other units in the group
            if((_x getvariable ["assignedTeam","ColorWhite"]) != _colorTeam) then {
                // debug messages
                if (f_var_debugMode == 1) then {
                    ["f\\FTMemberMarkers\\fn_LocalFTMarkerSync.sqf", "%1 -> %2 by %3",
                     (_x getvariable ["assignedTeam","ColorWhite"]),
                     _colorTeam,_unit] call mc_fnc_bothlog;
                };

                // sends a call to each unit in the group to use the local
                // with the [x_colorTeam] as args.
                [[_x,_colorTeam] , "f_fnc_SetTeamValue", _grp, false] spawn BIS_fnc_MP;
            };
        };
    } foreach units _grp;
    sleep 3;
};

// if the group is not gone.
if(!isnil "_grp") then {
    // get the new leader
    private _l = leader _grp;
    // tell him to start running the sync.
    [[_grp,_l] , "f_fnc_LocalFTMarkerSync",_l, false] spawn BIS_fnc_MP;
};

// vim: sts=-1 ts=4 et sw=4
