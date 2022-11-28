#include "script_component.hpp"
/*
* Author: [79AD] S. Spartan
* Check if the given unit should drop the weapon because the conditions from the settings are met.
* 
* Arguments:
* 0: unit to check (ACE_player)
*
* Return Value:
* nothing
*
* Example:
* [ACE_player] spawn awr_ai_fnc_checkHandleWeaponEH
*
* Public: No
*/
params ["_unit","_painLevel"];
_isIncapacitated = _unit getVariable [QEGVAR(main,isIncapacitated), false];
if (GVAR(weaponHandleMode) == 0)  exitWith {};



_wasIncapacitated = _unit getVariable [QGVAR(wasIncapacitated), false];

_pWeapon = primaryWeapon _unit;
_handgun = handgunWeapon _unit;
_cWeapon = currentWeapon _unit;

if(!_wasIncapacitated) then {
	_unit setVariable [QGVAR(canUseHandgun), GVAR(handgunChance) > random 100 ,true];
};

if(_cWeapon != "" && _cWeapon == _pWeapon) then {
	switch (GVAR(weaponHandleMode)) do {
		case 1: {
			_pHolder = [_unit] call ACEFUNC(hitreactions,throwWeapon);
			_unit setVariable [QGVAR(primaryWeaponHolder), [_pHolder,_pWeapon], true];
		};
		case 2: {
			_unit action ["SwitchWeapon", _unit, _unit, 299];
		};			
	};
} else {
	_ignoreIndex = EGVAR(main,ignoreChanceClasses) findIf {_handgun == _x || _handgun isKindOf _x};
	if(_cWeapon != "" && _cWeapon == _handgun && (_ignoreIndex != -1 || !(_unit getVariable QGVAR(canUseHandgun)))) then {
		switch (GVAR(weaponHandleMode)) do {
			case 1: {
				_hHolder = [_unit] call ACEFUNC(hitreactions,throwWeapon);
				_unit setVariable [QGVAR(handgunWeaponHolder), [_hHolder,_handgun], true];
			};
			case 2: {
				_unit action ["SwitchWeapon", _unit, _unit, 299];
			};
		};
	};
};
