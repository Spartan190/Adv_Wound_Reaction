#include "script_component.hpp"


["CBA_settingsInitialized", {
	if (!hasInterface) exitWith {};
	["ace_medical_handleUnitVitals", {
		params ["_unit"];
		if(!GVAR(isEnabled) || !isPlayer _unit) exitWith {};
		_bodyAreasStates = [_unit,GVAR(incapacitationType)] call EFUNC(main,getAreaStates);
		[_unit, _bodyAreasStates] spawn FUNC(checkIncapacitatedEH);
	}] call CBA_fnc_addEventHandler;

	[QACEVAR(medical,woundReceived), {
		params ["_unit", "_allDamages", "_shooter", "_damageType"];
		if(!isPlayer _unit || !GVAR(concussionEnabled)) exitWith {};
		{
			_x params ["_damage","_bodyPart"];
			if(_bodyPart == "Head") then {
				if(_damage >= ACEVAR(medical,const_penetrationThreshold)) exitWith {
					if(GVAR(playFallAnimation)) then {
						[_unit, 5] call EFUNC(main,fallDown);
					} else {
						_unit call EFUNC(main,goProne);
					};
					[_unit,5] call EFUNC(main,blurAndDeaf);
				};
			};
		} forEach _allDamages;

	}] call CBA_fnc_addEventHandler;
}] call CBA_fnc_addEventHandler;