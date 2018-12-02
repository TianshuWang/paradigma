object barrio{
	var property chicos = []
	
	method agregarChico(chico){
		chicos.add(chico)
	}
	method ordenamientoCaramelos() = chicos.sortedBy({c1,c2=>c1.caramelos()>c2.caramelos()})
	
	method los3MasCaramelos() = self.ordenamientoCaramelos().take(3)
	
	method losMas10Caramelos() = chicos.filter({c=>c.tieneMasCaramelos(10)})
	
	method elementosDeLosMas10Caramelos() = self.losMas10Caramelos().map({c=>c.elementos()}).asSet()
		
}

class Chico{
	var property elementos = []
	var property actitud
	var property caramelos
	var property salud = sano
	
	method agregarElemento(elemento){
		elementos.add(elemento)
	}
	method sustoTotal() = elementos.sum({e=>e.susto()})
	
	method capacidad() = self.sustoTotal() * actitud
	
	method recibirCaramelos(cant){
		caramelos += cant
	}
	method verificarCant(cant){
		if(cant > caramelos){
			throw new Exception({"No tenes suficiente!"})
		}
	}
	method disminuirCaramelos(cant){
		caramelos -= cant
	}
	method disminuirActitud(cant){
		actitud -= cant
	}
	method comerCaramelos(cant){
		self.verificarCant(cant)
		salud.comer(self,cant)
		self.disminuirCaramelos(cant)
		
	}
	
	method tieneMasCaramelos(cant) = caramelos > cant
		
}

object sano{
	method comer(chico,cant){
		if(cant > 10){
			chico.salud(empachado)
			empachado.efecto(chico)
		}		
	}

}
object empachado{
	method efecto(chico){
		chico.disminuirActitud(chico.actitud().div(2))
	}
	method comer(chico,cant){
		if(cant > 10){
			chico.salud(enCama)
			enCama.efecto(chico)
		}		
	}
}

object enCama{
	method comer(chico,cant){
		throw new Exception({"No pode comer mas!"})
	}
	method efecto(chico){
		chico.disminuirActitud(chico.actitud())		
	}
}

class Legion{
	var property miembros = []
	
	method agregarMiembro(chico){
		miembros.add(chico)
	}
	method capacidad() = miembros.sum({m=>m.capacidad()})
	
	method caramelos() = miembros.sum({m=>m.caramelos()})
	
	method lider() = miembros.max({m=>m.capacidad()})
	
	method recibirCaramelos(cant){
		self.lider().recibirCaramelos(cant)
	}	
}

class Maquillaje {
	var property susto = 3
}

class Traje{
	var property personaje
	
	method ssto() = personaje.susto()
}

class PersonajeTierno{
	var property susto = 2
}

class PersonajeTerrorifico{
	var property susto = 5
}

class Adulto{
	var property asustadores = []
	
	method tolerancia() = 10 * self.cantChicosMas15Caramelos()
	
	method cantCaramelos() = self.tolerancia().div(2)
	
	method cantChicosMas15Caramelos() = asustadores.count({a=>a.tieneMasCaramelos(15)})
	
	method seAsusta(chico) = self.tolerancia() < chico.capacidad()
	
	method serAsustado(chico){
		if(!self.seAsusta(chico)){
			throw new Exception({"No se asusta!"})
		}
		else{
			chico.recibirCaramelos(self.cantCaramelos())
		}
		asustadores.addAll(chico)
	}
}

class Abuelo inherits Adulto{
	override method seAsusta(chico) = true
	
	override method cantCaramelos() = super().div(2)
}

class Necio inherits Adulto{
	override method seAsusta(chico) = false
}