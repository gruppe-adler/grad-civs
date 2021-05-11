#include "..\script_component.hpp"

{    
	private _primaryTask = _x getVariable ["grad_civs_primaryTask", ""];
	private _civ = [[0, 0, 0], _x, _primaryTask] call EFUNC(lifecycle,spawnCivilian);	

    private _house = _group getVariable ["grad_civs_home", objNull];
    if (!(isNull _house)) then {
        private _residents = _house getVariable ["grad_civs_residents", []];
        _residents pushBackUnique _civ;
        _house setVariable ["grad_civs_residents", _residents, true];

        _civ setVariable ["grad_civs_home", _house, true];
    };
    private _vehicle = vehicle leader _x;
    if (_vehicle isNotEqualTo (leader _x)) then {
        _civ moveInAny _vehicle;
    } else {
        _civ setPos [_position#0, _position#1, 0];
    };

    INFO_2("%1 was added to group %2", _civ, _x);
} forEach (_groups select {(_x getVariable ["grad_civs_primaryTask", ""]) isNotEqualTo ""});
