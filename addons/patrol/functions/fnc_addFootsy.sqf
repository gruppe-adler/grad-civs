#include "..\script_component.hpp"

params [
    ["_allPlayers", []]
];

private _footSpawnDistances = [GVAR(spawnDistancesOnFoot)] call EFUNC(common,parseCsv);
private _footSpawnDistanceMin = _footSpawnDistances#0;
private _footSpawnDistanceMax = _footSpawnDistances#1;

private _house = [
    _allPlayers,
    _footSpawnDistanceMin,
    _footSpawnDistanceMax,
    "house"
] call EFUNC(lifecycle,findSpawnPosition);

if (isNull _house) exitWith {
    LOG("could not find house for patrol");
};

private _maxInitialGroupSize = GVAR(initialGroupSize);
private _groupSize = (floor random _maxInitialGroupSize) + 1;

_group = [getPos _house, _groupSize, _house, "patrol"] call EFUNC(lifecycle,spawnCivilianGroup);
