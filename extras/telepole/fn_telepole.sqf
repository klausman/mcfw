// Teleport script

params ["_tObj", "_tSide"];

private _grpLeaders = [];

["telepole", "Initializing object %1 for side %2", _tObj, _tSide] call mc_fnc_rptlog;

removeAllActions _tObj;

if (mc_assigngear_telepole == 1) then {
    _tobj addAction [
        "Reset my gear",
        {
            params ["_target", "_caller", "_actionId", "_arguments"];
            if (typeName (_caller getVariable "f_var_assignGear") == typeName "") then {
                private _loadout = (_caller getVariable "f_var_assignGear");
                _caller setVariable ["f_var_assignGear_done",false,true];
                [_loadout,_caller] call f_fnc_assignGear;
            };
        }
    ];
};

// Get all groups on the player's side
{
  //["telepole", "Considering group %1", _x] call mc_fnc_rptlog;
  private _l = leader _x;
  //["telepole", "Leader is %1", _l] call mc_fnc_rptlog;
  //["telepole", "Leader side is %1", side _l] call mc_fnc_rptlog;
  //if (isPlayer _l && side _l == _tSide) then {

  if (side _l == _tSide) then {
    ["telepole", "Everything lines up, adding leader %1", _l] call mc_fnc_rptlog;
    _grpLeaders pushBack _l
  }
} foreach allGroups;

["telepole", "Leaders: %1", _grpLeaders] call mc_fnc_rptlog;

// Add action for every leader
{
  _tObj addaction [
   format ["Teleport to %1 (SL: %2)", group _x, name _x],
   {
     params ["_target", "_caller", "_actionId", "_arguments"];
     //["telepole", "XXY: target %1, caller %2 actionId %3 args %4", _target, _caller, _actionId, _arguments] call mc_fnc_rptlog;
     [_arguments, _caller] call mc_fnc_teleport;
   },
   _x
  ]
} forEach _grpLeaders;

// Reset pole in case there are new groups or something else broke.
_tobj addAction [
    "Reset Teleport pole",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        
        [_target, _arguments] call mc_fnc_telepole;
    },
    _tSide
];

// Debug option
/*_tobj addAction [
    "Launch Bob 10km into the air",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        private _pos = getPos bob;
        bob setPos [_pos select 0, _pos select 1, 10000];
    }
];*/


// vim: sts=-1 ts=4 et sw=4
