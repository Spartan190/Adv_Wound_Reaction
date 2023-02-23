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
params ["_unit", "_bodyAreasStates"];
if (!alive _unit || !GVAR(isEnabled)) exitWith {};
private _inDeepWater = _unit call EFUNC(main,inDeepWater);
private _oldBodyAreasStates = _unit getVariable [QEGVAR(main,oldBodyAreasStates), [0,0,0]];

_unit setVariable [QEGVAR(main,bodyAreasStates), _bodyAreasStates, true];

_bodyAreasStates params ["_bodyState","_armsState","_legsState"];
_oldBodyAreasStates params ["_oldBodyState","_oldArmsState","_oldLegsState"];

[_unit,_oldBodyAreasStates,_bodyAreasStates] call FUNC(handleSurrendering);

[_unit,_oldBodyAreasStates,_bodyAreasStates] call FUNC(handleWeaponUsage);

_isCarryable = [_unit,_oldBodyAreasStates,_bodyAreasStates,_inDeepWater] call FUNC(handleLegsDamage);

_unit setVariable [QEGVAR(main,oldBodyAreasStates), _bodyAreasStates, true];