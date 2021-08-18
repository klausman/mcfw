// Handle event only if our respawn ticket system is enabled
if (!isServer
    || missionNamespace getVariable ["mc_respawnTickets", -1] < 0
) exitWith {};

_this spawn {
    scriptName "mc_fnc_handlePlayerRespawn";
    params ["_unit"];

    // Wait for the unit to be alive so we can check if it's a curator
    waitUntil {
        sleep 1;
        alive _unit
    };

    // Skip the ticket loss if it's a curator
    if (!isNull (getAssignedCuratorLogic _unit)) exitWith {
        if (f_var_debugMode == 1) then {
            [
                format ["Skipping ticket loss for curators"],
                "handlePlayerRespawn",
                [true, false, true]
            ] call CBA_fnc_debug;
        };
    };

    private _ticketCount = missionNamespace getVariable ["mc_respawnTickets", 0];

    if (f_var_debugMode == 1) then {
        [
            format ["Current ticket count = %1", str _ticketCount],
            "handlePlayerRespawn",
            [true, false, true]
        ] call CBA_fnc_debug;
    };

    if (_ticketCount > 0) then {
        _ticketCount = _ticketCount - 1;
        missionNamespace setVariable ["mc_respawnTickets", _ticketCount, true];

        // Disable unit and hide it
        [_unit, true] remoteExecCall ["hideObjectGlobal", 2, true];
        [_unit, false] remoteExecCall ["enableSimulationGlobal", 2, true];

        [format ["Reinforcements left: %1", _ticketCount]] remoteExec ["systemchat", west];

        // Disable ACE spectator mode
        [false] remoteExecCall ["ace_spectator_fnc_setSpectator", _unit];
    } else {
        // Enable unit and unhide it
        [_unit, false] remoteExecCall ["hideObjectGlobal", 2, true];
        [_unit, true] remoteExecCall ["enableSimulationGlobal", 2, true];

        // Transition to a black screen for 5-10 sec
        [[
            "<t size='3'>Reinforcement not available</t><br/>Respawn disabled, no tickets left. Switching to spectator mode...",
            "BLACK FADED",
            -1,
            true,
            true
        ]] remoteExecCall ["cutText", _unit];

        // Activate ACE spectator mode (first person with west/players only)
        // @see https://ace3mod.com/wiki/framework/spectator-framework.html
        [
            [west],
            [independent, east, civilian]
        ] remoteExecCall ["ace_spectator_fnc_updateSides", _unit];
        [
            allPlayers,
            [_unit]
        ] remoteExecCall ["ace_spectator_fnc_updateUnits", _unit];
        [true] remoteExecCall ["ace_spectator_fnc_setSpectator", _unit];
    };
};
