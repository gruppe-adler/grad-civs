#include "script_component.hpp"

if (!(EGVAR(main,enabled))) exitWith {};

ISNILS(GVAR(EXITON), {false});

if (isServer || CBA_isHeadlessClient) then {
    [] call FUNC(initHCs);
};

[
    QGVAR(do_dismiss_civ),
    {
        params [
            ["_object", objNull, [objNull, grpNull]]
        ];
        if (!((leader _object) in GVAR(localCivs))) exitWith {
            INFO_2("not dismissing %1 (%2) as it is not local civ led", _object, typeName _object);
        };

        if (_object isEqualType grpNull) then {
            [_object] call FUNC(dismissGroup);
        } else {
            [_object] call FUNC(dismissCiv);
        };
    }
] call CBA_fnc_addEventHandler;