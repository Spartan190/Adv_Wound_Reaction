#include "script_component.hpp"


["CBA_settingsInitialized", {
	["ace_medical_handleUnitVitals", {
		params ["_unit"];
		if(!GVAR(isEnabled) || isPlayer _unit) exitWith {};
		_painLevel = _unit call EFUNC(main,getPain);
		[_unit, _painLevel] spawn FUNC(checkIncapacitatedEH);
	}] call CBA_fnc_addEventHandler;
}] call CBA_fnc_addEventHandler;