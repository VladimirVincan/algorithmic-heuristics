 function newMIS = P1_SameOrHigher (currMIS,ADM)
% funkcija uradi potez P1, u kojem se jedan cvor pripadnika MIS-a
% 	 seli u jedan ili vise susednih cvorova, pa ce se stoga
%	 kardinalnost MIS-a povecati ili ostati ista
% PARAMETRI: 
%   currMIS - trenutni MIS (maximal independent set) 
%   ADM - matrica susedstva cvorova grafa (adjecency matrix)
% POVRATNA VREDNOST:
%   newMIS - novi MIS (maximal independent set)
  
	 % novom se dodeljuje trenutna vrednost
    newMIS=currMIS;

	 % pronalaze se potencijalni cvorovi 
	 % (oni koji imaju samo jednog suseda pripadnika MIS-a)
	 % dakle za njih ce povratna vrednost funkcije numOfAdjNodesIS
	 % biti jednaka jedinici
    potNodes = numOfAdjNodesIS(currMIS,ADM);
    potNodes(currMIS) = -1;
    randNodes = find(potNodes==1);

	 
	 % na nasumican nacin se bira jedan od potencijalnih cvorova
	 % ovaj cvor ima samo jednog suseda pripadnika MIS-a kao i svi potencijalni cvorovi
	 % u promenljivu chosen_one se smesta taj jedan sused (pripadnik trenutnog MIS-a)
    if (~isempty(randNodes))
        randNodes=randNodes(randperm(length(randNodes)));
        chosenIndex=(ADM(currMIS,randNodes(1))==1)';
        chosen_one = currMIS(chosenIndex);

        % izabrani pripadnik trenutnog MIS-a trazi sve susede u koje se moze
		  % razgranati a da skup ostane IS
        neigh_nodes = find(ADM(chosen_one,:).*potNodes==1);

        % posalji funkciji IS2MIS matricu susedstva svih potencijalnih cvorova 
		  % da vidi koliko je njih medjusobno nezavisno, tj u koliko se cvorova 
		  % cvor 'chosen_one' moze razgranati 
        new_nodes=neigh_nodes(IS2MIS([],ADM(neigh_nodes,neigh_nodes)));

        % izbacuje cvor 'chosen_one' iz MIS-a
        newMIS= currMIS(currMIS~=chosen_one);

        % dodaju se novi cvorovi umesto prethodnog
		  % cime se cvor 'chosen one' razgrana u okolne
        newMIS = sort([newMIS,new_nodes]);

        % dopuni trenutni skup do MIS-a ako je moguce
        newMIS = IS2MIS(newMIS,ADM);
    end
end
