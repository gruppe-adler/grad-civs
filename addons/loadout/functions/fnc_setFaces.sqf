#include "..\script_component.hpp"

params [["_value",[]]];

[QGVAR(faces), str _value, 1, "mission"] call CBA_settings_fnc_set;
