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
* [ACE_player] spawn snad_injuries_fnc_checkGoProneEH
*
* Public: No
*/
params ["_unit", "_painLevel"];
//_playerPain = [_unit] call FUNC(getPain);
_isProne = false;
if (GVAR(isEnabled) && _painLevel >= GVAR(painThreshold)) then {
	if(GVAR(goProne)) then {
		if(stance _unit != "PRONE") then {
			_unit switchMove "AmovPpneMstpSrasWrflDnon"; // player goes prone
		} else {
			_isProne = true;
		};
	} else {
		_isProne = false;
	};
};

_isProne;