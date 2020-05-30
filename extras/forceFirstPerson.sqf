if (isServer) exitWith {};

[] spawn {
    while {true} do {
        waitUntil { ( cameraView == "External" ) };
        // if player isn't inside a vehicle
        if ( (vehicle player) == player ) then {
            player switchCamera "Internal";
            // keep message local to player
            systemChat "Third Person View is not allowed.";
        };
        uiSleep 0.5; // lag won't mess with the timing
    };
};

// vim: sts=-1 ts=4 et sw=4
