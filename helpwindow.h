// Object Class for Access to the Help Window.

#define INCL_WINHELP

#include <pm/pm.h>

@interface HelpWindow : Object
{
	HELPINIT	HelpMgrInit;
	HWND			hwndHelp;
}

// Init, you must provide a Helptable ID, an Application Object and
// an Application Window to use the Help.
-initWithId: (USHORT) HelpTable andApplication: (StdApp *) Application
		andWindow: (Window *) WindowToHelp Title: (char *) HelpWindowTitle;

-free;

@end