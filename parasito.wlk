import persona.*

class Parasito{
	var nivelLastima
	var poder
	
	method nivelLastima() = nivelLastima
	
	method nivelLastima(valor){
		nivelLastima = valor
	}
	
	method poder() = poder
	
	method poder(valor){
		poder = valor
	}
	
	method reproducirse(persona){
		
		if(persona.nivelCordura() > self.nivelLastima()){
			poder = 1.max(self.poder()/2)
			nivelLastima = 10.max(self.nivelLastima()/4)
			persona.agregarParasitos([self])
			
		}
	}
	
}