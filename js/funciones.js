export const mostrarMensaje = (mensaje,clase) => {
    const $ventana_mensaje = document.getElementById("mensaje__sistema");
    const $mensaje_ventana = document.getElementById("mensaje_texto");

    $mensaje_ventana.innerHTML = mensaje;
    $ventana_mensaje.className = "modal_mensaje " + clase;
    $ventana_mensaje.style.right = 0;

    setTimeout(function() {
        $ventana_mensaje.style.right = "-100%";
    },5000)
}

const checkPasswordStrength = (password) => {
    const strongRegex = new RegExp("^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$", "g");
    const mediumRegex = new RegExp("^(?=.{7,})(((?=.*[A-Z])(?=.*[a-z]))|((?=.*[A-Z])(?=.*[0-9]))|((?=.*[a-z])(?=.*[0-9]))).*$", "g");
    const enoughRegex = new RegExp("(?=.{6,}).*", "g");

    if (false == enoughRegex.test(password)) {
        mensaje = "Minimo 8 caractéres"; 
    } else if (strongRegex.test(password)) {
        mensaje = "Fuerte";
    } else if (mediumRegex.test(password)) {
        mensaje = "Media";
    } else {
       mensaje = "Debil";
    }


    return mensaje;
}

function sleep (time) {
    return new Promise((resolve) => setTimeout(resolve, time));
}

/*  Funciones  */
const fadeIn = (element) => {
    element.style.display = "block";
    element.style.opacity = 0.1;
    let op = 0;
    var timer = setInterval(() => {
        if (op >= 1) {
            clearInterval(timer);
        }

        op += 0.1;
        element.style.opacity = op;
    }, 50);
}

const fadeOut = (element,padre) => {
    element.style.opacity = 1;
    let op = 1;
    var timer = setInterval(() => {
        if (op <= 0) {
            clearInterval(timer);
            element.style.display = "none";
            padre.classList.add('oculto');
        }

        op -= 0.1;
        element.style.opacity = op;
    }, 50);
}

export const calcularfechas = (fecha,dias) => {
    const fechaNueva = new Date(fecha);
    const diasAgregar = parseInt(dias);

    fechaNueva.setDate(fechaNueva.getDate() + diasAgregar);

    return fechaNueva.getFullYear()+'-'+(fechaNueva.getMonth()+1).toString().padStart(2, '0')+'-'+fechaNueva.getDate().toString().padStart(2, '0');
}

export const validarExtension = (fileUpload) =>{
    // Obtener nombre de archivo
    let archivo = fileUpload.value,
    // Obtener extensión del archivo
        extension = archivo.substring(archivo.lastIndexOf('.'),archivo.length);
    // Si la extensión obtenida no está incluida en la lista de valores
    // del atributo "accept", mostrar un error.
    if(fileUpload.getAttribute('accept').split(',').indexOf(extension) < 0) {
        return true;
    }else {
        return false;
    }
}


