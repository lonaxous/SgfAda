Package body sgf is 
	--R1 Creer le SGF
	arbre : T_Darbre;

	Procedure Format is
	Begin
		arbre := CreerArbre;
		--R2 Créer l'aborescence
		CreerNoeud(arbre,"/",true);
		CreerFils(arbre,"temp",true);
		CreerFils(arbre,"etc",true);
		CreerFils(arbre,"opt",true);
		CreerFils(arbre,"bin",true);
	End Format;

	--R1 Afficher le chemin courant
	Procedure Pwd is
	Begin
		Prompt;
		New_Line;
	End Pwd;

	--R1 Afficher les dossier et fichier du repertoire courant
	Procedure Ls is
	Begin
		--R2 Parcourir les fils
		For i in 1..arbre.all.nbFils Loop
			--R3 Afficher les fils
			Put(to_string(arbre.all.T_Fils(i).all.nom));
			--Affichage différent s'il s'agit d'un repertoire
			If arbre.all.T_Fils(i).all.objet then
				Put("/");
			End if;
			New_Line;
		End Loop;
		New_Line;
	End Ls;

	--R1 Affiche le contenu du repertoire courant et de ses sous repertoire
	Procedure LsR is
	Begin
		Put(".");
		--R2 Afficher tous les fils
		AfficheTousFils(arbre,1);
		New_Line;
	End LsR;

	--R1 Creer un fichier
	Procedure Touch(nom : String)is
		fils : T_Darbre;
	Begin
		--R2 Vérifier si la taille max n'est pas atteinte suite 
		If GetTailleRoot(arbre) + 10 < TAILLEMAX then
			CreerFils(arbre, nom, false);
			fils := RechercheFils(arbre,nom);
			If fils /= null then
				ModifTaille(fils,10);
			Else
				null;
			End if;
		Else
			raise Capacite_Max_Atteinte;
		End if;
		Exception
			When Capacite_Max_Atteinte =>Put_Line("Attention capacité maximal atteinte, annulation de la commande précédente !");
	End Touch;

	--R1 Creer un repertoire
	Procedure Mkdir(nom : String)is
	Begin
		CreerFils(arbre, nom, true);
	End Mkdir;

	--R1 Suppression d'un fichier
	Procedure Rm(chemin : String)is
		fichier: T_Darbre;
	Begin
		--R2 Chercher le fichier
		fichier := DetermineChemin(chemin,length(to_unbounded_string(chemin)));
		--R2 Déterminer si c'est bien un fichier
		if not fichier.all.objet then
			--R3 Supprimer le fichier
			SupprFils(fichier.all.T_Pere,to_string(fichier.all.nom));
		Else
			Put_Line("Ce n'est pas un fichier essayez rm -r");
		End If;
		Exception
			When CONSTRAINT_ERROR => null;
	End Rm;

	--R1 Supprimer un répertoire
	Procedure RmR(chemin : String)is
		repertoire: T_Darbre; --Repertoire à supprimer
	Begin
		--R2 Chercher le repertoire
		repertoire := DetermineChemin(chemin,length(to_unbounded_string(chemin)));
		--R2 Déterminer si c'est bien un repertoire
		If repertoire.all.objet then
			--R3 Vérifier qu'il ne s'agit pas du repertoire racine
			If repertoire.all.T_Pere /= null then
				--R3 Supprimer le fichier
				SupprFils(repertoire.all.T_Pere,to_string(repertoire.all.nom));
			Else
				raise Erreur_Root;
			End if;
		Else
			Put_Line("Ce n'est pas un fichier essayez rm.");
		End If;
		Exception
			When CONSTRAINT_ERROR => null;
			When Erreur_Root => Put_Line("Vous ne pouvez pas supprimer la racine.");
	End RmR;

	--R1 Donner l'arbre à partir d'un chemin
	Function DetermineChemin(chemin : String; lchemin : integer)return T_Darbre is
		save : T_Darbre; --Sauvegarde de l'arbre en cas d'erreur
		final : T_Darbre; --Pointeur vers l'arbre au bout du chemin
		EnTraitement : unbounded_string; --Chaine de caractère pour le traitement du chemin
		nbEnTraitement : integer;
		i : integer; --Indice
		ChaineChemin : String(1..lchemin); --String pour fixer la taille du stirng chemin
	Begin
		save := arbre;
		ChaineChemin:=chemin;
		--R2 Regarder chaque caractère
		nbEnTraitement := 0;
		i:=1;
		If ChaineChemin(i) = '/' then
			final := GoRoot(arbre);
			i := i+1;
		Else
			final := arbre;
		End if;
		While i<=lchemin Loop
			-- R3 Traiter les suites de caractère
			--On s'arrete au / pour descendre dans l'arborescense
			If ChaineChemin(i) = '/' then
				--R4 Déterminer la suite du chemin
				--Aller vers le père
				If to_String(EnTraitement) = ".." then
					final := RecherchePere(final);
					If final = null then
						raise Pere_Absent;
					Else
						null;
					End if;
				Else
					--Aller vers son dossier
					If to_string(EnTraitement)= "." then
						final := final;
					Else
						--Erreur
						If to_string(EnTraitement) = "" then
							raise Erreur_Root;
						Else 
							--Sinon Aller vers un fils
							final := RechercheFils(final,to_string(EnTraitement));
							If final = null then
								raise Fils_Absent;
							Else
								null;
							End If;
						End If;
					End If;
				End If;
				nbEnTraitement := 0;
				EnTraitement := Null_Unbounded_String;
			Else
				nbEnTraitement := nbEnTraitement + 1;
				EnTraitement := EnTraitement & ChaineChemin(i);
				--R5 Aller à l'adresse trouvé
				If i=lchemin then
					final := RechercheFils(final,to_string(EnTraitement));
					If final = null then
						raise Fils_Absent;
					Else
						null;
					End If;
				End If;
			End If;
			i := i+1;
		End Loop;
		return final;
		Exception
			When CONSTRAINT_ERROR => Put_Line("Erreur, Avec le déplacement");
									 return null;
			When Erreur_Root => Put_Line("Erreur, vous ne pouvez pas avoir de // dans un chemin.");
							    return null;
			When Fils_Absent => Put_Line("Erreur, Un Fichier ou Repertoire du chemin n'existe pas.");
								return null;
			When Pere_Absent => Put_Line("Erreur, Un ../ ne marche pas car vous êtes à la racine.");
								return null;
	End DetermineChemin;

	--R1 Deplacer un fichier ou renommer
	Procedure Mv(CheminADeplacer : String; chemin : String)is
		ADeplacer : T_Darbre; --Arbre contenant le fils à déplacer
		DuChemin  : T_Darbre; --Arbre contenant le futur pere
	Begin
		--R2 Recuperer le fils
		ADeplacer := DetermineChemin(CheminADeplacer,length(to_unbounded_string(CheminADeplacer)));
		--R2 Recuperer le futur pere
		DuChemin := DetermineChemin(chemin,length(to_unbounded_string(chemin)));
		if ADeplacer = null then
			raise Fils_Absent;
		Else if not ADeplacer.all.objet then
			If DuChemin = null then
				raise Erreur_Chemin;
			Else
				If DuChemin.all.objet then
						--R3 Changer le fils de pere
						ChangePere(ADeplacer,DuChemin);
				Else
					raise Pas_Repertoire;
				End If;
			End If;
		Else
			raise Pas_Fichier;
		End If;
		End If;
		Exception
			when Fils_Absent => Put_Line("Erreur, Le fichier n'existe pas");
			When Erreur_Chemin => null;
			When Pas_Repertoire => Put("Erreur, ");
								   Put(chemin);
								   Put(" désigne un fichier");
								   New_Line;
			When Pas_Fichier => Put_Line("Erreur, vous essayer de déplacer un repertoire avec Mv");
	End Mv;

	--R1 Changer de repertoire
	Procedure Cd(chemin : String)is
		a : T_Darbre; 
	Begin
		--R2 Obtenir le repertoire indiqué par le chemin
		a := DetermineChemin(chemin,length(to_unbounded_string(chemin)));
		If a = null then
			raise Erreur_Chemin;
		Else
			If a.all.objet then
				--R3 Se Déplacer vers le repertoire trouvé
				arbre := a;
			Else
				raise Pas_Repertoire;
			End If;
		End If;
		Exception
			when Erreur_Chemin => null;
			When Pas_Repertoire => Put("Erreur, ");
								   Put(chemin);
								   Put(" désigne un fichier");
								   New_Line;
	End Cd;

	--R2 Copier un fils dans un autre repertoire
	Procedure CpR(copie : String; chemin : String)is
		ACopier : T_Darbre; --Arbre contenant l'arbre à copier
		DuChemin : T_Darbre; --Arbre contenant l'arbre du chemin
		Save : T_Darbre;

	Begin
		Save := arbre;
		--R3 Récupérer le fils
		ACopier := DetermineChemin(copie,length(to_unbounded_string(copie)));
		--R3 Récupérer le repertoire au bout du chemin
		DuChemin := DetermineChemin(chemin,length(to_unbounded_string(chemin)));
		--Si le fils n'existe pas
		if ACopier = null then
			raise Fils_Absent;
		Else
			If DuChemin = null then
				raise Erreur_Chemin;
			Else
				If DuChemin.all.objet then
				--R4 Copier dans le repertoire trouvé
					CopierCpr(chemin,ACopier);
					arbre := save;
				Else
					raise Pas_Repertoire;
				End If;
			End If;
		End if;
		Exception
			when Fils_Absent => null;
			when Erreur_Chemin => null;
			When Pas_Repertoire => Put("Erreur, ");
								   Put(chemin);
								   Put(" désigne un fichier");
								   New_Line;
	End CpR;


	--R1 Copier le contenue d'un arbre dans un arbre
	Procedure CopierCpr(chemin : String; copie : T_Darbre)is
	Begin
		--R2 Vérifier qu'après la copie la taille maximale ne sera pas atteinte
		If GetTailleRoot(arbre) + copie.all.taille < TAILLEMAX then
			--R2 Copier les objets
			--Si c'est un repertoire
			If copie.all.objet then
				cd(chemin);
				Mkdir(to_string(copie.all.nom));
				--R3 COpier les fils de celui-ci
				for i in 1..copie.all.nbFils Loop
					CopierCpr(to_string(copie.all.nom),copie.all.T_Fils(i));
				End Loop;
				--Remonter dans l'arborescence
				cd("../");
			--Si c'est un fichier
			Else
				cd(chemin);
				Touch(to_string(copie.all.nom));
				--Remonter dans l'arborescence
				cd("../");
			End if;
		Else
			raise Capacite_Max_Atteinte;
		End if;
		Exception
			When Capacite_Max_Atteinte => Put_Line("Attention capacité maximal atteinte, annulation de la commande précédente !");


	End CopierCpr;

	--Compresser un repertoire
	Procedure Tar(chemin : String)is
	Begin
		arbre := arbre;
	End Tar;

	--R1 Modifier la taille d'un objet
	Procedure Nano(chemin : String; taille : string)is
		fils : T_Darbre; --Le Fils qui va être modifié
		tai : integer; --La futur taille d'un fichier
	Begin
		tai := integer'value(taille);
		fils := DetermineChemin(chemin,length(to_unbounded_string(chemin)));
		--R2 Vérifier si ce n'est pas un repertoire
		If not fils.all.objet then
			--R3 Vérifier la taille par rapport à la taille maximale possible
			If GetTailleRoot(arbre) + tai-fils.all.taille < TAILLEMAX then
				If fils /= null then
					--R4 Changer la taille des pères
					AugmenterTaille(fils,tai-fils.all.taille);
					fils.all.taille := tai;
				Else	
					null;
				End if;
			Else
				Raise Capacite_Max_Atteinte;
			End if;
		Else
			raise Pas_Repertoire;
		End if;
		Exception
			When Capacite_Max_Atteinte => Put_Line("Attention, capacité maximale atteinte, annulation de la commande précédente.");
			When Pas_Repertoire => Put("Erreur, ");
								   Put(to_string(fils.all.nom));
								   Put(" désigne un fichier");
								   New_Line;
			When Constraint_Error => Put_Line("Erreur, Nano à besoin d'un entier, nano {nom du fichier} {Nouvelle Taille}");
	End Nano;

	--Afficher les père pour le chemin
	Procedure Pwd(a : T_Darbre)is
	Begin
		--R1 Parcourir les pères
		If a.all.T_Pere /= null then
			--R2 Afficher le père
			Pwd(a.all.T_Pere);
			--R2 Afficher le chemin
			Put("/");
			Put(to_string(a.all.nom));
		Else
			null;
		End if;
	End Pwd;

	--R1 Afficher la capacité restante 
	Procedure getCapacite is
		save : T_Darbre;
	Begin
		save := arbre;
		cd("/");
		Put("Capacité restante : ");
		Put(TAILLEMAX-arbre.all.taille,0);
		New_Line;
		arbre := save;
	End getCapacite;

	Procedure Prompt is
	Begin
		If arbre.all.T_Pere /= null then
			Pwd(arbre);
		Else
			Put("/");
		End if;
	End Prompt;
End sgf;