#include "script_component.hpp"


["CBA_settingsInitialized", {
	if (!hasInterface) exitWith {};
	["awr_handleStaesUpdate", {
		params ["_unit","_oldBodyAreaStates","_bodyAreaStates"];
		_bodyAreaStates params ["_bodyState","_armsState","_legsState"];
		_oldBodyAreaStates params ["_oldBodyState","_oldArmsState","_oldLegsState"];

		_isIncapacitated = _bodyState == 2 || _armsState > 1 || _legsState > 0;
		_wasIncapacitated = _oldBodyState == 2 || _oldArmsState > 1 || _oldLegsState > 0;
		if (_isIncapacitated && !_wasIncapacitated) then {
			[_unit, false] call FUNC(setPlayerMeleeMode);
		} else {
			if(!_isIncapacitated && _wasIncapacitated) then {
				[_unit, true] call FUNC(setPlayerMeleeMode);
			}
		};

	}] call CBA_fnc_addEventHandler;
}] call CBA_fnc_addEventHandler;