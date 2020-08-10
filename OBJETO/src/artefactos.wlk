import personaje.*
import hechizos.*
import refuerzos.*

object hoy{
	const property fecha = new Date()
}

class Artefacto{
	var pesoBase = 0
	const property fechaDeCompra = new Date()
	var diasDeCompra = 0

	method calcularDiasDeCompra(){
		diasDeCompra = new Date() - fechaDeCompra
	}
		
	method factorCorreccion() = (diasDeCompra/1000).min(1)
	
	method pesoTotal() = pesoBase - self.factorCorreccion()
}

class Arma inherits Artefacto{		
	
	method habilidadDeLucha(duenio) = 3
	
	method precio() = 5 * self.pesoTotal()
}


object collarDivino inherits Artefacto{
	var property cantPerlas = 5

	method habilidadDeLucha(duenio) = cantPerlas
	
	method precio() = 2 * cantPerlas
	
	override method pesoTotal() = 0.5 * cantPerlas
	
}

class Mascara inherits Artefacto{
	var property indiceOscuridad = 1
	var property valorLuchaMinimo = 4
	
	method valorLucha() = fuerzaOscura.valor() / 2 * indiceOscuridad
	
	method habilidadDeLucha(duenio){
		return valorLuchaMinimo.max(self.valorLucha())
	}	
	method precio() = indiceOscuridad * 10
	
	method difereciaValorLucha() = 0.max(self.valorLucha()-3)		
		
	override method pesoTotal() =  pesoBase + self.difereciaValorLucha()

}

class Armadura inherits Artefacto{
	 var property refuerzo = ningunRefuerzo
	 var property valorBase = 2
	 	 
	 method habilidadDeLucha(duenio) =  valorBase + refuerzo.habilidadDeLucha(duenio)
	 
	 method precio() = refuerzo.costo(self)
	 
	 override method pesoTotal() = pesoBase + refuerzo.pesoAdicional()	 
}


object espejo inherits Artefacto{
	
	method reflejo(duenio){
		
		return duenio.mejorArtefacto()
	}
	
	method habilidadDeLucha(duenio){
		
		if(duenio.soloTieneEspejo()){return 0}
		else{
			return self.reflejo(duenio).habilidadDeLucha(duenio)
		}
	}		
	
	method precio() = 90

}





