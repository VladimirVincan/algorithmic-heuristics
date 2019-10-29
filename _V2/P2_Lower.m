function newMIS = P2_Lower (currMIS,ADM) 
% funkcija uradi potez P2, u kojem se vise cvorova pripadnika trenutnog
%   MIS-a preseli u jedan cvor, efektivno smanjujuci kardinalnost MIS-a
% PARAMETRI:
%   currMIS - trenutni MIS (maximal independet set)
%   ADM - matrica susedstva grafa (adjecency matrix)
% POVRATNA VREDNOST:
%   newMIS - novi MIS (maximal independet set)
    
	 % ukoliko se pronadje cvor koji ima n>1 suseda
	 % pripadnika trenutnog MIS-a, ti cvorovi se mogu preseliti
	 % u potencijalni, cime se n cvorova seli u samo jedan
	 % ukoliko ima vise ovakvih cvorova jedan se bira nasumicno
    potNodes = numOfAdjNodesIS(currMIS,ADM);
    potNodes(currMIS) = -1;
    randNodes = find(potNodes>1);
    if(~isempty(randNodes) && (length(currMIS)>1))
        randNodes=randNodes(randperm(length(randNodes)));
        new_node = randNodes(1);
        chosenIndexes=(ADM(currMIS,new_node)==1)';
        chosen_ones = currMIS(chosenIndexes);
        
        % izbaci cvorove 'chosen_ones'
        newMIS=currMIS;
        idx=ismember(currMIS,chosen_ones);
        newMIS(idx)=[];
        
        % dodaje se novi cvor 'new node'
        % ovime su 'chosen ones' preseljeni u 
		  % jedan cvor 'new node'
		  newMIS = sort([newMIS,new_node]);

        %dopuni do MIS-a
        newMIS = IS2MIS(newMIS,ADM);
    else
		  % ukoliko nema potencijalnih cvorova vrati 
		  % prethodni MIS
        newMIS=currMIS;
    end
end
