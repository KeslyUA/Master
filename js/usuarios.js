export const buscarDatosUsuarios = (dni) =>{
    let formData = new FormData();

    document.getElementById("tablaProyectosBody").innerHTML = "";
    
    formData.append('funcion','existeDatosColaborador');
    formData.append('dni',dni);

    try {
        fetch('../inc/busquedas.inc.php',{
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            user_paterno.value          = data.datos[0]['paterno'];
            user_materno.value          = data.datos[0]['materno'];
            user_nombres.value          = data.datos[0]['nombres'];
            existe.value                = data.registros[0].usuario;

            if (data.registros[0].usuario == 1) {
                registro.value              = data.acceso[0]['freg'];
                usuario.value               = data.acceso[0]['cusername'];
                clave.value                 = data.acceso[0]['cuserpass'];
                estado_user.value           = data.acceso[0]['nflgactivo'] == 1 ? '01' : '02';
                
                let fila = 1;
                const cuerpo = document.getElementById("tablaProyectosBody");

                data.proyectos.forEach(element =>{
                    let row = `<tr class="activity_row_click" data-grabado="1" > 
                                <td>${fila++}</td>
                                <td>${element.ccodigo}</td>
                                <td>${element.cdescripcion}</td>
                                <td><a href="${element.idreg}" class="item_click_remove texto_centro" ><i class="fas fa-trash-alt"></i></a></td>
                            </tr>`;

                    cuerpo.insertRow(-1).outerHTML = row;
                            
                });
            }else{
                registro.value              = "";
                usuario.value               = "";
                clave.value                 = "";
                estado_user.value           = "-1";
            }   
        })
    } catch (error) {
        console.log(error.message);
    }
    

    return true;
}