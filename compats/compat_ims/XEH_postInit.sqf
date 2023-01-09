#include "script_component.hpp"


["CBA_settingsInitialized", {
	if (!hasInterface) exitWith {};
	["ace_medical_handleUnitVitals", {
		// TODO: rework logic with new damage determination
		params ["_unit"];
		if(!EGVAR(player,isEnabled) || !EGVAR(ai,isEnabled)) exitWith {};
		_isIncapacitated = _unit getVariable [QEGVAR(main,isIncapacitated), false];
		_wasIncapacitated = _unit getVariable [QGVAR(wasIncapacitated), false];

		if (_isIncapacitated && !_wasIncapacitated) then {
			[_unit, false] call FUNC(setPlayerMeleeMode);
		} else {
			if(!_isIncapacitated && _wasIncapacitated) then {
				[_unit, true] call FUNC(setPlayerMeleeMode);
			}
		};
		_unit setVariable [QGVAR(wasIncapacitated), _isIncapacitated, true];

	}] call CBA_fnc_addEventHandler;
}] call CBA_fnc_addEventHandler;