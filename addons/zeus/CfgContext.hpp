class zen_context_menu_actions {
    class GRAD_Civs {
        displayName = "GRAD Civs";
        icon = PATHTOEF(main,ui\adlerkopp_white_64.paa);
        priority = 1;
        condition = QUOTE(_this call FUNC(context_condition_gradCivs));

        class Stop {
            displayName = "Stop";
            statement = QUOTE(_this call FUNC(context_statement_doStop));
            condition = QUOTE(_this call FUNC(context_condition_doStop));
            icon = QPATHTOF(ui\icon_zen_context_doStop.paa);
        };
        class CarryOn {
            displayName = "Continue";
            statement = QUOTE(_this call FUNC(context_statement_doCarryOn));
            condition = QUOTE(_this call FUNC(context_condition_doCarryOn));
            icon = QPATHTOF(ui\icon_zen_context_doCarryOn.paa);
        };
        class DismissCiv {
            displayName = "Dismiss";
            statement = QUOTE(_this call FUNC(context_statement_dismissCiv));
            condition = QUOTE(_this call FUNC(context_condition_dismissCiv));
            icon = QPATHTOF(ui\icon_zen_context_dismissCiv.paa);
        };
        class AddUnit {
            displayName = "Add Unit";
            statement = QUOTE(_this call FUNC(context_statement_addUnit));
            condition = QUOTE(_this call FUNC(context_condition_addUnit));
            icon = QPATHTOF(ui\icon_zen_context_addUnit.paa);
        };
    };
};
