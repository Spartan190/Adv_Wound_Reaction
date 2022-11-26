#include "script_component.hpp"

if (!hasInterface) exitWith {};

["CBA_settingsInitialized", {
	["ace_medical_handleUnitVitals", {
		params ["_unit"];
		_painLevel = _unit call EFUNC(main,getPain);
		INFO_2("Vitals for unit %1 are %2",_unit, _painLevel);
		[_unit, _painLevel] spawn FUNC(checkIncapacitatedEH);
	}] call CBA_fnc_addEventHandler;
}] call CBA_fnc_addEventHandler;