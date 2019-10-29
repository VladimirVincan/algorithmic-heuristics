function expNodes = numOfAdjNodesIS (currIS,ADM)
% funkcija za svaki cvor vrati broj suseda koji pripadaju trenutnom IS-u
%	 cvorovi koji budu imali vrednost nula su ili vec pripadnici IS-a ili 
%   potencijalni novi cvorovi koji se mogu ukljuciti u IS
% PARAMETRI: 
%   currIS - trenutni IS (independent set)
%   ADM - matrica susedstva cvorova grafa (adjecency matrix)
% POVRATNA VREDNOST:
%   expNodes - vektor koji za svaki cvor grafa ima pridruzen broj 
%					koji govori koliko suseda toga cvora su u trenutnom IS-u
    
    % Uzimamo samo redove matrice koji odgovaraju clanovima IS-a zato 
    % sto trebamo izracunati za svaki cvor (kolonu) koliko ima suseda
    % pripadnika IS-a
    ADM=ADM(currIS,:);
    
    % Sumiramo kolone i dobijamo red 1xn (n=br.cvorova) gdje broj u matrici  
    % predstavlja broj suseda pripadnika IS-a. Cvorovi pripadnici IS-a ce imati 
    % broj 0 buduci da u IS-u nije dozvoljeno da dva pripadnika IS-a budu susedi.
    % Ukoliko se radi o MIS-u nule ce imati samo cvorovi pripadnici MIS-a,
    % dok ukoliko se radi o IS-u nule ce imati i 'exposed' cvorovi koji su
    % potencijalni clanovi za dodavanje IS-u (nemaju suseda iz IS-a, dakle mogu se dodati)
    expNodes = sum(ADM,1);
end

