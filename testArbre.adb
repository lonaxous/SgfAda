with text_io;
use text_io;

with ada.integer_text_io;
use ada.integer_text_io;

with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

with arbre;
Procedure testArbre is
	package arbre_sgf is new arbre(boolean);
	use arbre_sgf;

	arbre : T_Darbre;
Begin
	--Création de l'arbre
	arbre := CreerArbre;
	CreerNoeud(arbre,to_unbounded_string("/"),true);
	AfficheArbre(arbre);
End testArbre;