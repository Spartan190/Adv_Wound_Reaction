#include "script_component.hpp"

/*["ace_medical_handleUnitVitals", {
	params ["_unit"];
	_painLevel = [_unit] call EFUNC(main,getPain);
	[_unit, _painLevel] spawn FUNC(checkIncapacitatedEH);
}] call CBA_fnc_addEventHandler;*/