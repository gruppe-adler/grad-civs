#include "..\script_component.hpp"

params [
    ["_civ", objNull],
    ["_reverseTargetPos", [0, 0, 0]]
];

if (!(local _civ)) exitWith {
    [
        QGVAR(doReverse),
        [_object, _reverseTargetPos],
        _object
    ] call CBA_fnc_targetEvent;
};

if (_civ == ACE_player) exitWith {};

[
    _civ,
    {
        params ["_civ", "_reverseTargetPos"];
        private _group = group driver vehicle _civ;
        INFO_1("civ %1 is being sent away with vehicle, remove pre-existing waypoints", _civ);

        [_group] call CBA_fnc_clearWaypoints;

        [
            vehicle _civ,
            _reverseTargetPos,
            60,
            {}
        ] call FUNC(reverse);

        INFO_2("vehicle %1 reversing to %2 and then waiting", _civ, _reverseTargetPos);
    },
    {
        params ["_civ", ""];
        [vehicle _civ] call FUNC(reverse_abort);
    },
    { // wait for players to go away
        params ["_civ"];
        [ALL_HUMAN_PLAYERS, getPos _civ, 200] call FUNC(isInDistanceFromOtherPlayers);
    },
    [_reverseTargetPos],
    "reversing",
    "sent away. reversing, then doing nothing until players have left"
] call FUNC(doCustomActivity);
