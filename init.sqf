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

// SETTING: Fireteam Member Markers
// Comment out this line to disable Fireteam-level map markers (small
// triangles)
[] spawn f_fnc_SetLocalFTMemberMarkers;

// SETTING: ARPS Group Markers
// Comment out this line to disable squad-level markers (BLUFOR tracker)
f_script_setGroupMarkers = [] execVM "f\groupMarkers\f_setLocalGroupMarkers.sqf";

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

// SETTING: AI Skill Selector
// [] execVM "f\setAISkill\f_setAISkill.sqf";
// f_var_civAI = independent; // Optional: The civilian AI will use this side's settings

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

// SETTING: JIP setup
// Note: if you *don't* want respawn (and spectator instead), go to
// description.ext and follow the instructions there (look for f_spectator)

// Note: respawn_west etc. markers are mandatory. When not using respawn,
// place these markers somewhere players will not go
f_var_JIP_JIPMenu = true;       // Do JIP players get the JIP menu?
f_var_JIP_RespawnMenu = true;   // Do respawning players get the JIP menu?
f_var_JIP_RemoveCorpse = false; // Remove corpses of respawning players?
f_var_JIP_Spectate = false;     // JIP players go into spectate straight away?

// WARNING: DO NOT DISABLE THIS COMPONENT
if (hasInterface) then {
    []spawn {
        waitUntil {sleep 0.1; !isNull player};
        player addEventHandler ["killed", "['F_ScreenSetup'] call BIS_fnc_blackOut"];
    };
};


// Clientside caching
// run this instead of SETTING: AI unit caching (server side)
if (!isserver && hasInterface) then {
    //run on all player clients incl. player host and excl. headless clients
    []spawn {
    waitUntil {sleep 0.1; !isNull player};
    waitUntil{!isNil "pa_param_cscaching"};
        if (pa_param_cscaching == 1) then {
            handle_pacaching2 = [{[] call pa_fnc_CscGroupmanagement;}, 30] call CBA_fnc_addPerFrameHandler;
            waitUntil{!isNil "pa_AIGroups"};
            handle_pacaching1 = [{[] call pa_fnc_ClientsideCaching;}, 6] call CBA_fnc_addPerFrameHandler;
        };
    };
};

// Thermals
// Disable thermal sights for everything
//player addEventHandler ["WeaponAssembled",{(_this select 1) disableTIEquipment true}];
//[] execVM "pa\disableThermals.sqf";

// PabstMirror - Mission Intro
// Credits: PabstMirror
[] execVM "pa\PM_missionIntro.sqf";

// Force First Person
// Disable 3PV regardless of server settings
//[] execVM "pa\forceFirstPerson.sqf";

// WS - AI Flashlights
// Credits: Wolfenswan
// [] execVM "pa\forceFlashlightAI.sqf";

// vim: sts=-1 ts=4 et sw=4
