Package body sgf is 

	--Création d'un SGF ne contenant que le dossier racine
	Function Format return T_Darbre is
		a : T_Darbre;
	Begin
		a := new T_Noeud;
		a.all.taille := 0;
		a.all.nom :="/";
		a.all.nbFils := 0;
		a.all.EstRepertoire := true;
		a.all.T_Fils := null;
		a.all.T_Pere := null;
		return a;
	End Format;

	--Affichage du chemin courant
	Procedure Pwd(arbre : IN T_Darbre)is
	Begin
		--R1 Parcourir les pères
		If arbre.all.T_Pere /= null then
			--R2 Afficher le père
			Pwd(arbre.all.T_Pere);
			--R2 Afficher le chemin
			Put(arbre.all.nom);
			Put("/");
		Else
			Put(arbre.all.nom);
		End if;
	End Pwd;

	--Afficher les dossier et fichier du repertoire courant
	Procedure Ls(arbre : IN T_Darbre)is
	Begin
		For i in 1..nbFils Loop
			Put(arbre.all.T_Fils(i).all.nom);
			Put(" ");
		End Loop;
		New_Line;
	End Ls;
End sgf;