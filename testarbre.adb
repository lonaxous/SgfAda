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
	fils : T_Darbre;
Begin
	--Création de l'arbre
	arbre := CreerArbre;
	--Création de l'aborescence
	CreerNoeud(arbre,"/",true);
	--Création de fils
	Put_Line("Affiche des fils d'un noeud");
	CreerFils(arbre,"temp",true);
	CreerFils(arbre,"etc",true);
	CreerFils(arbre,"opt",true);
	CreerFils(arbre,"bin",true);
	AfficheFils(arbre);
	--Test de récupération d'un fils
	arbre := RechercheFils(arbre,"etc");
	CreerFils(arbre,"Documents",true);
	CreerFils(arbre,"Picture",true);
	CreerFils(arbre,"Movie",true);
	arbre := RechercheFils(arbre,"Documents");
	CreerFils(arbre,"compte_rendu.odt",false);
	CreerFils(arbre,"cv.pdf",false);
	arbre := RecherchePere(arbre);
	arbre := RecherchePere(arbre);
	arbre := RechercheFils(arbre,"temp");
	CreerFils(arbre,"pic180118.jpg",false);
	--Affichage de l'arbre
	Put_Line("Affichage de l'arbre");
	AfficheArbre(arbre);
	--Test de la suppression
	Put_Line("Suppression des composants de temp");
	SupprTousFils(arbre);
	AfficheArbre(arbre);
	Put_Line("Suppression du cv.pdf");
	arbre := RecherchePere(arbre);
	arbre := RechercheFils(arbre,"etc");
	arbre := RechercheFils(arbre,"Documents");
	--Test de l'exception
	fils := RechercheFils(arbre,"test");
	SupprFils(arbre,"cv.pdf");
	AfficheArbre(arbre);

End testArbre;