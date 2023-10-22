[
    QGVAR(ignoreIMSWeapons),//"awr_player_GoProne", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    [LSTRING(IgnoreIMSWeapons_DisplayName),LSTRING(IgnoreIMSWeapons_Description)], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [LSTRING(Category), LSTRING(Subcategory)], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // defaultvalue
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		if(GVAR(ignoreIMSWeapons)) then {
			EGVAR(main,ignoreChanceClasses) = EGVAR(main,ignoreChanceClasses) + IMS_Melee_Weapons;
		} else {
			EGVAR(main,ignoreChanceClasses) = EGVAR(main,ignoreChanceClasses) - IMS_Melee_Weapons;
		};
	}
] call CBA_fnc_addSetting;