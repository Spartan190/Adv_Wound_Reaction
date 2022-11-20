#include "\z\ace\addons\main\script_macros.hpp"
#define COMPILE_SCRIPT(var1) compileScript ['PATHTO_SYS(PREFIX,COMPONENT_F,var1)']
#define ACEFUNC(comp, func) ace_##comp##_fnc_##func
#define ACEPATHOF(comp, file) \z\ace\addons\##comp##\##file