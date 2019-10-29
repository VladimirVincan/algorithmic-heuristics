%Cilj: naci MIS (maximal independent set) sto vece kardinalnosti
disp('Pokrenuti nad:');
disp('0 -> test matricom (unetom ru?no u kodu ispod):');
disp('1 -> benchmark grafovima');
b = input('# ');
if(b)
    disp('Uneti velicinu grafa: 30|35|40|45');
    gsize = input('# ');
    disp('Uneti redni broj primera: 1|2|3|4|5');
    eg = input('# ');
    %benchmark graf koju vuce iz fajla
    X = mis2matrix(gsize,eg);
else
    %test matrica (sa casa, videti sliku testgraf.png) izmeniti po volji, 
    %mora biti simetricna
    X  =    [ 0 1 1 0 0 0 0 0 ;
             1 0 1 1 0 0 0 0 ;
             1 1 0 1 1 0 0 0 ;
             0 1 1 0 0 1 0 0 ;
             0 0 1 0 0 1 1 0 ;
             0 0 0 1 1 0 1 1 ;
             0 0 0 0 1 1 0 1 ;
             0 0 0 0 0 1 1 0 ];
end

disp('Uneti koliko puta zelite pokrenuti algoritam');
disp('Pri pokretanju vise puta ce se sacuvati najbolji rezultat');
nrepeats = input('# ');

maxxIS=[];% najbolje resenje pri pokretanju algoritma vise puta
numSteps=10000;% broj koraka koje ce algoritam odraditi pre nego sto stane


%for petlja za pokretanje programa vise puta kako bi se dobila razlicita resenja 
%zbog randomizovanog pocetnog stanja sistema
for k=1:nrepeats
    
    maxIS=[];% najbolje resenje u ovoj instanci problema
    % kako bi se dobilo pocetno stanje se prvo na nasumican nacin uzme
    % jedan od cvorova iz grafa, a zatim se dopuni do 
    % maximal independent seta pozivom funkcije IS2MIS

    z=randperm(length(X));
    currIS = z(1);
    currIS = IS2MIS(currIS,X);
    
    %Glavni dio programa - kretanje kroz prostor resenja
    % u 90% koraka se poziva funkcija P1_SameOrHigher
    % u 10% koraka se poziva funkcija P2_Lower
    for i=1:numSteps
        if(rand(1)>0.1)
            currIS=P1_SameOrHigher(currIS,X);
        else
            currIS=P2_Lower(currIS,X);
        end
        % ukoliko se u trenutnom maximal independent skupu 'currIS' nalazi 
        % vise cvorova nego u do sada najboljem 'maxIS', 
        % 'currIS' postaje novi najbolji
        if(length(currIS) > length(maxIS))
            maxIS=currIS;
        end
    end
    %Kraj iterovanja kroz korake P1 i P2
    
    % Pri pokretanju prethodnog programa vise puta, ovde se proverava da li
    % je najoblje resenje trenutne iteracije bolje od globalno najboljeg
    % resenja 'maxxIS'
    if(length(maxIS) > length(maxxIS))
        maxxIS=maxIS;
    end
    
    numM=numel(maxIS);
    numX=numel(maxxIS);
    fprintf('Kardinalnost MIS-a u %d iteraciji je %d\tMaksimalni je: %d\n',k,numM,numX);
end



% ukoliko se u matrica susedstva cvorova indeksira pomocu cvorova iz MIS-a
% nova matrica mora biti prazna jer ne sme postojati grana medju
% cvorovima iz MIS-a
EmptyX = X(maxxIS,maxxIS);  

% proveravamo da li su cvorovi MIS ako je ta nova matrica zaista prazna
if(~sum(sum(EmptyX,1),2))
    disp('maxIS JESTE maximal independent set');
else
    disp('maxIS NIJE maximal independent set');
end

%sacuvaj najbolju matricu
save('MISave.mat','maxxIS');

