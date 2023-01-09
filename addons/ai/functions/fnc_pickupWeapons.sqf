#define DEBUG_MODE_FULL
#include "script_component.hpp"
/*
* Author: [79AD] S. Spartan
* Makes the AI pickup his weapons if they were dropped.
* 
* Arguments:
* 0: unit to check (AI unit)
*
* Return Value:
* nothing
*
* Example:
* [ACE_player] call awr_ai_fnc_pickupWeapons
*
* Public: No
*/

params["_unit","_secondaryOnly"];
if(GVAR(weaponHandleMode) != 1) exitWith {};

[_unit] spawn {
	params["_unit"];
	_pickUpPrim = _unit getVariable [QGVAR(primaryWeaponHolder),[]];
	if((count _pickUpPrim) > 0) then {
		_unit action ["TakeWeapon", _pickUpPrim select 0, _pickUpPrim select 1];
	};
	
	sleep 3;
	if(!(_unit getVariable QGVAR(canUseHandgun))) then {
		_pickUpHandgun = _unit getVariable [QGVAR(handgunWeaponHolder),[]];
		if((count _pickUpHandgun) > 0) then {
			_unit action ["TakeWeapon", _pickUpHandgun select 0, _pickUpHandgun select 1];
		};
	};
};