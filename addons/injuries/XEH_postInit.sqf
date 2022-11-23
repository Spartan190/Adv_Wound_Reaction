#include "script_component.hpp"

["ace_medical_handleUnitVitals", {
	params ["_unit"];
	_painLevel = [_unit] call FUNC(getPain);
	[_unit, _painLevel] spawn FUNC(checkPainEH);
}] call CBA_fnc_addEventHandler;