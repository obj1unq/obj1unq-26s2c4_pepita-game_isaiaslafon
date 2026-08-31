import wollok.game.*

object pepita {

	var property energia = 100 //El getter y setter solo lo necesito para testear
	var position = game.origin()

	method image() { //metodo necesario para wollok game
		return "pepita.png"
	}

	method position() { //metodo necesario para wollok game
		return position
	}

	method position(_position) { //el setter solo lo necesito para testear
		position = _position 
	}


	method text() { //metodo opcional para mostrar un texto en wollok game
		return energia.toString()
	}

	method textColor() { //metodo opcional para definir el color del texto (RGBA)
		return "FF0000FF"
	}
	
	method volar(distancia) {
		self.validarVolar(distancia)
    	energia = energia - self.energiaQueGastaAlVolar(distancia)
  	}

	method validarVolar(distancia) {
		if (not self.puedeVolar(distancia)) {
			self.error("No tengo energia para volar " + distancia)
		}
	}

	method puedeVolar(distancia) {
		return energia >= self.energiaQueGastaAlVolar(distancia)
	}

	method energiaQueGastaAlVolar(distancia) {
		return 10 + distancia/10
  	}
	

	method mover(direccion) {
		const nuevaPosition = direccion.siguiente(position) //No modifico la position en la primera linea porque volar podría lanzar error
		self.volar(10) //asume que cada celda está a 10 km
		position = nuevaPosition //ahora si puedo modificar la posicion
	}

}

