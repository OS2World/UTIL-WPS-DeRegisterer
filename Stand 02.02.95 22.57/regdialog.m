#include "RegDialog.h"

@implementation DeRegDialogDelegate: Object

-initWithOwner: owner
{
	[super init];
	ClassList=[owner findFromID: CLASSLIST];
	MessageText=[owner findFromID: MESSAGETEXT];
	[owner	bindCommand:	ACTION_DOIT
					withObject:   self
					selector:			@selector(performDelete:)];
	CenterWindow([owner window]);
	return self;
}

-buttonWasPressed: (ULONG) menuId: sender
{
	switch(menuId)
	{
		// Help
		case ACTION_HELP:
			DosBeep(3000,100);
			return self;
			break;
	}
	return self;
}

-buildUpClassList
{
	char								*ClassListText=NULL;
	ULONG								ClassListTextSize;
	APIRET							rc;
	ClassListElement		Element;
	ULONG								Offset=0;

	[self message: "Searching for registered Object Classes..."];
	rc=WinEnumObjectClasses(ClassListText,&ClassListTextSize);
	ClassListText=malloc(ClassListTextSize);
	rc=WinEnumObjectClasses(ClassListText,&ClassListTextSize);
	//parsen von ClassListText und einfÅgen in ListBox
	Offset=(ULONG)ClassListText;
	while ((Offset-(ULONG)ClassListText)<ClassListTextSize)
	{
		Element.unknown1=(ULONG)Offset;
		Offset=Offset+4;
		Element.unknown2=(ULONG)Offset;
		Offset=Offset+4;
		Element.unknown3=(ULONG)Offset;
		Offset=Offset+4;
		Element.ClassName=(char *)Offset;
		Offset=Offset+strlen(Element.ClassName)+1;
		Element.LibraryName=(char *)Offset;
		Offset=Offset+strlen(Element.LibraryName)+1;
		[ClassList insertItem: LIT_SORTASCENDING text: Element.ClassName];
	}
	[self message: ""];
	free(ClassListText);
	return self;
}

-message: (const char *) buffer
{
	[MessageText setText: buffer];
	return self;
}

-performDelete: sender
{
	char 		*ClassName=NULL;
	SHORT 	Selection=-1;
	APIRET  rc;
	char		*MessageBuffer=NULL;

	Selection=[ClassList selected];
	if (Selection<0)
	{
		[self message: "No selection."];
	} else
	{
		ClassName=[ClassList item: Selection text:ClassName];
		if (rc=WinDeregisterObjectClass(ClassName)==TRUE)
		{
			MessageBuffer=malloc(sizeof(ClassName)+1+30);
			sprintf(MessageBuffer,"%s is successfully deregistered.",ClassName);
			[self message: MessageBuffer];
			free(MessageBuffer);
			[ClassList deleteItem: Selection];
		} else
		{
			MessageBuffer=malloc(sizeof(ClassName)+1+44);
			sprintf(MessageBuffer,"Unable to deregister %s. See help for details.",ClassName);
			[self message: MessageBuffer];
			free(MessageBuffer);
		}
		if (ClassName!=NULL) free(ClassName);
	}
	return self;
}

@end

/* Subfunktion des Dialogfensters zum Zentrieren auf dem Bildschirm        */
void CenterWindow(HWND hwnd)
{
	SHORT		SetPos_x, SetPos_y;
	SHORT		DisplayWidth, DisplayDepth;
	SWP			swp;

	DisplayWidth = WinQuerySysValue(HWND_DESKTOP, SV_CXSCREEN);
	DisplayDepth = WinQuerySysValue(HWND_DESKTOP, SV_CYSCREEN);
	WinQueryWindowPos(hwnd,(PSWP)&swp);
	SetPos_x=(SHORT)((DisplayWidth-swp.cx)/2);
	SetPos_y=(SHORT)((DisplayDepth-swp.cy)/2);
	WinSetWindowPos(hwnd, HWND_TOP, SetPos_x, SetPos_y, 0, 0, SWP_MOVE);
}

