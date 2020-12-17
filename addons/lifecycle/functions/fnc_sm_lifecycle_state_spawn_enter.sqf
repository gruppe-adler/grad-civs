#include "..\script_component.hpp"

private _unit = _this;

private _addBehaviour = {
	params ["_unit"];

	_unit setBehaviour "CARELESS";

	_unit disableAI "TARGET";
	_unit disableAI "AUTOTARGET";
	_unit disableAI "FSM";
	_unit disableAI "WEAPONAIM";
	_unit disableAI "AIMINGERROR";
	_unit disableAI "SUPPRESSION";
	_unit disableAI "CHECKVISIBLE";
	_unit disableAI "COVER";
	_unit disableAI "AUTOCOMBAT";
};

_unit setVariable ["BIS_noCoreConversations",true];

_unit addEventHandler [
	"Killed",
    {
		params ["_unit"];
		INFO_2("civ %1 was killed (index: %2), firing internal 'killed' event", _unit, GVAR(localCivs) find _unit);

		[QGVAR(killed), [_unit], [_unit]] call CBA_fnc_targetEvent;

		_unit removeEventHandler ["Killed", _thisEventHandler];
    }
];

private _addVars = {
	params [
		["_civ", objNull]
	];
	private _fastSpeed = _civ getSpeed "FAST";

	_civ setVariable["grad_civs_runspeed", random [_fastSpeed * 0.5, _fastSpeed, _fastSpeed * 1.3], true];
	_civ setVariable["grad_civs_recklessness", random [0, 5, 10], true];
};

_unit enableDynamicSimulation true;

_unit setVariable ["asr_ai_exclude", true, true];

[_unit] call _addBehaviour;
[_unit] call _addVars;
