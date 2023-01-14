#include "script_component.hpp"


["CBA_settingsInitialized", {
	if (!isServer && {hasInterface}) exitWith {}; // 1: Don't Run on non-hc Clients
	["ace_medical_handleUnitVitals", {
		params ["_unit"];
		if(!GVAR(isEnabled) || isPlayer _unit) exitWith {};
		_painLevel = _unit call EFUNC(main,getPain);
		_bodyAreasStates = [_unit,GVAR(incapacitationType)] call EFUNC(main,getAreaStates);
		[_unit, _bodyAreasStates] spawn FUNC(checkIncapacitatedEH);
	}] call CBA_fnc_addEventHandler;

}] call CBA_fnc_addEventHandler;