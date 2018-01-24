with text_io;
use text_io;

Package Body arbre is
	--Fonctions
	--R1 Créer un Arbre Vide
	Function CreerArbre return T_Darbre is
	Begin
		return null;
	End CreerArbre;


	--R1 Créer un noeud
	Procedure CreerNoeud(arbre : IN OUT T_Darbre; nom : string; objet : obj)is
		a : T_Darbre;
	Begin
		a := new T_Noeud;
		a.all.T_Pere := null;
		a.all.nom := to_unbounded_string(nom);
		a.all.taille := 0;
		a.all.objet := objet;
		a.all.nbFils := 0;
		InitialiseFils(a);
		arbre := a;
	End CreerNoeud;

	--R1 Créer un Fils
	Procedure CreerFils(arbre : IN OUT T_Darbre; nom : string; objet : obj)is
		fils : T_Darbre;
	Begin
		--R2 Créer un noeud
		CreerNoeud(fils,nom,objet);
		--R2 Ajouter un fils
		AjoutFils(arbre,fils);
	End CreerFils;

	--R1 Mettre tous les fils à null
	Procedure InitialiseFils(arbre : IN OUT T_Darbre)is
	Begin
		for i in 1..NMAX Loop
			arbre.all.T_Fils(i) := null;
		End Loop;
	End InitialiseFils;


	--R1 Modification du nom
	Procedure ModifNom(arbre : IN OUT T_Darbre; nom : string)is
	Begin
		arbre.all.nom := to_unbounded_string(nom);
	End ModifNom;


	--R1 Modifier la taille
	Procedure ModifTaille(arbre : IN OUT T_Darbre; taille : integer)is
	Begin
		arbre.all.taille := taille;
	End ModifTaille;


	--R1 Modifier l'objet
	Procedure ModifObjet(arbre : IN OUT T_Darbre; objet : obj)is
	Begin
		arbre.all.objet := objet;
	End ModifObjet;


	--R1 Modifier le pères
	Procedure ChangePere(fils : IN OUT T_Darbre; pere : IN OUT T_Darbre)is
	Begin
		--R2 Supprimer le fils du pere
		SupprFils(fils.all.T_Pere,to_string(arbre.all.nom));
		--R2 Ajouter le fils au nouveau pere
		AjoutFils(pere, fils);
	End ChangePere;


	--R1 Ajouter un Fils à un noeud
	Procedure AjoutFils(arbre : IN OUT T_Darbre; fils : T_Darbre)is
	Begin
		--R2 Incrémenter le nombre de fils
		arbre.all.nbFils := arbre.all.nbFils + 1;
		--R2 Ajouter le pointeur aux fils
		arbre.all.T_Fils(arbre.all.nbFils):= fils;
		--R2 Ajouter au fils le pere
		arbre.all.T_Fils(arbre.all.nbFils).all.T_Pere := arbre;
	End AjoutFils;


	--R1 Supprimer un fils
	Procedure SupprFils(arbre : IN OUT T_Darbre; nom : string)is
		i : integer; --indice du fils
	Begin
		--R2 Rechercher le fils
		i := RechercheIndiceFils(arbre,nom);
		if  i /= 0 then
			--R3 Supprimer le pointeur du fils vers le pere
			arbre.all.T_Fils(i).all.T_Pere := null;

			--R3 Supprimer le pointeur du pere vers le fils
			if i /= arbre.all.nbFils then
				arbre.all.T_Fils(i) := arbre.all.T_Fils(arbre.all.nbFils);
				arbre.all.T_Fils(arbre.all.nbFils) := null;
			else
				arbre.all.T_Fils(arbre.all.nbFils) := null;
			End if;

			arbre.all.nbFils := arbre.all.nbFils - 1; 
		else
			null;
		end if;
	End SupprFils;


	--R1 Retourner le fils
	Function RechercheFils(arbre : T_Darbre;nom : string)return T_Darbre is
		i : integer; -- Indice du fils
	Begin
		--R2 Rechercher le fils
		i := RechercheIndiceFils(arbre, nom);
		if i /= 0 then
			return arbre.all.T_Fils(i);
		else
			return null;
		End if;
	End RechercheFils;


	--R1 Rechercher l'indice d'un fils
	function RechercheIndiceFils(arbre : T_Darbre; nom : string)return integer is
		i : integer; --Indice pour la boucle
		estTrouve : boolean; --Booléen pour stopper la boucle
	Begin
		estTrouve := false;
		i := 0;
		--R2 Vérifier les fils jusqu'à trouver le bon
		While not(estTrouve) and i <= arbre.all.nbFils Loop
			i := i + 1;
			estTrouve := arbre.all.T_Fils(i).all.nom = to_unbounded_string(nom);
		End Loop;

		--R2 Retourner l'indice trouvé ou 0
		if estTrouve then
			return i;
		else
			return 0;
		End if;
		exception
			when Constraint_Error => Put(nom);
									 Put(" n'existe pas dans ");
									 Put(to_string(arbre.all.nom));
									 New_Line;
									 return 0;
	End RechercheIndiceFils;


	--R1 Retourner le pere
	Function RecherchePere(arbre : T_Darbre)return T_Darbre is
	Begin
		return arbre.all.T_Pere;
	End RecherchePere;

	--R1 Supprimer tous les fils
	Procedure SupprTousFils(arbre : IN OUT T_Darbre)is
	Begin
		arbre.all.nbFils := 0;
		InitialiseFils(arbre);
	End SupprTousFils;


	--R1 Afficher la totalité de l'arbre
	Procedure AfficheArbre(arbre : T_Darbre)is
		root : T_Darbre; --Racine de l'arbre
	Begin
		--R2 Aller à la racine
		root := GoRoot(arbre);
		AfficheTousFils(root,1);
		New_Line;
	End AfficheArbre;

	--R1 Retourner la racine de l'arbre
	Function GoRoot(arbre :T_Darbre)return T_Darbre is
	Begin
		if arbre.all.T_Pere /= null then
			return GoRoot(arbre.all.T_Pere);
		else
			return arbre;
		End if;
	End GoRoot;

	--R1 Afficher la totalité des fils
	Procedure AfficheTousFils(arbre : T_Darbre; ent : integer)is
	Begin
		Put(To_string(arbre.all.nom));
		--R2 Afficher les fils courant
		For i in 1..arbre.all.nbFils Loop
			New_Line;
			--Espace pour afficher proprement
			For j in 1..ent Loop
				Put("  ");
			End Loop;
			AfficheTousFils(arbre.all.T_Fils(i),ent+1);
		End Loop;
	End AfficheTousFils;

	--R1 Afficher les fils d'un noeud
	Procedure AfficheFils(arbre :T_Darbre)is
	Begin
		For i in 1..arbre.all.nbFils Loop
			Put_line(to_string(arbre.all.T_Fils(i).all.name));
		End Loop;
	End AfficheFils;
End arbre;