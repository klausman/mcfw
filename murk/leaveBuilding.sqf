params ["_unit"];
private ["_alivedudes","_grp","_remainingtoattack"];

_grp = group _unit;
_remainingtoattack = _grp getvariable "remainingtoattack";

_alivedudes = 0;

{
    if (alive _x) then { _alivedudes = _alivedudes + 1; };
} foreach (units group _this);

if (_alivedudes <= _remainingtoattack) then {
    {
        _x forceSpeed -1;
        _x enableAI "TARGET";
        [_x] spawn {
            params ["_man"];
            sleep 5;
            (_man) commandMove (getpos (_man));
        };
    } foreach (units group _this);

    [_this] call CBA_fnc_taskPatrol;
};
// vim: sts=-1 ts=4 et sw=4
