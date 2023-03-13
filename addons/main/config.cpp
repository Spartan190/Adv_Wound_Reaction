#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"CBA_main", "ace_medical"};
        author = ECSTRING(main,79AD);
        authors[] = {"[79AD] S. Spartan"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

class ACEVAR(medical_treatment,actions)
{
	class BasicBandage
	{
		treatmentTime = QFUNC(getBandageTime);
	};
};

#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"