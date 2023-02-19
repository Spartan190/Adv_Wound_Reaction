#include "script_component.hpp"
/*
* Author: [79AD] S. Spartan
* Gets if the given unit is in deep water, so that proning is impossible
* 
* Arguments:
* 0: unit to check (ACE_player)
*
* Return Value:
* True if water level is too deep, false otherwise
*
* Example:
* [ACE_player] call awr_main_fnc_inDeepWater
*
* Public: No
*/

params ["_unit"];
_isSwimming = _unit call ACEFUNC(common,isSwimming);
if (_isSwimming) exitWith {true};
private _isInWater = surfaceIsWater position _unit;
private _waterDepth = 0.0;
if(_isInWater) then {
	_waterDepth = selectBestPlaces [getPosASL _unit, 1, "waterDepth", 1, 1] select 0 select 1;
};

if(isNil "_waterDepth") exitWith {false};

if (_waterDepth >= 0.5) exitWith {true};
false