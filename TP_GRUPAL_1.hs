--3.1:Estructura:Data
data Microcontrolador = UnMicrocontrolador{
 nombre :: String,
 acumuladorA :: Int,
 acumuladorB :: Int,
 programCounter :: Int,
 memoria :: [Int],
 mensajeError :: String
} deriving Show

xt8088 = UnMicrocontrolador{
 nombre = "XT 8088",
 acumuladorA = 0,
 acumuladorB = 0, 
 programCounter = 0,
 memoria =  [],
 mensajeError = "OK"
}

--3.2:Composicion de funciones
incrementaPC::Microcontrolador->Microcontrolador
incrementaPC micro = micro{programCounter = programCounter micro +1}

nop::Microcontrolador->Microcontrolador
nop = incrementaPC 

--Prelude> (nop.nop.nop) xt8088
--UnMicrocontrolador {nombre = "XT 8088", acumuladorA = 0, acumuladorB = 0, programCounter = 3, memoria = [], mensajeError = "OK"}

--3.3:
lodv::Int->Microcontrolador->Microcontrolador
lodv val micro = incrementaPC(micro{acumuladorA = val} )

swap::Microcontrolador->Microcontrolador
swap (UnMicrocontrolador nom acumuladorA acumuladorB programCounter memoria mensajeError)= incrementaPC((UnMicrocontrolador nom acumuladorB acumuladorA programCounter memoria mensajeError))

add::Microcontrolador->Microcontrolador
add micro = (incrementaPC.vaciarAcumuladorB) ( micro {acumuladorA = acumuladorA micro + acumuladorB micro})

vaciarAcumuladorB::Microcontrolador->Microcontrolador
vaciarAcumuladorB micro = micro{acumuladorB = 0}

sumar::Microcontrolador->Microcontrolador
sumar micro = (add.lodv 22.swap.lodv 10) micro
--Prelude> sumar xt8088
--UnMicrocontrolador {nombre = "XT 8088", acumuladorA = 32, acumuladorB = 0, programCounter = 4, memoria = [], mensajeError = "OK"}

--3.4
str::Int->Int->Microcontrolador->Microcontrolador
str pos val micro= incrementaPC(micro{memoria = insertarValor pos val (memoria micro)})

insertarValor pos val lista = (take (pos-1) lista)++[val]++(drop pos lista)


divide::Microcontrolador->Microcontrolador
divide micro 
 |acumuladorB micro == 0 = incrementaPC(micro{mensajeError = "DIVISION BY ZERO"})
 |otherwise = (incrementaPC.vaciarAcumuladorB) (micro{acumuladorA = div (acumuladorA micro)(acumuladorB micro)})
 
lod::Int->Microcontrolador->Microcontrolador
lod pos micro = incrementaPC(micro{ acumuladorA = (memoria micro)!!(pos-1)})

dividir::Microcontrolador->Microcontrolador
dividir micro = (divide.lod 1.swap.lod 2.str 2 0.str 1 2)micro
--Prelude> dividir xt8088
--UnMicrocontrolador {nombre = "XT 8088", acumuladorA = 2, acumuladorB = 0, programCounter = 6, memoria = [2,0], mensajeError = "DIVISION BY ZERO"}

--En la consola
--4.1 
--Prelude> (nop.nop.nop) xt8088
--UnMicrocontrolador {nombre = "XT 8088", acumuladorA = 0, acumuladorB = 0, programCounter = 3, memoria = [], mensajeError = "OK"}

--4.2 
--Prelude> lodv 5 xt8088
--UnMicrocontrolador {nombre = "XT 8088", acumuladorA = 5, acumuladorB = 0, programCounter = 1, memoria = [], mensajeError = "OK"}

fp20 =  UnMicrocontrolador{
 nombre = "FP 20",
 acumuladorA = 7,
 acumuladorB = 24, 
 programCounter = 0,
 memoria = [],
 mensajeError = "OK"
}
--Prelude> swap fp20
--UnMicrocontrolador {nombre = "FP 20", acumuladorA = 24, acumuladorB = 7, programCounter = 1, memoria = [], mensajeError = "OK"}

--Prelude> (add.lodv 22.swap.lodv 10) fp20
--UnMicrocontrolador {nombre = "FP 20", acumuladorA = 32, acumuladorB = 0, programCounter = 4, memoria = [], mensajeError = "OK"}

--4.3
at8086 = UnMicrocontrolador{
 nombre = "AT 8086",
 acumuladorA = 0,
 acumuladorB = 0, 
 programCounter = 0,
 memoria = [1..20],
 mensajeError = "OK"
}
--Prelude> str 2 5 at8086
--UnMicrocontrolador {nombre = "AT 8086", acumuladorA = 0, acumuladorB = 0, programCounter = 1, memoria = [1,5,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20], mensajeError = "OK"}

memoriaVacia::Microcontrolador->Microcontrolador
memoriaVacia micro = micro{memoria = replicate 1024 0}
--Prelude> (lod 2.memoriaVacia)xt8088
--UnMicrocontrolador {nombre = "XT 8088", acumuladorA = 0, acumuladorB = 0, programCounter = 1, memoria = [0..0], mensajeError = "OK"}

-- Prelude> (divide.lod 1.swap.lod 2.str 2 0.str 1 2)xt8088
--UnMicrocontrolador {nombre = "XT 8088", acumuladorA = 2, acumuladorB = 0, programCounter = 6, memoria = [2,0], mensajeError = "DIVISION BY ZERO"}

--Prelude>  (divide.lod 1.swap.lod 2.str 2 4.str 1 12)xt8088
--UnMicrocontrolador {nombre = "XT 8088", acumuladorA = 3, acumuladorB = 0, programCounter = 6, memoria = [12,4], mensajeError = "OK"}