#include "script_component.hpp"
/*
* Author: [79AD] S. Spartan
* Event Handler to check if the given unit should drop the weapon because the conditions from the settings are met.
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
params ["_unit"];
_playerPain = [_unit] call SNAD_fnc_getPain;
if (SNAD_pain_Enabled && _playerPain >= SNAD_pain_PainThreshold) then {
	_pWeapon = currentWeapon _unit;
	if(_pWeapon != "") then {
		switch (SNAD_pain_DropWeapon) do {
			case 1: {
				[_unit] call ace_hitreactions_fnc_throwWeapon;
			};
			case 2: {
				hint "putting on back";
				_unit action ["SwitchWeapon", _unit, _unit, -1];
			};
			default{};
		};
	};
} else {
	_unit setVariable ["SNAD_draggableCarryable", false, true];
};