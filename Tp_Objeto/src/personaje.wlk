import hechizos.*
import artefactos.*
import refuerzos.*
import comerciantes.*

class Personaje{
	var property hechizoPreferido = hechizoBasico
	var property valorBaseLucha = 1
	var property artefactos = []
	var property monedas = 100	
	const cargaMaxima = 0
	
	method poderHechizoPreferido() = hechizoPreferido.poder()
	
	method nivelDeHechiceria(){
		return 3 * self.poderHechizoPreferido() + fuerzaOscura.valor()
	}
	
	method seCreePoderoso(){
		return hechizoPreferido.esPoderoso()
	}

	method agregarArtefacto(artefacto){
		self.agregarArtefactos([artefacto])
	}
	
	method agregarArtefactos(unosArtefactos){
		artefactos.addAll(unosArtefactos)
	}
	
	method desprenderArtefacto(artefacto){
		artefactos.remove(artefacto)
	}
	
	method habilidadDeLuchaTotal() = artefactos.sum({artefacto => artefacto.habilidadDeLucha(self)})
	
	method habilidadDeLucha(){
		return valorBaseLucha + self.habilidadDeLuchaTotal()
	}
	
	method mayorHabilidadLuchaQueNivelHechiceria(){
		return self.habilidadDeLucha() > self.nivelDeHechiceria()
	}	
	
	method artefactosSinEspejo(){
		return artefactos.filter({artefacto => !artefacto.equals(espejo)})
	}

	method mejorArtefacto(){
		return self.artefactosSinEspejo().max({artefacto => artefacto.habilidadDeLucha(self)})
	}
		
	method soloTieneEspejo(){
		return artefactos.all({artefacto => artefacto.equals(espejo)})
	}
	
	method cantArtefactos() = artefactos.size()
	
	method estasCargado(){
		return self.cantArtefactos() >= 5
	}	
	
	method pagas(precio){
		monedas -= precio
	}
	
	method precioMitadHechizoActual() = hechizoPreferido.precio() / 2
		
	method canjeasHechizo(alguien,hechizo){
		alguien.leCanjeasHechizo(self,hechizo)
	}	
		
	method comprasArtefactos(alguien,unosArtefactos){
		self.verificarCarga(unosArtefactos)
		alguien.leVendesArtefactos(self,unosArtefactos)
	}	
	
	method verificarCarga(unosArtefactos){
		if(unosArtefactos.sum({a => a.pesoTotal()}) + self.cargaTotal() > cargaMaxima){
			throw new Exception("pesoBase superado!")
		}
	}
	
	method cargaTotal(){
		return artefactos.sum({artefacto => artefacto.pesoTotal()})
	}
}

object fuerzaOscura{
	var property valor = 5
	
	method recibirEclipse(){
		valor = valor * 2
	}
}

object eclipse{
	method ocurrirEclipse(){
		fuerzaOscura.recibirEclipse()
	}
}