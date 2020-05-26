//  Convert teamcolors to markercolor.
//  Description: Converts group team colors to Marker colors
//  Parameters
//      0: String (MAIN,RED,GREEN,BLUE,YELLOW)
//  Returns:
//      0: String (ColorWhite,ColorRed,ColorGreen,ColorBlue,ColorYellow)
//  Example:
//      ["MAIN"] call f_fnc_GetMarkerColor;
//
// ==========================================================================
private _color = "ColorWhite";
switch ((_this select 0)) do {
  case "MAIN": {_color = "ColorWhite"};
  case "RED": {_color = "ColorRed"};
  case "GREEN": {_color = "ColorGreen"};
  case "BLUE": {_color = "ColorBlue"};
  case "YELLOW": {_color = "ColorYellow"};
};
_color

// vim: sts=-1 ts=4 et sw=4
