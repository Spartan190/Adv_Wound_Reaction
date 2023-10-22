#include "script_component.hpp"
#include "\a3\ui_f\hpp\defineDIKCodes.inc"
/*
* Author: [79AD] S. Spartan
* Sets if the given player is allowed to do melee
* 
* Arguments:
* 0: unit to check (ACE_player)
* 1: enable or distable melee
*
* Return Value:
* nothing
*
* Example:
* [ACE_player,true] spawn awr_compat_ims_fnc_setPlayerMeleeMode
*
* Public: No
*/
params ["_unit","_enable"];

WBK_IMSIsFistsAllowed = _enable;