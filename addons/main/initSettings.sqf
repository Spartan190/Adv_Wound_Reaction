[
    QGVAR(displayHints), //"awr_main_displayHints", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    [LSTRING(Hints_DisplayName), LSTRING(Hints_Description)],//"Enabled?", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [ELSTRING(main,Category), LSTRING(SubCategory)],//"79AD Settings", "Pain Handling"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // defaultvalue
    true // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;

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

[
    QGVAR(damageIgnoreLevel),//"awr_main_damageIgnoreLevel", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "LIST", // setting type
    [LSTRING(DamageIgnoreLevel_DisplayName), LSTRING(DamageIgnoreLevel_Description)],//"Weapon Handling", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [ELSTRING(main,Category), LSTRING(SubCategory)],//["79AD Settings", "Pain Handling"], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [[0, 1], [LSTRING(DamageIgnoreLevel_AfterBandage), LSTRING(DamageIgnoreLevel_AfterStitching)], 0], // defaultvalue
    true // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;


// AI
[
    QGVAR(ai_bodyDamageThreshold),//"awr_player_PainThreshold", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    [ELSTRING(ai,BodyDamageThreshold_DisplayName), ELSTRING(ai,BodyDamageThreshold_Description)], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [ELSTRING(main,Category), ELSTRING(ai,SubCategory)], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 100, 1, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;

[
    QGVAR(ai_armsDamageThreshold),//"awr_player_PainThreshold", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    [ELSTRING(ai,ArmsDamageThreshold_DisplayName), ELSTRING(ai,ArmsDamageThreshold_Description)], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [ELSTRING(main,Category), ELSTRING(ai,SubCategory)], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 100, 1, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;

[
    QGVAR(ai_legsDamageThreshold),//"awr_player_PainThreshold", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    [ELSTRING(ai,LegsDamageThreshold_DisplayName), ELSTRING(ai,LegsDamageThreshold_Description)], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [ELSTRING(main,Category), ELSTRING(ai,SubCategory)], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 100, 1, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;


// Player
[
    QGVAR(player_bodyDamageThreshold),//"awr_player_PainThreshold", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    [ELSTRING(player,BodyDamageThreshold_DisplayName), ELSTRING(player,BodyDamageThreshold_Description)], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [ELSTRING(main,Category), ELSTRING(player,SubCategory)], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 100, 1, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;

[
    QGVAR(player_armsDamageThreshold),//"awr_player_PainThreshold", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    [ELSTRING(player,ArmsDamageThreshold_DisplayName), ELSTRING(player,ArmsDamageThreshold_Description)], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [ELSTRING(main,Category), ELSTRING(player,SubCategory)], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 100, 1, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;

[
    QGVAR(player_legsDamageThreshold),//"awr_player_PainThreshold", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    [ELSTRING(player,LegsDamageThreshold_DisplayName), ELSTRING(player,LegsDamageThreshold_Description)], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    [ELSTRING(main,Category), ELSTRING(player,SubCategory)], // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0, 100, 1, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
] call CBA_fnc_addSetting;