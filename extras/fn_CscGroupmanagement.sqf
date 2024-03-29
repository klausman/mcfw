/*
fn_CscGroupmanagement
make mc_AIGroups array to be used in clientside caching.
delete empty groups
*/
mc_AIGroups = [];
{
    if ((count (units _x)) > 0) then {
        if (alive leader _x) then {
            if (!isplayer leader _x) then {
                // leader is a player: dont add to array
                mc_AIGroups pushback _x;
            };
        } else {
            // if leader is dead, check other units in group
            private ["_hasplayer"];
            _hasplayer = false;
            {
                if (isplayer _x) exitWith {_hasplayer = true;};
            } foreach units _x;
            if (!_hasplayer) then {
                mc_AIGroups pushback _x;
            };
        };
    } else { // delete empty groups
        deleteGroup _x;
        _x = grpNull;
        _x = nil;
    };
} foreach allGroups;

// vim: sts=-1 ts=4 et sw=4
