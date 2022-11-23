#include "\z\snad\addons\injuries\script_component.hpp"

#define ACEFUNC(var1,var2) ace_##var1##_fnc_##var2
#define ACEPATHOF(var1, var2) \x\ace\addons\var1\var2
#define ACE_GET_PAIN(unit) (unit getVariable [QACEVAR(medical,pain), 0])
#define ACE_GET_PAIN_SUPP(unit) (unit getVariable [QACEVAR(medical,pain_suppress),0])
#define ACE_GET_PAIN_PERCEIVED(unit) (0 max (ACE_GET_PAIN(unit) - ACE_GET_PAIN_SUPP(unit)) min 1)