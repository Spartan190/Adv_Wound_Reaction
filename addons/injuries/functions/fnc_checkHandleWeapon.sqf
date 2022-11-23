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
* [ACE_player] spawn snad_injuries_fnc_checkHandleWeaponEH
*
* Public: No
*/
params ["_unit","_painLevel"];
if (GVAR(isEnabled) && _painLevel >= GVAR(painThreshold)) then {
	_pWeapon = primaryWeapon _unit;
	//_sWeapon = secondaryWeapon _unit;
	_handgun = handgunWeapon _unit;
	_cWeapon = currentWeapon _unit;
	if(_pWeapon != "") then {
		switch (GVAR(weaponHandleMode)) do {
			case 1: {
				[_unit] call ACEFUNC(hitreactions,throwWeapon);
			};
			case 2: {
				// TODO: make a way to make the AI holster the weapon or not attack
				_unit action ["SwitchWeapon", _unit, _unit, -1];
			};
			default{};
		};
	};
}