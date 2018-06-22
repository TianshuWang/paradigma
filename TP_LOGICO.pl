persona(juan).
persona(ana).
persona(claudia).
persona(pedro).
mensaje(juan, ana, hola).
mensaje(juan, claudia, notequieromas).
contacto(juan, ana).
contacto(juan, claudia).
contacto(juan, pedro).
incomodidad(hola,1).
incomodidad(notequieromas,10).
--------------------------------------------------------
sonAmigos(P1,P2):-
  enContactos(P1,P2),
  mandaMensaje(P1,P2).
  
enContactos(P1,P2):-contacto(P1,P2).
enContactos(P2,P1):-contacto(P1,P2).

mandaMensaje(P1,P2):-mensaje(P1,P2,_).
mandaMensaje(P1,P2):-mensaje(P2,P1,_).
---------------------------------------------------------
mandaMensajeInesperado(Emisor,Persona):-
  persona(Emisor),
  not(enContactos(Emisor,Persona)),
  Emisor \= Persona.
----------------------------------------------------------
recibioMensajeIncomodo(Persona):-
  mensaje(_,Persona,Mensaje),
  esIncomodo(Mensaje). 
  
esIncomodo(Mensaje):-
 incomodidad(Mensaje,Nota),
 Nota > 7.
---------------------------------------------------------
esMolesto(Persona):-
  mensaje(Persona,_,_),
  not(recibioMensaje(Persona)).

recibioMensaje(Persona):-
  mensaje(_,Persona,_).
---------------------------------------------------------
mensajeMasIncomodo(Persona,Mensaje):-
  mensaje(Persona,_,Mensaje),
  esMensajePeorQue(Mensaje,_).

esMensajePeorQue(M1,M2):-
  incomodidad(M1,Nota1),
  incomodidad(M2,Nota2),
  Nota1 > Nota2.
---------------------------------------------------------
esMolesta(Persona):-
  mensajeMasIncomodo(Persona,_),
  esMolesto(Persona).


