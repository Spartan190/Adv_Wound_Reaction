#include "script_component.hpp"


["CBA_settingsInitialized", {
	if (!hasInterface) exitWith {};
	["ace_medical_handleUnitVitals", {
		params ["_unit"];
		if(!GVAR(isEnabled) || !isPlayer _unit) exitWith {};
		_painLevel = _unit call EFUNC(main,getPain);
		_damageLevel = _unit call EFUNC(main,getDamage);
		[_unit, _painLevel,_damageLevel] spawn FUNC(checkIncapacitatedEH);
	}] call CBA_fnc_addEventHandler;
}] call CBA_fnc_addEventHandler;