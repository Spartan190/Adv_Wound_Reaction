#include "script_component.hpp"


["CBA_settingsInitialized", {
	if (!hasInterface) exitWith {};
	["ace_medical_handleUnitVitals", {
		params ["_unit"];
		if(!EGVAR(player,isEnabled) || !EGVAR(ai,isEnabled)) exitWith {};
		
		_bodyAreasStates = [_unit,([EGVAR(ai,incapacitationType),EGVAR(player,incapacitationType)] select (isPlayer _unit))] call EFUNC(main,getAreaStates);
		private _oldBodyAreasStates = _unit getVariable [QGVAR(oldBodyAreasStates), [0,0,0]];
		_bodyAreasStates params ["_bodyState","_armsState","_legsState"];
		_oldBodyAreasStates params ["_oldBodyState","_oldArmsState","_oldLegsState"];

		_isIncapacitated = _bodyState == 2 || _armsState > 1 || _legsState > 0;
		_wasIncapacitated = _oldBodyState == 2 || _oldArmsState > 1 || _oldLegsState > 0;
		if (_isIncapacitated && !_wasIncapacitated) then {
			[_unit, false] call FUNC(setPlayerMeleeMode);
		} else {
			if(!_isIncapacitated && _wasIncapacitated) then {
				[_unit, true] call FUNC(setPlayerMeleeMode);
			}
		};
		_unit setVariable [QGVAR(oldBodyAreasStates), _bodyAreasStates, true];

	}] call CBA_fnc_addEventHandler;
}] call CBA_fnc_addEventHandler;