function ADM = mis2matrix(graph_size,graph_eg)
% funkcija pretvara *.mis fajl u matricu susedstva ?vorova
% PARAMETRI:
%   graph_size - velicina grafa
%       30 - broj cvorova =450, broj grana ~83200, maksimalni pronadjen MIS =30
%       35 - broj cvorova =595, broj grana ~148700, maksimalni pronadjen MIS =35
%       40 - broj cvorova =760, broj grana ~247000, maksimalni pronadjen MIS =40
%       45 - broj cvorova =945, broj grana ~387500, maksimalni pronadjen MIS =45
%   graph_eg - primer grafa, za svaki od datih veli?ina ima 5 primera (1-5)
% POVRATNA VREDNOST:
%   ADM - matrica susedstva cvorova za dati graf

%sajt sa koga su skinuti primeri:
%http://iridia.ulb.ac.be/~fmascia/maximum_clique/BHOSLIB-benchmark
    
    %na osnovu parametara otvori odgovaraju?i fajl
    path_to_graph=strcat('BenchGraph/frb-',num2str(graph_size),'-mis'); 
    addpath(path_to_graph)
    fid = fopen(strcat('frb-',num2str(graph_size),'-',num2str(graph_eg),'.mis'),'r');
    
    %iz prve linije fajla se izvu?e broj cvorova i grana i smesti u matricu
    %vertex_edge=[br_cvorova, br_grana]
    tline = fgetl(fid);
    vertex_edge = str2num(tline(1,7:length(tline)));

    %na osnovu izvu?enog broja cvorova 
    %inicijalizujemo matricu susedstva ?vorova
    ADM = zeros(vertex_edge(1),vertex_edge(1));
    
    %prolazimo kroz fajl gde svaka linija predstavlja jednu granu
    %datu preko brojeva ?vorova izmedju kojih se nalazi 
    while ~feof(fid)
        tline = fgetl(fid);
        edge = str2num(tline(1, 3:length(tline)));
        %kada znamo redne brojeve ?vorova, možemo na odgovaraju?e mesto
        %u matrici susedstva ?vorova upisati jedinicu
        ADM(edge(1),edge(2)) = 1; 
    end
    %sada imamo matricu sa vrednostima samo iznad glavne dijagonale
    %iz razloga što smo unosili samo grane cvor1-cvor2, a ne i cvor2-cvor1,
    %kako bi je upotpunili transliranu sabiramo sa originalnom
    ADM=ADM+ADM';
end