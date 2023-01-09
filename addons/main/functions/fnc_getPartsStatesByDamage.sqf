#include "script_component.hpp"
/*
* Author: [79AD] S. Spartan
* Gets the damage states for the areas of the unit
* 
* Arguments:
* 0: unit to check (ACE_player)
* 1: the type to handle the states:
*    - 0: Pain only
*    - 1: Damage only
*    - 2: Both
*
* Return Value:
* The states for the areas ([body,arms,legs])
* Each is 0-2:
* 0: Everything fine
* 1: It's Injured
* 2: Critical
*
* Example:
* _areaDamages = [ACE_player,2] call awr_main_fnc_getAreaDamages
* _areaDamages params ["_bodyState","_armsState","_legsState"];
*
* Public: No
*/
params ["_unit"];

private _bodyPartDamage = [0,0,0,0,0,0];
_areaDamages = [0,0,0];
_openWounds = _unit getVariable [QACEVAR(medical,openWounds), []];
// Exclude non penetrating body damage
{
    _x params ["", "_bodyPartN", "_amountOf", "", "_damage"];
    if (_damage >= ACEVAR(medical,const_penetrationThreshold)) then {
        _bodyPartDamage set [_bodyPartN, (_bodyPartDamage select _bodyPartN) + (_amountOf * _damage)];
    };
} forEach _openWounds;

if(GVAR(damageIgnoreLevel) > 0) then {
    _bandagedWounds = _unit getVariable [QACEVAR(medical,bandagedWounds), []];
    // Exclude non penetrating body damage
    {
        _x params ["", "_bodyPartN", "_amountOf", "", "_damage"];
        if (_damage >= ACEVAR(medical,const_penetrationThreshold)) then {
            _bodyPartDamage set [_bodyPartN, (_bodyPartDamage select _bodyPartN) + (_amountOf * _damage)];
        };
    } forEach _bandagedWounds;
};

_bodyPartDamage params ["_headDamage", "_bodyDamage", "_leftArmDamage", "_rightArmDamage", "_leftLegDamage", "_rightLegDamage"];
_bodyDamageThreshold = GET_BODY_DAMAGE_THRESHOLD(_unit);
if((_headDamage >= _bodyDamageThreshold / 2) || {_bodyDamage >= _bodyDamageThreshold}) then {
    _areaDamages set [0, 2]; // body damage is always critical
} else {
    _areaDamages set [0, 0];
};

_armsDamageThreshold = GET_ARMS_DAMAGE_THRESHOLD(_unit);
if(((_leftArmDamage >= _armsDamageThreshold) && (_rightArmDamage >= _armsDamageThreshold))) then {
    _areaDamages set [1, 2]; // both arms injured so it's critical
} else {
    if((_leftArmDamage >= _armsDamageThreshold) || (_rightArmDamage >= _armsDamageThreshold)) then {
        _areaDamages set [1, 1]; // only left arm is injured so we keep the pistol but not the primary weapon
    } else {
        _areaDamages set [1, 0]; // both legs are fine
    }
};

_legsDamageThreshold = GET_LEGS_DAMAGE_THRESHOLD(_unit);
if((_leftLegDamage >= _legsDamageThreshold) && (_rightLegDamage >= _legsDamageThreshold)) then {
    _areaDamages set [2, 2]; // both legs injured so it's critical
} else {
    if((_leftLegDamage >= _legsDamageThreshold) || (_rightLegDamage >= _legsDamageThreshold)) then {
        _areaDamages set [2, 1]; // only one leg is injured so we start limping
    } else {
        _areaDamages set [2, 0]; // both legs are fine
    }
};

_areaDamages;