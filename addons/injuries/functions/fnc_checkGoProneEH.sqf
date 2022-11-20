#include "script_component.hpp"
/*
* Author: [79AD] S. Spartan
* Event Handler to check if the given unit should go prone because the conditions from the settings are met.
* 
* Arguments:
* 0: unit to check (ACE_player)
*
* Return Value:
* nothing
*
* Example:
* [ACE_player] spawn snad_injuries_fnc_checkGoProneEH
*
* Public: No
*/
params ["_unit"];
_playerPain = [_unit] call SNAD_fnc_getPain;
if (SNAD_pain_Enabled && _playerPain >= SNAD_pain_PainThreshold) then {
	
	if(SNAD_pain_GoProne) then {
		if(stance _unit != "PRONE") then {
			_unit switchMove "AmovPpneMstpSrasWrflDnon"; // player goes prone
		} else {
			_unit setVariable ["SNAD_draggableCarryable", true, true];
		};
	} else {
		_unit setVariable ["SNAD_draggableCarryable", false, true];
	};
} else {
	_unit setVariable ["SNAD_draggableCarryable", false, true];
};