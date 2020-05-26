// Multiplayer Ending Controller

// SERVER CHECK
// Make sure that the script is only run on the server
if (!isServer) exitWith {};

// SET ENDING & BROADCAST
// The desired ending # is taken from the arguments passed to this script.
// Using BIS_fnc_MP the function mpEndReceiver is being spawned on all clients
// (and server), with the passed ending # as parameter
[_this,"f_fnc_mpEndReceiver",true] spawn BIS_fnc_MP;

// vim: sts=-1 ts=4 et sw=4
