// Briefing
scriptName "f_briefing_admin.sqf";

private ["_title", "_ending", "_endings", "_customText", "_briefing", "_i"];

// Mission maker notes sections
// All text added below will only be visible to the current admin
_customText = "";

// Admin Briefing
// This is a generic section displayed only to the admin
_briefing ="
<br/>
<font size='18'>ADMIN SECTION</font><br/>
This briefing section can only be seen by the current admin.
<br/><br/>
";

// Mission maker notes
// This section displays notes made by the mission-maker for the ADMIN
if (_customText != "") then {
    _briefing ="
    <br/>
    <font size='18'>MISSION-MAKER NOTES</font><br/>
    Notes and messages from the mission-maker:<br/>
    ";
    _briefing = _briefing + _customText + "<br/><br/>";
};

// Endings
// This block of code collects all valid endings and formats them properly
_title = [];
_ending = [];
_endings = [];

_i = 1;
while {true} do {
    _title = getText (missionconfigfile >> "CfgDebriefing" >> format ["end%1",_i] >> "title");
    private _description = getText (missionconfigfile >> "CfgDebriefing" >> format ["end%1",_i] >> "description");
    if (_title == "") exitWith {};
    _ending = [_i,_title,_description];
    _endings append ([_ending]);
    _i = _i + 1;
};

// Create the briefing section to display the endings
_briefing = _briefing + "
<font size='18'>ENDINGS</font><br/>
These endings are available. To trigger an ending click on its link.<br/><br/>
";

{
    _briefing = _briefing + format [
    "<execute expression=""['end%1', true, true, false] remoteExecCall ['BIS_fnc_endMission', 0];"">'end%1'</execute> - %2:<br/>
    %3<br/><br/>"
    ,_x select 0,_x select 1,_x select 2];
} forEach _endings;

// Safe start section
_briefing = _briefing + "
<font size='18'>SAFE START CONTROL</font><br/>
|- <execute expression=""f_var_mission_timer = f_var_mission_timer + 1; publicVariable 'f_var_mission_timer'; hintsilent format ['Mission Timer: %1',f_var_mission_timer];"">
Increase Safe Start timer by 1 minute</execute><br/>

|- <execute expression=""f_var_mission_timer = f_var_mission_timer - 1; publicVariable 'f_var_mission_timer'; hintsilent format ['Mission Timer: %1',f_var_mission_timer];"">
Decrease Safe Start timer by 1 minute</execute><br/>

|- <execute expression=""[[[],'f\safeStart\f_safeStart.sqf'],'BIS_fnc_execVM',true]  call BIS_fnc_MP;
hintsilent 'Safe Start started!';"">
Begin Safe Start timer</execute><br/>

|- <execute expression=""f_var_mission_timer = -1; publicVariable 'f_var_mission_timer';
[['SafeStartMissionStarting',['Mission starting now!']],'bis_fnc_showNotification',true] call BIS_fnc_MP;
[[false],'f_fnc_safety',playableUnits + switchableUnits] call BIS_fnc_MP;
hintsilent 'Safe Start ended!';"">
End Safe Start timer</execute><br/>

|- <execute expression=""[[true],'f_fnc_safety',playableUnits + switchableUnits] call BIS_fnc_MP;
hintsilent 'Safety on!' "">
Force safety on for all players</execute><br/>

|- <execute expression=""[[false],'f_fnc_safety',playableUnits + switchableUnits] call BIS_fnc_MP;
hintsilent 'Safety off!' "">
Force safety off for all players</execute><br/><br/>
";


// Add Zeus support section
_briefing = _briefing + "
<font size='18'>ZEUS SUPPORT</font><br/>
<execute expression=""
if !(isNull (getAssignedCuratorLogic player)) then {hintsilent 'ZEUS already assigned!'} else {
    [[player,true],'f_fnc_zeusInit',false] spawn BIS_fnc_MP; hintsilent 'Curator assigned.';
};"">Assign ZEUS to host</execute>.<br/>

|- <execute expression=""
if (isNull (getAssignedCuratorLogic player)) then {hintsilent 'Assign ZEUS first!'} else {[[player,playableUnits],'f_fnc_zeusAddObjects',false] spawn BIS_fnc_MP; hintsilent 'Added playable units.'};"">Add players and playable units to ZEUS object list</execute>.<br/>

|- <execute expression=""
if (isNull (getAssignedCuratorLogic player)) then {hintsilent 'Assign ZEUS first!'} else {
    [[player,true,true],'f_fnc_zeusAddObjects',false] spawn BIS_fnc_MP; hintsilent 'Assigned control over all group leaders and empty vehicles.'};"">
Add all group leaders and empty vehicles</execute>.<br/>

|- <execute expression=""
if (isNull (getAssignedCuratorLogic player)) then {hintsilent 'Assign ZEUS first!'} else {[[player,true],'f_fnc_zeusAddObjects',false] spawn BIS_fnc_MP; hintsilent 'Add all units.'};"">Add all mission objects</execute> <font color='#FF0000'>(POSSIBLE DESYNC)</font>.<br/>

|- <execute expression=""
if (isNull (getAssignedCuratorLogic player)) then {hintsilent 'Assign ZEUS first!'} else {(getAssignedCuratorLogic player) removeCuratorEditableObjects [allDead,true]; hintsilent 'Removed dead units.'};"">Remove all dead units from ZEUS</execute>.<br/>

|- <execute expression=""
if (isNull (getAssignedCuratorLogic player)) then {hintsilent 'Assign ZEUS first!'} else {[[player,false],'f_fnc_zeusAddObjects',false] spawn BIS_fnc_MP; [[player,false],'f_fnc_zeusAddAddons',false] spawn BIS_fnc_MP; hintsilent 'Removed powers and units.'};"">Remove all powers and objects from ZEUS</execute>.<br/>
<br/>
";

// Add respawn ticket actions if ticket system is enabled
if (missionNamespace getVariable ["mc_respawnTickets", -1] >= 0) then {
    _briefing = _briefing + "
<font size='18'>RESPAWN TICKET SYSTEM</font><br/>
|- <execute expression=""[] remoteExecCall ['mc_fnc_broadcastTicketCount', 2];"">Broadcast current count</execute>.<br/>
|- <execute expression=""[1] remoteExecCall ['mc_fnc_editTicketCount', 2];"">Increase by 1</execute>.<br/>
|- <execute expression=""[5] remoteExecCall ['mc_fnc_editTicketCount', 2];"">Increase by 5</execute>.<br/>
|- <execute expression=""[-1] remoteExecCall ['mc_fnc_editTicketCount', 2];"">Decrease by 1</execute>.<br/>
|- <execute expression=""[-5] remoteExecCall ['mc_fnc_editTicketCount', 2];"">Decrease by 5</execute>.<br/>
<br/>
";
};

// CREATE DIARY ENTRY
private _clb = [_briefing, ["&"], "&amp;"] call mc_fnc_stringReplace;
player createDiaryRecord ["diary", ["Admin",_clb]];

// vim: sts=-1 ts=4 et sw=4
