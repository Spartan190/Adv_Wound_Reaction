#include "script_component.hpp"
/*
* Author: [79AD] S. Spartan
* Check if the given unit should drop the weapon because the conditions from the settings are met.
* 
* Arguments:
* 0: unit to check (ACE_player)
* 1: old body states array
* 2: new body states array
*
* Return Value:
* nothing
*
* Example:
* [ACE_player, [0,0,0], [2,2,2]] spawn awr_ai_fnc_handleWeaponUsage
*
* Public: No
*/
params ["_unit","_oldBodyAreaStates","_bodyAreaStates"];

if (GVAR(weaponHandleMode) == 0)  exitWith {};


_bodyAreaStates params ["_bodyState","_armsState","_legsState"];
_oldBodyAreaStates params ["_oldBodyState","_oldArmsState","_oldLegsState"];
_isIncapacitated = _bodyState == 2 || _armsState == 2;
_wasIncapacitated =_oldBodyState == 2 || _oldArmsState == 2;

_pWeapon = primaryWeapon _unit;
_handgun = handgunWeapon _unit;
_cWeapon = currentWeapon _unit;

if((_bodyState != _oldBodyState) || (_armsState != _oldArmsState)) then {
	_canUseHandgun = ((_armsState < 2 && _bodyState < 2) || (_bodyState == 2 && _armsState < 2 && (GVAR(handgunChance) > random 100)));
	_unit setVariable [QGVAR(canUseHandgun), _canUseHandgun ,true];
	
	if((_oldBodyState > _bodyState) || (_oldArmsState > _armsState)) then {
		[_unit] spawn {
			params["_unit"];
			waitUntil {!(_unit getVariable [QGVAR(isSurrendered),false] && !(_unit getVariable [QGVAR(isHandcuffed),false]))};
			_areaStates = _unit getVariable [QEGVAR(main,bodyAreaStates), [0,0,0]];
			_areaStates params ["_bodyState","_armsState","_legsState"];
			if(_bodyState == 0 && _armsState == 1) then {
				[_unit,true] call FUNC(pickupWeapons);
			} else {
				if(_bodyState == 0 && _armsState == 0) then {
					[_unit,false] call FUNC(pickupWeapons);
				};
			};
		};
	};
};

if(_bodyState < 2 && _armsState == 0) exitWith {};

if(_cWeapon == "") exitWith {};
if(_cWeapon == _pWeapon && (_isIncapacitated || _armsState == 1)) then {
	switch (GVAR(weaponHandleMode)) do {
		case 1: {
			_pHolder = [_unit] call ACEFUNC(common,throwweapon);
			_unit setVariable [QGVAR(primaryWeaponHolder), [_pHolder,_pWeapon], true];
		};			
	};
} else {
	_ignoreIndex = EGVAR(main,ignoreChanceClasses) findIf {_handgun == _x || _handgun isKindOf _x};
	if(_cWeapon == _handgun && (_ignoreIndex != -1 || !(_unit getVariable [QGVAR(canUseHandgun), false]))) then {
		switch (GVAR(weaponHandleMode)) do {
			case 1: {
				_hHolder = [_unit] call ACEFUNC(common,throwweapon);
				_unit setVariable [QGVAR(handgunWeaponHolder), [_hHolder,_handgun], true];
			};
		};
	};
};
