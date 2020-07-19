import personaje.*

class Npc inherits Personaje{
	var property nivel
	
	override method habilidadDeLucha() = (valorBaseLucha + self.habilidadDeLuchaTotal()) * nivel.valor()
}

class Nivel{
	var property valor = 0
}