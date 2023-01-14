#define DEBUG_MODE_FULL
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
params ["_unit","_oldBodyAreasStates","_newBodyAreasStates"];

if (GVAR(weaponHandleMode) == 0)  exitWith {};


_bodyAreasStates params ["_bodyState","_armsState","_legsState"];
_oldBodyAreasStates params ["_oldBodyState","_oldArmsState","_oldLegsState"];
_isIncapacitated = _bodyState == 2 || _armsState == 2;
_wasIncapacitated =_oldBodyState == 2 || _oldArmsState == 2;

_pWeapon = primaryWeapon _unit;
_handgun = handgunWeapon _unit;
_cWeapon = currentWeapon _unit;

if((_bodyState != _oldBodyState) || (_armsState != _oldArmsState)) then {
	_canUseHandgun = ((_armsState < 2 && _bodyState < 2) || (_bodyState == 2 && _armsState < 2 && (GVAR(handgunChance) > random 100)));
	_unit setVariable [QGVAR(canUseHandgun), _canUseHandgun ,true];
	/*if((_bodyState == 2 && !_canUseHandgun) || _armsState == 2) then {
		_unit disableAI "TARGET";
		_unit disableAI "AUTOTARGET";
	};*/
};

/*if(_bodyState < 2 && _armsState < 2) then {
	LOG_1("Enabling AI %1", _unit);
	_unit enableAI "TARGET";
	_unit enableAI "AUTOTARGET";
};*/

if(_bodyState < 2 && _armsState == 0) exitWith {};

if(_cWeapon == "") exitWith {};
if(_cWeapon == _pWeapon && (_isIncapacitated || _armsState == 1)) then {
	switch (GVAR(weaponHandleMode)) do {
		case 1: {
			_pHolder = [_unit] call ACEFUNC(hitreactions,throwWeapon);
			_unit setVariable [QGVAR(primaryWeaponHolder), [_pHolder,_pWeapon], true];
		};			
	};
} else {
	_ignoreIndex = EGVAR(main,ignoreChanceClasses) findIf {_handgun == _x || _handgun isKindOf _x};
	if(_cWeapon == _handgun && (_ignoreIndex != -1 || !(_unit getVariable [QGVAR(canUseHandgun), true]))) then {
		switch (GVAR(weaponHandleMode)) do {
			case 1: {
				_hHolder = [_unit] call ACEFUNC(hitreactions,throwWeapon);
				_unit setVariable [QGVAR(handgunWeaponHolder), [_hHolder,_handgun], true];
			};
		};
	};
};
