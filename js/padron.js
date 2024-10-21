export const buscarProyectos = (select) =>{
    let nro_doc = localStorage.getItem("documento"),
    formData = new FormData();

    formData.append("funcion","proyectosUsuarios");
    formData.append("dni",nro_doc);

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
                option.value = element.ccodigo;
                option.innerHTML = element.cdescripcion;

                select.appendChild(option);
           })
        })
    } catch (error) {
        console.log(error.message);
    }
} 


export const listarPadron = (cc) => {
    let formData = new FormData();
    formData.append("funcion","listarPadron");
    formData.append("costos",cc);

    const cuerpo = document.getElementById("tablaPersonalBody");
    let fila = 1;

    cuerpo.innerHTML = "";
    let estadosTareo
    getTareo().then(data => {
        estadosTareo = data;
    });
    try {
        fetch('../inc/busquedas.inc.php',{
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            /* data.datos.map(d => {

            }) */
           data.datos = data.datos.map(item => {
                const user = estadosTareo.find(u => u.nrodoc == item.dni);
                if(user){
                    return {...item, estado: user.estado}
                }
                return { ...item, estado: 'A' };
           })
           data.datos.forEach(element => {
                let row = `<tr data-grabado="0">
                    <td>${fila++}</td>
                    <td class="padding20left">${element.paterno+ ' ' + element.materno + ' ' + element.nombres}</td>
                    <td class="texto_centro">${element.dni}</td>
                    <td class="texto_centro">${element.proyecto}</td>
                    <td class="texto_centro">${element.sucursal}</td>
                    <td><input type="text" value="${element.estado}" class="texto_centro"></td>
                    <td class="texto_centro"></td>
                </tr>`;

                cuerpo.insertRow(-1).outerHTML = row;
           })
           /* console.log(estadosTareo) */
        })
    } catch (error) {
        console.log(error.message);
    }
}

export const getTareo = () => {
    let formData = new FormData();
    formData.append("funcion","estadoUsuarioPadron");

    return fetch('../inc/busquedas.inc.php',{
        method: 'POST',
        body: formData
    }).then(response => response.json())
    .then(data => {return data})
    
}

/* const getTareo = () => {
    let formData = new FormData();
    formData.append("funcion", "estadoUsuarioPadron");

    return fetch('../inc/busquedas.inc.php', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        return data; // Devuelve los datos obtenidos
    })
    .catch(error => {
        console.error('Error:', error);
    });
}; */