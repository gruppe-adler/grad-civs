private _lifecycle = [{GRAD_CIVS_ONFOOTUNITS + GRAD_CIVS_INVEHICLESUNITS}, true] call CBA_statemachine_fnc_create;

private _activities = [] call grad_civs_fnc_sm_activities;
private _emotions = [] call grad_civs_fnc_sm_emotions;

private _lifecycle_spawn  = [
    _lifecycle,
    {},
    { _this call grad_civs_fnc_sm_lifecycle_state_spawn_enter },
    {},
    "spawn"
] call CBA_statemachine_fnc_addState;

private _lifecycle_life  = [
    _lifecycle,
    [_activities, _emotions],
    {},
    {},
    {},
    "life"
] call grad_civs_fnc_addCompoundState;

private _lifecycle_death  = [
    _lifecycle,
    {},
    { _this call grad_civs_fnc_sm_lifecycle_state_death_enter },
    {},
    "death"
] call CBA_statemachine_fnc_addState;

private _lifecycle_despawn  = [
    _lifecycle,
    {},
    { _this call grad_civs_fnc_sm_lifecycle_state_despawn_enter },
    {},
    "despawn"
] call CBA_statemachine_fnc_addState;

assert ([
    _lifecycle,
    _lifecycle_spawn, _lifecycle_life,
    { true },
    {},
    _lifecycle_spawn + _lifecycle_life
] call CBA_statemachine_fnc_addTransition);

assert ([
    _lifecycle,
    _lifecycle_life, _lifecycle_despawn,
    { _this call grad_civs_fnc_sm_lifecycle_trans_init_despawn_condition },
    {},
    _lifecycle_life + _lifecycle_despawn
] call CBA_statemachine_fnc_addTransition);

assert ([
    _lifecycle,
    _lifecycle_life, _lifecycle_death,
    ["killed"],
    { true },
    {},
    _lifecycle_life + _lifecycle_death
] call CBA_statemachine_fnc_addEventTransition);