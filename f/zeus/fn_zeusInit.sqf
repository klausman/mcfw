// Zeus Support  - Initialization
params [
    ["_unit", [objNull]],
    ["_addons", [],["",true,[]]],
    ["_objects", [],[objNull,true,[],west]],
    ["_announce", false]
];
private ["_curator"];

scriptName "f/zeus/fn_zeusInit.sqf";

// Ensure this script only executes on the server:
if !(isServer) exitWith {};

// Exit if no unit was passed
if (isNull _unit) exitWith {};

// Exit if this already is a Zeus
if !(isNull (getAssignedCuratorLogic _unit)) exitWith {
    ["ZeusInit", "Zeus already assigned to %1.",_unit] call mc_fnc_bothlog;
};

// Exit if the unit is not a player
if !(isPlayer _unit) exitWith {
    ["ZeusInit", "Did not assign Zeus to %1 because it is not under control of a player.",
        _unit] call mc_fnc_bothlog;
};

// Make sure a side logic exists, if not create it
if (isNil "f_var_sideCenter") then {
    f_var_sideCenter = createCenter sideLogic;
    publicVariable "f_var_sideCenter";
};

// Create a new curator logic
_curator = (createGroup f_var_sideCenter) createUnit ["ModuleCurator_F",[0,0,0] , [], 0, ""];

// Assign the passed unit as curator
_unit assignCurator _curator;

//Add desired addons
[_curator,_addons] spawn f_fnc_zeusAddAddons;

//Add desired objects
[_curator,_objects] spawn f_fnc_zeusAddObjects;

// Reduce costs for all actions
_curator setCuratorWaypointCost 0;
{_curator setCuratorCoef [_x,0];} forEach ["place","edit","delete","destroy","group","synchronize"];

// If announce is set to true, the new curator will be announced to all
// players
if (_announce) then {
    [["Alert",[format ["%1 has become curator!",name _unit]]],"BIS_fnc_showNotification",true] call BIS_fnc_MP;
};

// Return the newly created curator
_curator

// vim: sts=-1 ts=4 et sw=4
