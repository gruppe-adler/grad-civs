#include "..\script_component.hpp"

params ["_groupOrUnit", "_vehicle"];

private _group = if (typeName _groupOrUnit == "OBJECT") then {group _groupOrUnit} else {_groupOrUnit};

_group setVariable ["grad_civs_ownedVehicle", _vehicle, true]; /* players need to check these for surrender behavior*/
_vehicle setVariable ["grad_civs_owner", _group, true];
