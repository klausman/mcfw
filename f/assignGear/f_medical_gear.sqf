// Add medical gear to assignGear-enabled units

private _typeofUnit = _this select 0;
private _unit = _this select 1;

{_unit removeItems _x} forEach ["FirstAidKit","Medikit","ACE_fieldDressing","ACE_packingBandage","ACE_elasticBandage","ACE_tourniquet","ACE_morphine","ACE_atropine","ACE_epinephrine","ACE_plasmaIV","ACE_plasmaIV_500","ACE_plasmaIV_250","ACE_bloodIV","ACE_bloodIV_500","ACE_bloodIV_250","ACE_salineIV","ACE_salineIV_500","ACE_salineIV_250","ACE_quikclot","ACE_personalAidKit","ACE_surgicalKit","ACE_bodyBag"];

// Standard for everyone: 8 bandages, 4 morphine, 5 tourniquets
{_unit addItem "ACE_fieldDressing"} forEach [1,2,3,4,5,6,7,8];
{_unit addItem "ACE_morphine"} forEach [1,2,3,4];
{_unit addItem "ACE_tourniquet"} forEach [1,2,3,4,5];

// Medics *additonally* get 25 bandages, 15 morphine, 15 epi, 8 500ml
// bloodbags and 10 tourniquets
if (_typeOfUnit == "m") then {
    (unitBackpack _unit) addItemCargoGlobal ["ACE_fieldDressing", 25];
    (unitBackpack _unit) addItemCargoGlobal ["ACE_morphine", 15];
    (unitBackpack _unit) addItemCargoGlobal ["ACE_epinephrine",   15];
    (unitBackpack _unit) addItemCargoGlobal ["ACE_bloodIV_500", 8];
    (unitBackpack _unit) addItemCargoGlobal ["ACE_tourniquet", 10];
};
// vim: sts=-1 ts=4 et sw=4
