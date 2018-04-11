data Hobbits = UnHobbits {nom::String, estat::Int, salud::Int, fuerza::Int,esCom::Bool,anillo::Anillo} deriving Show
data Anillo = UnAnillo {peso::Int,frase::String} deriving Show

frodo = (UnHobbits "Frodo" 106 10 50 True anilloDefrodo)
anilloDefrodo = (UnAnillo 12 "Un Anillo para gobernarlos a todos. Un Anillo para encontrarlos, un Anillo para atraerlos a todos y atarlos en las tinieblas.")
bilbo = (UnHobbits "Bilbo" 100 15 90 False anilloDebilbo)
anilloDebilbo = (UnAnillo 9 "Un Anillo no funciona nunca")
anilloExtra = (UnAnillo 100 "Super Poder")

poderDelAnillo::Anillo->Int
poderDelAnillo (UnAnillo peso frase) = peso * (length frase)

absoluto n
 | n<=0 = 0
 | otherwise = n
 
resistenciaDeHobbits::Hobbits->Int
resistenciaDeHobbits(UnHobbits nom estat salud fuerza esCom anillo)
 |(esCom == True && (head nom) == 'F') = absoluto(10 + estat * salud + fuerza - (poderDelAnillo anillo))
 |(esCom == False && (head nom) == 'F') = absoluto(10 + salud * fuerza - (poderDelAnillo anillo))
 | esCom == True = absoluto(estat * salud + fuerza - (poderDelAnillo anillo))
 | otherwise = absoluto(salud * fuerza - (poderDelAnillo anillo))

cambiarAnillo::Hobbits->Anillo->Hobbits
cambiarAnillo (UnHobbits nom estat salud fuerza esCom anillo) anilloNuevo = (UnHobbits nom estat salud fuerza esCom anilloNuevo)

desayuno::Hobbits->Hobbits
desayuno(UnHobbits nom estat salud fuerza esCom anillo) = (UnHobbits ("Errrp"++nom) estat (salud+5) fuerza esCom anillo)

segundoDesayuno::Int->Hobbits->Hobbits
segundoDesayuno cantManza (UnHobbits nom estat salud fuerza esCom anillo)  =  (UnHobbits nom estat salud (fuerza+cantManza*4) esCom anillo)

merienda::Hobbits -> Hobbits
merienda hobbits = segundoDesayuno 2 (desayuno hobbits)

masResistencia::Hobbits->Hobbits->Hobbits
masResistencia hobbits1 hobbits2 
 | resistenciaDeHobbits hobbits1 > resistenciaDeHobbits hobbits2 = hobbits1
 | otherwise = hobbits2
 
 