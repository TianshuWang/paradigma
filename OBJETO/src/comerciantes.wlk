import personaje.*
import artefactos.*
import hechizos.*
import refuerzos.*


class Comerciante{
	var property categoria
	
	method precioCanjeaHechizo(persona,hechizo){
		if(persona. precioMitadHechizoActual() < hechizo.precio()){			
			return hechizo.precio() - persona. precioMitadHechizoActual()			
		}
		return 0	
	}
	
	method verificarSaldo(persona,precio){
		if(precio > persona.monedas()){
			throw new Exception("Saldo insuficiente !")
		}
	}
	
	method leCanjeasHechizo(persona,hechizo){
		var precioPagar = self.precioCanjeaHechizo(persona,hechizo)
		self.verificarSaldo(persona,precioPagar)
		persona.pagas(precioPagar)
		persona.hechizoPreferido(hechizo)			
	}	
	
	method precioDeArtefactos(unosArtefactos) = unosArtefactos.sum({artefacto => artefacto.precio()})
	
	method precioAcobrar(unosArtefactos) = categoria.precioAcobrar(self,unosArtefactos)
	
	method leVendesArtefactos(persona,unosArtefactos){
		var precioPagar = self.precioAcobrar(unosArtefactos)
		self.verificarSaldo(persona,precioPagar)
		persona.pagas(precioPagar)
		persona.agregarArtefactos(unosArtefactos)
	}	
	
	method recategorizarse(){
		categoria.recategorizarse(self)
	}	
}

class ComercianteIndependiente {
	var property comision 
	
	method precioAcobrar(comerciante,artefactos) = comerciante.precioDeArtefactos(artefactos) * (1 + comision)
	
	method recategorizarse(comerciante){
		comision *= 2
		self.verificarComision(comerciante)		
	}
	
	method verificarComision(comerciante){
		 if(comision >= 0.21){
			comerciante.categoria(new ComercianteRegistrado())
		}
	}
}

class ComercianteRegistrado {

	method precioAcobrar(comerciante,artefactos) = comerciante.precioDeArtefactos(artefactos) * 1.21	
	
	method recategorizarse(comerciante){
		comerciante.categoria(new ComercianteImpuesto())
	}
} 

class ComercianteImpuesto  {
	var property minimo = 5
	
	method diferenciaPrecioYminimo(comerciante,artefactos) = comerciante.precioDeArtefactos(artefactos) - minimo
	
	method precioAcobrar(comerciante,artefactos){
		var diferencia = self.diferenciaPrecioYminimo(comerciante,artefactos)
		return (comerciante.precioDeArtefactos(artefactos)+(diferencia*0.35)).max(comerciante.precioDeArtefactos(artefactos))
	}	
	
	method recategorizarse(comerciante){}
}

class ComercianteSinCategoria{
	
	method precioAcobrar(comerciante,artefactos) = comerciante.precioDeArtefactos(artefactos)
}


