#include "script_component.hpp"
/*
* Author: [79AD] S. Spartan
* Checks if the unit should surrender
* 
* Arguments:
* 0: unit to check (ACE_player)
* 1: the old body states
* 2: the body states of the unit
*
* Return Value:
* Nothing
*
* Example:
* [unit] spawn awr_ai_fnc_handleSurrendering
*
* Public: No
*/
params ["_unit","_oldBodyStates","_bodyStates"];

_bodyAreasStates params ["_bodyState","_armsState","_legsState"];
_oldBodyAreasStates params ["_oldBodyState","_oldArmsState","_oldLegsState"];

_isIncapacitated = _bodyState == 2 || _armsState >= 1;
_wasIncapacitated =_oldBodyState == 2 || _oldArmsState >= 1;

if(_isIncapacitated && !_wasIncapacitated) then {
	[_unit] spawn {
		params["_unit"];
		_bodyStates = _unit getVariable [QEGVAR(main,bodyAreasStates), [0,0,0]];
		_bodyStates params ["_bodyState","_armsState","_legsState"];
		_isIncapacitated = _bodyState == 2 || _armsState >= 1;
		_enemyUnits = count (_unit call BIS_fnc_enemyTargets);
		while { _isIncapacitated && !(captive _unit) } do {
			_bodyStates = _unit getVariable [QEGVAR(main,bodyAreasStates), [0,0,0]];
			_bodyStates params ["_bodyState","_armsState","_legsState"];
			_isIncapacitated = _bodyState == 2 || _armsState >= 1;
			_enemyUnits = count (_unit call BIS_fnc_enemyTargets);
			if(_enemyUnits >= GVAR(minSurrenderEnemies) && (GVAR(surrenderChance) > random 100)) then {
				_isSurrendering = _unit getVariable [QACEVAR(captives,isSurrendering), false];
				if (!_isSurrendering) then {
					[_unit, true] call ACEFUNC(captives,setSurrendered);
					break;
				};
			};
			sleep 10;
		};
	};
};