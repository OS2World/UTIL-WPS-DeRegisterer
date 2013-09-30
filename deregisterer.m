#include "DeRegMain.h"
#include "RegDialog.h"
#include "HelpWindow.h"

// Globale Variablen

StdApp							*Application;
StdDialog       		*DeRegDialog;
DeRegDialogDelegate	*DeRegDelegate;
HelpWindow					*DeRegHelp;

int main(int argc, char *argv[]){

	Application=[[StdApp alloc] init];
	DeRegDialog=[[StdDialog alloc] initWithId: ClassEnterDialog];
	// Hilfe aufbauen
	DeRegHelp=[[HelpWindow alloc] initWithId: 0
		andApplication: Application
		andWindow: DeRegDialog
		Title: "DeRegisterer Help"];
	// Sub-Objekte des Dialogs erzeugen
	[DeRegDialog createObjects];
	// Delegate (pers”nliche Note des Dialogs) starten
	DeRegDelegate=[[DeRegDialogDelegate alloc] initWithOwner:DeRegDialog];
	[DeRegDialog setDelegate: DeRegDelegate];

	[DeRegDelegate buildUpClassList];

	// auf gehts
	[DeRegDialog runModalFor: nil];

	// Programm wird beendet, aufr„umen
	[DeRegHelp free];
	[DeRegDialog free];
	[DeRegDelegate free];
	[Application free];
	return 0;
}