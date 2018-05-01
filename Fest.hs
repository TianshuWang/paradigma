--Punto 1
data Cliente = UnCliente{
 nombre::String,
 resistencia::Int,
 amigos::[Cliente]
} deriving Show

--Punto 2
rodri = UnCliente{
 nombre = "Rodri",
 resistencia = 55,
 amigos = []
}
 
marcos = UnCliente{
 nombre = "Marcos",
 resistencia = 40,
 amigos = [rodri]
}

ana = UnCliente{
 nombre = "Ana",
 resistencia = 120,
 amigos = [rodri,marcos]
}

cristian = UnCliente{
 nombre = "Cristian",
 resistencia = 45,
 amigos = []
}

--punto 3
comoEsta cliente 
 | resistencia cliente > 50 = "fresco"
 | resistencia cliente <=50 && length(amigos cliente)>1 = "piola"
 | otherwise = "duro"
 
--Punto 4
reconoceAmigo cliente2 cliente1 
 | elem (nombre cliente2) (map nombre (amigos cliente1)) || (nombre cliente1)==(nombre cliente2) = cliente1
 | otherwise = cliente1{amigos = (amigos cliente1)++[cliente2]}
 
--Punto 5
grogXD cliente = cliente{resistencia = 0}

restaResistencia10 cliente = cliente{resistencia = resistencia cliente -10}
jarraLoca (UnCliente nombre resistencia amigos) = UnCliente nombre (resistencia-10) (map restaResistencia10 amigos)

klusener gusto cliente = cliente{resistencia = (resistencia cliente) - length gusto}

tintico cliente = cliente{resistencia = (resistencia cliente) + 5 * length(amigos cliente)}

soda fuerza cliente  = cliente{nombre = "e"++concat(replicate fuerza "r")++"p" ++ (nombre cliente)}

rescatarse duracion cliente
 | duracion > 3 = cliente{resistencia = (resistencia cliente) + 200}
 | duracion <=3 && duracion >0 = cliente{resistencia = (resistencia cliente) + 100}
 | otherwise = cliente

--Punto 6
rescatable cliente = resistencia cliente == 0

--Punto 7
--(klusener "huevo".rescatarse 2.klusener "chocolate".jarraLoca) ana

