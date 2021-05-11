#include "..\script_component.hpp"

params [
    ["_pos", [0, 0, 0], [[]]],
    ["_groupSize", 1, [0]],
    ["_house", objNull, [objNull]],
    ["_primaryTask", "", [""]]
];

if (_pos isEqualTo [0, 0, 0]) exitWith {
    ERROR_1("tried to spawn civs at %1", _pos);
    grpNull
};

private _group = createGroup [civilian, true];
_group setCombatMode "GREEN";
_group setVariable ["grad_civs_primaryTask", _primaryTask, true];

for "_i" from 1 to _groupSize do {
    private _civ = [_pos, _group, _primaryTask] call FUNC(spawnCivilian);
};

if (!(isNull _house)) then {
    _group setVariable ["grad_civs_home", _house, true];
    _house setVariable ["grad_civs_residents", units _group, true];
    {
        _x setVariable ["grad_civs_home", _house, true];
    } forEach units _group;
};

_group
