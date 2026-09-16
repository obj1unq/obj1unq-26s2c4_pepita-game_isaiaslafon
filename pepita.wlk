import wollok.game.*
import extras.*
import direcciones.*

object normal{
	method forma(){
		return "normal"
	}

	method puedeMover(){
		return true
	}

}

object perdedora{
	method forma(){
		return "gris"
	}

	method puedeMover(){
		return false
	}

	method mensaje(){
		return "perdí!"
	}
}

object ganadora{
	method forma(){
		return "grande"
	}

	method puedeMover(){
		return false
	}

	method mensaje(){
		return "gané!"
	}
}


object pepita {
	var property energia = 200 //El getter y setter solo lo necesito para testear
	var position = game.at(0,1) // game.origin() 
	var estado = normal

	method image(){
		return "pepita-" + estado.forma() + ".png"
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
			self.perder()
		}
	}

	method puedeVolar(distancia) {
		return energia >= self.energiaQueGastaAlVolar(distancia)
	}

	method energiaQueGastaAlVolar(distancia) {
		return 10 + distancia/10
  	}

	method mover(direccion) {
		if(estado.puedeMover()){		
			const nuevaPosition = direccion.siguiente(position) //No modifico la position en la primera linea porque volar podría lanzar error
			self.volar(10) //asume que cada celda está a 10 km
			position = nuevaPosition //ahora si puedo modificar la posicion
		}
	}


	method caer() {
		position = abajo.siguiente(position)
	}

	method finalizar(estadoNuevo){
		estado = estadoNuevo
		game.say(self, estado.mensaje())
		game.schedule(3000, {game.stop()})
	}

	method ganar(){
		self.finalizar(ganadora)
	}

	method perder(){
		self.finalizar(perdedora)
	}

	method comer(comida){
		energia += comida.energia()
	}

}

//comentario
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



object jaula{
	const property image = "jaula.png"
	const property position = game.at(3,3)

	method cruzarse(alguien){
		alguien.perder()
	}
}