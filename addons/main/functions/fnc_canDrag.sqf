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

_canAceCarry = [_unit,_target] call ACEFUNC(dragging,canCarry);
_canAceDrag = [_unit,_target] call ACEFUNC(dragging,canDrag);

if(_canAceCarry || _canAceDrag) exitWith {false};

if !([_unit, _target, ["isNotSwimming"]] call ACEFUNC(common,canInteractWith)) exitWith {false};

_bodyAreasSates = _target getVariable [QGVAR(bodyAreasStates), [0,0,0]];
_bodyAreasSates params ["_bodyState","_armsSate","_legsState"];

alive _target && {vehicle _target isEqualto _target} && {_bodyState == 2 || _legsState == 2};
