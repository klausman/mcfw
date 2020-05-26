// Multiplayer Ending Controller

// DECLARE VARIABLES AND FUNCTIONS
private ["_ending","_state"];
_ending = _this select 0;
_state = if (count _this > 1) then {_this select 1} else {true};

// SERVER DELAY
// If this script is executing on the server a small delay is used.
if (isServer) then {
    sleep 3;
};

if (f_var_debugMode == 1) then {
    ["f\\mpEnd\\fn_mpEndReceiver.sqf", "_ending = %1, _state = %2"] call pa_fnc_bothlog;
};

// CLEAN-UP OBJECTIVES & TRIGGER CUT-SCENES ETC.
// This is an opportunity to set all objectives to pass/fail, trigger
// cut-scenes etc. depending on the ending that has been selected. Initially,
// we identify the desired ending using the parsed value. By default allowed
// values are: 1,2,3,4,5,6.
switch (_ending) do{
    case 1: {
    // BEGIN Ending 1 custom code

    // END Ending 1 custom code
    };
    case 2: {
    // BEGIN Ending 2 custom code

    // END Ending 2 custom code
    };
    case 3: {
    // BEGIN Ending 3 custom code

    // END Ending 3 custom code
    };
    case 4: {
    // BEGIN Ending 4 custom code

    // END Ending 4 custom code
    };
    case 5: {
    // BEGIN Ending 5 custom code

    // END Ending 5 custom code
    };
    case 6: {
    // BEGIN Ending 6 custom code

    // END Ending 6 custom code
    };

    default {

    };
};

// Using the integer we've got we use format to compile a string (e.g. "end1")
// and call the BIS function with it.
_ending = format ["end%1",_ending];
[_ending,_state] spawn BIS_fnc_endMission;

// EXIT THE SPECTATOR SCRIPT IF IS OPEN
// Clients just "hang" if the mission has ended but are still inside the
// spectator script.
if (dialog) then {
    closeDialog 0;
};

// vim: sts=-1 ts=4 et sw=4
