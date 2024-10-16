import {buscarDatos} from "./matriz.js";
import {calcularfechas,mostrarMensaje} from "./funciones.js";
import {buscarDatosUsuarios} from "./usuarios.js";
import {buscarProyectos,listarPadron} from "./padron.js";

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

document.addEventListener('keypress',(e)=>{
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
        return false;
    }else if (e.target.matches(".select")){
        codigo_costos.value= e.target.value;
    }else if (e.target.matches(".modal__body")){
        vistaPreliminarHojaSalida.setAttribute('src',"");
        modalHojaSalida.style.display = 'none';
    }
})

document.addEventListener('change',(e)=>{
    if (e.target.matches(".select")){
        listarPadron(e.target.value);
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

function grabarDatosTareo(proyecto){
    let formData = new FormData();
    formData.append("funcion","grabarEstadosPersonal");
    formData.append("proyecto",proyecto);
    formData.append("datosTareo",JSON.stringify(datosTareoPersonal()));

    fetch('../inc/grabar.inc.php',{
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        console.log(data);
    })

}

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
       window.open("http://localhost/master/documentos/plantillas/plantillaRegistros.xlsx");        ;
    })
}

const datosTareoPersonal = () =>{
    let fila = document.querySelector("#tablaPersonalBody").getElementsByTagName("tr"),
    nreg = fila.length;

    let DATOS = [];

    for (let i = 0; i < nreg; i++) {
        let dato = {};

        if ( fila[i].dataset.grabado  === "0" ) {
            dato['documento']   = fila[i].cells[2].innerHTML;
            dato['ubicacion']   = fila[i].cells[4].innerHTML;
            dato['estado']      = fila[i].cells[5].children[0].value;

            DATOS.push(dato);

            fila[i].setAttribute("data-grabado", "1");
        }   
    }

    console.log(DATOS);

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
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            data.datos.forEach( function(valor, indice) {
                if (fila[indice].cells[2].innerHTML == valor.documento){
                    fila[indice].cells[3].innerHTML = valor.ubicacion;
                    fila[indice].cells[4].children[0].value = valor.estado;
                    fila[indice].cells[5].innerHTML = valor.ingreso;
                }
            });
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

