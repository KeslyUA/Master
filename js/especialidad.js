export const listarEspecialidadesTable = () => {
    let formData = new FormData();
    formData.append("funcion","obtenerEspecialidades");

    const cuerpo = document.getElementById("tablaEspecialidadesBody");
    let fila = 1;

    cuerpo.innerHTML = "";
    try {
        fetch('../inc/busquedas.inc.php',{
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
           data.forEach(element => {
                let row = `<tr>
                    <td>${fila++}</td>
                    <td class="padding20left">${element.cespecialidad}</td>
                    <td>
                        <a href="#" class="actions texto_centro" id="editUbicacion" data-id=${element.idfase}>
                            Editar
                        </a>
                    </td>
                </tr>`;

                cuerpo.insertRow(-1).outerHTML = row;
           })
           /* console.log(estadosTareo) */
        })
    } catch (error) {
        console.log(error.message);
    }
}

export const listarEspecialidades = (select) =>{
    const formData = new FormData();
        formData.append("funcion","obtenerEspecialidades");
        select.innerHTML = `<option value='-1'>Seleccionar</option>`;

        try {
            fetch('../inc/busquedas.inc.php',{
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
               data.forEach(element => {
                    let option = document.createElement("option");
                    option.value = element.idespecialidad;
                    option.innerHTML = element.cespecialidad;
    
                    select.appendChild(option);
               })
            })
        } catch (error) {
            console.log(error.message);
        }
}