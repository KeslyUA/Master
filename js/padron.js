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
    getTareoMaxFecha().then(data => {
        estadosTareo = data;
        console.log(data)
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
                    return {...item, estado: user.estado, fregsys: user.fregsys, fingreso: user.fingreso}
                }
                return { ...item, estado: 'A' };
           })
           console.log(data)
           data.datos.forEach(element => {
                let row = `<tr>
                    <td>${fila++}</td>
                    <td class="padding20left">${element.paterno+ ' ' + element.materno + ' ' + element.nombres}</td>
                    <td class="texto_centro">${element.dni}</td>
                    <td class="texto_centro">${element.proyecto}</td>
                    <td class="texto_centro">${element.sucursal}</td>
                    <td><input type="text" value="${element.estado}" class="texto_centro"></td>
                    <td class="texto_centro">${element.fregsys}</td>
                    <td><input type="text" class="texto_centro" value="${element.fingreso != null ? element.fingreso : ''}"></td>
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

export const getColaboradorRegistro = () => {
    let formData = new FormData();
    formData.append("funcion","validarColaborador");

    return fetch('../inc/busquedas.inc.php',{
        method: 'POST',
        body: formData
    }).then(response => response.json())
    .then(data => {return data})
    
}
export const getTareoMaxFecha = () => {
    let formData = new FormData();
    formData.append("funcion","tareosMaxFecha");
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