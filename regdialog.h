#include "DeRegmain.h"

typedef struct 			_ClassListElement
{
	OBJCLASS					ClassPtrs;
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

