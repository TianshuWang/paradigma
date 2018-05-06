data Postulante = UnPostulante{
 nombre::String,
 edad::Int,
 remuneracion::Float,
 conocimientos::[Conocimiento]
} deriving Show

data Puesto = UnPuesto{
 nombrePuesto::String,
 conoNecesarios::[Conocimiento]
} deriving Show

type Conocimiento = String

apellidoDuenio = "Perez"
pepe = UnPostulante "Jose Perez" 35 15000.0 ["Haskell", "Prolog", "Smalltalk", "C"]
tito = UnPostulante "Roberto Gonzalez" 20 12000.0 ["Haskell", "Php"]

jefe = UnPuesto "gerente de sistemas" ["Haskell", "Prolog", "Smalltalk"] 
chePibe = UnPuesto "cadete" ["ir al banco"] 

tieneConocimientos puesto postulante = conoNecesarios puesto <= conocimientos postulante

edadAceptable edadMinima edadMaxima postulante = (edad postulante) >=edadMinima && (edad postulante) <= edadMaxima

sinArreglo postulante = (take 5.reverse) (nombre postulante) /= reverse apellidoDuenio

cumpleRequisitos [x] postulante = x postulante 
cumpleRequisitos (x:xs) postulante = x postulante && cumpleRequisitos xs postulante

preSeleccion postulantes requisitos = filter (cumpleRequisitos requisitos) postulantes

incrementarEdad postulante = postulante{edad = (edad postulante) +1 }
aumentarSueldo porcentaje postulante = postulante{remuneracion = (remuneracion postulante) + porcentaje * (remuneracion postulante)}

actualizarPostulantes postulantes = map (aumentarSueldo 0.27.incrementarEdad) postulantes

--postulantes = [pepe]++postulantes

class Persona a where
 capacitar:: a->Conocimiento->a

instance Persona Postulante 
 where capacitar (UnPostulante n e r conocimientos) conocimiento = UnPostulante n e r (conocimiento:conocimientos)

data Estudiante = UnEstudiante{
 legajo::Int,
 conoEstudiante::[Conocimiento]
} deriving Show

lucho = UnEstudiante 1648748 ["C++","Haskell"]

instance Persona Estudiante 
 where  capacitar (UnEstudiante l conocimientos) conocimiento = UnEstudiante l (conocimiento:init conocimientos)

capacitacion puesto persona = foldl capacitar persona (conoNecesarios puesto)
