#include "script_component.hpp"


["CBA_settingsInitialized", {
	if (!hasInterface) exitWith {};
	TRACE_1("Adding Player EH","");
	["ace_medical_handleUnitVitals", {
		params ["_unit"];
		if(!GVAR(isEnabled) || !isPlayer _unit || !local _unit) exitWith {};
		TRACE_2("Updating Player",player,_unit);
		_bodyAreasStates = [_unit,GVAR(incapacitationType)] call EFUNC(main,getAreaStates);
		[_unit, _bodyAreasStates] spawn FUNC(checkIncapacitatedEH);
	}] call CBA_fnc_addEventHandler;

	[QACEVAR(medical,woundReceived), {
		params ["_unit", "_allDamages", "_shooter", "_damageType"];
		if(!isPlayer _unit || !local _unit || !GVAR(concussionEnabled)) exitWith {};
		TRACE_2("Wound Received Player",player,_unit);
		_bodyAreasStates = [_unit,GVAR(incapacitationType)] call EFUNC(main,getAreaStates);
		_bodyAreaStates params ["_bodyState","_armsState","_legsState"];
		if(_bodyState == 2 || _legsState == 2) exitWith {};
		{
			_x params ["_damage","_bodyPart"];
			if(_bodyPart == "Head") then {
				if(_damage >= ACEVAR(medical,const_penetrationThreshold)) exitWith {
					if(GVAR(playFallAnimation)) then {
						[_unit, GVAR(concussionTime)] call EFUNC(main,fallDown);
					} else {
						_unit call EFUNC(main,goProne);
					};
					[_unit,GVAR(concussionTime)*2.0] call EFUNC(main,blurAndDeaf);
				};
			};
		} forEach _allDamages;

	}] call CBA_fnc_addEventHandler;
}] call CBA_fnc_addEventHandler;