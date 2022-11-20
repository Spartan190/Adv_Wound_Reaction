#define COMPILE_SCRIPT(var1) compileScript ['PATHTO_SYS(PREFIX,COMPONENT_F,var1)']

class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_SCRIPT(test_XEH_preInit));
    };
};

class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_SCRIPT(XEH_postInit));
    };
};