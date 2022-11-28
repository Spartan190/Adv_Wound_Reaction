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
params ["_unit", "_painLevel"];
if (!(_unit getVariable [QEGVAR(main,isIncapacitated), false])) exitWith {false};

_isProne = false;
if(GVAR(goProne)) then {
	if(stance _unit != "PRONE" && stance _unit != "UNDEFINED") then {
		_pWeapon = primaryWeapon _unit;
		_launcher = secondaryWeapon _unit;
		_handgun = handgunWeapon _unit;
		_animation = "amovppnemstpsnonwnondnon";
		switch(currentWeapon _unit) do {
			case _pWeapon: {
				_animation = "amovppnemstpsraswrfldnon";
			};
			case _launcher: {
				_animation = "amovppnemstpsraswlnrdnon";
			};
			case _handgun: {
				_animation = "amovppnemstpsraswpstdnon";
			};
		};
		if (_animation != animationState _unit) then {
			[
				_unit,
				_animation
			] call ACEFUNC(common,doAnimation);
		};
	} else {
		_isProne = true;
	};
} else {
	_isProne = false;
};

_isProne;