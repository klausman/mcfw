// Zeus Support - Add Objects

params [
    ["_curator", objNull],
    ["_mode" ,[], [true, west, objNull, []]],
    ["_groupLeaders", false]
];
private ["_objects","_leaders"];

scriptName "f/zeus/fn_zeusAddObjects.sqf";

// Ensure this script only executes on the server:
if !(isServer) exitWith {};

// If the passed unit is not in the list of all curators, check whether the
// curator is assigned to it
if !(_curator in allCurators) then {
    _curator = getAssignedCuratorLogic _curator;
};

// If curator is null or not the correct logic exit with an error message.
if (isNull _curator || typeOf _curator != "ModuleCurator_F") exitWith {
    ["Error: curator==null (%1) or wrong type. Wanted ModuleCurator_F, got %2",
        isNull _curator,typeOf _curator] call mc_fnc_bothlog;
};

// Decide which objects to add based on passed mode
_objects = [];
switch (typeName _mode) do {
    case "ARRAY": {_objects = _mode};
    case "OBJECT": {_objects = [_mode]};
    case "SIDE": {
        private _everything = allUnits + vehicles;
        {
            if ((side _x) == _mode) then {
                _objects pushBack _x;
            }
        } foreach _everything;
    };
    case "BOOL": {
         if (_mode) then {
            _objects = (vehicles+allUnits);

            // To prevent unnecessary stress on the network compare the the
            // new _objects array to the existing curator objects. If they are
            // identical, reset _objects to an empty array
            if (_objects isEqualTo (curatorEditableObjects _curator)) then {
                _objects = [];
            };

         } else {
            _curator removeCuratorEditableObjects [curatorEditableObjects _curator,true];
         };

     };
};

// Reduce list to group-leaders and empty vehicles if desired
_leaders = [];
if (_groupLeaders) then {
    {
        if ((isNull group _x) || _x == leader group _x) then {
            _leaders pushBack _x;
        };
    } forEach _objects;
    _objects = _leaders;
};

// Add all selected objects to curator lists
_curator addCuratorEditableObjects [_objects,true];

// vim: sts=-1 ts=4 et sw=4
