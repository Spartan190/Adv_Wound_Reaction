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
* [ACE_player] spawn awr_player_fnc_checkGoProneEH
*
* Public: No
*/
params ["_unit","_inDeepWater"];
if (!(_unit getVariable [QEGVAR(main,isIncapacitated), false])) exitWith {false};
if !(isNull objectParent _unit) exitWith {false};
if (_inDeepWater) exitWith {false};
_isProne = false;
if(GVAR(goProne)) then {
	if(stance _unit != "PRONE" && stance _unit != "UNDEFINED") then {
		_noWeaponAnim = "amovppnemstpsnonwnondnon";
		if("" == currentWeapon _unit) then {
			[
				_unit,
				_noWeaponAnim
			] call ACEFUNC(common,doAnimation);
		} else {
			[_unit] call ACEFUNC(common,setProne);
		};
	} else {
		_isProne = true;
	};
} else {
	_isProne = false;
};

_isProne;