#include "\z\ace\addons\main\script_macros.hpp"
#include "\z\ace\addons\medical_engine\script_macros_medical.hpp"
#define COMPILE_SCRIPT(var1) compileScript ['PATHTO_SYS(PREFIX,COMPONENT_F,var1)']
#define ACEFUNC(comp, func) ace_##comp##_fnc_##func
#define ACEPATHOF(comp, file) \z\ace\addons\##comp##\##file
#define ACEVAR(comp, var) ace_##comp##_##var
#define QACEVAR(comp,var) #ACEVAR(comp,var)

#define ACE_GET_PAIN(unit) (unit getVariable [QACEVAR(medical,pain), 0])
#define ACE_GET_PAIN_SUPP(unit) (unit getVariable [QACEVAR(medical,pain_suppress),0])
#define ACE_GET_PAIN_PERCEIVED(unit) (0 max (ACE_GET_PAIN(unit) - ACE_GET_PAIN_SUPP(unit)) min 1)

