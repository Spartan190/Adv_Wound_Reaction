#include "script_component.hpp"
/*
* Author: [79AD] S. Spartan
* Event Handler to check the current pain level of the unit.
* Sets the GVAR(draggableCarryable) to false if the system is not enabled or the pain is below the threshold.
* 
* Arguments:
* 0: unit to check (ACE_player)
*
* Return Value:
* nothing
*
* Example:
* [ACE_player] spawn awr_player_fnc_checkIncapacitaedEH;
*
* Public: No
*/
params ["_unit", "_painLevel", "_damageLevel"];
if (!alive _unit || !GVAR(isEnabled)) exitWith {};

private _incapacitatedTriggered = false;
// pain
if(GVAR(incapacitationType) in [0,2] && _painLevel >= GVAR(painThreshold)) then {
	_incapacitatedTriggered = true;
};

// damage
if(GVAR(incapacitationType) in [1,2] && _damageLevel >= GVAR(damageThreshold)) then {
	_incapacitatedTriggered = true;
};

if (_incapacitatedTriggered) then {
	_inDeepWater = _unit call EFUNC(main,inDeepWater);
	_unit setVariable [QEGVAR(main,isIncapacitated), true, true];
	_isCarryable = [_unit,_inDeepWater] call FUNC(checkGoProne);
	[_unit, _inDeepWater] call FUNC(checkHandleWeapon);
} else {
	_unit setVariable [QEGVAR(main,isIncapacitated), false, true];
};

_unit setVariable [QGVAR(wasIncapacitated), _unit getVariable QEGVAR(main,isIncapacitated), true];