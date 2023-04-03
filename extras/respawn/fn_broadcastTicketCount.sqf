scriptName "mc_fnc_broadcastTicketCount";

if (!isServer) exitWith {};

private _bluforTicketCount = missionNamespace getVariable ["mc_respawnTickets_blufor", 0];
private _opforTicketCount = missionNamespace getVariable ["mc_respawnTickets_opfor", 0];
private _indepTicketCount = missionNamespace getVariable ["mc_respawnTickets_indep", 0];

[
    format ["Reinforcements left: %1", _bluforTicketCount]
] remoteExec ["systemChat", blufor];

[
    format ["Reinforcements left: %1", _redforTicketCount]
] remoteExec ["systemChat", opfor];

[
    format ["Reinforcements left: %1", _indepTicketCount]
] remoteExec ["systemChat", independent];
