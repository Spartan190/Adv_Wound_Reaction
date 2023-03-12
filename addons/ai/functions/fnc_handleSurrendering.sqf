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
if(!GVAR(enableSurrender)) exitWith {};

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
		while { _isIncapacitated } do {
			_enemyUnits = count (_unit call BIS_fnc_enemyTargets);
			_surrenderChance = 85 min (GVAR(surrenderChance) + (_enemyUnits * GVAR(surrenderChancePerEnemy)));
			_surrenderChance = GVAR(surrenderChance) max _surrenderChance;
			if(_enemyUnits > 0 && _surrenderChance > random 100) then {
				_isSurrendering = _unit getVariable [QACEVAR(captives,isSurrendering), false];
				if (!_isSurrendering) then {
					TRACE_1("Surrendering",_isSurrendering);
					//_unit setUnitPos "AUTO";
					//_unit enableai "PATH";
					//_unit setCombatMode "BLUE";
					_unit leaveVehicle vehicle _unit;
					doGetOut _unit;
					_speed = 1.5;
					//_unit setUnitPos "UP";
					//_unit setBehaviour "SAFE";
					//_unit setSpeedMode "Limited";
					["ACE_captives_setSurrendered", [_unit, true], _unit] call CBA_fnc_targetEvent;
					_noEnemyTimer = 0.0;
					waitUntil {
						if(!GVAR(enableSurrender)) exitWith {true};
						sleep 1;
#ifdef DEBUG_MODE_FULL
						["Starting Check..."] remoteExec ["hint"];
						sleep 1;
						[""] remoteExec ["hintSilent"];
						[format ["Surrendered %1",_unit getVariable [QGVAR(isSurrendered), false]]] remoteExec ["hint"];
						sleep 1;
						[""] remoteExec ["hintSilent"];
						if(!(_unit getVariable [QGVAR(isSurrendered), false])) exitWith {true};
						[format ["Handcuffed %1",_unit getVariable ["ace_captives_isHandcuffed", false]]] remoteExec ["hint"];
						sleep 1;
						[""] remoteExec ["hintSilent"];
#endif
						if(_unit getVariable ["ace_captives_isHandcuffed", false]) exitWith {false};
						_enemyClose = _unit distance (_unit findNearestEnemy _unit) < 50;
#ifdef DEBUG_MODE_FULL
						[format ["Enemey Close %1 %2",_enemyClose,_unit distance (_unit findNearestEnemy _unit)]] remoteExec ["hint"];
						sleep 1;
						[""] remoteExec ["hintSilent"];
#endif
						if(_enemyClose) then {
							_noEnemyTimer = 0.0;
						} else {
							_noEnemyTimer = _noEnemyTimer + 1.0;
#ifdef DEBUG_MODE_FULL							
							[format ["Timer %1 %2",_enemyClose,_noEnemyTimer]] remoteExec ["hint"];
							sleep 1;
							[""] remoteExec ["hintSilent"];
#endif
						};
						if(_enemyClose) exitWith {false};
						if(_noEnemyTimer >= 5.0) exitWith {true};
						false;
					};
#ifdef DEBUG_MODE_FULL
					[""] remoteExec ["hintSilent"];
#endif
					if((_unit getVariable [QGVAR(isSurrendered), false])) then {
						["ace_captives_setSurrendered",[_unit,false]] call CBA_fnc_globalEvent;
					};
					
					//_unit setUnitPos "AUTO";
					//_unit setBehaviour "AWARE";
					//_unit setSpeedMode "NORMAL";
				};
			};
			sleep 10;
			_bodyStates = _unit getVariable [QEGVAR(main,bodyAreasStates), [0,0,0]];
			_bodyStates params ["_bodyState","_armsState","_legsState"];
			_isIncapacitated = _bodyState == 2 || _armsState >= 1;
		};
	};
};