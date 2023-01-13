#include "script_component.hpp"

/*
* Author: [79AD] S. Spartan
* Blurs the vision and deafens the unit for a given amount of time.
* Only works for a local player unit
* 
* Arguments:
* 0: unit
* 1: time
*
* Return Value:
* None
*
* Example:
* [ACE_player, 5] call awr_main_fnc_blurAndDeaf
*
* Public: No
*/

params ["_unit", "_time"];

if(!(local _unit) || !(isPlayer _unit)) exitWith {};
[_unit,_time] spawn {
	params ["_unit","_time"];
	
	["awr_headshot", VOL_UNCONSCIOUS, true] call ACEFUNC(common,setHearingCapability);
	[0, true] call ACEFUNC(common,blurScreen);

	sleep _time;
	
	["awr_headshot", 1.0, false] call ACEFUNC(common,setHearingCapability);
	[0, false] call ACEFUNC(common,blurScreen);
};