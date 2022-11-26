#include "script_component.hpp"

/*
* Author: [79AD] S. Spartan
* Returns if the target can be dragged or carried.
* 
* Arguments:
* 0: player (ACE_player)
* 1: target
*
* Return Value:
* If the target can be dragged or carried. <BOOL>
*
* Example:
* [ACE_player, _target] call awr_main_fnc_canDrag
*
* Public: No
*/

params ["_unit", "_target"];

if !([_unit, _target, ["isNotSwimming"]] call ACEFUNC(common,canInteractWith)) exitWith {false};
alive _target && {vehicle _target isEqualto _target} && {_target getVariable [QGVAR(isIncapacitated), false]}
