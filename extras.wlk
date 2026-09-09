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

    method esAtravesable(){
        return true
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

    method esAtravesable(){
        return true
    }
}

object manzana {
    const property image = "manzana.png"
    const property position = game.at(5, 5)

    const property energia = 100

    method chocar(ave){ 
    }

    method esComidoPor(ave){
        ave.comer(self)
        game.removeVisual(self)
    }

    method esAtravesable(){
        return true
    }
}

object alpiste {
    const property image = "alpiste.png"
    const property position = game.at(8, 3)

    const property energia = 50

    method chocar(ave){ 
    }

    method esComidoPor(ave){
        ave.comer(self)
        game.removeVisual(self)
    }

    method esAtravesable(){
        return true
    }
}

object muro {
    const property image = "muro.png"
    const property position = game.at(4, 3)

    method esAtravesable(){
        return false 
    }

    method chocar(ave){ 
    }
}
