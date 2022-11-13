// ACRE integration for MCFW, by Bubbus
// Add an event handler to react to gear assignment - configure radios freshly given to a unit.

[
	"MCFW_AssignedGear_Local", 
	f_fnc_configureUnitAcreRadios

] call CBA_fnc_addEventHandler;


// Rest of file is for clients only.
if !(hasInterface) exitWith {};

// Wait until first time the player has had gear assigned, then force execution of local event.
// This is a workaround for the initial gearscripting at mission start:
// Gearscript does not necessarily wait for the player to become local, so we wait for that here - it's necessary for successful radio config.
[
	// Condition
	{
		(local player) &&
		{!isNil {player getVariable "f_var_assignGear"}} &&
		{player getVariable ["f_var_assignGear_done", false]}
	},

	// Script
	{
		private _role = player getVariable ["f_var_assignGear", ""];
		["MCFW_AssignedGear_Local", [_role, player, faction player]] call CBA_fnc_localEvent;
	},

	// Arguments
	[]

] call CBA_fnc_waitUntilAndExecute;