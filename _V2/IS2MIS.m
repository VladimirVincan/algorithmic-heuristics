function newIS = IS2MIS (currIS,ADM)
% funkcija dopunjava independent set do maximal independent seta
% 	 potencijalni cvorovi se dodaju na pseudoslucajan nacin (nije greedy)
% PARAMETRI:
%   currIS - independent set
% POVRATNA VREDNOST
%   newIS - novi maximal independent set

    %ako se ne ne moze prosiriti vrati stari
    newIS=currIS;
    
    % pozivamo funkciju i dobijamo niz 1xn (n=br.cvorova grafa) gdje ce '0'
    % biti na indeksima cvorova pripadnika IS-a kao i na indeksima
    % potencijalnih novih clanova za dodavanje u IS
    potNodes = numOfAdjNodesIS(currIS,ADM);
    
    % na mesta trenutnih pripadnika IS-a stavljamo (-1) tako da ce nakon ove
    % linije nule biti samo na mestima cvorova koji se mogu ubaciti u IS (potencijalni novi clanovi)
    potNodes(currIS) = -1;
    
    % uzimamo listu indeksa potencijalnih clanova za dodavanje u IS
    potNodes = find(potNodes == 0);
    
    % izmesaj ih kako se u koraku koji sledi ne bi  
    % uvek dodavali cvorovi istim redosledom (prema rednom broju) 
    potNodes=potNodes(randperm(length(potNodes)));
    

    % ukoliko ima potencijalnih cvorova za dodavanje u IS
	 % na trenutni IS dodajemo prvi iz prethodne liste 
    if(~isempty(potNodes)) 
        newIS = sort([currIS , potNodes(1)]);
    end 

	 % ukoliko ima vise potencijalnih clanova rekurzivno pozvati funkciju
	 % sa novim IS-om kako bi se na taj nacin doslo do MIS-a
    if(length(potNodes)>1)
        newIS = IS2MIS(newIS,ADM);
    end
end
