export const listarUbicacionesTable = () => {
    let formData = new FormData();
    formData.append("funcion", "obtenerUbicaciones");

    const cuerpo = document.getElementById("tablaUbicacionesBody");
    let fila = 1;

    cuerpo.innerHTML = "";
    try {
        fetch('../inc/busquedas.inc.php', {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                data.sort((a, b) => a.cubicacion.localeCompare(b.cubicacion));
                data.forEach(element => {
                    let row = `<tr data-id=${element.idubicacion}>
                    <td>${fila++}</td>
                    <td class="padding20left">${element.cubicacion}</td>
                    <td style="display: flex; justify-content: center; gap: 1rem">
                        <a href="#" class="actions texto_centro" id="editUbicacion" data-id=${element.idubicacion}>
                            Editar
                        </a>
                        <a href="#" class="actions texto_centro" id="deleteUbicacion" data-id=${element.idubicacion}>
                            Eliminar
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

export const listarUbicaciones = (select) =>{
    const formData = new FormData();
        formData.append("funcion","obtenerUbicaciones");
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
                    option.value = element.idubicacion;
                    option.innerHTML = element.cubicacion;
    
                    select.appendChild(option);
               })
            })
        } catch (error) {
            console.log(error.message);
        }
}