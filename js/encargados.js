export const listarEncargadosTable = () => {
    let formData = new FormData();
    formData.append("funcion","obtenerEncargados");

    const cuerpo = document.getElementById("tablaEncargadosBody");
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
                let row = `<tr data-id=${element.idencargado}>
                    <td>${fila++}</td>
                    <td class="padding20left">${element.cnumdoc}</td>
                    <td class="texto_centro">${element.cnombrecompleto}</td>
                    <td style="display: flex; justify-content: center; gap: 1rem">
                        <a href="#" class="actions texto_centro" id="editEncargado" data-id=${element.idencargadoproyecto}>
                            Editar
                        </a>
                        <a href="#" class="actions texto_centro" id="deleteEncargado" data-id=${element.idencargadoproyecto}>
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


export const listarEncargadosProyectoTable = () => {
    let formData = new FormData();
    formData.append("funcion","obtenerEncargadosProyecto");

    const cuerpo = document.getElementById("tablaEncargadosProyectoBody");
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
                console.log(data)
                let row = `<tr data-id=${element.idencargadoproyecto}>
                    <td>${fila++}</td>
                    <td class="padding20left">${element.ccodigoproyecto}</td>
                    <td class="texto_centro">${element.nombreCompleto}</td>
                    <td style="display: flex; justify-content: center; gap: 1rem">
                        <a href="#" class="actions texto_centro" id="editEncargadoProyecto" data-id=${element.idencargadoproyecto}>
                            Editar
                        </a>
                        <a href="#" class="actions texto_centro" id="deleteEncargadoProyecto" data-id=${element.idencargadoproyecto}>
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

export const listarEncargados = async (select) =>{
    const formData = new FormData();
        formData.append("funcion","obtenerEncargados");
        select.innerHTML = `<option value='-1'>Seleccionar</option>`;

        try {
            await fetch('../inc/busquedas.inc.php',{
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
               data.forEach(element => {
                    let option = document.createElement("option");
                    option.value = element.idencargado;
                    option.innerHTML = `${element.cnombrecompleto}`;
    
                    select.appendChild(option);
               })
            })
        } catch (error) {
            console.log(error.message);
        }
}

export const listarEncargadosByProyecto = async (select, cc) => {
    const formData = new FormData();
        formData.append("funcion","obtenerEncargadosProyecto");
        select.innerHTML = `<option value='-1'>Seleccionar</option>`;

        try {
            await fetch('../inc/busquedas.inc.php',{
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                const dataByProyecto = data.filter(item => parseInt(item.ccodigoproyecto) == cc)
                dataByProyecto.forEach(element => {
                    let option = document.createElement("option");
                    option.value = element.idencargado;
                    option.innerHTML = element.nombreCompleto;
    
                    select.appendChild(option);
               })
            })
        } catch (error) {
            console.log(error.message);
        }
}