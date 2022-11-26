#include "script_component.hpp"
/*
* Author: [79AD] S. Spartan
* Checks if the given unit should go prone because the conditions from the settings are met.
* Returns if the unit is prone or not
* 
* Arguments:
* 0: unit to check (ACE_player)
*
* Return Value:
* If the unit is prone or not
*
* Example:
* [ACE_player] spawn awr_ai_fnc_checkGoProneEH
*
* Public: No
*/
params ["_unit", "_painLevel"];
_isProne = false;
if (EGVAR(main,isIncapacitated)) then {
	if(GVAR(goProne)) then {
		if(stance _unit != "PRONE") then {
			// Adjust animation based on the current weapon 
			private _wpn = ["non", "rfl", "lnr", "pst"] param [["", primaryWeapon _medic, secondaryWeapon _medic, handgunWeapon _medic] find currentWeapon _medic, "non"];
			_animation = ["AmovPpneMstpSrasW[wpn]Dnon", "[wpn]", _wpn] call CBA_fnc_replace;
			_unit playActionNow _animation; // player goes prone
		} else {
			_isProne = true;
		};
	} else {
		_isProne = false;
	};
};

_isProne;