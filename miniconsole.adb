Package Body miniconsole is

Procedure Main is

	commande : String(1..1000); --String pour stocker la commande
	estFini : boolean; --Booléen de fin de boucle
	lcommande : integer; --Longueur de la commande
Begin
	Put_Line("Bienvenue dans le sgf, utilisez '?' ou 'help' pour obtenir la liste des commandes.");
	estFini := false;
	Format;
	While not estFini Loop
		Put(">>");
		get_line(commande,lcommande);
		If commande = "quit" then
			estFini := true;
		Else
			InterpreteurCommande(commande,lcommande);
			estFini := false;
		End If;
	End Loop;
	Put_Line("Au revoir !");
End Main;

--R1 Interpreter une commande
Procedure InterpreteurCommande(commande: String;lcommande: integer )is
	Ainterpreter : String(1..lcommande); --La commande à interpreter
	LaCommande : Unbounded_String; --La commande de base à executer	
	LeChemin : Unbounded_String;  --Le chemin désigné par la commande
	LObjet : Unbounded_String; --L'objet que la commande va manipuler
	Type T_Valide is array (1..3) of boolean; --Tableau 
	cpt : integer; --Indice pour le tableau de booléen
	T_Bool : T_Valide;


Begin
	--R2 Analyser la commande
	T_Bool(1) := false;
	T_Bool(2) := false;
	T_Bool(3) := false;
	cpt := 1;
	Ainterpreter := commande(1..lcommande);
	for i in 1..lcommande Loop
		If Ainterpreter(i)=' ' and cpt /= 1 then
			T_Bool(cpt) := true;
			cpt := cpt+1;
		Else
			If Ainterpreter(i)='-'and not T_Bool(1)then
				LaCommande := LaCommande & Ainterpreter(i);
			Else
				If not T_Bool(1) then
					LaCommande := LaCommande & Ainterpreter(i);
				Else
					If not T_Bool(2) then
						LObjet := LObjet & Ainterpreter(i);
					Else
						If not T_Bool(3) then
							LeChemin := LeChemin & Ainterpreter(i);
						Else
							T_Bool(cpt):= true;
							cpt := cpt + 1;
						End If;
					End if;
				End If;
			End If;
		End If;
	End Loop;

	--R2 Executer la commande
	If LaCommande = "ls" then
		Ls;
	Elsif LaCommande = "pwd" then
		Pwd;
	Elsif LaCommande = "ls -r" then
		LsR;
	Else
		Put_Line("Commande inexistante !");
	End If;
End InterpreteurCommande;
End miniconsole;