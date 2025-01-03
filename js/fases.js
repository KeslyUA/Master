export const listarFases = async (select) =>{
    const formData = new FormData();
        formData.append("funcion","obtenerFases");
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
                    option.value = element.idfase;
                    option.innerHTML = element.cnombre+ " "+element.cdescripcion;
    
                    select.appendChild(option);
               })
            })
        } catch (error) {
            console.log(error.message);
        }
}

export const listarFasesByProyecto = async (select, cc) => {
    const formData = new FormData();
        formData.append("funcion","obtenerProyectosFases");
        select.innerHTML = `<option value='-1'>Seleccionar</option>`;

        try {
            await fetch('../inc/busquedas.inc.php',{
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                const dataByProyecto = data.filter(item => item.codigoProyecto == cc)
                dataByProyecto.forEach(element => {
                    let option = document.createElement("option");
                    option.value = element.idFase;
                    option.innerHTML = `${element.nombreFase} ${element.descripcionFase}`;
                    select.appendChild(option);
               })
            })
        } catch (error) {
            console.log(error.message);
        }
}

export const listarFasesTable = () => {
    let formData = new FormData();
    formData.append("funcion","obtenerFases");

    const cuerpo = document.getElementById("tablaFasesBody");
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
                let row = `<tr data-id=${element.idfase}>
                    <td>${fila++}</td>
                    <td class="padding20left">${element.cnombre}</td>
                    <td class="texto_centro">${element.cdescripcion}</td>
                    <td style="display: flex; justify-content: center; gap: 1rem">
                        <a href="#" class="actions texto_centro" id="editFase" data-id=${element.idfase}>
                            Editar
                        </a>
                        <a href="#" class="actions texto_centro" id="deleteFase" data-id=${element.idfase}>
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

export const listarProyectosFasesTable = () => {
    let formData = new FormData();
    formData.append("funcion","obtenerProyectosFases");

    const cuerpo = document.getElementById("tablaProyectosFasesBody");
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
                let row = `<tr data-id=${element.idProyectoFase}>
                    <td>${fila++}</td>
                    <td class="padding20left">${element.codigoProyecto}</td>
                    <td class="texto_centro">${element.nombreFase} ${element.descripcionFase}</td>
                    <td style="display: flex; justify-content: center; gap: 1rem">
                        <a href="#" class="actions texto_centro" id="editProyectoFase" data-id=${element.idProyectoFase}>
                            Editar
                        </a>
                        <a href="#" class="actions texto_centro" id="deleteProyectoFase" data-id=${element.idProyectoFase}>
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