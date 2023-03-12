#include "script_component.hpp"
/*
* Author: [79AD] S. Spartan
* Event Handler to check the current pain level of the unit.
* Sets the GVAR(draggableCarryable) to false if the system is not enabled or the pain is below the threshold.
* 
* Arguments:
* 0: unit to check (ACE_player)
*
* Return Value:
* nothing
*
* Example:
* [ACE_player] spawn awr_player_fnc_checkIncapacitaedEH;
*
* Public: No
*/
params ["_unit","_oldBodyAreaStates","_bodyAreaStates"];
if (!alive _unit || !GVAR(isEnabled)) exitWith {};
private _inDeepWater = _unit call EFUNC(main,inDeepWater);

_bodyAreaStates params ["_bodyState","_armsState","_legsState"];
_oldBodyAreaStates params ["_oldBodyState","_oldArmsState","_oldLegsState"];

[_unit,_oldBodyAreaStates,_bodyAreaStates] call FUNC(handleSurrendering);

[_unit,_oldBodyAreaStates,_bodyAreaStates] call FUNC(handleWeaponUsage);

_isCarryable = [_unit,_oldBodyAreaStates,_bodyAreaStates,_inDeepWater] call FUNC(handleLegsDamage);

