Generic 
	Type obj is private;

--Arbre portant un objet généric
Package arbre is
--Variables
NMAX : constant integer := 20;
TAILLEMAX: constant integer := 10;

Type T_Noeud;
Type T_Darbre is access T_Noeud; 
Type T_Tsuiv is array(1..NMAX) of T_Darbre; --Contient des pointeurs vers les fils de l'arbre

Type T_Noeud is record -- Définition du noeud d'un arbre(Fichier ou Repertoire)
	T_Pere : T_Darbre; --Les Répertoires précédents
	nom : String(1..NMAX); --Nom de l'élément
	objet : obj; --Objet générique de l'arbre
	taille : integer;  --La taille
	nbFils: integer; --Le nombre de fils
	T_Fils : T_Tsuiv; --Les noeuds suivants
End record;

--Fonctions

--###############################################################
--Nom : CreerArbre
--Sémantique : Créer un arbre générique
--Paramètre : Aucun
--retourne : Le nouvelle Arbre 
--précondition : Aucune
--postcondition : Aucune
--Exception : Aucune
--###############################################################
Function CreerArbre return T_Darbre;

--###############################################################
--Nom : CreerNoeud
--Sémantique : Créer un noeud 
--Paramètre : arbre : Pointeur vers un arbre
--			  nom : Nom du noeud
--			  objet : Objet du noeud
--retourne : Aucun 
--précondition : Aucune
--postcondition : Aucune
--Exception : Aucune
--###############################################################
Procedure CreerNoeud(arbre : IN OUT T_Darbre; nom : String; objet : obj);

--###############################################################
--Nom : InitialiseFils
--Sémantique : Met tous les fils possibles à null
--Paramètre : arbre : Pointeur vers noeud
--retourne : Aucun 
--précondition : Aucune
--postcondition : Aucune
--Exception : Aucune
--###############################################################
Procedure InitialiseFils(arbre : IN OUT T_Darbre);

--###############################################################
--Nom : RechercheIndiceFils
--Sémantique : Renvoie l'indice d'un fils
--Paramètre : arbre : Pointeur vers un noeud
--			  nom : Nom du fils recherché
--retourne : Retourne l'indice du fils s'il n'existe pas retourne 0
--précondition : Aucune
--postcondition : Aucune
--Exception : Aucune
--###############################################################
Function RechercheIndiceFils(arbre : T_Darbre; nom : String)return integer;

--###############################################################
--Nom : RechercheFils
--Sémantique : Renvoie un Fils s'il existe
--Paramètre : arbre : Pointeur vers un arbre existant
--			  nom : Nom du fils recherché
--retourne : Retourne l'adresse du fils recherché s'il existe sinon null
--précondition : Aucune
--postcondition : Aucune
--Exception : Aucune
--###############################################################
Function RechercheFils(arbre : T_Darbre;nom : String)return T_Darbre;

--###############################################################
--Nom : RecherchePere
--Sémantique : Renvoie le pere s'il existe 
--Paramètre : arbre : Pointeur vers un noeud
--retourne : Retourne l'adresse du pere sinon null
--précondition : Aucune
--postcondition : Aucune
--Exception : Aucune
--###############################################################
Function RecherchePere(arbre : T_Darbre)return T_Darbre;

--###############################################################
--Nom : AjoutFils
--Sémantique : Création d'un Noeud
--Paramètre : arbre : Pointeur vers un arbre existant
--			  nom : Nom du noeud
--			  objet : L'objet que porte le noeud
--			  taille : Taille en Ko du noeud
--retourne : Auncun
--précondition : Aucune
--postcondition : Le fils existe bien
--Exception : TailleMax
--###############################################################
Procedure AjoutFils(arbre : IN OUT T_Darbre; fils : T_Darbre)
With
	Post => RechercheFils(nom) /= null and arbre.all.nbFils'Result = arbre.all.nbFils'old + 1;

--###############################################################
--Nom : SupprFils
--Sémantique : Supprime un fils à partir de son nom
--Paramètre : arbre : Pointeur vers un noeud
--			  nom : Nom du fils
--retourne : Auncun
--précondition : Aucune
--postcondition : Le fils a été supprimé
--Exception : Aucune
--###############################################################
Procedure SupprFils(arbre : IN OUT T_Darbre; nom : String)
With
	Post => RechercheFils(nom) = null and arbre.all.nbFils'old = arbre.all.nbFils'Result + 1;

--###############################################################
--Nom : SupprTousFils
--Sémantique : Supprime tous les fils d'un noeud
--Paramètre : arbre : Pointeur vers un noeud
--retourne : Auncun
--précondition : Aucune
--postcondition : Les fils ont été supprimés
--Exception : Aucune
--###############################################################
Procedure SupprTousFils(arbre : IN OUT T_Darbre)
With
	Post => arbre.all.nbFils = 0;

--###############################################################
--Nom : ModifNom
--Sémantique : Modifie le nom d'un noeud
--Paramètre : arbre : Pointeur vers un noeud
--			  nom : Nom du noeud
--retourne : Auncun
--précondition : Aucune
--postcondition : Le noeud correspond bien au nom entrée
--Exception : TypeException
--###############################################################
Procedure ModifNom(arbre : IN OUT T_Darbre; nom : String)
With
	Post => arbre.all.nom = nom;

--###############################################################
--Nom : ModifTaille
--Sémantique : Modifie la taille
--Paramètre : arbre : Pointeur vers un noeud
--			  taille : Nouvelle taille
--retourne : Auncun
--précondition : Aucune
--postcondition : La nouvelle taille est bien entrée
--Exception : TypeException
--###############################################################
Procedure ModifTaille(arbre : IN OUT T_Darbre; taille : integer)
With
	Post => arbre.all.taille = taille;

--###############################################################
--Nom : ModifObjet
--Sémantique : Modification d'un objet
--Paramètre : arbre : Pointeur vers un noeud
--			  objet : nouvelle objet
--retourne : Auncun
--précondition : Aucune
--postcondition : Le nouvelle objet est bien entrée
--Exception : TypeException
--###############################################################
Procedure ModifObjet(arbre : IN OUT T_Darbre; objet : obj)
With
	Post => arbre.all.objet = objet;

--###############################################################
--Nom : ChangePere
--Sémantique : Change le pere d'un noeud
--Paramètre : arbre : Pointeur vers un noeud
--			  pere : Nouveau pere 
--retourne : Auncun
--précondition : Aucun
--postcondition : Le nouveau père à bien été rentrée
--Exception : Aucune
--###############################################################
Procedure ChangePere(arbre : IN OUT T_Darbre; pere : IN OUT T_Darbre)
With
	Post => arbre.all.T_Pere = pere;

--###############################################################
--Nom : AfficheArbre
--Sémantique : Affiche la totalité de l'arbre
--Paramètre : arbre : Pointeur vers un noeud
--retourne : Auncun
--précondition : Aucun
--postcondition : Auncun
--Exception : Aucune
--###############################################################
Procedure AfficheArbre(arbre : T_Darbre);

--###############################################################
--Nom : GoRoot
--Sémantique : Retourne la racine de l'arbre
--Paramètre : arbre : Pointeur vers un noeud
--retourne : Retourne la racine de l'arbre
--précondition : Aucun
--postcondition : Auncun
--Exception : Aucune
--###############################################################
Function GoRoot(arbre : T_Darbre)return T_Darbre;

--###############################################################
--Nom : AfficheTousFils
--Sémantique : Affiche les fils et leur prédecesseur
--Paramètre : arbre : Pointeur vers un noeud
--retourne : Aucun
--précondition : Aucun
--postcondition : Auncun
--Exception : Aucune
--###############################################################
Procedure AfficheTousFils(arbre : T_Darbre);
End arbre;