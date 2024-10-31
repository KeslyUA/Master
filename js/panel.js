import {asd, buscarDatos, buscarDatosTerceroDB, buscarDatosTerceros} from "./matriz.js";
import {calcularfechas,mostrarMensaje} from "./funciones.js";
import {buscarDatosUsuarios} from "./usuarios.js";
import {buscarProyectos,getColaboradorRegistro,getTareo,listarPadron} from "./padron.js";

const documento = document.getElementById("documento");

const paterno = document.getElementById("paterno");
const materno = document.getElementById("materno");
const nombres = document.getElementById("nombres");
const nacimiento = document.getElementById("nacimiento");
const codigo = document.getElementById("codigo");
const grupo = document.getElementById("grupo");
const planilla = document.getElementById("planilla");   
const cargo = document.getElementById("cargo");
const nacionalidad = document.getElementById("nacionalidad");
const procedencia = document.getElementById("procedencia");
const estado = document.getElementById("estado");
const telefono = document.getElementById("telefono");
const correo = document.getElementById("correo");
const direccion = document.getElementById("direccion");
const dpto = document.getElementById("dpto");
const prov = document.getElementById("prov");
const dist = document.getElementById("dist");
const fecha_ingreso = document.getElementById("fecha_ingreso");
const inicio_contrato = document.getElementById("inicio_contrato");
const fin_contrato = document.getElementById("fin_contrato");
const proyecto = document.getElementById("proyecto");

const encargado = document.getElementById("encargado");
const condicion = document.getElementById("encargado");
const personal = document.getElementById("personal");
const especialidad = document.getElementById("especialidad");
const manoobra = document.getElementById("manoobra");
const proyecto_actual = document.getElementById("proyecto_actual");
const fase_actual = document.getElementById("fase_actual");
const ubicacion = document.getElementById("ubicacion");
const regimen_trabajo = document.getElementById("regimen_trabajo");
const ingreso_obra = document.getElementById("ingreso_obra");
const salida_obra = document.getElementById("salida_obra");
const retorno_programado = document.getElementById("retorno_programado");
const dias_goce = document.getElementById("dias_goce");
const dias_libre = document.getElementById("dias_libre");
const dias_campo = document.getElementById("dias_campo");
const dias_reales = document.getElementById("dias_reales");
const observaciones = document.getElementById("observaciones");
const motivo_descanso = document.getElementById("motivo_descanso");
const fecha_cese = document.getElementById("fecha_cese");
const motivo_cese = document.getElementById("motivo_cese");

const menuList = document.getElementById("menuList");
const opcionesMenu = menuList.querySelectorAll('li');

const codigo_costos = document.getElementById("codigo_costos");
const fileUpload = document.getElementById("fileUpload");

const modalHojaSalida = document.getElementById("hojaSalidaModal");
const vistaPreliminarHojaSalida = document.getElementById("vistaPreliminarHojaSalida");

const p1 = document.getElementById("p1");
const p2 = document.getElementById("p2");
const p3 = document.getElementById("p3");
const p4 = document.getElementById("p4");
const p5 = document.getElementById("p5");
const p6 = document.getElementById("p6");
const p7 = document.getElementById("p7");
const p8 = document.getElementById("p8");
const p9 = document.getElementById("p9");
const p10 = document.getElementById("p10");
const p11 = document.getElementById("p11");
const p12 = document.getElementById("p12");
const p13 = document.getElementById("p13");
const p14 = document.getElementById("p14");
const p15 = document.getElementById("p15");
const p16 = document.getElementById("p16");
const p17 = document.getElementById("p17");
const p18 = document.getElementById("p18");
const p19 = document.getElementById("p19");
const p20 = document.getElementById("p20");
const p21 = document.getElementById("p21");
const p22 = document.getElementById("p22");
const p23 = document.getElementById("p23");
const p24 = document.getElementById("p24");
const p25 = document.getElementById("p25");
const p26 = document.getElementById("p26");
const p27 = document.getElementById("p27");
const p28 = document.getElementById("p28");
const p29 = document.getElementById("p29");
const p30 = document.getElementById("p30");
const p31 = document.getElementById("p31");

const user_doc = document.getElementById("user_doc");
const select = document.getElementById("select_proyectos");

document.addEventListener('DOMContentLoaded', datosUsuarioCabecera);

document.addEventListener('focusin',(e) =>{
    if (e.target.matches(".select")){
        buscarProyectos(e.target);
    }
})

document.addEventListener('keypress',async (e)=>{
    if (e.target.id == 'documento'){
        if (e.keyCode === 13) {
            buscarDatos(e.target.value);
        }
    }else if (e.target.id == 'regimen_trabajo'){
        if (e.keyCode === 13) {
            const regimen = e.target.value.split('/');

            const salida_de_obra = calcularfechas(document.getElementById('ingreso_obra').value,regimen[0]);
            const retorno_programado = calcularfechas(salida_de_obra,regimen[1]);

            document.getElementById('salida_obra').value = salida_de_obra;
            document.getElementById('retorno_programado').value = retorno_programado;
        }
    }else if(e.target.id == 'dias_goce'){
        if (e.keyCode === 13) {
            const valor = parseInt(e.target.value);

            for (let i = 1; i <= valor; i++) {
                let pos = 'p'+i;
                document.getElementById(pos).value = 'A';
            }
        }
    }else if (e.target.id == 'user_doc'){
        if (e.keyCode === 13) {
            buscarDatosUsuarios(e.target.value);
        }
    }else if (e.target.id == 'ubicacion_padron'){
        buscar(document.getElementById(e.target.id).value); 
    }else if (e.target.id == 'documento_tercero'){
        if (e.keyCode === 13) {
            /* buscarDatosTerceros(e.target.value); */
            /* let datoTercero = await buscarDatosTerceroDB(e.target.value);
            console.log(datoTercero)
            if(!datoTercero){
                buscarDatosTerceros(e.target.value);
            } */
           asd(e.target.value);
        }
    }
})

document.addEventListener('click',(e)=>{
    if (e.target.matches(".opciones")){
        e.preventDefault();

        opcionesMenu.forEach(element => {
            element.classList.remove('menu_selected');
        });
    
        e.target.closest('li').classList.add('menu_selected');
    
        //////PARA CARGAR LA PAGINA EXTERNA//////
        LoadElement(e.target.id+'.php');

        return false;
    }else if (e.target.matches(".botones")){
        e.preventDefault();

        if (e.target.closest('a').id == 'grabarDatos')
            grabarDatosMatriz();
        else if (e.target.closest('a').id == 'hojaSalida')
            hojaSalida(proyecto_actual.value);
        else if(e.target.closest('a').id == 'reporteDiario') 
            reporteMatriz();
        else if(e.target.closest('a').id == 'grabarDatosUsuario') 
            grabarDatosUsuario();
        else if (e.target.closest('a').id == "agregaProyectosUsuario")
            agregaProyectosUsuario();
        else if (e.target.closest('a').id == "grabarDatosPadron")
            grabarDatosTareo(codigo_costos.value);
        else if (e.target.closest('a').id == "cargarDatosPadron")
            fileUpload.click();
        else if (e.target.closest('a').id == "descargarPlantilla")
            obtenerDatosPadron();
        else if (e.target.closest('a').id == "descargarReporteTareo")
            obtenerReportePadron();
        else if (e.target.closest('a').id == "grabarDatosTerceros")
            grabarDatosMatrizTerceros();
        return false;
    }else if (e.target.matches(".select")){
        codigo_costos.value= e.target.value;
    }else if (e.target.matches(".modal__body")){
        vistaPreliminarHojaSalida.setAttribute('src',"");
        modalHojaSalida.style.display = 'none';
    }
})

document.addEventListener('change',(e)=>{
    if (e.target.matches(".select") && e.target.id === "select_proyectos"){
        listarPadron(e.target.value);
    }if (e.target.matches(".select") && e.target.id === "select_proyectos_terceros"){
        console.log("listando terceros")
    }if (e.target.matches(".archivo")){
        actualizarPadronExcel(fileUpload.files[0])
    }
})

function reporteMatriz(){
    let formData = new FormData();
    formData.append("funcion","reporteDiario");

    fetch('../inc/reportes.inc.php',{
        method:'POST',
        body:formData
    })
    .then(response => response.json())
    .then(data => {
        window.open("http://localhost/master/documentos/reportes/reportediario.xlsx");
    })
}

function grabarDatosMatriz(){
     //serializar los formulario en javascript
     const datos = new URLSearchParams(new FormData(document.getElementById("data_matriz")));
     datos.append("funcion","grabar");
 
     fetch('../inc/grabar.inc.php',{
         method: 'POST',
         body:datos
     })
     .then(response => response.json())
     .then(data => {
         console.log(data);
     });
 
}

function grabarDatosUsuario(){
    try {
        if (document.getElementById("user_doc").value == "" ) throw new Error('Por favor elija un usuario');
        if (document.getElementById('usuario').value == "") throw new Error('Escribe el usuario');
        if (document.getElementById('clave').value == "") throw new Error('Escriba la clave');
        if (document.getElementById('estado_user').value == "-1") throw new Error('Indique el estado del usuario');

        //serializar los formulario en javascript
        const datos = new URLSearchParams(new FormData(document.getElementById("data_usuarios")));
        datos.append("funcion","grabarUsuario");
        datos.append("proyectos",JSON.stringify(datosProyectos()))

        fetch('../inc/grabar.inc.php',{
            method: 'POST',
            body:datos
        })
        .then(response => response.json())
        .then(data => {
            console.log(data);
        });

    } catch (error) {
        mostrarMensaje(error.message,"msj_error");
    }   
}

function agregaProyectosUsuario(){
    const cuerpo = document.getElementById("tablaProyectosBody");
    
    let fila = document.querySelector("#tablaProyectosBody").getElementsByTagName("tr").length+1;

    let row = `<tr data-grabado="0">
                <td>${fila++}</td>
                <td><input type="number"></td>
                <td><input type="value"></td>
                <td><a href="#" class="item_click_remove texto_centro" ><i class="fas fa-trash-alt"></i></a></td>
            </tr>`;
    
    cuerpo.insertRow(-1).outerHTML = row;
}

function LoadElement(page) {
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
       if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
          document.querySelector(".loader").innerHTML = xmlhttp.responseText;
       }
    }
    xmlhttp.open("GET", page, true);
    xmlhttp.send();
}

const datosProyectos = () => {
    let fila = document.querySelector("#tablaProyectosBody").getElementsByTagName("tr"),
        nreg = fila.length;

    let DATOS = [];

    for (let i = 0; i < nreg; i++) {
        let dato = {};

        if ( fila[i].dataset.grabado  === "0" ) {
            dato['item']        = fila[i].cells[0].innerHTML;
            dato['codigo']      = fila[i].cells[1].children[0].value;
            dato['descripcion'] = fila[i].cells[2].children[0].value;

            DATOS.push(dato);

            fila[i].setAttribute("data-grabado", "1");
        }   
    }

    return DATOS;
}

function datosUsuarioCabecera () {
    let nro_doc = localStorage.getItem("documento"),
        formData = new FormData();
    
    formData.append("funcion","buscarDatosUsuarioSistema");
    formData.append("dni",nro_doc);

    try {
        fetch('../inc/busquedas.inc.php',{
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            document.getElementById("nombreUsuarioSistema").outerHTML = data.datos[0].nombres+' '+data.datos[0].paterno;
            document.getElementById("cargoUsuarioSistema").innerHTML = data.datos[0].cargo;
            document.getElementById("correoUsuarioSistema").innerHTML = data.datos[0].correo;  
        })
    } catch (error) {
        console.log(error.message);
    }

}

async function grabarDatosTareo(proyecto){
    let formData = new FormData();
    let lisTable = datosTareoPersonal(); //obtener tareos de la tabla de la vista
    let listTareoToday = await getTareo(); //obtener tareos del dia
    console.log("lista de la tabla")
    console.log(lisTable)

    //obtener el numero de documento de los registrados de hoy
    const listDocsRegistro = listTareoToday.map(item => item.nrodoc);
    // Filtrar los elementos de lista1 que no están en nrodocLista2
    const listNoRegistrado = lisTable.filter(item => !listDocsRegistro.includes(item.documento));
    listNoRegistrado.map(item => {
        item.fingreso = item.fingreso.trim() === '' ? null : item.fingreso;
    })
    console.log("lista de no registrados");
    console.log(listNoRegistrado)

    formData.append("funcion","grabarEstadosPersonal");
    formData.append("proyecto",proyecto);
    formData.append("datosTareo",JSON.stringify(listNoRegistrado));

    //Agregar en la tabla los no registrados del dia de hoy
    if(listNoRegistrado.length > 0){
        /* Swal.fire({
            title: 'Cargando...',
            text: 'Por favor, espere un momento.',
        }); */
        Swal.showLoading();
        await fetch('../inc/grabar.inc.php',{
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if(data){
                console.log(`agregando ${listNoRegistrado.length} registros`);
                Swal.fire({
                    icon: "success",
                    title: "Guardado Correctamente",
                    text: "Se han guardado los registros exitosamente"
                  });
            }else{
                Swal.fire({
                    icon: "error",
                    title: "Error!",
                    text: "Ha ocurrido un error"
                });
            }
        })
        .catch(error => {
            Swal.fire({
                icon: "error",
                title: "Error!",
                text: "Ha ocurrido un error" + error
            });
        })
    }

    const lisTableStates = lisTable.map(item =>{
        return {nrodoc: item.documento, estado: item.estado};
    })
    console.log("parseado lista de la tabla:");
    console.log(lisTableStates)

    //obtener tareos de hoy y comparar
    
    console.log(listTareoToday);
    /* const filterData = lisTable.filter(item => item.estado !== 'A'); */

    //Obtener listado de tareos que tienen diferente estado al ya registrado en la base de datos
    const result = listTareoToday.filter(item2 => {
        const match = lisTable.find(item1 => item1.documento === item2.nrodoc);
        match.fingreso = match.fingreso.trim() === '' ? null : match.fingreso;
        return match && (match.estado !== item2.estado || match.fingreso != item2.fingreso); // Devolver solo si el estado es diferente
    }).map(item2 => {
        const match = lisTable.find(item1 => item1.documento === item2.nrodoc);

        /* const result = match.fingreso != null ? { ...item2, estado: match.estado, fingreso: match.fingreso } : {...item2, estado: match.estado}; */
        return {...item2, estado: match.estado, fingreso: match.fingreso, item: match.item};
    })

    console.log(result);

    //actualizar estado si encuentra estados diferentes
    if(result.length > 0) {
        formData.set("funcion","actualizarEstadoPersonal");
        formData.append("updateDatosTareo", JSON.stringify(result));
        Swal.showLoading();
        await fetch('../inc/grabar.inc.php',{
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            console.log(data);
            if(data.success){
                console.log(`actualizando ${result.length} registros`);
                Swal.fire({
                    icon: "success",
                    title: "Guardado Correctamente",
                    text: "Se han guardado los registros exitosamente"
                });
            }else{
                Swal.fire({
                    icon: "error",
                    title: "Error!",
                    text: "Ha ocurrido un error"
                });
            }
        })
        .catch(error => {
            Swal.fire({
                icon: "error",
                title: "Error!",
                text: "Ha ocurrido un error" + error
            });
        })
    }
    /* let cc = document.getElementById("select_proyectos");
    listarPadron(cc.value); */
}

/* async function grabarDatosTareo(proyecto){
    let formData = new FormData();
    formData.append("funcion","grabarEstadosPersonal");
    formData.append("proyecto",proyecto);
    let sendData = datosTareoPersonal();
    const filterData = sendData.filter(item => item.estado !== 'A');
    let registrados;

    let estadosTareo = await getTareo()
    console.log(sendData);

    //identificar colaboradores no registrados
    let colaboradorRegistro = await getColaboradorRegistro();
    const listaDocsRegistro = colaboradorRegistro.map(item => item.nrodoc);
    const listaDocsTable = sendData.map(item => item.documento)

    // Filtrar los elementos de lista1 que no están en nrodocLista2
    const colaboradorNoRegistrado = sendData.filter(item => !listaDocsRegistro.includes(item.documento));

    if(colaboradorNoRegistrado.length > 0){
        console.log(`Añadiendo ${colaboradorNoRegistrado.length} no registrodados`)
        formData.append("datosTareo", JSON.stringify(colaboradorNoRegistrado));
        fetch('../inc/grabar.inc.php',{
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(async data => {
            if(data){
                console.log("exitoso");
                Swal.fire({
                    icon: "success",
                    title: "Guardado Correctamente"
                });
                registrados = await getTareo();
                console.log(registrados);
            }else{
                console.log("error");
            }
        })
    }
    
    // verificar que haya registros
    
    let nrodocs = estadosTareo.map(item => {return item.nrodoc});

    const filterExistData = filterData.filter(item => !nrodocs.includes(item.documento));
    console.log(estadosTareo);
    console.log(filterExistData);
    if(filterExistData.length == 0 && registrados.length == 0){
        if(!nrodocs.includes("00000000")){
            console.log("añadiendo dni 00000 porque no hay estados diferentes a 'A'")
            filterExistData[0] = {
                "documento" : "00000000",
                "estado" : "A",
                "ubicacion": "LIMA"
            }
        }
        
    }

    formData.append("datosTareo", JSON.stringify(filterExistData));
    console.log(filterExistData);
    fetch('../inc/grabar.inc.php',{
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if(data){
            console.log(`Añadiendo diferentes ${filterExistData.length} a 'A'`);
            Swal.fire({
                icon: "success",
                title: "Guardado Correctamente"
              });
        }else{
            console.log("error");
        }
    })

    const result = estadosTareo.filter(item2 => {
        const match = filterData.find(item1 => item1.documento === item2.nrodoc);
        return match && match.estado !== item2.estado; // Devolver solo si el estado es diferente
    }).map(item2 => {
        const match = filterData.find(item1 => item1.documento === item2.nrodoc);
        return {...item2, estado: match.estado};
    })
    console.log(result)
    if(result.length > 0) {
        formData.set("funcion","actualizarEstadoPersonal");
        formData.append("updateDatosTareo", JSON.stringify(result));
        fetch('../inc/grabar.inc.php',{
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if(data){
                console.log(`actualizando ${result.length} registros`);
                Swal.fire({
                    icon: "success",
                    title: "Guardado Correctamente"
                  });
            }else{
                console.log("error");
            }
        })
    }
    //const filtrados = datos.filter(item => item.estado !== 'A');
} */

const obtenerDatosPadron = () => {
    let fila = document.querySelector("#tablaPersonalBody").getElementsByTagName("tr"),
        nreg = fila.length,
        formData = new FormData();

    let DATOS = [];

    for (let i = 0; i < nreg; i++) {
        let dato = {};

        dato['item']        = fila[i].cells[0].innerHTML;
        dato['nombres']     = fila[i].cells[1].innerHTML;
        dato['documento']   = fila[i].cells[2].innerHTML;
        dato['ubicacion']   = fila[i].cells[3].innerHTML;
        dato['estado']      = fila[i].cells[5].children[0].value;

        DATOS.push(dato);
    }

    formData.append("padron",JSON.stringify(DATOS));
    formData.append("funcion","plantillaExcel");

    fetch('../inc/exportar.inc.php',{
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data =>{
       window.open("../documentos/plantillas/plantillaRegistros.xlsx");
    })
}

const obtenerReportePadron = async () => {
    Swal.fire({
        title: "Generando el reporte",
        html: "Se están cargando los datos del reporte, por favor, espere",
        timerProgressBar: true,
        didOpen: () => {
          Swal.showLoading();
        }
      })
    let fila = document.querySelector("#tablaPersonalBody").getElementsByTagName("tr"),
        nreg = fila.length,
        formData = new FormData();

    let DATOS = [];
    let datosReporte;

    formData.append("funcion","obtenerTareosProyectoColaborador");
    formData.append("proyecto", codigo_costos.value)

    await fetch('../inc/busquedas.inc.php', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data =>{
        console.log(data);
        datosReporte = data;
    })

    for (let i=0; i < nreg; i++){
        let dato = {};

        dato['item']        = fila[i].cells[0].innerHTML;
        dato['nombres']     = fila[i].cells[1].innerHTML;
        dato['documento']   = fila[i].cells[2].innerHTML;
        dato['proyecto']   = fila[i].cells[3].innerHTML;
        dato['ubicacion']  = fila[i].cells[4].innerHTML;
        dato['cargo'] = datosReporte.colaboradoresProyecto.find(item => item.dni == dato['documento']).cargo;
        /* dato['tareos'] = datosReporte.tareos.filter(item => {
            if(item.nrodoc == dato['documento']){
                return item.estados.split(',');
            }
        }).map(item => item.estados.split(',')) */
        dato['tareos'] = datosReporte.tareos.filter(item => item.nrodoc == dato['documento']).flatMap(item => item.estados.split(','));
        let contador = {};
        dato['tareos'].forEach(item => {
            if (contador[item]) {
                contador[item]++;
            } else {
                contador[item] = 1;
            }
        });
        contador.total = (contador.A || 0) + 
        (contador.D || 0) + 
        (contador.F || 0) + 
        (contador.M || 0) + 
        (contador.V || 0) + 
        (contador.P || 0);
        dato['dias'] = contador;
        DATOS.push(dato);
    }
    console.log(DATOS);
    formData.append("padron",JSON.stringify(DATOS));
    formData.append("funcion","plantillaTareoExcel");

    await fetch('../inc/exportar.inc.php',{
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data =>{
       window.open(`..${data.archivo}`);
    })
    Swal.close();

    
    

    /* for (let i = 0; i < nreg; i++) {
        let dato = {};

        dato['item']        = fila[i].cells[0].innerHTML;
        dato['nombres']     = fila[i].cells[1].innerHTML;
        dato['documento']   = fila[i].cells[2].innerHTML;
        dato['proyecto']   = fila[i].cells[3].innerHTML;
        dato['ubicacion']  = fila[i].cells[4].innerHTML;
        dato['estado']      = fila[i].cells[5].children[0].value;
        //buscarDatosColaborador
        formData.append("funcion","buscarDatosColaborador");
        formData.append("dni",dato['documento']);
        await fetch('../inc/busquedas.inc.php',{
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data =>{
            dato['cargo'] = data.datos.find(item => item.dni == dato['documento']).cargo;
            dato['tareos'] = data.tareo.map(item => item.estado);
        })
        let contador = {};
        dato['tareos'].forEach(item => {
            if (contador[item]) {
                contador[item]++;
            } else {
                contador[item] = 1;
            }
        });
            
        dato['dias'] = contador;
        DATOS.push(dato);
    } 
   console.log(DATOS);
    formData.append("padron",JSON.stringify(DATOS));
    formData.append("funcion","plantillaTareoExcel");

    await fetch('../inc/exportar.inc.php',{
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data =>{
       window.open(`..${data.archivo}`);
    })
    Swal.close();  */
}

const datosTareoPersonal = () =>{
    let fila = document.querySelector("#tablaPersonalBody").getElementsByTagName("tr"),
    nreg = fila.length;

    let DATOS = [];

    for (let i = 0; i < nreg; i++) {
        let dato = {};

        //if ( fila[i].dataset.grabado  === "0" ) {
            dato['documento']   = fila[i].cells[2].innerHTML;
            dato['ubicacion']   = fila[i].cells[4].innerHTML;
            dato['estado']      = fila[i].cells[5].children[0].value;
            dato['fingreso']    = fila[i].cells[7].children[0].value;

            DATOS.push(dato);

            /* fila[i].setAttribute("data-grabado", "1"); */
        //}   
    }


    return DATOS;
}

const actualizarPadronExcel = (archivo) =>{
    try {
        const formData = new FormData();
        formData.append("funcion",'importarArchivo');
        formData.append("archivo",archivo );

        let fila = document.querySelector("#tablaPersonalBody").getElementsByTagName("tr");

        fetch('../inc/importar.inc.php',{
            method: 'POST',
            body: formData,
            cache: 'no-store'
        })
        .then(response => response.json())
        .then(data => {
            console.log(data)
            data.datos.forEach( function(valor, indice) {
                if (fila[indice].cells[2].innerHTML == valor.documento){
                    /* fila[indice].cells[4].innerHTML = valor.ubicacion; */
                    fila[indice].cells[5].children[0].value = valor.estado;
                    /* if(valor.ingreso != null){
                        fila[indice].cells[7].children[0].value = valor.ingreso;
                    } */
                    fila[indice].cells[7].children[0].value = valor.ingreso != null ? valor.ingreso : ''
                }
            });

            // Limpiar el valor del input de archivo
            fileUpload.value = "";
        })
    } catch (error) {
        console.log(error.message);
    }
}

const buscar = (texto) => {
    let input,filter, table, tr, td, i, j, visible;

    input = document.getElementById("ubicacion_padron");
    filter = input.value.toUpperCase();
    table = document.getElementById("tablaPersonalBody");
    tr = table.getElementsByTagName("tr");

    // Loop through all table rows, and hide those who don't match the search query
    for (i = 0; i < tr.length; i++) {
        visible = false;
        /* Obtenemos todas las celdas de la fila, no sólo la primera */
        td = tr[i].getElementsByTagName("td");
        for (j = 0; j < td.length; j++) {
            if (td[j] && td[j].innerHTML.toUpperCase().indexOf(filter) > -1) {
                visible = true;
            }
        }
        if (visible === true) {
            tr[i].style.display = "";
        } else {
            tr[i].style.display = "none";
        }
    }
}

const hojaSalida = (proyecto) =>{
    try {

        if ( documento.value == "" ) throw new Error("Escribe el nro. de documento");

        const datos = new URLSearchParams(new FormData(document.getElementById("data_matriz")));

        datos.append("funcion","hojaSalida");
        datos.append("proyecto",proyecto);
    
        fetch('../inc/reportes.inc.php',{
            method: 'POST',
            body: datos
        })
        .then(response => response.json())
        .then(data => {
            modalHojaSalida.style.display = 'block';
            vistaPreliminarHojaSalida.setAttribute('src',data);
        })
    } catch (error) {
         mostrarMensaje(error.message,"msj_error");
    }
}

const readExcel = (e) => {
    const file = e.target.files[0];
    const reader = new FileReader();

    reader.onload = function(event) {
      const data = new Uint8Array(event.target.result);
      const workbook = XLSX.read(data, { type: 'array' });

      // Aquí puedes acceder a las hojas del libro
      const firstSheetName = workbook.SheetNames[0]; // Nombre de la primera hoja
      const worksheet = workbook.Sheets[firstSheetName];

      // Convertir la hoja a JSON
      const jsonData = XLSX.utils.sheet_to_json(worksheet);
      console.log(jsonData); // Aquí están los datos en formato JSON
}
}

document.getElementById("toggleMenu").addEventListener("click",function(e){
    e.preventDefault();/*  */
    document.getElementById("menu").classList.toggle('active');
})

function grabarDatosMatrizTerceros(){
    //serializar los formulario en javascript
    const datos = new URLSearchParams(new FormData(document.getElementById("data_matriz")));
    datos.append("funcion","grabarDatosTerceros");

    fetch('../inc/grabar.inc.php',{
        method: 'POST',
        body:datos
    })
    .then(response => response.json())
    .then(data => {
        console.log(data);
    });
}

/* document.getElementById("ubigeo").addEventListener("blur", function() {
    console.log("El campo ha perdido el foco");
    getUbigeo(); // Asegúrate de que esta función esté definida
}); */
document.addEventListener("focusout", (e)=>{
    if(e.target.id == 'ubigeo'){
        getUbigeo();
    }
})
function getUbigeo(){
    let ubigeo = document.getElementById("ubigeo").value;
    const formData = new FormData();
    formData.append("funcion","obtenerUbigeo");
    formData.append("ubigeo", ubigeo);
    fetch('../inc/busquedas.inc.php',{
        method: 'POST',
        body:formData
    })
    .then(response => response.json())
    .then(data => {
        console.log(data);
        document.getElementById("dist").value=data.ubigeo.dist;
        document.getElementById("dpto").value=data.ubigeo.dpto;
        document.getElementById("prov").value=data.ubigeo.prov;
    });
}

function obtenerTercero(dni){
    const formData = new FormData();
    formData.append("funcion","obtenerTercero");
    formData.append("dni", dni);
    fetch('../inc/busquedas.inc.php',{
        method: 'POST',
        body:formData
    })
    .then(response => response.json())
    .then(data => {
        console.log(data);
    });
}

