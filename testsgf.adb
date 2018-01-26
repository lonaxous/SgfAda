with ada.integer_text_io;
use ada.integer_text_io;

with text_io;
use text_io;

with sgf;
use sgf;

Procedure testsgf is
Begin
	Put_Line("Création de l'arbre :");
	Format;
	Put_Line("Test du Pwd à la racine");
	Pwd;
	Put_Line("Test du Cd dans un fils");
	Cd("temp");
	Put_Line("Test de Touch");
	Touch("test.jpg");
	Touch("RickRoll.jpg");
	Put_Line("Test du Mkdir");
	Mkdir("Test");
	Put_Line("Test du Ls");
	Ls;
	Put_Line("Test du Pwd dans une aborescense");
	Pwd;
	Put_Line("Test du cd ./");
	Cd("./");
	Put_Line("Test du cd ../");
	cd("../");
	cd("temp");
	Put_Line("Test du cd avec un retour racine /temp/Test");
	Cd("/temp/Test");
	Pwd;
	Put_Line("Test du cd en racine /");
	Cd("/");
	Pwd;
	Put_Line("Test pour se déplacer dans un fichier");
	Cd("/temp/test.jpg");
	Pwd;
End testsgf;