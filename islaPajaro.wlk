object islaPajaro{
	var property pajaros = []
	var property huevos = []
	
	method agregarPajaro(pajaro){
		pajaros.add(pajaro)
	}
	
	method pajarosFuertes() = pajaros.filter({p => p.esFuerte()})
	
	method fuerza() = self.pajarosFuertes().sum({p=>p.fuerza()})
	
	method suceder(evento){
		pajaros.forEach({p=>evento.efecto(p)})
	}
	
	method primerPajaro() = pajaros.first()	
	
	
	method atacar(){
		pajaros.forEach({p=>islaCerdo.recibirAtaque(p)})
	}
	
	method removerHuevo(huevo){
		huevos.remove(huevo)
	}
	
}

class Pajaro{
	var property ira
	
	method fuerza() = ira * 2
	
	method enojarse(){
		ira *= 2
	}
	
	method esFuerte() = self.fuerza() > 50
	
	method tranquilizarse(){
		ira -= 5
	}
	
	method puedeDerribar(obstaculo) = self.fuerza() > obstaculo.resistencia()
}

object bomb inherits Pajaro{
	var property top = 9000
	
	override method fuerza() = super().min(top)
}

object chuck inherits Pajaro{
	var property velocidad
	
	method kmsMayor80() = (velocidad - 80).max(0)
	
	override method fuerza() = 150 + self.kmsMayor80()*5
	
	override method enojarse(){
		velocidad *= 2
	}
	
	override method tranquilizarse(){}
}

object matilda inherits Pajaro{
	var property huevos = []
	
	method agregarHuevo(huevo){
		huevos.add(huevo)
	}
	
	override method fuerza() = super() + huevos.sum({h=>h.fuerza()})
	
	override method enojarse(){
		self.agregarHuevo(new Huevo(peso = 2))
	}
}

class PajaroRencoroso inherits Pajaro{
	var property veces
	var property multiplicador
	
	override method enojarse(){
		super()
		veces += 1
	}
	
	override method fuerza() = ira*multiplicador*veces
}

class Huevo{
	var property peso
	
	method fuerza() = peso
	
	method seAbre(valor){
		islaPajaro.agregarPajaro(new Pajaro(ira=valor))
		islaPajaro.removerHuevo(self)
	}
}

object sesionDeManejoDeLaIraMatilda{
	method efecto(pajaro){
		pajaro.tranquilizarse()
	}
}

class InvasionCerditos{
	var cantCerditos
	
	method efecto(pajaros){
		(cantCerditos.div(100)).times({x=>pajaros.enojarse()})
	}
}

class Fiesta{
	var homenajeados = []
	
	method efecto(pajaro){
		if(homenajeados.contains(pajaro)){
			pajaro.enojarse()
		}
		else{
			throw new Exception({"No hay ninguno!"})
		}
	}
}

class SerieDeEventos{
	var eventos = []
	
	method efecto(pajaro){
		eventos.forEach({e=>e.efecto(pajaro)})
	}
}

object islaCerdo{
	var obstaculos = []
	
	method sacarObstaculo(obstaculo){
		obstaculos.remove(obstaculo)
	}
	
	method libreDeObstaculos() = obstaculos.isEmpty()
	
	method obstaculoMasCercano() = obstaculos.first()
	
	method recibirAtaque(pajaro){
		var obstaculo = self.obstaculoMasCercano()
		if(!self.libreDeObstaculos() && pajaro.puedeDerribar(obstaculo)){
			self.sacarObstaculo(obstaculo)
		}
	}
}

class Pared{
	var material
	var ancho
	
	method resistencia() = material.resistencia() * ancho
}

class Material{
	var property resistencia
}

class Cerdito{
	var profesion
	
	method resistencia() = profesion.resistencia()
}

object obrero{
	method resistencia() = 50
}

class Armado{
	var property arma
	
	method resistencia() = 10 * arma.resistencia()
}