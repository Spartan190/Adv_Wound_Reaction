#define DEBUG_MODE_FULL
#include "script_component.hpp"
/*
	* Author: [79AD] S. Spartan
	* Gets the damage states for the areas of the unit
	* 
	* Arguments:
	* 0: unit to check (ACE_player)
	* 1: the type to handle the states:
	*    - 0: Pain only
	*    - 1: damage only
	*    - 2: Both
	*
	* Return Value:
	* The states for the areas ([body, arms, legs])
	* Each is 0-2:
	* 0: Everything fine
	* 1: It's Injured
	* 2: Critical
	*
	* Example:
	* _areaDamages = [ACE_player, 2] call awr_main_fnc_getAreaDamages
	* _areaDamages params ["_bodyState", "_armsState", "_legsState"];
	*
	* Public: No
*/
params ["_unit"];

private _bodyPartDamage = [0, 0, 0, 0, 0, 0];
private _openWounds = _unit getVariable [QACEVAR(medical,openWounds), createHashMap];

// _openWounds = new HashMap<string, list<Wound>>
// Wound = new["_classID", "_amountOf", "_bleeding"];
// Exclude non penetrating body damage
{
	private _partIndex = ALL_BODY_PARTS find _x;
	{
		_x params ["_classID", "_amountOf", "_bleeding", "_damage"];
		if (_damage >= ACEVAR(medical,const_penetrationThreshold)) then {
			private _className = ACEVAR(medical_damage,woundClassNamesComplex) select _classID; // ThermalBurn
			if (!("ThermalBurn" in _className) || !GVAR(ignoreBurnDamage)) then {
				_bodyPartDamage set [_partIndex, (_bodyPartDamage select _partIndex) + (_amountOf * _damage)];
			};
		};
	} forEach _y;
} forEach _openWounds;

if (GVAR(damageIgnoreLevel) > 0) then {
	_bandagedWounds = _unit getVariable [QACEVAR(medical,bandagedWounds), []];
	    // Exclude non penetrating body damage
	{
		private _partIndex = ALL_BODY_PARTS find _x;
		{
			_x params ["_classID", "_amountOf", "_bleeding", "_damage"];
			if (_damage >= ACEVAR(medical,const_penetrationThreshold)) then {
				private _className = ACEVAR(medical_damage,woundClassNamesComplex) select _classID; // ThermalBurn
				if (!("ThermalBurn" in _className) || !GVAR(ignoreBurnDamage)) then {
					_bodyPartDamage set [_partIndex, (_bodyPartDamage select _partIndex) + (_amountOf * _damage)];
				};
			};
		} forEach _y;
	} forEach _bandagedWounds;
};

_bodyPartDamage params ["_headDamage", "_bodyDamage", "_leftArmDamage", "_rightArmDamage", "_leftLegDamage", "_rightLegDamage"];
_bodyDamageThreshold = GET_BODY_DAMAGE_THRESHOLD(_unit);
private _areaDamages = [0, 0, 0];
if((_headDamage >= _bodyDamageThreshold / 2) || {
	_bodyDamage >= _bodyDamageThreshold
}) then {
	_areaDamages set [0, 2]; // body damage is always critical
} else {
	_areaDamages set [0, 0];
};

_limbDamageMode = GET_LIMBS_DAMAGE_MODE(_unit);
if (_limbDamageMode == 0) exitWith {
	_areaDamages
};

_fractures = (_unit getVariable [QACEVAR(medical,fractures), [0, 0, 0, 0, 0, 0]]);
_fractures params ["_headHasFracture", "_bodyHasFracture", "_leftArmHasFracture", "_rightArmHasFracture", "_leftLegHasFracture", "_rightLegHasFracture"];

_armsDamageThreshold = GET_ARMS_DAMAGE_THRESHOLD(_unit);

_leftArmHurt = ((_limbDamageMode in [1, 3] && _leftArmDamage >= _armsDamageThreshold) || (_limbDamageMode in [2, 3] && _leftArmHasFracture == 1));
_rightArmHurt = ((_limbDamageMode in [1, 3] && _rightArmDamage >= _armsDamageThreshold) || (_limbDamageMode in [2, 3] && _rightArmHasFracture == 1));
if ((_leftArmHurt && _rightArmHurt)) then {
	_areaDamages set [1, 2]; // both arms injured so it's critical
} else {
	if ((_leftArmHurt) || (_rightArmHurt)) then {
		_areaDamages set [1, 1]; // only left arm is injured so we keep the pistol but not the primary weapon
	} else {
		_areaDamages set [1, 0]; // both legs are fine
	}
};

_legsDamageThreshold = GET_LEGS_DAMAGE_THRESHOLD(_unit);
_leftLegHurt = ((_limbDamageMode in [1, 3] && _leftLegDamage >= _legsDamageThreshold) || (_limbDamageMode in [2, 3] && _leftLegHasFracture == 1));
_rightLegHurt = ((_limbDamageMode in [1, 3] && _rightLegDamage >= _legsDamageThreshold) || (_limbDamageMode in [2, 3] && _rightLegHasFracture == 1));
if (_leftLegHurt && _rightLegHurt) then {
	_areaDamages set [2, 2]; // both legs injured so it's critical
} else {
	if (_leftLegHurt || _rightLegHurt) then {
		_areaDamages set [2, 1]; // only one leg is injured so we start limping
	} else {
		_areaDamages set [2, 0]; // both legs are fine
	}
};
TRACE_1("Area Damages",_areaDamages);
_areaDamages;