with text_io;
use text_io;

with ada.integer_text_io;
use ada.integer_text_io;

with sgf;
use sgf;

Procedure main is
	CMAX : constant integer := 10; --Taille max d'une commande
	PARAMAX : constant integer := 40; --Taille max d'un paramètre
	commande : String(1..100); --Une commande entière (commande+paramètres) entrée par l'utilisateur
	param1 : String(1..PARAMAX); --Premier Paramètre
	param2 : String(1..PARAMAX); -- Second Paramètre
	longueur : integer; --Longueur de chaine entrée par l'utilisateur
	arbre : T_Darbre;

	--###############################################################
	--Nom : SepareCommande
	--Sémantique : Separe la commande en une commande et ses paramètre
	--Paramètre : cmd : (D/R) la commande
	--			  param1 : (R) Le premier paramètre
	--			  param2 : (R) Le second paramètre (optionnel)
	--retourne : Aucun
	--précondition : Aucune
	--postcondition : Aucune
	--Exception : La commande n'existe pas
	--###############################################################
	--Procedure SepareCommande(cmd : IN OUT String; param1 : OUT String; param2 : OUT String)is
	--	cmd : String(1..100);
	--Begin
	--End SepareCommande;
Begin
	--La mini console
	--While true loop
	--	Put(">");
	--	--Caputre de la commande
	--	get_line(commande,longueur);
	--end loop;
	arbre := Format;
End main;