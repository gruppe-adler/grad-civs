#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = QUOTE(COMPONENT);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "grad_civs_common"
            ,"grad_civs_activities"
            ,"grad_civs_voyage"
#ifdef HARD_DEPENDENCIES 
            ,"zen_context_menu"
            ,"zen_custom_modules"
#endif
        };
        author = "AUTHOR";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgContext.hpp"
