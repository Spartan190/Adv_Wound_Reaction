#include "script_component.hpp"

["CBA_settingsInitialized", {
	["ace_medical_handleUnitVitals", {
		params ["_unit"];
		if(!EGVAR(player,isEnabled) && !EGVAR(ai,isEnabled) || !(local _unit)) exitWith {};
		_bodyAreaStates = [_unit,([EGVAR(ai,incapacitationType),EGVAR(player,incapacitationType)] select (isPlayer _unit))] call EFUNC(main,getAreaStates);
		_oldBodyAreaStates = _unit getVariable [QGVAR(oldbodyAreaStates),[0,0,0]];
		_unit setVariable [QGVAR(bodyAreaStates), _bodyAreaStates, true];
		["awr_handleStatesUpdate", [_unit,_oldBodyAreaStates,_bodyAreaStates]] call CBA_fnc_localEvent;
		_unit setVariable [QGVAR(oldbodyAreaStates), _bodyAreaStates, true];
	}] call CBA_fnc_addEventHandler;
}] call CBA_fnc_addEventHandler;