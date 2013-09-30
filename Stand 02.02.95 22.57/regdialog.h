#include "DeRegmain.h"

typedef struct 			_ClassListElement
{
	ULONG							unknown1;
	ULONG							unknown2;
	ULONG							unknown3;
	char							*ClassName;
	char							*LibraryName;
} ClassListElement;

@interface DeRegDialogDelegate: Object
{
	ListBox							*ClassList;
	Static							*MessageText;
}

-initWithOwner: owner;

-buttonWasPressed: (ULONG) menuId: sender;

-buildUpClassList;

-message: (const char *) buffer;

-performDelete: sender;

@end

/* Subfunktion des Dialogfensters zum Zentrieren auf dem Bildschirm        */
void CenterWindow(HWND hwnd);

