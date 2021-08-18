scriptName "mc_fnc_broadcastTicketCount";

if (!isServer) exitWith {};

private _ticketCount = missionNamespace getVariable ["mc_respawnTickets", 0];

[
    format ["Reinforcements left: %1", _ticketCount]
] remoteExec ["systemChat", west];
