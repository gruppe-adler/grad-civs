#include "..\script_component.hpp"

private _house = _this getVariable ["grad_civs_home", objNull];
_this setVariable ["grad_civs_housework_time", random [5, 15, 20]];
_this call EFUNC(activities,forceEmotionSpeed);

if (isNull _house) exitWith {};

if (random 4 > 1) then { // in 2 of 3 cases , do change position
    [QEGVAR(common,switchMove), [_this, ""]] call CBA_fnc_globalEvent;
    doStop _this;

    // add one random really close position to house positions
    private _currentPos = getPos _this;
    private _nearPos = [random 10, random 10, (_currentPos select 2)] vectorAdd _currentPos;
    private _positions = ([_house] call BIS_fnc_buildingPositions) + [_nearPos];
    private _pos = selectRandom _positions;

    _this moveTo _pos;
} else {
    [_this, selectRandom GVAR(houseworkAnimationSets), "NONE", objNull, true] call BIS_fnc_ambientAnim;
};

/*
Acts_B_M05_briefing > 27s
Acts_JetsOfficerSpilling = 11s , braucht eigentlich Anschluanim
acts_miller_knockout = 5.5s
InBaseMoves_HandsBehindBack1 = 3.5
*/
