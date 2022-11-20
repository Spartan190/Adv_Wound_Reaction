#include "script_component.hpp"

["ace_medical_handleUnitVitals", {
	params ["_caller", "_target", "_selectionName", "_classname"];
	[ACE_player] spawn FUNC(checkPain);
}] call CBA_fnc_addEventHandler;