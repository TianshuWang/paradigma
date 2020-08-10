instance Show (a -> b) where
  show f = "<Instruccion>"
  
--1°Entrega
--3.1:Estructura:Data
data Microcontrolador = UnMicrocontrolador{
 nombre :: String,
 acumuladorA :: Int,
 acumuladorB :: Int,
 programCounter :: Int,
 memoria :: [Int],
 mensajeError :: String,
 programa :: Program --Se agrego "programa" para la segunda entrega
} deriving Show

xt8088 = UnMicrocontrolador{
 nombre = "XT 8088",
 acumuladorA = 0,
 acumuladorB = 0, 
 programCounter = 0,
 memoria =  [],
 mensajeError = "OK",
 programa = []
}

fp20 =  UnMicrocontrolador{
 nombre = "FP 20",
 acumuladorA = 7,
 acumuladorB = 24, 
 programCounter = 0,
 memoria = [0,0,0,0],
 mensajeError = "OK",
 programa = []
}

at8086 = UnMicrocontrolador{
 nombre = "AT 8086",
 acumuladorA = 0,
 acumuladorB = 0, 
 programCounter = 0,
 memoria = [1..20],
 mensajeError = "OK",
 programa = []
}

--3.2
incrementaPC::Microcontrolador->Microcontrolador
incrementaPC micro = micro{programCounter = programCounter micro +1}

nop::Microcontrolador->Microcontrolador
nop = incrementaPC 

--3.3
lodv::Int->Microcontrolador->Microcontrolador
lodv val micro = micro{acumuladorA = val}

swap::Microcontrolador->Microcontrolador
swap (UnMicrocontrolador nom acumuladorA acumuladorB programCounter memoria mensajeError programa)= UnMicrocontrolador nom acumuladorB acumuladorA programCounter memoria mensajeError programa

add::Microcontrolador->Microcontrolador
add micro = vaciarAcumuladorB( micro {acumuladorA = acumuladorA micro + acumuladorB micro})

vaciarAcumuladorB::Microcontrolador->Microcontrolador
vaciarAcumuladorB micro = micro{acumuladorB = 0}

--3.4
str::Int->Int->Microcontrolador->Microcontrolador
str pos val micro= micro{memoria = insertarValor pos val (memoria micro)}

insertarValor pos val lista = (take (pos-1) lista)++[val]++(drop pos lista)


divide::Microcontrolador->Microcontrolador
divide micro 
 |acumuladorB micro == 0 = micro{mensajeError = "DIVISION BY ZERO"}
 |otherwise = vaciarAcumuladorB (micro{acumuladorA = div (acumuladorA micro)(acumuladorB micro)})
 
lod::Int->Microcontrolador->Microcontrolador
lod pos micro = micro{ acumuladorA = (memoria micro)!!(pos-1)}

memoriaVacia::Microcontrolador->Microcontrolador
memoriaVacia micro = micro{memoria = replicate 1024 0}

--2°Entrega
--Para la segunda entrega se modificaron las instrucciones (lodv, str, add, etc) de modo que ya no aumentan el programCounter del micro por si mismas.

--3.1
type Program = [Microcontrolador->Microcontrolador]
cargarPrograma program micro = micro{programa = (programa micro)++program}
sumar::Program
sumar = [lodv 10,swap,lodv 22,add]

dividir::Program
dividir = [str 1 2,str 2 0,lod 2,swap,lod 1,divide]

--3.2
ejecutarInstru micro instruccion 
 |mensajeError micro /= "OK" = micro
 |otherwise = incrementaPC(instruccion micro)
 
ejecutarPrograma micro = foldl ejecutarInstru micro (programa micro)

--3.3
condicionEjecutar micro instruccion 
 |acumuladorA micro == 0 = micro
 |otherwise = incrementaPC(instruccion micro)
 
ifnz::[Microcontrolador->Microcontrolador]->Microcontrolador->Microcontrolador
ifnz instrucciones micro = foldl condicionEjecutar micro instrucciones

--3.4
sumar1::Program
sumar1 = [swap,nop,lodv 133,lodv 0,str 1 3,str 2 0]

condicionEliminar micro instruccion = acumuladorA (instruccion micro) == 0 && acumuladorB (instruccion micro) ==0 && sum(memoria (instruccion micro))==0
instruAEliminar micro instruccion 
 |condicionEliminar micro instruccion = []
 |otherwise = [instruccion]

depurarPrograma::Microcontrolador->[Microcontrolador->Microcontrolador]->[Microcontrolador->Microcontrolador]
depurarPrograma micro [] = [] 
depurarPrograma micro (x:xs) = instruAEliminar micro x ++ depurarPrograma micro xs

--3.5
microDesorden = UnMicrocontrolador{
 nombre = "Micro Desorden",
 acumuladorA = 0,
 acumuladorB = 0,
 programCounter = 0,
 memoria = [2,5,1,0,6,9],
 mensajeError = "OK",
 programa = []
} --Ejemplo de prueba 

memoriaOrden::Microcontrolador->Bool
memoriaOrden micro = ordenLista(memoria micro)

ordenLista::Ord a=>[a]->Bool
ordenLista[] = True
ordenLista[_] = True
ordenLista(x:y:xs) = x<=y && ordenLista(y:xs)


--3.6
bx8080 = UnMicrocontrolador{
 nombre = "BX 8080",
 acumuladorA = 3,
 acumuladorB = 5, 
 programCounter = 0,
 memoria = ceroInfinito,
 mensajeError = "OK",
 programa = []
}
memoriaInfinita::Microcontrolador->Microcontrolador
memoriaInfinita micro = micro{memoria = [0] ++ memoria(memoriaInfinita micro)}
ceroInfinito = 0:ceroInfinito

--Prelude> ejecutarPrograma(cargarPrograma sumar bx8080)
--UnMicrocontrolador {nombre = "BX 8080", acumuladorA = 32, acumuladorB = 0, programCounter = 8, memoria = [0,0,0,0,0..]
--Se puede cargar y ejecutar el programa cargada,pero la funcion no podria terminar nunca,ya que no hay ningun punto en el que se corte los infinitos ceros.

--Prelude> memoriaOrden bx8080
--la funcion no muestra "True" o "False" es porque todavia esta ejecutando para verificar si la memoria con infinitos ceros esta ordenada.

--4.2
--Prelude>ejecutarPrograma (cargarPrograma sumar xt8088)
--UnMicrocontrolador {nombre = "XT 8088", acumuladorA = 32, acumuladorB = 0, programCounter = 4, memoria = [], mensajeError = "OK", programa = [<Instruccion>,<Instruccion>,<Instruccion>,<Instruccion>]}

--Prelude>  ejecutarPrograma (cargarPrograma dividir xt8088)
--UnMicrocontrolador {nombre = "XT 8088", acumuladorA = 2, acumuladorB = 0, programCounter = 6, memoria = [2,0], mensajeError = "DIVISION BY ZERO", programa = [<Instruccion>,<Instruccion>,<Instruccion>,<Instruccion>,<Instruccion>,<Instruccion>]}

--4.2
--Prelude> ifnz [lodv 3,swap] fp20
--UnMicrocontrolador {nombre = "FP 20", acumuladorA = 24, acumuladorB = 3, programCounter = 2, memoria = [0,0,0,0], mensajeError = "OK", programa = []}

--Prelude> ifnz [lodv 3,swap] xt8088
--UnMicrocontrolador {nombre = "XT 8088", acumuladorA = 0, acumuladorB = 0, programCounter = 0, memoria = [], mensajeError = "OK", programa = []}

--4.4
--Prelude> depurarPrograma xt8088 [swap,nop,lodv 133,lodv 0,str 1 3,str 2 0]
--[<Instruccion>,<Instruccion>]

--4.5
--Prelude> memoriaOrden at8086
--True

--Prelude> memoriaOrden microDesorden
--False
--Prelude> microDesorden
--UnMicrocontrolador {nombre = "Micro Desorden", acumuladorA = 0, acumuladorB = 0, programCounter = 0, memoria = [2,5,1,0,6,9], mensajeError = "OK", programa = []}