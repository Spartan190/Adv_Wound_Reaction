#include "script_component.hpp"
/*
* Author: [79AD] S. Spartan
* Checks if the given unit should go prone because the conditions from the settings are met.
* Returns if the unit is prone or not
* 
* Arguments:
* 0: unit to check (ACE_player)
*
* Return Value:
* If the unit is prone or not
*
* Example:
* [ACE_player] spawn awr_player_fnc_checkGoProneEH
*
* Public: No
*/
params ["_unit","_oldBodyAreasStates","_newBodyAreasStates","_inDeepWater"];
_oldBodyAreasStates params ["_oldBodyState","_oldArmsState","_oldLegsState"];
_newBodyAreasStates params ["_bodyState","_armsState","_legsState"];
_isIncapacitated = _bodyState == 2 || _legsState > 0;
_wasIncapacitated =_oldBodyState == 2 || _oldLegsState > 0;


if (!(_isIncapacitated) && !_wasIncapacitated) exitWith {false};
if !(isNull objectParent _unit) exitWith {false};
if (_inDeepWater) exitWith {false};
_isProne = false;

_isAceLimping = _unit getVariable [QACEVAR(medical,isLimping), false];
if(_legsState == 1) then {
	_unitHitDamage = _unit getHitPointDamage "HitLegs";
	if(!(_isAceLimping) && (_unitHitDamage < 0.5)) then {
		_unit setHitPointDamage ["HitLegs", 1];
	};
} else { 
	if((_legsState == 0) && (_oldLegsState > 0) && !(_isAceLimping)) then {
		_unit setHitPointDamage ["HitLegs", 0];
	};
};

if(GVAR(goProne) && (_legsState == 2 || _bodyState == 2)) then {
	if(_isIncapacitated && _oldLegsState != 2) then {
		_unit call EFUNC(main,fallDown);
	} else {
		if((lifeState _unit) != "INCAPACITATED" && stance _unit != "PRONE" && stance _unit != "UNDEFINED") then {
			SHOW_HINT(localize LSTRING(UNABLE_TO_STAND));
			_noWeaponAnim = "amovppnemstpsnonwnondnon";
			if("" == currentWeapon _unit) then {
				[
					_unit,
					_noWeaponAnim
				] call ACEFUNC(common,doAnimation);
			} else {
				[_unit] call ACEFUNC(common,setProne);
			};
		} else {
			_isProne = true;
		};
	};
} else {
	_isProne = false;
};

_isProne;