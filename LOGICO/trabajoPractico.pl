persona(juan).
persona(nico).
persona(maiu).
persona(gaston).
persona(alf).

serie(himym).
serie(futurama).
serie(got).
serie(madMen).
serie(starWars).
serie(onePiece).
serie(hoc).
serie(drHouse).

miraSerie(juan,himym).
miraSerie(juan,futurama).
miraSerie(juan,got).
miraSerie(nico,starWars).
miraSerie(maiu,starWars).
miraSerie(maiu,onePiece).
miraSerie(maiu,got).
miraSerie(nico,got).
miraSerie(gaston,hoc).
miraSerie(pedro,got).

%nadiemiraMadMen 
%alfnoveNada

seriePopular(got).
seriePopular(hoc).
seriePopular(starWars).

quiereVer(juan,hoc).
quiereVer(aye,got).
quiereVer(gaston,himym).
quiereVer(aye,got).

%epXtempo(Serie,Episodio,Temporada)
epXtempo(got,12,3).
epXtempo(got,10,2).
epXtempo(himym,23,1).
epXtempo(himym,_,4).
epXtempo(drHouse,16,8).
epXtempo(madMen,_,2).
epXtempo(futurama,_,2).

%paso(Serie, Temporada, Episodio, Lo que paso)
paso(futurama, 2, 3, muerte(seymourDiera)).
paso(starWars, 10, 9, muerte(emperor)).
paso(starWars, 1, 2, relacion(parentesco, anakin, rey)).
paso(starWars, 3, 2, relacion(parentesco, vader, luke)).
paso(himym, 1, 1, relacion(amorosa, ted, robin)).
paso(himym, 4, 3, relacion(amorosa, swarley, robin)).
paso(got, 4, 5, relacion(amistad, tyrion, dragon)).

paso(got,3,2,plotTwists([suenio,sinPiernas])).
paso(got,3,12,plotTwists([fuego,boda])).
paso(supercampeones,9,9,plotTwists([suenio,sinPiernas])).
paso(doctorhouse,8,7,plotTwists([coma,pastillas])).

%leDijo(Persona1,Persona2,Serie, Lo que paso)
leDijo(gaston, maiu, got, relacion(amistad, tyrion, dragon)).
leDijo(nico, maiu, starWars, relacion(parentesco, vader, luke)).
leDijo(nico, juan, got, muerte(tyrion)). 
leDijo(aye, juan, got, relacion(amistad, tyrion, john)).
leDijo(aye, maiu, got, relacion(amistad, tyrion, john)).
leDijo(aye, gaston, got, relacion(amistad, tyrion, dragon)).
leDijo(nico,juan,futurama,muerte(seymourDiera)).
leDijo(pedro,aye,got,relacion(amistad, tyrion, dragon)).
leDijo(pedro,nico,got,relacion(parentesco, tyrion, dragon)).


%Punto3B
esSpoiler(Serie,Spoiler):- 
	paso(Serie, _, _, Spoiler).

% Tipos existenciales o individuales,
% Individuales: Aquellas en las que queremos determinar si una relación se satisface o no, detallando todos los argumentos: Esto se verifica (true) o no (false). Ejemplo:  esSpoiler(starWars,relacion(parentesco, anakin, rey)). 
% Existenciales: Las consultas existenciales permiten conocer los individuos que satisfacen una relación, en ese caso alguno de los argumentos debe estar libre.  Ejemplo: esSpoiler(Serie,Spoiler).

%Punto4C
leSpoileo(Persona1,Persona2,Serie):- 
	leDijo(Persona1,Persona2,Serie,Algo),
	esSpoiler(Serie,Algo),
	miraoplaneaverserie(Persona2,Serie).

	
 % Tipos existenciales o individuales,
	% Individuales: Aquellas en las que queremos determinar si una relación se satisface o no, detallando todos los argumentos: Esto se verifica (true) o no (false). Ejemplo:  leSpoileo(gaston,maiu,got). 
	% Existenciales: Las consultas existenciales permiten conocer los individuos que satisfacen una relación, en ese caso alguno de los argumentos debe estar libre.  Ejemplo: leSpoileo(Persona1,Persona2,Serie).
				
%Punto5D
televidenteResponsable(Persona):-
	persona(Persona),
	not(leSpoileo(Persona,_,_)).

%Punto6E
miraoplaneaverserie(Persona,Serie):- 
	miraSerie(Persona,Serie).
miraoplaneaverserie(Persona,Serie):- 
	quiereVer(Persona,Serie).
espopularopasoalgofuertetodastemporadas(Serie):- 
	seriePopular(Serie).
espopularopasoalgofuertetodastemporadas(Serie):- 	
	pasoAlgoFuerteTodasTemporadas(Serie).

vieneZafando(Persona,Serie):-
	espopularopasoalgofuertetodastemporadas(Serie),
	miraoplaneaverserie(Persona,Serie),
	not(leSpoileo(_,Persona,Serie)).

pasoAlgoFuerte(Serie,Temporada):-
	paso(Serie,Temporada,_,Algo), 
	esFuerte(Algo).

esFuerte(muerte(_)).
esFuerte(relacion(amorosa,_,_)).
esFuerte(relacion(parentesco,_,_)).

pasoAlgoFuerteTodasTemporadas(Serie):-
	epXtempo(Serie,_,_),
	forall(epXtempo(Serie,_,Temporada),pasoAlgoFuerte(Serie,Temporada)).
	

	

%Segunda Entrega

%Punto1A
malaGente(Persona):-
	forall(leDijo(Persona,_,Serie,_),leSpoileo(Persona,_,Serie)),
	persona(Persona).

malaGente(Persona):- 
	persona(Persona),
	leSpoileo(Persona,_,Serie),
	not(miraSerie(Persona,Serie)).


%Punto2B	
fuerte(plotTwists(Palabra),Serie):-	
	paso(Serie,Temporada,Episodio,(plotTwists(Palabra))),
	not(esCliche(plotTwists(Palabra))),
	epXtempo(Serie,Episodio,Temporada).
	
fuerte(Algo,Serie):-
	paso(Serie,_,_,Algo),
	esFuerte(Algo).

/*
esCliche(plotTwists(Palabra)):-	
	cantidad(Serie,paso(Serie,_,_,plotTwists(Palabra)),Cant),
	Cant > 1.	Solucion anterior*/
esCliche(plotTwists([Palabra | Resto])):-
	estaEnOtrasSeries(Palabra),
	esCliche(plotTwists(Resto)).

esCliche(plotTwists([Palabra])):-
	estaEnOtrasSeries(Palabra).

estaEnOtrasSeries(Palabra):-
	paso(Serie1,_,_,plotTwists(ListaPalabras1)),
	paso(Serie2,_,_,plotTwists(ListaPalabras2)),
	member(Palabra,ListaPalabras1),
	member(Palabra,ListaPalabras2),
	Serie1 \= Serie2.

/* Otra Alternativa, esta bien?
esCliche(plotTwists(ListaPalabras)):-
	paso(_,_,_,plotTwists(ListaPalabras)),
	forall(palabrasDeUnGiro(plotTwists(ListaPalabras),Palabra),estaOtraSerie(Palabra)).

estaOtraSerie(Palabra):-
	paso(Serie1,_,_,plotTwists(Lista1)),
	paso(Serie2,_,_,plotTwists(Lista2)),
	member(Palabra,Lista1),
	member(Palabra,Lista2),
	Serie1 \= Serie2 .

palabrasDeUnGiro(plotTwists(ListaPalabras),Palabra):-
	paso(_,_,_,plotTwists(ListaPalabras)),
	member(Palabra,ListaPalabras).
*/
	
%Punto3C 
popular(hoc).
popular(Serie):-
	serie(Serie),
	popularidad(Serie,Popularidad1),
	popularidad(starWars,Popularidad2),
	Popularidad1 >= Popularidad2.

popularidad(Serie,Popularidad):-
	cantidad(Serie,miraSerie(_,Serie),CantMira),
	cantidad(Serie,leDijo(_,_,Serie,_),CantConver),
	Popularidad is CantMira * CantConver.

cantidad(Serie,Criterio,Cant):-
	findall(Serie,Criterio,Lista),
	length(Lista,Cant).

%Punto4D	
amigo(nico, maiu).
amigo(maiu, gaston).
amigo(maiu, juan).
amigo(juan, aye).

noSonLaMismaPersona(P1,P2):- P1 \= P2.
fullSpoil(P1,P2):-
	leSpoileo(P1,P2,_),
	noSonLaMismaPersona(P1, P2).

fullSpoil(P1,P2):-
	amigo(P3,P2),
	fullSpoil(P1,P3),
	noSonLaMismaPersona(P1, P3).

	

	
	
	
