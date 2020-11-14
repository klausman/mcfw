// Teleport script
// (C) 2020 T. Klausmann

params ["_tObj", "_tSide", "_quiet", "_scheduled"];

// Only run serverside
if (!isServer) exitwith {};

private _grpLeaders = [];

if (isNil "_scheduled") then {_scheduled=false;};
if (isNil "_quiet") then {_quiet=false;};

if (!_quiet && !_scheduled) then {
    ["telepole", "Initializing object %1 for side %2", _tObj, _tSide] call mc_fnc_rptlog;
};

removeAllActions _tObj;

if (!_scheduled) then {
    // Re-run ourselves periodically *silently*
    [_tSide, _tObj]spawn {
	params ["_tSide", "_tObj"];
        while {true} do {
            //["telepole",
            // "Scheduled update for %1/%2", _tObj, _tSide] call mc_fnc_rptlog;
            [_tObj, _tSide, true, true] call mc_fnc_telepole;
            sleep 60;
        };
    };
    // Add telepole to global list so it can be re-inited on the player kill
    // event handler.
    private _poles = missionNameSpace getVariable ["telepole_poles", []];
    _poles pushBack [_tObj, _tSide];
    missionNameSpace setVariable ["telepole_poles", _poles, true];
};

// "Reset my gear" action to work around assignGear limitations
if (mc_assigngear_telepole == 1) then {
    _tobj addAction [
        "Reset my gear",
        {
            params ["", "_caller", "", "_arguments"];
            if (typeName (_caller getVariable "f_var_assignGear") == typeName "") then {
                private _loadout = (_caller getVariable "f_var_assignGear");
                _caller setVariable ["f_var_assignGear_done",false,true];
                [_loadout,_caller] call f_fnc_assignGear;
            };
        }
    ];
};

// Get all groups leaders that are alive and players on the indicated side.
{
  private _l = leader _x;
  //if (side _l == _tSide && alive _l) then {
  if (/*isPlayer _l &&*/ side _l == _tSide && alive _l) then {
    if (!_quiet) then {
        ["telepole",
         "Leader %1 is a player, alive and on side %2, adding TP entry",
         _l, _tSide] call mc_fnc_rptlog;
    };
    _grpLeaders pushBack _l
  }
} foreach allGroups;

// Add action for every leader
{
  _tObj addaction [
   format ["Teleport to %1 (SL: %2)", groupID group _x, name _x],
   {
     params ["", "_caller", "", "_arguments"];
     [_arguments, _caller] call mc_fnc_teleport;
   },
   _x
  ]
} forEach _grpLeaders;

// Add Reset Pole action in case something broke.
_tobj addAction [
    "Reset Teleport pole",
    {
        params ["_target", "", "", "_arguments"];
        [_target, _arguments] call mc_fnc_telepole;
    },
    _tSide
];
