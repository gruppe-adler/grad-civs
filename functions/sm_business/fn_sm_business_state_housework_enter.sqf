private _house = _this getVariable ["grad_civs_home", objNull];
_this setVariable ["grad_civs_housework_time", random [5, 15, 120]];
_this call grad_civs_fnc_forceBusinessSpeed;

if (isNull _house) exitWith {};

if (random 4 > 1) then { // in 2 of 3 cases , do change position
    _this switchMove "";
    doStop _this;

    // add one random really close position to house positions
    private _currentPos = getPos _this;
    private _nearPos = [random 10, random 10, (_currentPos select 2)] vectorAdd _currentPos;
    private _positions = ([_house] call BIS_fnc_buildingPositions) + [_nearPos];
    private _pos = selectRandom _positions;

    _this moveTo _pos;
} else {
    _this switchMove selectRandom ["Acts_B_M05_briefing", "Acts_JetsOfficerSpilling", "acts_miller_knockout", "InBaseMoves_HandsBehindBack1"];
};
