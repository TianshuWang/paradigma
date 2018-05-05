import Text.Show.Functions 
data Serie = UnaSerie {
 nombre :: String,
 genero :: String,
 duracion :: Int,
 cantTemporadas :: Int, 
 calificaciones :: [Int],
 esOriginalDeNetflis :: Bool
} deriving (Eq, Show)

tioGolpetazo = UnaSerie {
    nombre = "One punch man",
    genero = "Monito chino",
    duracion = 24,
    cantTemporadas = 1,
    calificaciones = [5],
    esOriginalDeNetflis = False
}
 
cosasExtranias = UnaSerie {
    nombre = "Stranger things",
    genero = "Misterio",
    duracion = 50,
    cantTemporadas = 2,
    calificaciones = [3,3],
    esOriginalDeNetflis = True
}

dbs = UnaSerie {
    nombre = "Dragon ball supah",
    genero = "Monito chino",
    duracion = 150,
    cantTemporadas = 5,
    calificaciones = [],
    esOriginalDeNetflis = False
}

espejoNegro = UnaSerie {
    nombre = "Black mirror",
    genero = "Suspenso",
    duracion = 123,
    cantTemporadas = 4,
    calificaciones = [2],
    esOriginalDeNetflis = True
}

rompiendoMalo = UnaSerie {
    nombre = "Breaking Bad",
    genero = "Drama",
    duracion = 200,
    cantTemporadas = 5,
    calificaciones = [],
    esOriginalDeNetflis = False
}

treceRazonesPorque = UnaSerie {
    nombre = "13 reasons why",
    genero = "Drama",
    duracion = 50,
    cantTemporadas = 1,
    calificaciones = [3,3,3],
    esOriginalDeNetflis = True
}

--Parte 1
maraton = [tioGolpetazo,cosasExtranias,dbs,espejoNegro,rompiendoMalo, treceRazonesPorque]

cantSeries maraton = length maraton

esPopular serie = length(calificaciones serie) >=3

valePenaSerie serie = cantTemporadas serie > 1 && esPopular serie

valePenaMaraton maraton = valePenaSerie(head maraton) && valePenaSerie(last maraton) ||elem rompiendoMalo maraton

primeraMaraton maraton = take (div (cantSeries maraton) 2) maraton
segundaMaraton maraton = drop (div (cantSeries maraton) 2) maraton

repuntaFinal maraton = valePenaMaraton(primeraMaraton maraton)==False && valePenaMaraton(segundaMaraton maraton)==True

califSerie serie 
 |null(calificaciones serie) = 0
 |otherwise =  div (sum(calificaciones serie)) (length(calificaciones serie))

dispersion serie = maximum(calificaciones serie) - minimum(calificaciones serie)

calificarSerie cali serie = serie{calificaciones = (calificaciones serie) ++ [cali]}
 
hypearSerie serie
 |elem 1 (calificaciones serie) || null(calificaciones serie) = serie
 |otherwise = serie{calificaciones = [suma2(head (calificaciones serie))]++ elementoMedio(calificaciones serie)++[suma2 (last(calificaciones serie))]}
elementoMedio lista = (init.drop 1) lista
suma2 numero = min (numero+2) 5

--Parte 2
serieMonitoChino serie = genero serie == "Monito chino"
monitosChinos maraton = filter (serieMonitoChino) maraton

serieBuenaOriginal serie = valePenaSerie serie && esOriginalDeNetflis serie
buenaOriginal maraton = filter serieBuenaOriginal maraton

serieNTemporadas serie = cantTemporadas serie > 1
nTemporadas maraton = filter serieNTemporadas maraton

serieFlojita serie = cantTemporadas serie == 1
esFlojita maraton = map serieFlojita maraton ==[True]

serieDuracion serie = duracion serie * cantTemporadas serie
tiempoCompleto maraton = sum (map serieDuracion maraton)

valePenaMaratonAct maraton = length(filter valePenaSerie maraton) >=1|| elem rompiendoMalo maraton

maxCalifOriginal maraton = maximum(map califSerie (filter esOriginalDeNetflis maraton))

generoDramaSuspenso serie = (genero serie == "Drama") || (genero serie == "Suspenso")

hypearSerieC maraton = map hypearSerie (filter generoDramaSuspenso maraton)

--Parte 3

promedioDuracion maraton = div (tiempoCompleto maraton) (length maraton)

promedioCalif maraton = div (sum(map califSerie maraton)) (length maraton)

promedioCalifListaM maratones = div(sum(map promedioCalif maratones)) (length maratones)

maxCalif maraton =  maximum(map califSerie maraton)

mejorSerie maraton = filter (\x-> califSerie x == maxCalif maraton) maraton

duracionMax maraton = maximum(map serieDuracion maraton)

duracionMaxSerie maraton = filter (\x->serieDuracion x == duracionMax maraton) maraton

data Critico = UnCritico{
 nombreCritico::String,
 preferencia::(Serie->Bool),
 critica::Critica
} deriving Show
type Critica = Serie->Serie

dMoleitor = UnCritico "D.Moleitor" serieFlojita demoler
eliminarCaliMayor3 serie = serie{calificaciones = filter (<=3) (calificaciones serie)}
agregarCalifAlFinal1 serie = serie{calificaciones = calificaciones serie ++ [1]}
demoler::Critica
demoler serie = (agregarCalifAlFinal1.eliminarCaliMayor3)serie

hypeador = UnCritico "Hypeador" esHypeable hypear
esHypeable serie = not(elem 1 (calificaciones serie)) 
hypear::Critica
hypear serie = serie{calificaciones = [suma2(head (calificaciones serie))]++ elementoMedio(calificaciones serie)++[suma2 (last(calificaciones serie))]}

exquisito = UnCritico "Exquisito" valePenaSerie exquisita
promedioCalisMas1 serie = califSerie serie + 1
exquisita::Critica
exquisita serie = serie{calificaciones = replicate (length (calificaciones serie)) (calif5(promedioCalisMas1 serie))}
calif5 nota = min nota 5

cualquierColectivoLoDejaBien = UnCritico "CualquierColectivoLoDejaBien" todasSeries bien
todasSeries serie = elem serie maraton
bien::Critica
bien serie = serie{calificaciones = (calificaciones serie) ++ [5]}