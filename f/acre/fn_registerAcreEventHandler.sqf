// ACRE integration for MCFW, by Bubbus
// Add an event handler to react to gear assignment - configure radios freshly given to a unit.

[
	"MCFW_AssignedGear_Local", 
	f_fnc_configureUnitAcreRadios

] call CBA_fnc_addEventHandler;