class CfgVehicles {
	class Man;
	class CAManBase: Man {
		class ACE_Actions {
			class ACE_MainActions{
				class GVAR(drag) {
					displayName = CSTRING(Drag);
					condition = QUOTE([ARR_2(_player, _target)] call FUNC(canDrag)]);
					statement = QUOTE([ARR_2(_player, _target)] call ACEFUNC(dragging, startDrag));
					showDisabled = 0;
					icon = QUOTE(ACEPATHOF(dragging, UI\icons\person_drag.paa));
				};
				class GVAR(carry) {
					displayName = CSTRING(Drag);
					condition = QUOTE([ARR_2(_player, _target)] call FUNC(canDrag)]);
					statement = QUOTE([ARR_2(_player, _target)] call ACEFUNC(dragging, startCarry));
					showDisabled = 0;
					icon = QUOTE(ACEPATHOF(dragging, UI\icons\person_carry.paa));
				};
			};
		};
	};
};