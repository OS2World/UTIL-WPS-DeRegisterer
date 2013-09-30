#include "HelpWindow.h"

@implementation HelpWindow: Object

-initWithId: (USHORT) HelpTable andApplication: (StdApp *) Application
		andWindow: (Window *) WindowToHelp Title: (char *) HelpWindowTitle
{
	APIRET rc;

	[super init];
	HelpMgrInit.cb = sizeof(HELPINIT);
	HelpMgrInit.ulReturnCode = 0;
	HelpMgrInit.pszTutorialName=(PSZ) NULL;
	HelpMgrInit.phtHelpTable = (PHELPTABLE)MAKELONG(HelpTable, 0xFFFF);
	HelpMgrInit.hmodHelpTableModule = 0L;
	HelpMgrInit.hmodAccelActionBarModule = 0L;
	HelpMgrInit.idAccelTable = 0L;
	HelpMgrInit.idActionBar = 0L;
	HelpMgrInit.pszHelpWindowTitle=HelpWindowTitle;
	HelpMgrInit.pszHelpLibraryName=(PSZ) NULL;
	if (((hwndHelp=WinCreateHelpInstance([Application hab], &HelpMgrInit))==NULLHANDLE)||
		(rc=WinAssociateHelpInstance(hwndHelp,[WindowToHelp window])==FALSE))
	{
		WinMessageBox(
			HWND_DESKTOP,
			HWND_DESKTOP,
			"Help not Available.",
			"Error",
			0,
			MB_OK|MB_ERROR);
		return self;
	}
	return self;
}

-free
{
	APIRET rc;
	rc=WinAssociateHelpInstance(NULLHANDLE,hwndHelp);
	rc=WinDestroyHelpInstance(hwndHelp);
	return [super free];
}

@end

