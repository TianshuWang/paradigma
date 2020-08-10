import personaje.*
import refuerzos.*
import artefactos.*

class Hechizo{
	method poder()
	
	method precio() = self.poder()
	
	method pesoAdicional(){
		if(self.poder().even()) return 2
		else return 1
	}
}

class HechizoLogo inherits Hechizo {
	var property nombre
	var property multiplo = 1
		
	method cantLetraNombre() = nombre.length()
		
	override method poder() = self.cantLetraNombre() * multiplo
		
	method esPoderoso(){
		return self.poder() > 15
	}
	
	method habilidadDeLucha(duenio) = self.poder()
		
	method costo(armadura) = armadura.valorBase() + self.precio()

}

class HechizoComercial inherits HechizoLogo{
	var property porcentaje = 0.2
	override method poder() = porcentaje * super()
}

object hechizoBasico inherits HechizoLogo(nombre = "hechizoaaa") {}


class LibroDeHechizos inherits Hechizo {
	var property hechizos = []
	
	method agregarHechizos(unosHechizos){
		
		hechizos.addAll(unosHechizos)
	}
	
	method hechizosPoderosos(){
		return hechizos.filter({hechizo => hechizo.esPoderoso()})
	}
	
	override method poder(){
		return self.hechizosPoderosos().sum({hechizo => hechizo.poder()})
	}
	
	method cantHechizos() = self.hechizos().size()
	
	override method precio(){
		return 10 * self.cantHechizos() + self.poder()
	}
		
}



