#include "\z\ace\addons\main\script_macros.hpp"
#include "\z\ace\addons\medical_engine\script_macros_medical.hpp"
#define COMPILE_SCRIPT(var1) compileScript ['PATHTO_SYS(PREFIX,COMPONENT_F,var1)']
#define ACEFUNC(comp, func) ace_##comp##_fnc_##func
#define ACEPATHOF(comp, file) \z\ace\addons\##comp##\##file
#define ACEVAR(comp, var) ace_##comp##_##var
#define QACEVAR(comp,var) #ACEVAR(comp,var)

#define ACE_GET_PAIN(unit) (unit getVariable [QACEVAR(medical,pain), 0])
#define ACE_GET_PAIN_SUPP(unit) (unit getVariable [QACEVAR(medical,painSuppress),0])
#define ACE_GET_PAIN_PERCEIVED(unit) (0 max (ACE_GET_PAIN(unit) - ACE_GET_PAIN_SUPP(unit)) min 1)
#define GET_BODY_DAMAGE_THRESHOLD(unit)  ([GVAR(ai_bodyDamageThreshold),GVAR(player_bodyDamageThreshold)] select (isPlayer unit))
#define GET_ARMS_DAMAGE_THRESHOLD(unit)  ([GVAR(ai_armsDamageThreshold),GVAR(player_armsDamageThreshold)] select (isPlayer unit))
#define GET_LEGS_DAMAGE_THRESHOLD(unit)  ([GVAR(ai_legsDamageThreshold),GVAR(player_legsDamageThreshold)] select (isPlayer unit))
#define GET_PAIN_THRESHOLD(unit) ([EGVAR(ai,painThreshold),EGVAR(player,painThreshold)] select (isPlayer unit))
#define GET_INCAPACITATION_TYPE(unit) ([EGVAR(ai,incapacitationType),EGVAR(player,incapacitationType)] select (isPlayer unit))
#define GET_LIMBS_DAMAGE_MODE(unit) ([EGVAR(ai,limbHandleMode),EGVAR(player,limbHandleMode)] select (isPlayer unit))
#define SHOW_HINT(message) if(awr_main_displayHints) then { 0 spawn { hintSilent message; sleep 5; hintSilent ""; }; }
#define VOL_UNCONSCIOUS 0.25
#define BURN_TIME_TO_FATAL 10.0

