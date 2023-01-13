
#include "script_component.hpp"
/*
* Author: [79AD] S. Spartan
* Set the unit prone
* 
* Arguments:
* 0: unit to got prone
*
* Return Value:
* None
*
* Example:
* [ACE_player] call awr_main_fnc_goProne
*
* Public: No
*/

params ["_unit"];
if((lifeState _unit) != "INCAPACITATED" && stance _unit != "PRONE" && stance _unit != "UNDEFINED") then {
	
	_noWeaponAnim = "amovppnemstpsnonwnondnon";
	if("" == currentWeapon _unit) then {
		[
			_unit,
			_noWeaponAnim
		] call ACEFUNC(common,doAnimation);
	} else {
		[_unit] call ACEFUNC(common,setProne);
	};
};