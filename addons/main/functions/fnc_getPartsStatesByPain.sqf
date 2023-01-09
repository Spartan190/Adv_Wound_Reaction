#include "script_component.hpp"
/*
* Author: [79AD] S. Spartan
* Gets the damage states for the areas of the unit
* 
* Arguments:
* 0: unit to check (ACE_player)
* 1: the type to handle the states:
*    - 0: Pain only
*    - 1: Damage only
*    - 2: Both
*
* Return Value:
* The states for the areas ([body,arms,legs])
* Each is 0-2:
* 0: Everything fine
* 1: It's Injured
* 2: Critical
*
* Example:
* _areaDamages = [ACE_player,2] call awr_main_fnc_getAreaDamages
* _areaDamages params ["_bodyState","_armsState","_legsState"];
*
* Public: No
*/
params ["_unit"];

private _bodyPartsDamages = [0,0,0];
_painLevel = _unit call FUNC(getPain);
_painThreshold = GET_PAIN_THRESHOLD(_unit);

if(_painLevel >= _painThreshold) then {
	_bodyPartsDamages = [2,2,2];
};

_bodyPartsDamages;