// Handle event only if our respawn ticket system is enabled
if (!isServer
    || (missionNamespace getVariable ["mc_respawnTickets_blufor", -1] < 0
        && missionNamespace getVariable ["mc_respawnTickets_opfor", -1] < 0
        && missionNamespace getVariable ["mc_respawnTickets_indep", -1] < 0
    )
) exitWith {};

_this spawn {
    scriptName "mc_fnc_handlePlayerRespawn";
    params ["_unit"];

    // Wait for the unit to be alive so we can check if it's a curator
    waitUntil {
        sleep 1;
        alive _unit
    };

    // Skip the ticket loss if it's disabled on this unit
    if (_unit getVariable ["mc_respawnTickets_disabled", false]) exitWith {
        if (f_var_debugMode == 1) then {
            [
                format ["Skipping ticket loss for unit %1 (disabled)", name _unit],
                "handlePlayerRespawn",
                [true, false, true]
            ] call CBA_fnc_debug;
        };
    };

    private _side = side _unit;
    private _ticketCount = 0;
    private _varName = "";
    private _excludedSpectatorSides = [];

    switch (_side) do {
        case (blufor): {
            _ticketCount = missionNamespace getVariable ["mc_respawnTickets_blufor", 0];
            _varName = "mc_respawnTickets_blufor";
            _excludedSpectatorSides = [civilian, independent, opfor];
        };
        case (opfor): {
            _ticketCount = missionNamespace getVariable ["mc_respawnTickets_opfor", 0];
            _varName = "mc_respawnTickets_opfor";
            _excludedSpectatorSides = [civilian, independent, blufor];
        };
        case (independent): {
            _ticketCount = missionNamespace getVariable ["mc_respawnTickets_indep", 0];
            _varName = "mc_respawnTickets_indep";
            _excludedSpectatorSides = [civilian, blufor, opfor];
        };
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

    // Skip the ticket loss if the system isn't activated (for this side)
    if (_ticketCount < 0) exitWith {
        if (f_var_debugMode == 1) then {
            [
                format ["Skipping ticket loss for this side (%1)", str _side],
                "handlePlayerRespawn",
                [true, false, true]
            ] call CBA_fnc_debug;
        };
    };

    if (f_var_debugMode == 1) then {
        [
            format ["Current %2 ticket count = %1", str _ticketCount, str _side],
            "handlePlayerRespawn",
            [true, false, true]
        ] call CBA_fnc_debug;
    };

    if (_ticketCount > 0) then {
        _ticketCount = _ticketCount - 1;
        missionNamespace setVariable [_varName, _ticketCount, true];

        // Disable unit and hide it
        [_unit, true] remoteExecCall ["hideObjectGlobal", 2, true];
        [_unit, false] remoteExecCall ["enableSimulationGlobal", 2, true];

        [format ["Reinforcements left: %1", _ticketCount]] remoteExec ["systemchat", _side];

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
            [_side],
            _excludedSpectatorSides
        ] remoteExecCall ["ace_spectator_fnc_updateSides", _unit];
        [
            allPlayers,
            [_unit]
        ] remoteExecCall ["ace_spectator_fnc_updateUnits", _unit];
        [true] remoteExecCall ["ace_spectator_fnc_setSpectator", _unit];
    };
};
