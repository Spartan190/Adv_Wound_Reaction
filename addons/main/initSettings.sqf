[
    QGVAR(ignoreChanceClasses), //"awr_main_isEnabled", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "EDITBOX", // setting type
    [LSTRING(IgnoreChanceClasses_DisplayName), LSTRING(IgnoreChanceClasses_Description)],//"Enabled?", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [LSTRING(Category), LSTRING(SubCategory)],//"AWR Settings", "Common"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    "[]", // defaultvalue
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{
		GVAR(ignoreChanceClasses) = parseSimpleArray GVAR(ignoreChanceClasses);
	}
] call CBA_fnc_addSetting;