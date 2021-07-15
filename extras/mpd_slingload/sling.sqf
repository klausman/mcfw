 [10, [_this select 0], {
        private _cargo = _this select 0;
        private _nObject = nearestObject [_cargo, "Helicopter"];

        _cargo attachTo [_nObject, [0, 1.1, -7]];

        /* 
            Credits for finding corners go to sethduda from Advanced Sling Loading.
            https://github.com/sethduda/
            https://github.com/sethduda/AdvancedSlingLoading
        */
        private _widthFactor = 0.5;
        private _lengthFactor = 0.5;
        if(_cargo isKindOf "Air") then {
             _widthFactor = 0.3;
        };
        if(_cargo isKindOf "Helicopter") then {
            _widthFactor = 0.2;
            _lengthFactor = 0.45;
        };

        private _centerOfMass = getCenterOfMass _cargo;
        private _bbr = boundingBoxReal _cargo;
        private _p1 = _bbr select 0;
        private _p2 = _bbr select 1;
        private _maxWidth = abs ((_p2 select 0) - (_p1 select 0));
        private _widthOffset = ((_maxWidth / 2) - abs ( _centerOfMass select 0 )) * _widthFactor;
        private _maxLength = abs ((_p2 select 1) - (_p1 select 1));
        private _lengthOffset = ((_maxLength / 2) - abs (_centerOfMass select 1 )) * _lengthFactor;
        private _maxHeight = abs ((_p2 select 2) - (_p1 select 2));
        private _heightOffset = _maxHeight/6;

        private _rearCorner1 = [(_centerOfMass select 0) + _widthOffset, (_centerOfMass select 1) - _lengthOffset, (_centerOfMass select 2)+_heightOffset];
        private _rearCorner2 = [(_centerOfMass select 0) - _widthOffset, (_centerOfMass select 1) - _lengthOffset, (_centerOfMass select 2)+_heightOffset];
        private _frontCorner1 = [(_centerOfMass select 0) + _widthOffset, (_centerOfMass select 1) + _lengthOffset, (_centerOfMass select 2)+_heightOffset];
        private _frontCorner2 = [(_centerOfMass select 0) - _widthOffset, (_centerOfMass select 1) + _lengthOffset, (_centerOfMass select 2)+_heightOffset];

        private _ropelength = _lengthOffset + 4.8;

        private _rope1 = ropeCreate [_nObject, [0,1.1,-2], _ropelength];
        private _rope2 = ropeCreate [_nObject, [0,1.1,-2], _ropelength];
        private _rope3 = ropeCreate [_nObject, [0,1.1,-2], _ropelength];
        private _rope4 = ropeCreate [_nObject, [0,1.1,-2], _ropelength];

        [_cargo , _rearCorner1, [0,0,-1]] ropeAttachTo (_rope1);
        [_cargo , _rearCorner2, [0,0,-1]] ropeAttachTo (_rope2);
        [_cargo , _frontCorner1, [0,0,-1]] ropeAttachTo (_rope3);
        [_cargo , _frontCorner2, [0,0,-1]] ropeAttachTo (_rope4);

        [_nObject, ["Release Cargo", {  
            private _heli = _this select 0;
            private _cargoRopes = ropes _heli;
            {
                ropeDestroy _x;
            } forEach _cargoRopes; 
            {
                detach _x;
                private _pos = [_heli, 5, 10, 0, 0, 20, 0] call BIS_fnc_findSafePos;
                _x setPos _pos;
            } forEach attachedObjects _heli;
        [_heli] remoteExec ["removeallactions"];
    },nil,1.5,true,true,"","true",8,false,"",""]] remoteExec ["addAction"];
}, {}, "Sling Loading..."] call ace_common_fnc_progressBar;
