import wollok.game.*
import pepita.*

object fondo{
    var property image = "fondo.jpg"
    const property position = game.at(-1,-1)

    method cambiar(){
        if(image == "fondo.jpg"){
            image = "fondo2.jpg"
        } else { image = "fondo.jpg" }
    }

    method chocar(ave){

    }
}

object nido{
    const property position = game.at(7, 7)

    method image() = "nido.png"

    
    method chocar(ave){
        ave.ganar()

        //## Esto noe staría muy bueno porque no delega en pepita y se adjudica responsabilidades, 
        //## el code smell se llama "feature envy" (envídia de funcionalidad), 
        //## porque envía varios mensajes al objeto y el que se los manda practicamente no ahce nada.
        //ave.estado("grande")
        //game.say(ave, "gané!")
    }
}

object silvestre{
    const presa = pepita

    method image() = "silvestre.png"

    method position() = game.at(self.x(), 0)

    method x() = 3.max(presa.position().x()) //presa.position().x().max(3)
    //if(presa.position().x() >= 3) { presa.position().x()} else { 3 }

    method chocar(ave){
        ave.perder()
    }
}