export const listarFases = (select) =>{
    const formData = new FormData();
        formData.append("funcion","obtenerFases");
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
                    option.value = element.idfase;
                    option.innerHTML = element.cnombre;
    
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
           console.log(data)
           data.forEach(element => {
                let row = `<tr>
                    <td>${fila++}</td>
                    <td class="padding20left">${element.cnombre}</td>
                    <td class="texto_centro">${element.cdescripcion}</td>
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
           console.log(data)
           data.forEach(element => {
                let row = `<tr>
                    <td>${fila++}</td>
                    <td class="padding20left">${element.codigoProyecto}</td>
                    <td class="texto_centro">${element.nombreFase}</td>
                </tr>`;

                cuerpo.insertRow(-1).outerHTML = row;
           })
           /* console.log(estadosTareo) */
        })
    } catch (error) {
        console.log(error.message);
    }
}