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
    formData.append("tercero", document.getElementById("tablaPersonal").getAttribute("tercero"))

    const cuerpo = document.getElementById("tablaPersonalBody");
    let fila = 1;

    cuerpo.innerHTML = ""; 
    let estadosTareo
    getTareoMaxFecha(cc).then(data => {
        estadosTareo = data;
    });
    let todosTareo
    getTodosDatosTareo().then(data => {
        todosTareo = data;
    })
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
                    return {...item, estado: user.estado, fmodificacion: user.fmodificacion, fingreso: user.fingreso}
                }
                return { ...item, estado: 'A' };
           })
           const filteredData = data.datos.filter(d => new Date(d.ingreso) <= new Date().setHours(0, 0, 0, 0))
           filteredData.forEach(element => {
            const ubicacion = todosTareo.find(item => item.nddoc == element.dni);
                let row = `<tr>
                    <td>${fila++}</td>
                    <td class="padding20left">${element.paterno+ ' ' + element.materno + ' ' + element.nombres}</td>
                    <td class="texto_centro">${element.dni}</td>
                    <td class="texto_centro">${element.proyecto}</td>
                    <td class="texto_centro">${ubicacion != undefined ? ubicacion.cubicacion : element.sucursal}</td>
                    <td><input type="text" value="${element.estado}" class="texto_centro"></td>
                    <td class="texto_centro">${element.fmodificacion != null ? element.fmodificacion : ''}</td>
                    <td><input type="text" class="texto_centro" value="${element.fingreso != null ? element.fingreso : ''}"></td>
                </tr>`;

                cuerpo.insertRow(-1).outerHTML = row;
           })
        })
    } catch (error) {
        console.log(error.message);
    }
}

export const listarPadronByFecha = (cc, fecha) => {
    let formData = new FormData();
    formData.append("funcion","listarPadron");
    formData.append("costos",cc);

    const cuerpo = document.getElementById("tablaPersonalBody");
    let fila = 1;

    cuerpo.innerHTML = "";
    let estadosTareo
    getTareosByFecha(cc,fecha).then(data => {
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
                    return {...item, estado: user.estado, fmodificacion: user.fmodificacion, fingreso: user.fingreso}
                }
                return { ...item, estado: 'A' };
           })
           const filteredData = data.datos.filter(d => new Date(d.ingreso) <= new Date(fecha))
            filteredData.forEach(element => {
                let row = `<tr>
                    <td>${fila++}</td>
                    <td class="padding20left">${element.paterno+ ' ' + element.materno + ' ' + element.nombres}</td>
                    <td class="texto_centro">${element.dni}</td>
                    <td class="texto_centro">${element.proyecto}</td>
                    <td class="texto_centro">${element.sucursal}</td>
                    <td><input type="text" value="${element.estado}" class="texto_centro"></td>
                    <td class="texto_centro">${element.fmodificacion != null ? element.fmodificacion : ''}</td>
                    <td><input type="text" class="texto_centro" value="${element.fingreso != null ? element.fingreso : ''}"></td>
                </tr>`;

                cuerpo.insertRow(-1).outerHTML = row;
           })
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
export const getTareoMaxFecha = (cc) => {
    let formData = new FormData();
    formData.append("funcion","tareosMaxFecha");
    formData.append("tercero", document.getElementById("tablaPersonal").getAttribute("tercero"))
    formData.append("proyecto",cc)
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


export const listarPadronTerceros = async (cc, selectedText) => {
    let formData = new FormData();
    formData.append("funcion","listarPadronTerceros");
    formData.append("proyecto",cc);
    formData.append("tercero", document.getElementById("tablaPersonal").getAttribute("tercero"))

    const cuerpo = document.getElementById("tablaPersonalBody");
    let fila = 1;

    cuerpo.innerHTML = "";
    let estadosTareo
    await getTareoMaxFecha(cc).then(data => {
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
                    return {...item, estado: user.estado, fmodificacion: user.fmodificacion, fingreso: user.fingreso}
                }
                return { ...item, estado: 'A' };
           })
           console.log(data)
           data.datos.forEach(element => {
                let row = `<tr>
                    <td>${fila++}</td>
                    <td class="padding20left">${element.paterno+ ' ' + element.materno + ' ' + element.nombres}</td>
                    <td class="texto_centro">${element.dni}</td>
                    <td class="texto_centro">${element.proyecto} ${selectedText}</td>
                    <td class="texto_centro">${element.sucursal}</td>
                    <td><input type="text" value="${element.estado}" class="texto_centro"></td>
                    <td class="texto_centro">${element.fmodificacion != null ? element.fmodificacion : ''}</td>
                    <td><input type="text" class="texto_centro" value="${element.fingreso != null ? element.fingreso : ''}"></td>
                </tr>`;

                cuerpo.insertRow(-1).outerHTML = row;
           })
        })
    } catch (error) {
        console.log(error.message);
    }
}

export const listarPadronTercerosByFecha = async (cc, selectedText, fecha) => {
    let formData = new FormData();
    formData.append("funcion","listarPadronTerceros");
    formData.append("proyecto",cc);

    const cuerpo = document.getElementById("tablaPersonalBody");
    let fila = 1;

    cuerpo.innerHTML = "";
    let estadosTareo
    await getTareosByFecha(cc,fecha).then(data => {
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
                    return {...item, estado: user.estado, fmodificacion: user.fmodificacion, fingreso: user.fingreso}
                }
                return { ...item, estado: 'A' };
           })
           console.log(data)
           data.datos.forEach(element => {
                let row = `<tr>
                    <td>${fila++}</td>
                    <td class="padding20left">${element.paterno+ ' ' + element.materno + ' ' + element.nombres}</td>
                    <td class="texto_centro">${element.dni}</td>
                    <td class="texto_centro">${element.proyecto} ${selectedText}</td>
                    <td class="texto_centro">${element.sucursal}</td>
                    <td><input type="text" value="${element.estado}" class="texto_centro"></td>
                    <td class="texto_centro">${element.fmodificacion != null ? element.fmodificacion : ''}</td>
                    <td><input type="text" class="texto_centro" value="${element.fingreso != null ? element.fingreso : ''}"></td>
                </tr>`;

                cuerpo.insertRow(-1).outerHTML = row;
           })
        })
    } catch (error) {
        console.log(error.message);
    }
}

export const getTareosByFecha = (cc, fecha) => {
    let formData = new FormData();
    formData.append("funcion","getTareosByFecha");
    formData.append("fecha",fecha);
    formData.append("proyecto",cc)
    return fetch('../inc/busquedas.inc.php',{
        method: 'POST',
        body: formData
    }).then(response => response.json())
    .then(data => {return data})
}

export const getTodosDatosTareo = () => {
    let formData = new FormData();
    formData.append("funcion","obtenerTodosDatosTareo");
    return fetch('../inc/busquedas.inc.php',{
        method: 'POST',
        body: formData
    }).then(response => response.json())
    .then(data => {return data})
}