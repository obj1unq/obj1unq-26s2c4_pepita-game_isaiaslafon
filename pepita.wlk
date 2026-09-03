import wollok.game.*
import extras.*

object pepita {
	var property energia = 1000 //El getter y setter solo lo necesito para testear
	var position = game.at(0,1) // game.origin() 
	var estado = "normal"


	method image(){
		return "pepita-" + estado + ".png"
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
    	energia -= self.energiaQueGastaAlVolar(distancia)
  	}

	method validarVolar(distancia) {
		if(not self.puedeVolar(distancia)) { 
			self.error("no puede volar")
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

	//method colisionar(entidad){
	//	entidad.chocar(self)
	//}

	method ganar(){
		estado = "grande"
		game.say(self, "gane")
	}

	method perder(){
		estado = "gris"
		game.say(self, "pucha, que pobreza...")
	}
}

//game.say(pepita, "perdí, che")
//game.schedule(2000, {game.stop()})

//const moverse = game.tick(2000, {pepita.mover(iquierda)})
//moverse.start()
//moverse.stop()


/*
//Esquema como hacer excepciones bonitas.
	method accion(a , b , c){ //Podría no tener parametros la orden o los necesarios
		self.validarAccion() //la validacion podría o no necesitar ciertos parámetros, no se enviaria info propia ya que es info que el mismo objeto ya conoce.
		//Si se lanza una excepción la logica que continua nunca se ejecuta. Se frena el flujo del programa, aunque los objetos siguen andando.

		//código / lógica de negocio que hace si puede realizar la orden.
	}

	method validarAccion() { //La validacion podría o no tener que recibir cierta información
		if(not self.puedeAccionar()) { //Condición (usualmente negada) de si puede realizar la acción,
			self.error("no puede accionar!") //Si no puede entonces lanza una excepción
		}
	}

	method puedeAccionar(){
		return condicionParaPoderAcciones
	}
*/


//##############################################################################

object perdedora{

	method mover(ave, direccion){
		self.terminarJuego(ave)
	}

	method terminarJuego(ave){
		game.say(ave, "estoy atrapada")
		game.schedule(3000, {game.stop()})
	}
	
}

object jaula{
	const property image = "jaula.png"
	const property position = game.at(3,3)

	method cruzarse(alguien){
		alguien.perder()
	}
}