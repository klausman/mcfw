scriptName "mc_fnc_editTicketCount";

params ["_amount", "_side"];

if (!isServer) exitWith {};

private _ticketCount = 0;
private _varName = "";

switch (_side) do {
    case (blufor): {
        _ticketCount = missionNamespace getVariable ["mc_respawnTickets_blufor", 0];
        _varName = "mc_respawnTickets_blufor";
    };
    case (opfor): {
        _ticketCount = missionNamespace getVariable ["mc_respawnTickets_opfor", 0];
        _varName = "mc_respawnTickets_opfor";
    };
    case (independent): {
        _ticketCount = missionNamespace getVariable ["mc_respawnTickets_indep", 0];
        _varName = "mc_respawnTickets_indep";
    };
};

if (f_var_debugMode == 1) then {
    [
        format ["Current %3 ticket count = %1, change = %2", str _ticketCount, _amount, str _side],
        "editTicketCount",
        [true, false, true]
    ] call CBA_fnc_debug;
};

if (_ticketCount + _amount < 0) then {
    missionNamespace setVariable [_varName, 0, true];
} else {
    missionNamespace setVariable [_varName, _ticketCount + _amount, true];
};
