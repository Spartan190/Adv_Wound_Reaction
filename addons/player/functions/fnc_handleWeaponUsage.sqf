#include "script_component.hpp"
/*
* Author: [79AD] S. Spartan
* Check if the given unit should drop the weapon because the conditions from the settings are met.
* 
* Arguments:
* 0: unit to check (ACE_player)
*
* Return Value:
* nothing
*
* Example:
* [ACE_player] spawn awr_player_fnc_checkHandleWeaponEH
*
* Public: No
*/
params ["_unit","_oldbodyAreaStates","_bodyAreaStates","_inDeepWater"];

if (GVAR(weaponHandleMode) == 0)  exitWith {};


_bodyAreaStates params ["_bodyState","_armsState","_legsState"];
_oldbodyAreaStates params ["_oldBodyState","_oldArmsState","_oldLegsState"];
_isIncapacitated = _bodyState == 2 || _armsState == 2;
_wasIncapacitated =_oldBodyState == 2 || _oldArmsState == 2;

_statesChanged = (_bodyState != _oldBodyState) || (_armsState != _oldArmsState);
TRACE_1("Checking if update of handgun is needed",_statesChanged);
if(_statesChanged) then {
	_canUseHandgun = (_armsState < 2 && _bodyState < 2) || (_bodyState == 2 && _armsState < 2 && (GVAR(handgunChance) > random 100));
	_unit setVariable [QGVAR(canUseHandgun), _canUseHandgun ,true];
	TRACE_1("Updating "+QGVAR(canUseHandgun),_canUseHandgun);
};

if(_bodyState < 2 && _armsState == 0) exitWith {};

_pWeapon = primaryWeapon _unit;
_launcher = secondaryWeapon _unit;
_handgun = handgunWeapon _unit;
_cWeapon = currentWeapon _unit;

_isInVehicle = !(isNull objectParent _unit);

if(_cWeapon == "") exitWith {};

if(_cWeapon == _launcher && (_isIncapacitated || _armsState == 1)) then {
	SHOW_HINT(localize LSTRING(UNABLE_TO_USE_WEAPON));
	_unit action ["SwitchWeapon", _unit, _unit, -1];
} else {
	if(_cWeapon == _pWeapon && (_isIncapacitated || _armsState == 1)) then {
		switch (GVAR(weaponHandleMode)) do {
			case 1: {
				if(_inDeepWater || _isInVehicle) then {
					_unit action ["SwitchWeapon", _unit, _unit, -1];
				} else {
					[_unit] call ACEFUNC(hitreactions,throwWeapon);
				};
				SHOW_HINT(localize LSTRING(UNABLE_TO_USE_WEAPON));
			};
			case 2: {
				_unit action ["SwitchWeapon", _unit, _unit, -1];
				SHOW_HINT(localize LSTRING(UNABLE_TO_USE_WEAPON));
			};			
		};
	} else {
		_ignoreIndex = EGVAR(main,ignoreChanceClasses) findIf {_handgun == _x || _handgun isKindOf _x};
		TRACE_1("Checking "+QGVAR(canUseHandgun),_unit getVariable [QGVAR(canUseHandgun),false]);
		if(_cWeapon == _handgun && (_ignoreIndex != -1 || !(_unit getVariable [QGVAR(canUseHandgun),false]))) then {
			switch (GVAR(weaponHandleMode)) do {
				case 1: {
					if(_inDeepWater || _isInVehicle) then {
						_unit action ["SwitchWeapon", _unit, _unit, -1];
					} else {
						[_unit] call ACEFUNC(hitreactions,throwWeapon);
					};
					SHOW_HINT(localize LSTRING(UNABLE_TO_USE_WEAPON));
				};
				case 2: {
					_unit action ["SwitchWeapon", _unit, _unit, -1];
					SHOW_HINT(localize LSTRING(UNABLE_TO_USE_WEAPON));
				};
			};
		};
	};
};