#define DEBUG_MODE_FULL
#include "script_component.hpp"
#include "\a3\ui_f\hpp\defineDIKCodes.inc"
/*
* Author: [79AD] S. Spartan
* Sets if the given player is allowed to do melee
* 
* Arguments:
* 0: unit to check (ACE_player)
* 1: enable or distable melee
*
* Return Value:
* nothing
*
* Example:
* [ACE_player,true] spawn awr_compat_ims_fnc_setPlayerMeleeMode
*
* Public: No
*/
params ["_unit","_enable"];

// actual non functional way
/*if (_enable) then {
	//Enable it back
	if (!(isNil {_unit getVariable QGVAR(WBKKeybind);})) then {
		_savedKeybind = _unit getVariable QGVAR(WBKKeybind);
		LOG_1("Setting keybind to: %1", _savedKeybind);
		hint format ["keybind loaded: %1", _savedKeybind];
		_savedKeybind call cba_fnc_addKeybind;
		_unit setVariable [QGVAR(WBK_Keybind), nil, true];
	};
} else {
	if (isNil {_unit getVariable QGVAR(WBKKeybind)}) then {
		_keybind = ["WebKnight's Melee", "WBK_FistFightmode"] call cba_fnc_getKeybind;
		hint format ["keybind saved: %1", _keybind];
		_unit setVariable [QGVAR(WBKKeybind),_keybind,true];
		LOG_1("Saving keybind: %1", toString _keybind);
	};
	_keybind = ["WebKnight's Melee", "WBK_FistFightmode"] call cba_fnc_getKeybind;
	LOG_1("Unsetting keybind: %1", _keybind);
	["WebKnight's Melee", "WBK_FistFightmode", _keybind select 2, {}, {}, [35, [false, true, false]]] call cba_fnc_addKeybind;
};*/

// hacky way
WBK_IMSIsFistsAllowed = _enable;