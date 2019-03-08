
private _activities = [[], true] call CBA_statemachine_fnc_create;
private _business = [] call grad_civs_fnc_sm_business;
private _panic = [] call grad_civs_fnc_sm_panic;

// CBA EVENTS

_id1 = ["pointed_at_inc", {
    params ["_civ"];
    private _currentCount = _civ getVariable ["grad_civs_isPointedAtCount", 0];
    _civ setVariable ["grad_civs_isPointedAtCount", _currentCount + 1];
}] call CBA_fnc_addEventHandler;

_id2 = ["pointed_at_dec", {
    params ["_civ"];
    private _currentCount = _civ getVariable ["grad_civs_isPointedAtCount", 0];
    assert(_currentCount > 0);
    if (_currentCount < 1) then {_currentCount = 1;};
    _civ setVariable ["grad_civs_isPointedAtCount", _currentCount - 1];
}] call CBA_fnc_addEventHandler;

// STATES
assert(_activities isEqualType locationNull);
assert(_business isEqualType locationNull);
assert(_panic isEqualType locationNull);

private _act_business = [
    _activities,
    [_business],
    {},
    {},
    {},
    "act_business"
] call grad_civs_fnc_addCompoundState;
assert(_act_business != "");

private _act_asOrdered = [
    _activities,
    { _this call grad_civs_fnc_sm_activities_state_asOrdered_loop },
    { _this call grad_civs_fnc_sm_activities_state_asOrdered_enter },
    { _this call grad_civs_fnc_sm_activities_state_asOrdered_exit },
    "act_asOrdered"
] call CBA_statemachine_fnc_addState;
assert(_act_asOrdered != "");

private _act_surrendered = [
    _activities,
    {},
    { _this call grad_civs_fnc_sm_activities_state_surrendered_enter },
    { _this call grad_civs_fnc_sm_activities_state_surrendered_exit },
    "act_surrendered"
] call CBA_statemachine_fnc_addState;
assert(_act_surrendered != "");

private _act_panic = [
    _activities,
    [_panic],
    {  },
    { _this call grad_civs_fnc_sm_activities_state_panic_enter },
    { _this call grad_civs_fnc_sm_activities_state_panic_exit },
    "act_panic"
] call grad_civs_fnc_addCompoundState;
assert(_act_panic != "");

// TRANSITIONS

assert ([
    _activities,
    _act_business, _act_surrendered,
    { _this call grad_civs_fnc_sm_activities_trans_business_surrendered_condition },
    {},
    _act_business + _act_surrendered
] call CBA_statemachine_fnc_addTransition);

assert ([
    _activities,
    _act_business, _act_panic,
    { _this call grad_civs_fnc_sm_activities_trans_business_panic_condition },
    {},
    _act_business + _act_panic
] call CBA_statemachine_fnc_addTransition);

assert ([
    _activities,
    _act_surrendered, _act_business,
    { _this call grad_civs_fnc_sm_activities_trans_surrendered_business_condition },
    {},
    _act_surrendered + _act_business
] call CBA_statemachine_fnc_addTransition);

assert ([
    _activities,
    _act_surrendered, _act_panic,
    { _this call grad_civs_fnc_sm_activities_trans_surrendered_panic_condition },
    {},
    _act_surrendered + _act_panic
] call CBA_statemachine_fnc_addTransition);

assert ([
    _activities,
    _act_panic, _act_business,
    ["grad_civs_panicking_end"],
    {true},
    {_this switchmove ""},
    _act_panic + _act_business
] call CBA_statemachine_fnc_addEventTransition);

assert ([
    _activities,
    _act_business, _act_asOrdered,
    ["ace_interaction_getDown", "ace_interaction_sendAway"],
    {true},
    {},
    _act_business + _act_asOrdered
] call CBA_statemachine_fnc_addEventTransition);

assert ([
    _activities,
    _act_asOrdered, _act_business,
    { _this call grad_civs_fnc_sm_activities_trans_asOrdered_business_condition },
    {},
    _act_asOrdered + _act_business
] call CBA_statemachine_fnc_addTransition);

GRAD_CIVS_STATE_ACTIVITIES = _activities;
GRAD_CIVS_STATEMACHINES setVariable ["activities", _activities];

_activities
