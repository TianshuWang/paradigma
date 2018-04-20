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
 memoria = [],
 mensajeError = "OK"
}

at8086 = UnMicrocontrolador{
 nombre = "AT 8086",
 acumuladorA = 0,
 acumuladorB = 0, 
 programCounter = 0,
 memoria = [1..20],
 mensajeError = "OK"
}

fp20 =  UnMicrocontrolador{
 nombre = "AT 8086",
 acumuladorA = 7,
 acumuladorB = 24, 
 programCounter = 0,
 memoria = [],
 mensajeError = "OK"
}

nop  micro = micro{programCounter = programCounter micro +1}

contar::Microcontrolador->Microcontrolador
contar micro = micro{programCounter = programCounter micro + 1 }

avanzar3p micro = (nop.nop.nop) micro

lodv val micro = nop(micro{acumuladorA = val} )

swap (UnMicrocontrolador nom acumuladorA acumuladorB programCounter memoria etiqueta)= nop((UnMicrocontrolador nom acumuladorB acumuladorA programCounter memoria etiqueta))

add micro =nop (vaciar( micro {acumuladorA = acumuladorA micro + acumuladorB micro}))

vaciar micro = micro{acumuladorB = 0}

str pos val micro= nop(micro{memoria =(take (pos-1) (memoria micro))++[val]++(drop (pos-1) (memoria micro))})

divide micro 
 |acumuladorB micro == 0 = nop(micro{mensajeError = "DIVISION BY ZERO"})
 |otherwise = nop (vaciar(micro{acumuladorA = div (acumuladorA micro)(acumuladorB micro)}))

lod pos micro = nop(micro{ acumuladorA = last(take pos (memoria micro))})

