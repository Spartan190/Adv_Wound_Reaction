#include "script_component.hpp"
/*
* Author: [79AD] S. Spartan
* Makes the unit fall down
* 
* Arguments:
* 0: unit to force to fall down (ACE_player)
*
* Return Value:
* None
*
* Example:
* [ACE_player] call awr_main_fnc_fallDown
*
* Public: No
*/

params ["_unit"];
[_unit] spawn {
	params ["_unit"];
	[_unit, true] call ACEFUNC(medical_engine,setUnconsciousAnim);
	sleep 1;
	[_unit, false] call ACEFUNC(medical_engine,setUnconsciousAnim);
};