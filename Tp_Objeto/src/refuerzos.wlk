import personaje.*
import artefactos.*
import hechizos.*

object cotaDeMalla{
	var property unidadLucha = 5
	var property pesoAdicional = 1
	
	method habilidadDeLucha(duenio) = self.unidadLucha()
	
	method costo(armadura) = unidadLucha / 2
}

object bendicion{
	var property pesoAdicional = 0
	
	method habilidadDeLucha(duenio) = duenio.nivelDeHechiceria()
	
	method costo(armadura) = armadura.valorBase()
}

object ningunRefuerzo{
	var property pesoAdicional = 0
	
	method habilidadDeLucha(duenio) = 0
	
	method costo(armadura) = 2
	
}