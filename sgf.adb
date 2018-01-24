Package body sgf is 
	Pas_Repertoire,Pere_Absent,Fils_Absent,Erreur_Root,Erreur_Chemin : Exception;
	--R1 Creer le SGF
	Function Format return T_Darbre is
		a : T_Darbre;
	Begin
		a := CreerArbre;
		--R2 Créer l'aborescence
		CreerNoeud(a,"/",true);
		CreerFils(a,"temp",true);
		CreerFils(a,"etc",true);
		CreerFils(a,"opt",true);
		CreerFils(a,"bin",true);
		return a;
	End Format;

	--R1 Afficher le chemin courant
	Procedure Pwd(arbre : IN T_Darbre)is
	Begin
		--R1 Parcourir les pères
		If arbre.all.T_Pere /= null then
			--R2 Afficher le père
			Pwd(arbre.all.T_Pere);
			--R2 Afficher le chemin
			Put("/");
			Put(to_string(arbre.all.nom));
		Else
			Put(to_string(arbre.all.nom));
		End if;
	End Pwd;

	--R1 Afficher les dossier et fichier du repertoire courant
	Procedure Ls(arbre : IN T_Darbre)is
	Begin
		--R2 Parcourir les fils
		For i in 1..arbre.all.nbFils Loop
			--R3 Afficher les fils
			Put_Line(to_string(arbre.all.T_Fils(i).all.nom));
		End Loop;
		New_Line;
	End Ls;

	--R1 Affiche le contenu du repertoire courant et de ses sous repertoire
	Procedure LsR(arbre : IN T_Darbre)is
	Begin
		AfficheFils(arbre);
	End LsR;

	--R1 Creer un fichier
	Procedure Touch(arbre : IN OUT T_Darbre; nom : String)is
	Begin
		CreerFils(arbre, nom, false);
	End Touch;

	--R1 Creer un repertoire
	Procedure Mkdir(arbre : IN OUT T_Darbre; nom : String)is
	Begin
		CreerFils(arbre, nom, true);
	End Mkdir;

	--R1 Suppression d'un fichier
	Procedure Rm(arbre : IN OUT T_Darbre; nom : String)is
		i: integer;
	Begin
		--R2 Regarder si c'est un fichier
		i := RechercheIndiceFils(arbre,nom);
		if not arbre.all.T_Fils(i).all.objet then
			--R3 Supprimer le fichier
			SupprFils(arbre,nom);
		Else
			Put_Line("Ce n'est pas un fichier essayez rm -r");
		End If;
	End Rm;

	--R1 Supprimer un répertoire
	Procedure RmR(arbre : IN OUT T_Darbre; nom : String)is
		i : integer; --Indice du fils
	Begin
		--R2 Regarder si c'est un repertoire
		i := RechercheIndiceFils(arbre,nom);
		if arbre.all.T_Fils(i).all.objet then
			--R3 Supprimer le repertoire
			SupprFils(arbre,nom);
		Else
			Put_Line("Ce n'est pas un fichier essayez rm");
		End If;
	End RmR;

	--R1 Donner l'arbre à partir d'un chemin
	Function DetermineChemin(arbre : T_Darbre; chemin : String; lchemin : integer)return T_Darbre is
		final : T_Darbre;
		EnTraitement : unbounded_string;
		nbEnTraitement : integer;
		i : integer;
		ChaineChemin : String(1..lchemin); --String pour fixer la taille du stirng chemin
	Begin
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
			If ChaineChemin(i) = '/' then
				nbEnTraitement := 0;
				EnTraitement := Null_Unbounded_String;
				--R4 Determiner le pointeur qui y est attaché
				If to_String(EnTraitement) = ".." then
					final := RecherchePere(final);
					If final = null then
						raise Pere_Absent;
					Else
						null;
					End if;
				Else
					If to_string(EnTraitement)= "." then
						final := final;
					Else
						If to_string(EnTraitement) = "" then
							raise Erreur_Root;
						Else 
							final := RechercheFils(final,to_string(EnTraitement));
							If final = null then
								raise Fils_Absent;
							Else
								null;
							End If;
						End If;
					End If;
				End If;
			Else 
				nbEnTraitement := nbEnTraitement + 1;
				Replace_Element(EnTraitement,nbEnTraitement,ChaineChemin(i));
			End If;
			i := i+1;
		End Loop;
		return final;
		Exception
			When Erreur_Root => Put_Line("Erreur, vous ne pouvez pas avoir de // dans un chemin");
							    return null;
			When Fils_Absent => Put_Line("Erreur, Un Fichier ou Repertoire du chemin n'existe pas");
								return null;
			When Pere_Absent => Put_Line("Erreur, Un ../ ne marche pas car le repertoire n'a pas de pere");
								return null;
	End DetermineChemin;

	--R1 Deplacer un fichier ou renommer
	Procedure Mv(arbre : IN OUT T_Darbre; nom : String; chemin : String)is
		ADeplacer : T_Darbre; --Arbre contenant le fils à déplacer
		DuChemin  : T_Darbre; --Arbre contenant le futur pere
	Begin
		--R2 Recuperer le fils
		ADeplacer := RechercheFils(arbre,nom);
		--R2 Recuperer le futur pere
		DuChemin := DetermineChemin(arbre,chemin,length(to_unbounded_string(chemin)));
		if ADeplacer = null then
			raise Fils_Absent;
		Else
			If DuChemin = null then
				raise Erreur_Chemin;
			Else
				If DuChemin.all.objet then
						--R3 Changer le fils de pere
						ChangePere(ADeplacer,DuChemin);
						arbre := ADeplacer;
				Else
					raise Pas_Repertoire;
				End If;
			End If;
		End If;
		Exception
			when Fils_Absent => null;
			When Erreur_Chemin => null;
			When Pas_Repertoire => Put_Line("Le chemin ne désigne pas un repertoire");
	End Mv;

	--R1 Changer de repertoire
	Procedure Cd(arbre : IN OUT T_Darbre; chemin : String)is
		a : T_Darbre; 
	Begin
		--R2 Obtenir le repertoire indiqué par le chemin
		a := DetermineChemin(arbre,chemin,length(to_unbounded_string(chemin)));
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
			when Pas_Repertoire => Put_Line("Le chemin ne désigne pas un repertoire");
	End Cd;

	--R2 Copier un fils dans un autre repertoire
	Procedure CpR(arbre : IN OUT T_Darbre; nom : String; chemin : String)is
		ACopier : T_Darbre; --Arbre contenant l'arbre à copier
		DuChemin : T_Darbre; --Arbre contenant l'arbre du chemin

	Begin
		--R3 Récupérer le fils
		ACopier := RechercheFils(arbre,nom);
		--R3 Récupérer le repertoire au bout du chemin
		DuChemin := DetermineChemin(arbre,nom,length(to_unbounded_string(chemin)));
		if ACopier = null then
			raise Fils_Absent;
		Else
			If DuChemin = null then
				raise Erreur_Chemin;
			Else
				If DuChemin.all.objet then
				--R4 Copier dans le repertoire trouvé
					AjoutFils(DuChemin,ACopier);
					arbre := DuChemin;
				Else
					raise Pas_Repertoire;
				End If;
			End If;
		End if;
		Exception
			when Fils_Absent => null;
			when Erreur_Chemin => null;
			when Pas_Repertoire => Put_Line("Le chemin ne désigne pas un repertoire");
	End CpR;

	--Compresser un repertoire
	Procedure Tar(arbre : IN OUT T_Darbre; chemin : String)is
	Begin
		arbre := arbre;
	End Tar;

	--Modifirt un objet
	Procedure Nano(arbre : IN OUT T_Darbre; nom : String)is
	Begin
		arbre := arbre;
	End Nano;
End sgf;