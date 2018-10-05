import parasito.*

class Persona{
	var nivelCordura
	var parasitos = []
	
	method nivelCordura() = nivelCordura
	
	method nivelCordura(valor){
		nivelCordura = valor
	}
	
	method parasitos() = parasitos
	
	method poderDeParasitos(unosParasitos) = unosParasitos.sum({parasito => parasito.poder()})
	
	method infectadaPor(unosParasitos){
		
		nivelCordura -= self.poderDeParasitos(unosParasitos)
				
	}
	
	method agregarParasitos(unosParasitos){
		self.parasitos().addAll(unosParasitos)
	}
	
	method contactarCon(alguien){
		
		alguien.infectadaPor(self.parasitos())
		self.parasitos().forEach({parasito => parasito.reproducirse(alguien)})
		alguien.infectadaPor(alguien.parasitos())
	}
}