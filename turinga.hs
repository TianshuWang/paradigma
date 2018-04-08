anioIngreso::String->Int
anioIngreso "george" = 2018
anioIngreso "sexy99" = 2017
anioIngreso "boca_cabj" = 2010
anioIngreso "jroman" = 2014
anioIngreso "turing" = 2005
anioIngreso "Tur1ng" = 2018

antiguedad::String->Int
antiguedad nombre = 2018 - (anioIngreso nombre)

puntosBase::String->Int
puntosBase nombre = (length nombre) * (antiguedad nombre)

nivel::String->String
nivel nombre 
 |(antiguedad nombre)<1 = "newbie"
 |(puntosBase nombre)<50 = "intermedio"
 |nombre == "turing" = "avanzado"
 |otherwise = "avanzado"

puedeOtorgar::String->Int->Bool
puedeOtorgar nombre punto
 |nombre == "admin" = False
 |nivel nombre == "newbie" && punto <=1 = True
 |nivel nombre == "intermedio" && punto <=5 = True
 |nivel nombre == "avanzado" && punto <=10 = True
 |otherwise = False

tieneMasPuntos::String->String->String
tieneMasPuntos nombre1 nombre2
 |(puntosBase nombre1) > (puntosBase nombre2) = nombre1
 |otherwise = nombre2

puntosDelMasGroso::String->String->Int
puntosDelMasGroso nombre1 nombre2 = puntosBase(tieneMasPuntos nombre1 nombre2)

