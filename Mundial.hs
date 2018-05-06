data Jugador = CJugador{
 nombre::String,
 edad::Int,
 promedioGol::Float,
 habilidad::Int,
 cansancio::Float
} deriving Show

martin = CJugador "Martin" 26 0.0 50 35.0
juan = CJugador "Juancho" 30 0.2 50 40.0
maxi = CJugador "Maxi Lopez" 27 0.4 68 30.0

jonathan = CJugador "Chueco" 20 1.5 80 99.0
lean = CJugador "Hacha" 23 0.01 50 35.0
brian = CJugador "Panadero" 21 5 80 15.0

garcia = CJugador "Sargento" 30 1 80 13.0
messi = CJugador "Pulga" 26 10 99 43.0
aguero = CJugador "Aguero" 24 5 90 5.0

luis = CJugador "Perez" 19 5 40 53.0
claudio = CJugador "Paz" 26 1 55 43.0
jose = CJugador "Colon" 24 2 65 25.0

type Equipo = (String,Char,[Jugador])
e1 = ("Lo Que Vale Es El Intento", 'F', [martin, juan, maxi])
e2 = ( "Los De Siempre", 'F', [jonathan, lean, brian])
e3 = ("Resto del Mundo", 'A', [garcia, messi, aguero])
e4 = ("Pierde siempre",'B' , [luis,claudio,jose])
jugadores(_,_,j) = j
grupo(_,g,_) = g

jugadoresFaranduleros = ["Maxi Lopez", "Icardi", "Aguero", "Caniggia", "Demichelis"]

quickSort _ [] = [] 
quickSort criterio (x:xs) = (quickSort criterio . filter (not . criterio x)) xs ++ [x] ++ (quickSort criterio . filter (criterio x)) xs 

esFigura jugador = (habilidad jugador)>75 && (promedioGol jugador) > 0
jugadorEquipo equipo = filter esFigura (jugadores equipo) 

esFarandulero jugador = elem (nombre jugador) jugadoresFaranduleros
tieneFarandulero equipo = (not.null) (filter esFarandulero (jugadores equipo))

esJoven jugador = (edad jugador) < 27

jugadorBrillante jugador = (esFigura jugador) && (esJoven jugador) && (not.esFarandulero)jugador

esGrupo g equipo = (grupo equipo) == g

figuritasDificiles g equipos = map nombre (filter jugadorBrillante (concat(map jugadores (filter (esGrupo g) equipos))))

cansarEquipo (n,g,jugadores) = (n,g,map cansarEdad jugadores)

cansancio50 jugador = jugador{cansancio = 50}
cansancio10 jugador = jugador{cansancio = (cansancio jugador) +0.1*(cansancio jugador)}
cansancioAum20 jugador = jugador{cansancio = (cansancio jugador)+20}
cansancioOtro jugador = jugador{cansancio = (cansancio jugador)*2}

cansarEdad jugador
 |jugadorBrillante jugador = cansancio50 jugador
 |esJoven jugador = cansancio10 jugador
 |(not.esJoven) jugador && esFigura jugador= cansancioAum20 jugador
 |otherwise = cansancioOtro jugador

menosCansado jugador1 jugador2 = (cansancio jugador1) < (cansancio jugador2)
golesEquipo equipo = (sum.map promedioGol .take 2 .quickSort menosCansado.jugadores) equipo

ganador e1 e2
 |golesEquipo e1 > golesEquipo e2 = e1
 |otherwise = e2

jugarPartido e1 e2 = cansarEquipo(ganador e1 e2)

campeon equipos = foldl jugarPartido (head equipos) (tail equipos)

masGol jugador1 jugador2 = (promedioGol jugador1) > (promedioGol jugador2)

grosoMundial equipos = (head.quickSort masGol. filter esFigura)(jugadores (campeon equipos))