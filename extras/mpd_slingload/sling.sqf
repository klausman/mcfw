 [10, [_this select 0], {
    private ["_cargo","_nObject","_pilot","_Rope1","_Rope2","_Rope3","_Rope4","_widthFactor","_lengthFactor","_centerOfMass","_bbr","_p1","_p2","_maxWidth","_widthOffset","_maxLength","_lengthOffset","_maxHeight","_heightOffset","_rearCorner","_rearCorner2","_frontCorner","_frontCorner2"];
        _cargo = _args select 0;
        _nObject = nearestObject [_cargo, "Helicopter"];
        _pilot = currentPilot _nObject;
        _cargo attachTo [_nObject, [0, 1.1, -7]];
	
        /* 
                                                    Credits for finding corners go to sethduda from Advanced Sling Loading
                                                                        https://github.com/sethduda/
                                                            https://github.com/sethduda/AdvancedSlingLoading
        */
        _widthFactor = 0.5;
	    _lengthFactor = 0.5;
	    if(_cargo isKindOf "Air") then {
		    _widthFactor = 0.3;
	    };
	    if(_cargo isKindOf "Helicopter") then {
		    _widthFactor = 0.2;
		    _lengthFactor = 0.45;
	    };
	
        _centerOfMass = getCenterOfMass _cargo;
	    _bbr = boundingBoxReal _cargo;
	    _p1 = _bbr select 0;
	    _p2 = _bbr select 1;
	    _maxWidth = abs ((_p2 select 0) - (_p1 select 0));
	    _widthOffset = ((_maxWidth / 2) - abs ( _centerOfMass select 0 )) * _widthFactor;
	    _maxLength = abs ((_p2 select 1) - (_p1 select 1));
	    _lengthOffset = ((_maxLength / 2) - abs (_centerOfMass select 1 )) * _lengthFactor;
	    _maxHeight = abs ((_p2 select 2) - (_p1 select 2));
	    _heightOffset = _maxHeight/6;
	
	    _rearCorner = [(_centerOfMass select 0) + _widthOffset, (_centerOfMass select 1) - _lengthOffset, (_centerOfMass select 2)+_heightOffset];
	    _rearCorner2 = [(_centerOfMass select 0) - _widthOffset, (_centerOfMass select 1) - _lengthOffset, (_centerOfMass select 2)+_heightOffset];
	    _frontCorner = [(_centerOfMass select 0) + _widthOffset, (_centerOfMass select 1) + _lengthOffset, (_centerOfMass select 2)+_heightOffset];
	    _frontCorner2 = [(_centerOfMass select 0) - _widthOffset, (_centerOfMass select 1) + _lengthOffset, (_centerOfMass select 2)+_heightOffset];
        
        _cargodistance = _nObject distance _cargo;
        _Rope1length = _lengthOffset + 4.8;
        _Rope2length = _lengthOffset + 4.8;
        _Rope3length = _lengthOffset + 4.8;
        _Rope4length = _lengthOffset + 4.8;
        
        _Rope1 = ropeCreate [_nObject, [0,1.1,-2], _Rope1length];
        _Rope2 = ropeCreate [_nObject, [0,1.1,-2], _Rope2length];
        _Rope3 = ropeCreate [_nObject, [0,1.1,-2], _Rope3length];
        _Rope4 = ropeCreate [_nObject, [0,1.1,-2], _Rope4length];
    
        [_cargo , _rearCorner, [0,0,-1]] ropeAttachTo (_Rope1);
	    [_cargo , _rearCorner2, [0,0,-1]] ropeAttachTo (_Rope2);
	    [_cargo , _frontCorner, [0,0,-1]] ropeAttachTo (_Rope3);
	    [_cargo , _frontCorner2, [0,0,-1]] ropeAttachTo (_Rope4);

	[_nObject, ["Release Cargo", {  private ["_heli","_cargoRopes"];     
                _heli = _this select 0;
                _cargoRopes = ropes _heli;
            {
                ropeDestroy _x;
            } forEach _cargoRopes;
            {
                detach _x;
                _pos = [_heli, 5, 10, 0, 0, 20, 0] call BIS_fnc_findSafePos;
                _x setPos _pos;
            } forEach attachedObjects _heli;
        [_heli] remoteExec ["removeallactions"];
    },nil,1.5,true,true,"","true",8,false,"",""]] remoteExec ["addAction"];
}, {}, "Sling Loading..."] call ace_common_fnc_progressBar; //I was lazy...