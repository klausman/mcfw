scriptName "mc_fnc_editTicketCount";

params ["_amount"];

if (!isServer) exitWith {};

private _ticketCount = missionNamespace getVariable ["mc_respawnTickets", 0];

if (f_var_debugMode == 1) then {
    [
        format ["Current ticket count = %1, change = %2", str _ticketCount, _amount],
        "editTicketCount",
        [true, false, true]
    ] call CBA_fnc_debug;
};

if (_ticketCount + _amount < 0) then {
    missionNamespace setVariable ["mc_respawnTickets", 0, true];
} else {
    missionNamespace setVariable ["mc_respawnTickets", _ticketCount + _amount, true];
};
