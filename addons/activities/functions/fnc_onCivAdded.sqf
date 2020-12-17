#include "..\script_component.hpp"

params [
	["_civ", objNull, [objNull]]
];
if (!local _civ) exitWith {};

private _panicCooldown = [GVAR(panicCooldown)] call EFUNC(common,parseCsv);
_civ setVariable[QGVAR(panicCooldown), random _panicCooldown, true];

_civ addEventHandler [
	"FiredNear",
    {
		params ["_unit"];
		if (!(alive _unit)) exitWith {};

		// throttle to once every 15s max - which is still a lot
		if ((_unit getVariable [QGVAR(lastFiredNear), 0]) > (CBA_missionTime - 15)) exitWith {};
		_unit setVariable [QGVAR(lastFiredNear), CBA_missionTime];

		LOG_2("gunfight close to %1 at %2", _unit, getPos _unit);
		[QGVAR(firedNear), [_unit], _unit] call CBA_fnc_targetEvent;
    }
];
