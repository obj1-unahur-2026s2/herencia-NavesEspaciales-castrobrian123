

class Nave {
    var velocidad
    var direccion
    var combustible

    method cargarCombustible(unValor) {
        combustible += unValor
    }

    method descargarCombustible(unValor) {
        combustible -= unValor
    }

    method acelerar(unValor) {
        velocidad = (velocidad + unValor).min(100000)
    }

    method desacelerar(unValor) {
        velocidad = (direccion - unValor).max(0)
    }

    method irHaciaElSol() {
        direccion = 10
    }

    method escaparDelSol() {
        direccion = -10
    }

    method ponerseParaleloAlSol() {
        direccion = 0
    }

    method acercarseUnPocoAlSol() {
        direccion = (direccion + 1).min(10)
    }

    method alejarseUnPocoDelSol() {
        direccion = (direccion - 1).max(-10)
    }

    method prepararViaje() {
        self.cargarCombustible(30000)
        self.acelerar(5000)
    }

    method estaTranquila() {
        return combustible >= 4000 and velocidad <= 12000
    }

    method recibirAmenaza() {}

    method tienePocaActividad() = true

    method estaDeRelajo() {
        return self.estaTranquila() and self.tienePocaActividad()
    }
}

class NaveBaliza inherits Nave {
    var color = "rojo"
    var cambioDeColor = false

    method cambiarColorDeBaliza(colorNuevo) {
        color = colorNuevo
        cambioDeColor = true
    }

    override method prepararViaje() {
        super()
        self.cambiarColorDeBaliza("verde")
        self.ponerseParaleloAlSol()
    }

    override method estaTranquila() {
        return super() and color != "rojo"
    }

    override method recibirAmenaza() {
        self.irHaciaElSol()
        self.cambiarColorDeBaliza("rojo")
    }
}

class NaveDePasajeros inherits Nave {
    var racionesComida
    var racionesBebida
    var cantPasajeros
    var racionesDeComidaServidas = 0

    method subirPasajeros(unValor) {
        cantPasajeros += unValor
    }

    method bajarPasajeros(unValor) {
        cantPasajeros -= unValor
    }

    method cargarComida(unValor) {
        racionesComida += unValor
    }

    method descargarComida(unValor) {
        racionesComida -= unValor
    }

    method cargarBebidas(unValor) {
        racionesBebida += unValor
    }
    
    method descargarBebidas(unValor) {
        racionesBebida -= unValor
    }

    override method prepararViaje() {
        super()
        self.cargarComida(4)
        self.cargarBebidas(6)
        self.acercarseUnPocoAlSol()
    }

    override method recibirAmenaza() {
        velocidad * 2
        racionesComida -= cantPasajeros
        racionesBebida -= cantPasajeros * 2
    }

}

class NaveDeCombate inherits Nave {
    var estaInvisible
    var tieneMisilesDesplegados
    const mensajesEmitidos = []

    method ponerseVisible() {
        estaInvisible = false
    }

    method ponerseInvisible() {
        estaInvisible = true
    }

    method estaInvisible() = estaInvisible

    method desplegarMisiles() {
        tieneMisilesDesplegados = true
    }

    method replegarMisiles() {
        tieneMisilesDesplegados = false
    }

    method misilesDesplegados() = tieneMisilesDesplegados

    method emitirMensaje(mensaje) {
        mensajesEmitidos.add(mensaje)
    }

    method mensajesEmitidos() {
        return mensajesEmitidos.size()
    }

    method primerMensajeEmitido() {
        return mensajesEmitidos.first()
    }

    method ultimoMensajeEmitido() {
        return mensajesEmitidos.last()
    }

    method esEscueta() {

    }

    method emitioMensaje(mensaje) {
        mensajesEmitidos.contains(mensaje)
    }

    override method prepararViaje() {
        super()
        self.ponerseVisible()
        self.replegarMisiles()
        self.acelerar(15000)
        self.emitirMensaje("Saliendo en mision")
    }

    override method estaTranquila() {
        return super() and !tieneMisilesDesplegados
    }

    override method recibirAmenaza() {
        self.acercarseUnPocoAlSol()
        self.acercarseUnPocoAlSol()
        self.emitirMensaje("Amenaza recibida")
    }
}

class NaveHospital inherits NaveDePasajeros {
    var tienePreparadosLosQuirofanos

    method prepararLosQuirofanos() {
        tienePreparadosLosQuirofanos = true
    }

    override method estaTranquila() {
        return super() and !tienePreparadosLosQuirofanos
    }

    override method recibirAmenaza() {
        self.prepararLosQuirofanos()
    }
}

class NaveDeCombateSigilosa inherits NaveDeCombate {
    override method estaTranquila() {
        return super() and !self.estaInvisible()
    }

    override method recibirAmenaza() {
        self.desplegarMisiles()
        self.ponerseInvisible()   
    }
}