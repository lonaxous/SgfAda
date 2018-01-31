with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

with ada.integer_text_io;
use ada.integer_text_io;

with text_io;
use text_io;

with sgf;
use sgf;

Package miniconsole is

--###############################################################
--Nom : Main
--Sémantique : Procedure pour utiliser le sgf
--Paramètre : Aucun
--retourne : Aucun
--précondition : Aucune
--postcondition : Aucune
--Exception : Aucune
--###############################################################
Procedure Main;

--###############################################################
--Nom : InterpreteurCommande
--Sémantique : Execute une commande
--Paramètre : commande : Une commande entrée
--retourne : Aucun
--précondition : Aucune
--postcondition : Aucune
--Exception : Aucune
--###############################################################
Procedure InterpreteurCommande(commande: String; lcommande: integer);
End miniconsole;