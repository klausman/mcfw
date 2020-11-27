// fnc_stringReplace: Replace substrings
// Usage:
// ["The X that can be spoken of is not the true X", ["X"], "Arma"] call mc_fnc_stringReplace;
//
params["_str", "_find", "_replace"];
private["_return", "_len", "_pos"];

{
    _return = "";
    _len = count _x;
    _pos = _str find _x;

    while {(_pos != -1) && (count _str > 0)} do {
        _return = _return + (_str select [0, _pos]) + _replace;

        _str = (_str select [_pos+_len]);
        _pos = _str find _x;
    };
    _str = _return + _str;
} forEach _find;

_str;
// vim: sts=-1 ts=4 et sw=4
