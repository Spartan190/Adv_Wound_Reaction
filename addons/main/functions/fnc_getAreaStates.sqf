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
params ["_unit","_incapacitationType"];
private _areaDamages = [0,0,0]; // body/head, arms, legs

// pain
if(_incapacitationType in [0,2]) then {
    _painStates = [_unit] call FUNC(getPartsStatesByPain);
    _areaDamages set [0, (_areaDamages select 0) max (_painStates select 0)];
    _areaDamages set [1, (_areaDamages select 1) max (_painStates select 1)];
    _areaDamages set [2, (_areaDamages select 2) max (_painStates select 2)];
};

// damage
if(_incapacitationType in [1,2]) then {
    _damageStates = [_unit] call FUNC(getPartsStatesByDamage);
    _areaDamages set [0, (_areaDamages select 0) max (_damageStates select 0)];
    _areaDamages set [1, (_areaDamages select 1) max (_damageStates select 1)];
    _areaDamages set [2, (_areaDamages select 2) max (_damageStates select 2)];
};

_areaDamages; // return the areaDamages

/*
* throw event for body parts if above/below a threshold
* body part index, damage value, state (true/false)
*/


/* // ACE
params ["_unit"];

private _painLevel = GET_PAIN_PERCEIVED(_unit);
private _bodyPartDamage = _unit getVariable [QEGVAR(medical,bodyPartDamage), [0,0,0,0,0,0]];

_bodyPartDamage params ["_headDamage", "_bodyDamage", "_leftArmDamage", "_rightArmDamage", "_leftLegDamage", "_rightLegDamage"];

// Exclude non penetrating body damage
{
    _x params ["", "_bodyPartN", "_amountOf", "", "_damage"];
    if (_bodyPartN == 1 && {_damage < PENETRATION_THRESHOLD}) then {
        _bodyDamage = _bodyDamage - (_amountOf * _damage);
    };
} forEach GET_OPEN_WOUNDS(_unit);

private _damageThreshold = GET_DAMAGE_THRESHOLD(_unit); // #define GET_DAMAGE_THRESHOLD(unit)  (unit getVariable [QEGVAR(medical,damageThreshold), [EGVAR(medical,AIDamageThreshold),EGVAR(medical,playerDamageThreshold)] select (isPlayer unit)])

if ((_headDamage > _damageThreshold / 2) || {_bodyDamage > _damageThreshold} || {(_painLevel >= PAIN_UNCONSCIOUS) && {random 1 < EGVAR(medical,painUnconsciousChance)}}) then {
    [QEGVAR(medical,CriticalInjury), _unit] call CBA_fnc_localEvent;
};
*/