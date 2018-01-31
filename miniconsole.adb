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
	Type T_US is array (1..3) of Unbounded_String; --Type de tableau pour contenir les arguments
	T_Arguments : T_US; --Tableau contenant les arguments
	cpt : integer; --Indice pour le tableau de booléen
	TestTiret : boolean; --Booléen pour savoir si le test du tiret est passé


Begin
	--R2 Analyser la commande
	--R3 Initialisation des variables
	cpt := 1;
	TestTiret := false;
	Ainterpreter := commande(1..lcommande);
	--R3 Analyser mot par mot
	for i in 1..lcommande Loop
		--R4 Analyser chaque caractère
		--Erreur si trop d'argument
		If cpt>3 then
			Put_Line("Il y a trop d'argument");
		Else
			--On vérifie le tiret
			If Ainterpreter(i)='-' and cpt = 1 then
				TestTiret := false;
				T_Arguments(cpt) := T_Arguments(cpt) & Ainterpreter(i);
			--Si il y a un espace après le premier argument on regarde s'il y a un tiret
			Elsif  Ainterpreter(i)=' ' and cpt = 1 and not TestTiret then
				TestTiret:=true;
			--Si ce n'est pas un tiret,c 'est qu'il n'y en a pas on passe à l'argument suivant
			Elsif Ainterpreter(i)/='-' and cpt = 1 and TestTiret then
				cpt := cpt + 1;
				TestTiret:=false;
				T_Arguments(cpt):= T_Arguments(cpt) & Ainterpreter(i);
			Elsif Ainterpreter(i)=' 'then
				cpt := cpt +1;
			--Sinon on rajoute des caractères dans les arguments
	 		Else
	 			TestTiret:=false;
				T_Arguments(cpt) := T_Arguments(cpt) & Ainterpreter(i);
			End If;
		End If;
	End Loop;

	--R2 Executer la commande
	If T_Arguments(1) = "ls" then
		Ls;
	Elsif T_Arguments(1) = "pwd" then
		Pwd;
	Elsif T_Arguments(1) = "ls-r" then
		LsR;
	Elsif T_Arguments(1) = "touch" then
		Touch(to_string(T_Arguments(2)));
	Elsif T_Arguments(1) = "mkdir" then
		Mkdir(to_string(T_Arguments(2)));
	Elsif T_Arguments(1) = "rm" then
		Rm(to_string(T_Arguments(2)));
	Elsif T_Arguments(1) = "rm-r" then
		RmR(to_string(T_Arguments(2)));
	Elsif T_Arguments(1) = "mv" then
		Mv(to_string(T_Arguments(2)),to_string(T_Arguments(3)));
	Elsif T_Arguments(1) = "cd" then
		Cd(to_string(T_Arguments(2)));
	Elsif T_Arguments(1) = "cp-r" then
		CpR(to_string(T_Arguments(2)),to_string(T_Arguments(3))); 
	Else
		Put_Line("Commande inexistante !");
	End If;
End InterpreteurCommande;
End miniconsole;