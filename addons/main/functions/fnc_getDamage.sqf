#include "script_component.hpp"
/*
* Author: [79AD] S. Spartan
* Gets the damgage level for the given unit
* 
* Arguments:
* 0: unit to check (ACE_player)
*
* Return Value:
* The damage level of the unit
*
* Example:
* [ACE_player] call awr_main_fnc_getDamage
*
* Public: No
*/
params ["_unit"];
private _bodyPartDamage = _unit getVariable [QACEVAR(medical,bodyPartDamage), [0,0,0,0,0,0]];
private _damageSum = 0.0;
{ _damageSum = _damageSum + _x} forEach _bodyPartDamage;
_damageSum;