/*
	Simple Sling Loading System or DSL as some call it
	Author: Dagger (MrPvTDagger#4176)
	License: MIT License  (https://gitlab.oki.cx/mrpvtdagger/arma-3-scripts/-/blob/547b6981dc7b02b5864d03fe1b2577a8c152486a/LICENSE)

	You can make any object slingable by simply calling DSL_fn_add_sling_action function with a parameter of the object
	example:
		private _object = "C_Offroad_01_F" createVehicle position player;
		[_object] call DSL_fn_add_sling_action
		
*/

if (mc_enable_dsl == 0) exitWith {["fn_simpleSlingloading (DSL) has been disabled in mission parameters"] call mc_fnc_rptlog;};
["fn_simpleSlingloading: initializing"] call mc_fnc_rptlog;

private ["_acargo","_action","_target","_action"];

// List objects classes that will be ignored at mission init.
_acargo = entities [[], ["Air","Man","Tank","Logic","House"], true];

DSL_fn_add_sling_action = {
	params ["_object"];
	_action = [
		"SlingLoad", "Sling Load", "", {
			// _args is populated by ace_common_fnc_progressBar
			// _target is from ace_interact_menu_fnc_addActionToObject
			[10, [_target], {[_args select 0] call DSL_fn_sling}, {}, "Sling Loading..."] call ace_common_fnc_progressBar;
		},
	{((nearestObject [_target, "Helicopter"]) distance _target < 15) && count attachedObjects nearestObject [_target, "Helicopter"] == 0},{},[],
	[0,0,0], 10] call ace_interact_menu_fnc_createAction;
	[_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
};

// Adds objects at Mission Start
{
	[_x] call DSL_fn_add_sling_action;
} forEach _acargo;

// Adds objects spawned by ACE_Fortify Tool
if (isClass(configFile >> "CfgWeapons" >> "ACE_Fortify")) then {
	["acex_fortify_objectPlaced", {
			params ["", "", "_object"];
			if (_object isKindOf "House") exitWith {};
			[_object] call DSL_fn_add_sling_action;
		}
	] call CBA_fnc_addEventHandler;
};

// Adds objects spawned by Zues
{
	_x addEventHandler ["CuratorObjectPlaced", {
		params ["", "_entity"];
		if !((_entity isKindOf "Tank")||(_entity isKindOf "Air")||(_entity isKindOf "Logic")||(_entity isKindOf "Man")||(_entity isKindOf "House")) then {
				[_entity] call DSL_fn_add_sling_action;
			};
		}
	];
} forEach allCurators;

// Adds Modules to Zeus Enhanced
if (!isNil "zen_custom_modules_fnc_register") then {
	["Objects", "Make Slingable", {
			if (isNull ( _this select 1)) exitWith {};
			[_this select 1] call DSL_fn_add_sling_action;
		}
	] call zen_custom_modules_fnc_register;

	["Objects", "Sling to Nearest Helicopter", {
			if (isNull (_this select 1)) exitWith {};
			[_this select 1] call DSL_fn_sling;
		}
	] call zen_custom_modules_fnc_register;
};

DSL_fn_sling = {
	params ["_cargo"];
	private ["_nObject","_Rope1","_Rope2","_Rope3","_Rope4"];
	_nObject = nearestObject [_cargo, "Helicopter"];

	if (count attachedObjects _nObject != 0) exitWith {
		hint "Helicopter already has cargo sling loaded";
	};

	//Slinging cargo to itself will crash arma
	if (_nObject == _cargo) exitWith {
		hint "You can't sling Load cargo to itself";
	};

	_cargo attachTo [_nObject, [0, 1.1, -7]];

	private _ropelength = (_cargo distance _nObject);
	_Rope1 = ropeCreate [_nObject, [0,1.1,-2], _ropelength];
	_Rope2 = ropeCreate [_nObject, [0,1.1,-2], _ropelength];
	_Rope3 = ropeCreate [_nObject, [0,1.1,-2], _ropelength];
	_Rope4 = ropeCreate [_nObject, [0,1.1,-2], _ropelength];

	private _attachmentPoints = [_cargo] call ASL_Get_Corner_Points;
	[_cargo, _attachmentPoints select 0, [0,0,-1]] ropeAttachTo _Rope1;
	[_cargo, _attachmentPoints select 1, [0,0,-1]] ropeAttachTo _Rope2;
	[_cargo, _attachmentPoints select 2, [0,0,-1]] ropeAttachTo _Rope3;
	[_cargo, _attachmentPoints select 3, [0,0,-1]] ropeAttachTo _Rope4;

	[_nObject, ["<t color='#FF0000'>Release Cargo</t>", {
		private ["_heli","_cargoRopes","_pos"];
		_heli = _this select 0;
		if ((getPosATL _heli) select 2 > 20 ) exitWith {
			hint "You are too High to release cargo"
		};
		_cargoRopes = ropes _heli;
		{
			ropeDestroy _x;
		} forEach _cargoRopes;

		{
			detach _x;
			_pos = [_heli, 5, 10, 0, 0, 20, 0] call BIS_fnc_findSafePos;
			_x setPos _pos;
		} forEach attachedObjects _heli;
		[_heli] remoteExec ["removeallactions"];
	},nil,1.5,true,true,"","true",8,false,"",""]] remoteExec ["addAction"];
};

/*
	Credits for finding rope points go to seth duda from Advanced Sling Loading.
	https://github.com/sethduda/
	https://github.com/sethduda/AdvancedSlingLoading
*/

if (isNil "ASL_Get_Corner_Points") then {
	["fn_simpleSlingloading: ASL is Disabled - Declaring ASL function"] call mc_fnc_rptlog;

	ASL_Get_Corner_Points = {
		params ["_vehicle"];
		private ["_centerOfMass","_bbr","_p1","_p2","_rearCorner","_rearCorner2","_frontCorner","_frontCorner2"];
		private ["_maxWidth","_widthOffset","_maxLength","_lengthOffset","_widthFactor","_lengthFactor","_maxHeight","_heightOffset"];
		
		// Correct width and length factor for air
		_widthFactor = 0.5;
		_lengthFactor = 0.5;
		if(_vehicle isKindOf "Air") then {
			_widthFactor = 0.3;
		};
		if(_vehicle isKindOf "Helicopter") then {
			_widthFactor = 0.2;
			_lengthFactor = 0.45;
		};
		
		_centerOfMass = getCenterOfMass _vehicle;
		_bbr = boundingBoxReal _vehicle;
		_p1 = _bbr select 0;
		_p2 = _bbr select 1;
		_maxWidth = abs ((_p2 select 0) - (_p1 select 0));
		_widthOffset = ((_maxWidth / 2) - abs ( _centerOfMass select 0 )) * _widthFactor;
		_maxLength = abs ((_p2 select 1) - (_p1 select 1));
		_lengthOffset = ((_maxLength / 2) - abs (_centerOfMass select 1 )) * _lengthFactor;
		_maxHeight = abs ((_p2 select 2) - (_p1 select 2));
		_heightOffset = _maxHeight/6;
		
		_rearCorner = [(_centerOfMass select 0) + _widthOffset, (_centerOfMass select 1) - _lengthOffset, (_centerOfMass select 2)+_heightOffset];
		_rearCorner2 = [(_centerOfMass select 0) - _widthOffset, (_centerOfMass select 1) - _lengthOffset, (_centerOfMass select 2)+_heightOffset];
		_frontCorner = [(_centerOfMass select 0) + _widthOffset, (_centerOfMass select 1) + _lengthOffset, (_centerOfMass select 2)+_heightOffset];
		_frontCorner2 = [(_centerOfMass select 0) - _widthOffset, (_centerOfMass select 1) + _lengthOffset, (_centerOfMass select 2)+_heightOffset];
		
		[_rearCorner,_rearCorner2,_frontCorner,_frontCorner2];
	};	
};
