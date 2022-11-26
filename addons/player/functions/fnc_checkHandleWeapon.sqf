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
* [ACE_player] spawn awr_player_fnc_checkHandleWeaponEH
*
* Public: No
*/
params ["_unit","_painLevel"];
if (!hasInterface) exitWith {};
_isIncapacitated = _unit getVariable [QEGVAR(main,isIncapacitated), false];
if (GVAR(weaponHandleMode) == 0 || !_isIncapacitated)  exitWith {};


_wasIncapacitated = _unit getVariable [QEGVAR(main,wasIncapacitated), false];
_pWeapon = primaryWeapon _unit;
_handgun = handgunWeapon _unit;
_cWeapon = currentWeapon _unit;

if(!_wasIncapacitated) then {
	_unit setVariable [QGVAR(canUseHandgun), GVAR(handgunChance) > random 100 ,true];
};

if(_cWeapon == _pWeapon) then {
	switch (GVAR(weaponHandleMode)) do {
		case 1: {
			[_unit] call ACEFUNC(hitreactions,throwWeapon);
		};
		case 2: {
			_unit action ["SwitchWeapon", _unit, _unit, -1];
		};			
	};
} else {
	if(_cWeapon == _handgun && !(_unit getVariable QGVAR(canUseHandgun))) then {
		switch (GVAR(weaponHandleMode)) do {
			case 1: {
				[_unit] call ACEFUNC(hitreactions,throwWeapon);
			};
			case 2: {
				_unit action ["SwitchWeapon", _unit, _unit, -1];
			};
		};
	};
};
