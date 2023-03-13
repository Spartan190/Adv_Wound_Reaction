#include "script_component.hpp"
/*
* Author: [79AD] S. Spartan
* Gets the bandage time multiplying the ACE bandage time with a multiplier if needed
*
* Arguments:
* 0: Medic <OBJECT>
* 1: Patient <OBJECT>
* 2: Body Part <STRING>
* 3: Treatment <STRING>
*
* Return Value:
* Treatment Time <NUMBER>
*
* Example:
* [player, cursorTarget, "Head", "FieldDressing"] call awr_main_fnc_getBandageTime
*
* Public: No
*/
params ["_medic", "_patient", "_bodypart", "_bandage"];
_bandageTime = [_medic, _patient, _bodypart, _bandage] call ACEFUNC(medical_treatment,getBandageTime);
_medicBodyAreaStates = _medic getVariable [QGVAR(bodyAreaStates), [0,0,0]];
_medicBodyAreaStates params ["_bodyState","_armsState","_legsState"];
if(_bodyState > 0 || _armsState > 0 || _legsState > 0) exitWith {GVAR(bandagingMultiplier) * _bandageTime};
_bandageTime;