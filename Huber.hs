instance Show (a -> b) where
  show f = "<funcion>"
  
data Chofer = UnChofer{
 nombre::String,
 kilometraje::Int,
 viajes::[Viaje],
 condicion::Condicion
} deriving Show

data Viaje = UnViaje{
 fecha::Int,
 cliente::Cliente,
 costo::Int
} deriving Show

data Cliente = UnCliente{
 nombreC::String,
 domicilio::String
} deriving Show

type Condicion = Viaje->Bool
cualquierViaje viaje = True
viajesMas200 viaje = costo viaje > 200
nombreMasNLetras n viaje = length(nombreC(cliente viaje)) > n
noVivaEnZona zona viaje = (domicilio(cliente viaje)) /= zona

lucas = UnCliente{
 nombreC = "Lucas",
 domicilio = "Victoria"
}

daniel = UnChofer{
 nombre = "Daniel",
 kilometraje = 23500,
 viajes = [viaje1],
 condicion = noVivaEnZona "Olivos"
}
 
viaje1 = UnViaje{
 fecha = 20042017,
 cliente = lucas,
 costo = 150
}

alejandra = UnChofer{
 nombre = "Alejandra",
 kilometraje = 180000,
 viajes = [],
 condicion = cualquierViaje
}

condicionado viaje chofer = (condicion chofer) viaje == True

liquidacionChofer chofer = (sum.map costo) (viajes chofer)

realizarUnViaje viaje listaChofer = efectuarViaje viaje.choferMenosViajes.(filter (condicionado viaje) )

choferMenosViajes::[Chofer]->Chofer
choferMenosViajes [chofer] =chofer
choferMenosViajes(chofer1:chofer2:choferes) = choferMenosViajes((menorCantViajes chofer1 chofer2):choferes)
menorCantViajes chofer1 chofer2 
 |length(viajes chofer1) <length(viajes chofer2) = chofer1
 |otherwise = chofer2



efectuarViaje viaje chofer = chofer{viajes = (viajes chofer) ++[viaje]}

nitoInfy = UnChofer{
 nombre = "Nito Infy",
 kilometraje = 70000,
 viajes = repetirViaje viaje2 ++ [viaje3],
 condicion = nombreMasNLetras 3
}

viaje2 = UnViaje{
 fecha = 11032017,
 cliente = lucas,
 costo = 50
}

viaje3 = UnViaje{
 fecha = 02052017,
 cliente = lucas,
 costo = 500
}

repetirViaje viaje = viaje : repetirViaje viaje

gongNeng::Ord a=>a->(a->Bool)->(b->a)->[b]->a
gongNeng arg1 arg2 arg3 = max arg1 . head . filter arg2 . map arg3
