diag_log "MC Framework v0.2.0 starting init.sqf";

// SETTING: Disable Saving and Auto Saving
enableSaving [false, false];

// SETTING: Mute Orders and Reports
enableSentences false;

// SETTING: Briefing
f_script_briefing = [] execVM "briefing.sqf";

// SETTING: Group IDs
f_script_setGroupIDs = [] execVM "f\setGroupID\f_setGroupIDs.sqf";

// SETTING: Buddy Team Colours
f_script_setTeamColours = [] execVM "f\setTeamColours\f_setTeamColours.sqf";

// SETTING: Fireteam Member Markers Comment out this line to disable
// Fireteam-level map markers (small triangles). The BLUFOR tracker (BFT) is
// configure in Addons settings > ACE Map 
[] spawn f_fnc_SetLocalFTMemberMarkers;

// Common Local Variables
// WARNING: DO NOT DISABLE THIS COMPONENT
if(isServer) then {
    f_script_setLocalVars = [] execVM "f\common\f_setLocalVars.sqf";
};

// SETTING: Casualties Cap
// [[GroupName or SIDE],100,1] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";
// [[GroupName or SIDE],100,{code}] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";

// BLUFOR > NATO
// [BLUFOR,100,1] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";

// OPFOR > CSAT
// [OPFOR,100,1] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";

// INDEPENDENT > AAF
// [INDEPENDENT,100,1] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";

// SETTING: Assign Gear AI
// [] execVM "f\assignGear\f_assignGear_AI.sqf";

// SETTING: ORBAT Notes
[] execVM "f\briefing\f_orbatNotes.sqf";

// SETTING: Loadout Notes
[] execVM "f\briefing\f_loadoutNotes.sqf";

// SETTING: Join Group Action
//[false] execVM "f\groupJoin\f_groupJoinAction.sqf";

// SETTING: Mission Timer/Safe Start
// Comment out this line to hard-disable the safe start timer.
[] execVM "f\safeStart\f_safeStart.sqf";

// Clientside caching
// run this instead of SETTING: AI unit caching (server side)
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
// Disable thermal sights for everything
//[] execVM "extras\disableThermals.sqf";

// PabstMirror - Mission Intro
// Credits: PabstMirror
[] execVM "extras\PM_missionIntro.sqf";

// Force First Person
// Disable 3PV regardless of server settings
//[] execVM "extras\forceFirstPerson.sqf";

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
                sleep 5;
                private _loadout = player getVariable ['f_var_assignGear', 'NO_LOADOUT'];
                if (_loadout!='NO_LOADOUT') then {
                    ['respawnEH', 'Unit %1 had a %2 loadout, recreating', player, _loadout] call mc_fnc_rptlog;
                    player setVariable ['f_var_assignGear_done',false,true];
                    [_loadout, player] call f_fnc_assignGear;
                } else {
                    ['respawnEH', 'Unit %1 had no loadout, doing nothing'] call mc_fnc_rptlog;
                };
                sleep 5;
                call mc_fnc_telepole_reinit;
             };"];
    };
};
// vim: sts=-1 ts=4 et sw=4
