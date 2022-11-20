////////////////////////////////////////////////////////////////////
//DeRap: config.bin
//Produced from mikero's Dos Tools Dll version 8.90
//https://mikero.bytex.digital/Downloads
//'now' is Mon Nov 21 00:25:34 2022 : 'file' last modified on Mon Nov 21 00:25:34 2022
////////////////////////////////////////////////////////////////////

#define _ARMA_

class CfgPatches
{
	class snad_injuries
	{
		name = "79AD - Injuries";
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.0;
		requiredAddons[] = {"CBA_main","ace_medical"};
		author = "$STR_snad_main_79AD";
		authors[] = {"[79AD] S. Spartan"};
		url = "$STR_snad_main_URL";
		version = 1.0;
		versionStr = "1.00";
		versionAr[] = {1,0,0,12};
	};
};
class Extended_PreInit_EventHandlers
{
	class snad_injuries
	{
		init = "call compileScript ['\z\snad\addons\injuries\XEH_preInit.sqf']";
	};
};
class Extended_PostInit_EventHandlers
{
	class snad_injuries
	{
		init = "call compileScript ['\z\snad\addons\injuries\XEH_postInit.sqf']";
	};
};
class CfgVehicles
{
	class Man;
	class CAManBase: Man
	{
		class ACE_Actions
		{
			class ACE_MainActions
			{
				class snad_injuries_drag
				{
					displayName = "$STR_snad_injuries_Drag";
					condition = "[_player, _target] call snad_injuries_fnc_canDrag]";
					statement = "[_player, _target] call ace_dragging_fnc_startDrag";
					showDisabled = 0;
					icon = "\z\ace\addons\dragging\UI\icons\person_drag.paa";
				};
				class snad_injuries_carry
				{
					displayName = "$STR_snad_injuries_Drag";
					condition = "[_player, _target] call snad_injuries_fnc_canDrag]";
					statement = "[_player, _target] call ace_dragging_fnc_startCarry";
					showDisabled = 0;
					icon = "\z\ace\addons\dragging\UI\icons\person_carry.paa";
				};
			};
		};
	};
};
