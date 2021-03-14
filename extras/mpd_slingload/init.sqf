/*
  Simple Sling Load Script by MrPvTDagger#4176 :D
*/

diag_log "MPD_SlingLoad is Loading...";

/* 
This is for Modded Objects that Might not be slingable by default. I have done this automtically but Just incase it doesn't work with all mods. 

EXAMPLE:
_ccargo = [
  RHS_Storage_Create_1,
  RHS_Storage_Create_2,
  RHS_Storage_Create_3 // Make sure the last one doesn't have a comment at the end
];
*/

_ccargo = [
  
];

/* Here you can change blacklisted entities which will be added at the start of a mission. */
_acargo = entities [[], ["Air","Man","Tank","Logic","House"], true];;

// ====================== Don't Touch Anything Below this line ======================
_acargo append _ccargo;
{
  _action = [
  "SlingLoad", // Action Name
  "Sling Load", // Name Of action Shown In menu
  "", // Icon
  {[_target] execVM "extras\mpd_slingload\sling.sqf";}, // Statment
  {(nearestObject [_target, "Helicopter"]) distance _target < 10}, // Condition
  {}, //
  [],
  [0,0,0], 100] call ace_interact_menu_fnc_createAction;

  [_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
} forEach _acargo;

/* Support for Fortification Tool ACEX */
if (isClass(configFile >> "CfgWeapons" >> "ACE_Fortify")) then
{
  ["acex_fortify_objectPlaced", {
    params ["_unit", "_side", "_object"];
    _action = [
    "SlingLoad", // Action Name
    "Sling Load", // Name Of action Shown In menu
    "", // Icon
    {[_target] execVM "extras\mpd_slingload\sling.sqf";}, // Statment
    {(nearestObject [_target, "Helicopter"]) distance _target < 10}, // Condition
    {}, //
    [],
    [0,0,0], 100] call ace_interact_menu_fnc_createAction;

    [_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
  }] call CBA_fnc_addEventHandler;
};

/* Support for Objects placed by Zues */
{ 
  _x addEventHandler ["CuratorObjectPlaced", {
    params ["_curator", "_entity"];
    if ((_entity isKindOf "Tank")||(_entity isKindOf "Air")||(_entity isKindOf "Logic")||(_entity isKindOf "Man")||(_entity isKindOf "House")) then { 
      //hint "Object is blacklisted";
    } else {
      _action = [
      "SlingLoad", // Action Name
      "Sling Load", // Name Of action Shown In menu
      "", // Icon
      {[_target] execVM "extras\mpd_slingload\sling.sqf";}, // Statment
      {(nearestObject [_target, "Helicopter"]) distance _target < 10}, // Condition
      {}, //
      [],
      [0,0,0], 100] call ace_interact_menu_fnc_createAction;

      [_entity, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
      //hint format["Object spawned: %1", _entity];
    };
  }];
} forEach allCurators;
