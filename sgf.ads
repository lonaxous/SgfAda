with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

with ada.integer_text_io;
use ada.integer_text_io;

with text_io;
use text_io;

with arbre;
Package sgf is
	package arbre_sgf is new arbre(boolean);
	use arbre_sgf;
--Fonctions

--###############################################################
--Nom : Format
--Sémantique : Création d'un SGF ne contenant que le dossier racine
--Paramètre : Aucun
--retourne : Aucun
--précondition : Aucune
--postcondition : Aucune
--Exception : Aucune
--###############################################################
Procedure Format;

--###############################################################
--Nom : Pwd
--Sémantique : Affiche les pères du repertoire courant
--Paramètre : Aucun
--retourne : Aucun
--précondition : Aucune
--postcondition : Aucune
--Exception : Aucune
--###############################################################
Procedure Pwd;

--###############################################################
--Nom : Ls
--Sémantique : Affiche les fils du repertoire courant
--Paramètre : Aucun
--retourne : Auncun 
--précondition : Aucune
--postcondition : Aucune
--Exception : Aucune
--###############################################################
Procedure Ls;

--###############################################################
--Nom : LsR
--Sémantique : Affiche le contenu du repertoire courant et de ses sous repertoire
--Paramètre : Aucun
--retourne : Aucun
--précondition : Aucune
--postcondition : Aucune
--Exception : Aucune
--###############################################################
Procedure LsR;

--###############################################################
--Nom : Touch
--Sémantique : Créer un fichier dans le repertoire courant
--Paramètre : nom : nom du fichier
--retourne : Aucun
--précondition : Aucune
--postcondition : Le fichier existe désormais
--Exception : Aucune
--###############################################################
Procedure Touch(nom : String);

--###############################################################
--Nom : Mkdir
--Sémantique : Création d'un dossier dans le repertoire courant
--Paramètre : nom : nom du repertoire
--retourne : Aucun
--précondition : Aucune
--postcondition : Le repertoire existe désormais
--Exception : Aucune
--###############################################################
Procedure Mkdir(nom : String);

--###############################################################
--Nom : Rm
--Sémantique : Suppression d'un fichier
--Paramètre : nom : nom du fichier
--retourne : Aucun
--précondition : Le fichier existe
--postcondition : Le fichier n'existe plus
--Exception : Aucune
--###############################################################
Procedure Rm(nom : String);

--###############################################################
--Nom : RmR
--Sémantique : Suppression d'un repertoir vide ou non
--Paramètre : nom : nom du repertoire
--retourne : Aucun
--précondition : Le repertoire existe
--postcondition : Le repertoire n'existe plus
--Exception : Aucune
--###############################################################
Procedure RmR(nom : String);

--###############################################################
--Nom : Mv
--Sémantique : Deplacement d'un fichier ou renommage
--Paramètre : nom : nom du fichier à deplacer
--			  chemin : chemin du nouveau fichier
--retourne : Aucun
--précondition : Le fichier existe
--postcondition : Le fichier existe et est dans le bon repertoire
--Exceptions : Fils_absent, Erreur_Chemin, Pas_Repertoire
--###############################################################
Procedure Mv(nom : String; chemin : String);

--###############################################################
--Nom : Cd
--Sémantique : Changement de repertoire
--Paramètre : chemin : Chemin du nouveau repertoire 
--retourne : Aucun
--précondition : Le repertoire lié au chemin existe
--postcondition : aucun
--Exception : Erreur_Chemin, Pas_Repertoire
--###############################################################
Procedure Cd(chemin : String);

--###############################################################
--Nom : CpR
--Sémantique : Copie d'un fichier ou un repertoire
--Paramètre : nom : nom du repertoire ou fichier
--			  chemin : chemin vers 
--retourne : Aucun
--précondition : Le repertoire existe
--postcondition : Le repertoire n'existe plus
--Exception : Fils_Absent, Pas_Repertoire, Erreur_Chemin
--###############################################################
Procedure CpR(nom : String; chemin : String);

--###############################################################
--Nom : CopieCpr
--Sémantique : Méthode Récursive pour utiliser le cpr, elle va reproduire à l'identique un arbre donnée
--Paramètre : chemin : chemin vers un repertoire
--			  arbe : arbre à  reproduire
--retourne : Aucun
--précondition : Le repertoire existe
--postcondition : Le repertoire n'existe plus
--Exception : Fils_Absent, Pas_Repertoire, Erreur_Chemin
--##############################################################
Procedure CopierCpR(chemin : String; copie : T_Darbre);

--###############################################################
--Nom : Tar
--Sémantique : Compression d'un repertoire
--Paramètre : chemin : chemin où ira la compression
--retourne : Aucun
--précondition : Le repertoire d'arriver existe
--postcondition : Le repertoire courant a été supprimer et le fichier compresser est au bon endroit
--Exception : Aucune
--###############################################################
Procedure Tar(chemin : String);

--###############################################################
--Nom : Nano
--Sémantique : Modifie (la taille) d'un fichier
--Paramètre : nom : nom du fichier à modifier
--			  tai : Nouvelle taille du fichier
--retourne : Aucun
--précondition : Le fichier existe
--postcondition : Le fichier a changé de taille
--Exception : Aucune
--###############################################################
Procedure Nano(nom : String;tai : integer);

--###############################################################
--Nom : DetermineChemin
--Sémantique : Retourne à partir d'un chemin un arbre
--Paramètre : chemin : Le chemin en chaine de caractère
--			  lchemin : Longueur de la chaine de caractère du chemin
--retourne : Pointeur vers le repertoire du chemin
--précondition : aucune
--postcondition : aucune
--Exceptions : Erreur_Root, Fils_Absent, Pere_Absent
--###############################################################
Function DetermineChemin(chemin : String; lchemin : integer)return T_Darbre;

--###############################################################
--Nom : getCapacite
--Sémantique : Affiche la capacite restante du système
--Paramètre : Aucun
--retourne : Aucune
--précondition : aucune
--postcondition : aucune
--Exceptions : Aucune
--###############################################################
Procedure getCapacite;
Procedure Pwd(a : T_Darbre);

End sgf;