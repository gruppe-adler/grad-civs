#include "..\script_component.hpp"

/**
 * they're coming to get me!
 *
 * flight behavior - fleeing, hiding, staying hidden
 */

private _panic = [[], true, "panic"] call EFUNC(cba_statemachine,create);

private _pan_flight = [
    _panic,
    { _this call FUNC(sm_panic_state_flight_loop) },
    { _this call FUNC(sm_panic_state_flight_enter) },
    { _this call FUNC(sm_panic_state_flight_exit) },
    "pan_flight"
] call EFUNC(cba_statemachine,addState);

private _pan_hide = [
    _panic,
    {},
    { _this call FUNC(sm_panic_state_hide_enter) },
    {},
    "pan_hide"
] call EFUNC(cba_statemachine,addState);


// NOTE concerning act_hidden and act_surrendered
// both states need the unit to be stopped, and to *not* move during the transition between both of them
// hence, I put the `_this stop <boolean>` into the *transitions* into and from the hidden/surrender node cluster
private _pan_hidden = [
    _panic,
    {},
    { _this call FUNC(sm_panic_state_hidden_enter) },
    {},
    "pan_hidden"
] call EFUNC(cba_statemachine,addState);


    // TRANSITIONS

assert ([
    _panic,
    _pan_flight, _pan_hide,
    {
        (CBA_missionTime - (_this getVariable ["grad_civ_hidetime", 0])) > 0
    },
    {},
    _pan_flight + _pan_hide
] call EFUNC(cba_statemachine,addTransition));


assert ([
    _panic,
    _pan_hide, _pan_hidden,
    { _this call FUNC(sm_panic_trans_hide_hidden_condition) },
    { _this call FUNC(sm_panic_trans_hide_hidden_handler) },
    _pan_hide + _pan_hidden
] call EFUNC(cba_statemachine,addTransition));

EGVAR(common,stateMachines) setVariable ["panic", _panic];



_panic
