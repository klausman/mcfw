// Process ParamsArray
private _paramArray = paramsArray;
{
    private _paramName =(configName ((missionConfigFile >> "Params") select _forEachIndex));
    private _paramValue = (_paramArray select _forEachIndex);
    private _paramCode = ( getText (missionConfigFile >> "Params" >> _paramName >> "code"));
    private _code = format[_paramCode, _paramValue];
    call compile _code;
    if (isServer) then {
        publicVariable _paramName;
    };
} foreach _paramArray;

// vim: sts=-1 ts=4 et sw=4
