diag_log "MC Framework v0.2.0 starting init.sqf";

// Disable Saving and Auto Saving
enableSaving [false, false];

// Mute Orders and Reports
enableSentences false;

// Briefing
f_script_briefing = [] execVM "briefing.sqf";

// Group IDs
f_script_setGroupIDs = [] execVM "f\setGroupID\f_setGroupIDs.sqf";

// Buddy Team Colours
f_script_setTeamColours = [] execVM "f\setTeamColours\f_setTeamColours.sqf";

// Fireteam Member Markers Comment out this line to disable Fireteam-level map
// markers (small triangles). The BLUFOR tracker (BFT) is configure in Addons
// settings > ACE Map 
// Also see https://www.misfit-company.com/arma3/mission_making/new_bft/
[] spawn f_fnc_SetLocalFTMemberMarkers;

// Casualties Cap
// [[GroupName or SIDE],100,1] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";
// [[GroupName or SIDE],100,{code}] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";

// BLUFOR
// [BLUFOR,100,1] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";

// OPFOR
// [OPFOR,100,1] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";

// INDEPENDENT
// [INDEPENDENT,100,1] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";

// Assign Gear AI
// Uncomment this line if you want to run assignGear for _all_ AI.
// [] execVM "f\assignGear\f_assignGear_AI.sqf";

// ORBAT Notes (in Briefing/Map)
[] execVM "f\briefing\f_orbatNotes.sqf";

// Loadout Notes (in Briefing/Map)
[] execVM "f\briefing\f_loadoutNotes.sqf";

// Mission Timer/Safe Start
[] execVM "f\safeStart\f_safeStart.sqf";

// Clientside caching
if (!isserver && hasInterface) then {
    //run on all player clients incl. player host and excl. headless clients
    []spawn {
    waitUntil {sleep 0.1; !isNull player};
    waitUntil{!isNil "mc_param_cscaching"};
        if (mc_param_cscaching == 1) then {
            handle_pacaching2 = [{[] call mc_fnc_CscGroupmanagement;}, 30] call CBA_fnc_addPerFrameHandler;
            waitUntil{!isNil "mc_AIGroups"};
            handle_pacaching1 = [{[] call mc_fnc_ClientsideCaching;}, 6] call CBA_fnc_addPerFrameHandler;
        };
    };
};

// Thermals
// Disable thermal sights for everything, including A3TI
//[] execVM "extras\disableThermals.sqf";

// PabstMirror - Mission Intro
// Credits: PabstMirror
[] execVM "extras\PM_missionIntro.sqf";

// WS - AI Flashlights
// Credits: Wolfenswan
// [] execVM "extras\forceFlashlightAI.sqf";

// Add two event handlers:
// - The first quickly removes a player's body upon death or respawn
// - The second runs on respawn, checks if the unit has an associated
//   assignGear loadout, and if so, re-runs assignGear.
if (hasInterface) then {
    []spawn {
        waitUntil {sleep 1; !isNull player};
        player addEventHandler [
            "killed",
            "params ['_unit'];
             [_unit] spawn {
                sleep 5;
                 hideBody _this;
                 sleep 10;
                 deleteVehicle _this;
             };"];
    };
    []spawn {
        waitUntil {sleep 1; !isNull player};
        player addEventHandler [
            "respawn",
             "[] spawn {
                scriptName 'respawnEH';
                sleep 5;
                private _loadout = player getVariable ['f_var_assignGear', 'NO_LOADOUT'];
                if (_loadout!='NO_LOADOUT') then {
                    ['Unit %1 had a %2 loadout, recreating', player, _loadout] call mc_fnc_rptlog;
                    player setVariable ['f_var_assignGear_done',false,true];
                    [_loadout, player] call f_fnc_assignGear;
                } else {
                    ['Unit %1 had no loadout, doing nothing'] call mc_fnc_rptlog;
                };
                sleep 5;
                call mc_fnc_telepole_reinit;
             };"];
    };
};
// vim: sts=-1 ts=4 et sw=4
