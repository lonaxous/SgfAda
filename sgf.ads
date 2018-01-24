with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

with arbre;
Package sgf is
	package arbre_sgf is new arbre(boolean);
	use arbre_sgf;
--Fonctions

--###############################################################
--Nom : Format
--Sémantique : Création d'un SGF ne contenant que le dossier racine
--Paramètre : Aucun
--retourne : Retourne un noeud root d'une nouvelle arborescence 
--précondition : Aucune
--postcondition : Aucune
--Exception : Aucune
--###############################################################
Function Format return T_Darbre;

--###############################################################
--Nom : Pwd
--Sémantique : Affiche les pères du repertoire courant
--Paramètre : arbre : repertoire courant
--retourne : Aucun
--précondition : Aucune
--postcondition : Aucune
--Exception : Aucune
--###############################################################
Procedure Pwd(arbre : IN T_Darbre);

--###############################################################
--Nom : Ls
--Sémantique : Affiche les fils du repertoire courant
--Paramètre : arbre : repertoire courant
--retourne : Auncun 
--précondition : Aucune
--postcondition : Aucune
--Exception : Aucune
--###############################################################
Procedure Ls(arbre : IN T_Darbre);

--###############################################################
--Nom : LsR
--Sémantique : Affiche le contenu du repertoire courant et de ses sous repertoire
--Paramètre : arbre : Repertoire courant
--retourne : Aucun
--précondition : Aucune
--postcondition : Aucune
--Exception : Aucune
--###############################################################
Procedure LsR(arbre : IN T_Darbre);

--###############################################################
--Nom : Touch
--Sémantique : Créer un fichier dans le repertoire courant
--Paramètre : arbre : Repertoire courant
--			  nom : nom du fichier
--retourne : Aucun
--précondition : Aucune
--postcondition : Le fichier existe désormais
--Exception : Aucune
--###############################################################
Procedure Touch(arbre : IN OUT T_Darbre; nom : String);

--###############################################################
--Nom : Mkdir
--Sémantique : Création d'un dossier dans le repertoire courant
--Paramètre : arbre : Repertoire courant
--			  nom : nom du repertoire
--retourne : Aucun
--précondition : Aucune
--postcondition : Le repertoire existe désormais
--Exception : Aucune
--###############################################################
Procedure Mkdir(arbre : IN OUT T_Darbre; nom : String);

--###############################################################
--Nom : Rm
--Sémantique : Suppression d'un fichier
--Paramètre : arbre : Repertoire courant
--			  nom : nom du fichier
--retourne : Aucun
--précondition : Le fichier existe
--postcondition : Le fichier n'existe plus
--Exception : Aucune
--###############################################################
Procedure Rm(arbre : IN OUT T_Darbre; nom : String);

--###############################################################
--Nom : RmR
--Sémantique : Suppression d'un repertoir vide ou non
--Paramètre : arbre : Repertoire courant
--			  nom : nom du repertoire
--retourne : Aucun
--précondition : Le repertoire existe
--postcondition : Le repertoire n'existe plus
--Exception : Aucune
--###############################################################
Procedure RmR(arbre : IN OUT T_Darbre; nom : String);

--###############################################################
--Nom : Mv
--Sémantique : Deplacement d'un fichier ou renommage
--Paramètre : arbre : Repertoire courant
--			  nom : nom du fichier à deplacer
--			  chemin : chemin du nouveau fichier
--retourne : Aucun
--précondition : Le fichier existe
--postcondition : Le fichier existe et est dans le bon repertoire
--Exceptions : Fils_absent, Erreur_Chemin, Pas_Repertoire
--###############################################################
Procedure Mv(arbre : IN OUT T_Darbre; nom : String; chemin : String);

--###############################################################
--Nom : Cd
--Sémantique : Changement de repertoire
--Paramètre : arbre : Repertoire courant
--			  chemin : Chemin du nouveau repertoire 
--retourne : Aucun
--précondition : Le repertoire lié au chemin existe
--postcondition : aucun
--Exception : Erreur_Chemin, Pas_Repertoire
--###############################################################
Procedure Cd(arbre : IN OUT T_Darbre; chemin : String);

--###############################################################
--Nom : CpR
--Sémantique : Copie d'un fichier ou un repertoire
--Paramètre : arbre : Repertoire courant
--			  nom : nom du repertoire ou fichier
--			  chemin : chemin vers 
--retourne : Aucun
--précondition : Le repertoire existe
--postcondition : Le repertoire n'existe plus
--Exception : Fils_Absent, Pas_Repertoire, Erreur_Chemin
--###############################################################
Procedure CpR(arbre : IN OUT T_Darbre; nom : String; chemin : String);

--###############################################################
--Nom : Tar
--Sémantique : Compression d'un repertoire
--Paramètre : arbre : Repertoire courant
--			  chemin : chemin où ira la compression
--retourne : Aucun
--précondition : Le repertoire d'arriver existe
--postcondition : Le repertoire courant a été supprimer et le fichier compresser est au bon endroit
--Exception : Aucune
--###############################################################
Procedure Tar(arbre : IN OUT T_Darbre; chemin : String);

--###############################################################
--Nom : Nano
--Sémantique : Modifie (la taille) d'un fichier
--Paramètre : arbre : Repertoire courant
--			  nom : nom du fichier à modifier
--retourne : Aucun
--précondition : Le fichier existe
--postcondition : Le fichier a changé de taille
--Exception : Aucune
--###############################################################
Procedure Nano(arbre : IN OUT T_Darbre; nom : String);

--###############################################################
--Nom : DetermineChemin
--Sémantique : Retourne à partir d'un chemin un arbre
--Paramètre : arbre : Repertoire courant
--			  chemin : Le chemin en chaine de caractère
--			  lchemin : Longueur de la chaine de caractère du chemin
--retourne : Pointeur vers le repertoire du chemin
--précondition : aucune
--postcondition : aucune
--Exceptions : Erreur_Root, Fils_Absent, Pere_Absent
--###############################################################
Function DetermineChemin(arbre : T_Darbre; chemin : String; lchemin : integer)return T_Darbre;

End sgf;