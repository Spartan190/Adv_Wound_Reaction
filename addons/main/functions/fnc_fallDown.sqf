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
* [ACE_player, 1, true] call awr_main_fnc_fallDown
*
* Public: No
*/

params ["_unit", ["_wakeUpTime", 1, [1]]];
TRACE_2("Called fallDown", _unit, _wakeUpTime);
_isFallingDown = _unit getVariable [QGVAR(fallingDown), false];
TRACE_2("IsFallingDown", _unit,_isFallingDown);
if(_isFallingDown) exitWith {};
_isAlive = alive _unit;
_lifeState = lifeState _unit;
TRACE_3("Unit State",_unit,_isAlive,_lifeState);
if(!_isAlive || {_lifeState == "INCAPACITATED"}) exitWith {};
TRACE_2("Allowed to play fallDown", _unit, _wakeUpTime);
[_unit, _wakeUpTime] spawn {
	params ["_unit", "_wakeUpTime"];
	_unit setVariable [QGVAR(fallingDown), true, true];
	[_unit, true] call ACEFUNC(medical_engine,setUnconsciousAnim);
	sleep _wakeUpTime;
	_isAlive = alive _unit;
	TRACE_3("Time is up",_unit,_wakeUpTime,_isAlive);
	if((alive _unit)) then {
		TRACE_2("Waking up",_unit,_wakeUpTime);
		[_unit, false] call ACEFUNC(medical_engine,setUnconsciousAnim);
	};
	_unit setVariable [QGVAR(fallingDown), false, true];
};