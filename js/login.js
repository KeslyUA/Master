import {mostrarMensaje} from "./funciones.js";
import {$,URLactual} from "./constantes.js";

const boton_login = $.getElementById("bntLogin");
const login_password = $.getElementById("login__password");
const login_name = $.getElementById("login__name");

boton_login.addEventListener("click",(e) => {
    try {
        if (login_name.value == "") throw new Error("No ingreso el usuario");
        if (login_password.value == "") throw new Error("No ingreso la clave");

        const formData = new FormData();
        formData.append('funcion','login');
        formData.append('username', login_name.value);
        formData.append('password', login_password.value);

        fetch('inc/login.inc.php',{
            method: 'POST',
            body: formData
        })
        .then(response =>response.json())
        .then(data =>{
            if (data.respuesta){
                localStorage.setItem('username',data.username);
                localStorage.setItem('documento',data.nro_doc);

                window.location = "php/panel.php";
            }else{
                mostrarMensaje(data.mensaje,"msj_error");
            }
        })
    } catch (error) {
        mostrarMensaje(error.message,"msj_error");
    }
})