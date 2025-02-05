import { listarEncargadosByProyecto } from "../js/encargados.js";
import { listarFasesByProyecto } from "../js/fases.js";

const ingreso_obra = document.getElementById("ingreso_obra");

export const buscarDatos = async (dni) =>{
    let formData = new FormData();
    
    formData.append('funcion','buscarDatosColaborador');
    formData.append('dni',dni);

    try {
        await fetch('../inc/busquedas.inc.php',{
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(async data => {
            console.log(data)
            documento.value         =data.datos[0]['dni'];
            paterno.value           = data.datos[0]['paterno'];
            materno.value           = data.datos[0]['materno'];
            nombres.value           = data.datos[0]['nombres'];
            cargo.value             = data.datos[0]['cargo'];
            correo.value            = data.datos[0]['correo'];
            codigo.value            = data.datos[0]['cut'];
            nacimiento.value        = data.datos[0]['nacimiento'];
            direccion.value         = data.datos[0]['direccion'];
            fecha_ingreso.value     = data.datos[0]['ingreso'];
            estado.value            = data.datos[0]['estado'];
            grupo.value             = data.datos[0]['sangre'];
            planilla.value          = data.datos[0]['regimen'];
            nacionalidad.value      = data.datos[0]['pais'];
            telefono.value          = data.datos[0]['telefono'];
            proyecto.value          = data.datos[0]['proyecto'];
            proyecto_actual.value   = data.datos[0]['proyecto'].split(" ")[0];
            regimen_trabajo.value   =data.datos[0]['regimen'].split("")[0];

            dpto.value          = data.ubigeo['dpto'];
            prov.value          = data.ubigeo['prov'];
            dist.value          = data.ubigeo['dist'];

            procedencia.value   = data.datos[0]['cod_pais'] == 144 ? data.origen['dpto'] : data.datos[0]['pais'];
            document.getElementById("foto_personal").style.backgroundImage = `url("https://rrhhperu.sepcon.net/postulanterrhh/documentos/jpg/${data.foto.data}")`
            await listarFasesByProyecto(document.getElementById("fase_actual"), document.getElementById("proyecto_actual").value)
            await listarEncargadosByProyecto(document.getElementById("encargado"), document.getElementById("proyecto_actual").value)
            if (data.datosTareo.length > 0) {
                condicion.value = data.datosTareo[0]['ncondicion'];
                personal.value = data.datosTareo[0]['npersonal'];;
                especialidad.value = data.datosTareo[0]['cespecialidad'];
                manoobra.value = data.datosTareo[0]['nmanoobra'];
                proyecto_actual.value = data.datosTareo[0]['cproyecto'];
                await listarFasesByProyecto(document.getElementById("fase_actual"), document.getElementById("proyecto_actual").value)
                await listarEncargadosByProyecto(document.getElementById("encargado"), document.getElementById("proyecto_actual").value)
                encargado.value = data.datosTareo[0]['cencargado'];    
                fase_actual.value = data.datosTareo[0]['cfase'];
                ubicacion.value = data.datosTareo[0]['cubicacion'];
                regimen_trabajo.value = data.datosTareo[0]['cregimen']; 
                ingreso_obra.value = data.datosTareo[0]['fingreso'];
                salida_obra.value = data.datosTareo[0]['fsalida'];
                retorno_programado.value = data.datosTareo[0]['fretorno'];
                dias_goce.value = data.datosTareo[0]['dgoce'];
                dias_libre.value = data.datosTareo[0]['dlibre'];
                dias_campo.value = data.datosTareo[0]['dcampo'];
                dias_reales.value = data.datosTareo[0]['dreales'];
                observaciones.value = data.datosTareo[0]['cobservaciones'];
                motivo_descanso.value = data.datosTareo[0]['cdescanso'];
                //fecha_cese.value = data.datosTareo[0]['fcese'];
                motivo_cese.value = data.datosTareo[0]['cmotivocese'];
                //2
                turnodia.value = data.datosTareo[0]['turnodia'];
                transito_ingreso=data.datosTareo[0]['transitoin'];
                transito_salida = data.datosTareo[0]['transitosal'];
                regimen.value = data.datosTareo[0]['nregimen'];
                especificacion_contrato.value = data.datosTareo[0]['nespecificacion']
                document.getElementById("existe").value = 1;
            }else{
                /* document.getElementById("data_matriz")[0].reset; */
                encargado.value = -1;
                condicion.value = -1;
                personal.value = -1;
                especialidad.value = -1;
                manoobra.value = -1;
                /* proyecto_actual.value = ''; */
                fase_actual.value = -1;
                ubicacion.value = -1;
                /* regimen_trabajo.value = -1; */
                ingreso_obra.value = null;
                salida_obra.value = null;
                retorno_programado.value = null;
                dias_goce.value = ''; 
                dias_libre.value = '';
                dias_campo.value = '';
                dias_reales.value = '';
                observaciones.value = '';
                transito_ingreso.value = '';
                transito_salida.value = '';
                motivo_descanso.value = -1;
                motivo_cese.value = -1;
                //3
                turnodia.value  = '';
                fecha_cese.value = null;
                regimen.value = -1;
                especificacion_contrato.value = -1;

                document.getElementById("existe").value = 0;
            }

            let valor,index = 1,activos = 0,descanso = 0,medico = 0,color_fondo;

            data.tareo.forEach(element =>{
                color_fondo = "#fff";

                if (element.estado == 'A'){
                    activos++;
                    color_fondo = "#92CDDC"
                }

                valor = "p"+element.dia;
                document.getElementById(valor).value = element.estado;
                document.getElementById(valor).style.backgroundColor = color_fondo;
            })

            document.getElementById('activo').value = activos;
        })
    } catch (error) {
        console.log(error.message);
    }
    

    return true;
}


/* 
export const buscarDatosApellido = async (dni) =>{
    let formData = new FormData();
    
    formData.append('funcion','buscarDatosColaborador');
    formData.append('dni',dni);

    try {
        await fetch('../inc/busquedas.inc.php',{
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(async data => {
            console.log(data)
            documento.value           = data.datos[0]['dni'];
            document.getElementById("paterno").value       =data.datos[0]['paterno'];
            materno.value           = data.datos[0]['materno'];
            nombres.value           = data.datos[0]['nombres'];
            cargo.value             = data.datos[0]['cargo'];
            correo.value            = data.datos[0]['correo'];
            codigo.value            = data.datos[0]['cut'];
            nacimiento.value        = data.datos[0]['nacimiento'];
            direccion.value         = data.datos[0]['direccion'];
            fecha_ingreso.value     = data.datos[0]['ingreso'];
            estado.value            = data.datos[0]['estado'];
            grupo.value             = data.datos[0]['sangre'];
            planilla.value          = data.datos[0]['regimen'];
            nacionalidad.value      = data.datos[0]['pais'];
            telefono.value          = data.datos[0]['telefono'];
            proyecto.value          = data.datos[0]['proyecto'];
            proyecto_actual.value   = data.datos[0]['proyecto'].split(" ")[0];

            dpto.value          = data.ubigeo['dpto'];
            prov.value          = data.ubigeo['prov'];
            dist.value          = data.ubigeo['dist'];

            procedencia.value   = data.datos[0]['cod_pais'] == 144 ? data.origen['dpto'] : data.datos[0]['pais'];
            document.getElementById("foto_personal").style.backgroundImage = `url("https://rrhhperu.sepcon.net/postulanterrhh/documentos/jpg/${data.foto.data}")`
            await listarFasesByProyecto(document.getElementById("fase_actual"), document.getElementById("proyecto_actual").value)
            await listarEncargadosByProyecto(document.getElementById("encargado"), document.getElementById("proyecto_actual").value)
            if (data.datosTareo.length > 0) {
                condicion.value = data.datosTareo[0]['ncondicion'];
                personal.value = data.datosTareo[0]['npersonal'];;
                especialidad.value = data.datosTareo[0]['cespecialidad'];
                manoobra.value = data.datosTareo[0]['nmanoobra'];
                proyecto_actual.value = data.datosTareo[0]['cproyecto'];
                await listarFasesByProyecto(document.getElementById("fase_actual"), document.getElementById("proyecto_actual").value)
                await listarEncargadosByProyecto(document.getElementById("encargado"), document.getElementById("proyecto_actual").value)
                encargado.value = data.datosTareo[0]['cencargado'];    
                fase_actual.value = data.datosTareo[0]['cfase'];
                ubicacion.value = data.datosTareo[0]['cubicacion'];
                regimen_trabajo.value = data.datosTareo[0]['cregimen'];
                ingreso_obra.value = data.datosTareo[0]['fingreso'];
                salida_obra.value = data.datosTareo[0]['fsalida'];
                retorno_programado.value = data.datosTareo[0]['fretorno'];
                dias_goce.value = data.datosTareo[0]['dgoce'];
                dias_libre.value = data.datosTareo[0]['dlibre'];
                dias_campo.value = data.datosTareo[0]['dcampo'];
                dias_reales.value = data.datosTareo[0]['dreales'];
                observaciones.value = data.datosTareo[0]['cobservaciones'];
                motivo_descanso.value = data.datosTareo[0]['cdescanso'];
                //fecha_cese.value = data.datosTareo[0]['fcese'];
                motivo_cese.value = data.datosTareo[0]['cmotivocese'];
                //2
                turnodia.value = data.datosTareo[0]['turnodia'];
                regimen.value = data.datosTareo[0]['nregimen'];
                especificacion_contrato.value = data.datosTareo[0]['nespecificacion']
                document.getElementById("existe").value = 1;
            }else{
                
                encargado.value = -1;
                condicion.value = -1;
                personal.value = -1;
                especialidad.value = -1;
                manoobra.value = -1;
                
                fase_actual.value = -1;
                ubicacion.value = -1;
                regimen_trabajo.value = '';
                ingreso_obra.value = null;
                salida_obra.value = null;
                retorno_programado.value = null;
                dias_goce.value = '';
                dias_libre.value = '';
                dias_campo.value = '';
                dias_reales.value = '';
                observaciones.value = '';
                motivo_descanso.value = -1;
                motivo_cese.value = -1;
                //3
                turnodia.value  = '';
                fecha_cese.value = null;
                regimen.value = -1;
                especificacion_contrato.value = -1;

                document.getElementById("existe").value = 0;
            }

            let valor,index = 1,activos = 0,descanso = 0,medico = 0,color_fondo;

            data.tareo.forEach(element =>{
                color_fondo = "#fff";

                if (element.estado == 'A'){
                    activos++;
                    color_fondo = "#92CDDC"
                }

                valor = "p"+element.dia;
                document.getElementById(valor).value = element.estado;
                document.getElementById(valor).style.backgroundColor = color_fondo;
            })

            document.getElementById('activo').value = activos;
        }) 
    } catch (error) {
        console.log(error.message);
    }
    

    return true;
} */
    

export const buscarDatosTerceros = (dni) =>{
    let formData = new FormData();
    
    formData.append('funcion','buscarDatosTercero');
    formData.append('dni',dni);
    try {
        fetch('../inc/busquedas.inc.php',{
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            document.getElementById("data_matriz")[0].reset();
            paterno.value           = data.apellidoPaterno;
            materno.value           = data.apellidoMaterno;
            nombres.value           = data.nombres;
        })
    }catch(error){
        console.log(error.message);
    }
}

export const buscarDatosTerceroDB = (dni) =>{
    let formData = new FormData();
    
    formData.append('funcion','obtenerTercero');
    formData.append('dni',dni);

    try {
        return fetch('../inc/busquedas.inc.php',{
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            return data;
        })
    }catch(error){
        console.log(error.message);
    }
}
export const buscarDatosColaboradorTercero = (dni) =>{
    const formData = new FormData();
    formData.append("funcion","buscarDatosColaboradorTercero");
    formData.append("dni", dni);
    fetch('../inc/busquedas.inc.php',{
        method: 'POST',
        body:formData
    })
    .then(response => response.json())
    .then(async data => {
        if(data.exist){
            paterno.value           = data.datos['paterno'];
            materno.value           = data.datos['materno'];
            nombres.value           = data.datos['nombres'];
            cargo.value             = data.datos['cargo'];
            correo.value            = data.datos['correo'];
            codigo.value            = data.datos['cut'];
            nacimiento.value        = data.datos['nacimiento'];
            direccion.value         = data.datos['direccion'];
            fecha_ingreso.value     = data.datos['ingreso'];
            estado.value            = data.datos['estado'];
            grupo.value             = data.datos['sangre'];
            planilla.value          = data.datos['regimen'];
            nacionalidad.value      = data.datos['pais'];
            telefono.value          = data.datos['telefono'];
            proyecto.value          = data.datos['proyecto'];
            proyecto_actual.value   = data.datos['proyecto'];
            /* ubigeo.value            = data.datos['ubigeo']; */
            empresa.value           = data.datos['empresa'];
            sucursal.value          = data.datos['sucursal'];

            dpto.value          = data.datos['departamento'];
            prov.value          = data.datos['provincia'];
            dist.value          = data.datos['distrito'];

            await listarFasesByProyecto(document.getElementById("fase_actual"), document.getElementById("proyecto_actual").value)
            await listarEncargadosByProyecto(document.getElementById("encargado"), document.getElementById("proyecto_actual").value)

            if (data.datosTareo.length > 0) {
                /* document.getElementById("data_matriz")[1].reset(); */
                encargado.value = data.datosTareo[0]['cencargado'];
                condicion.value = data.datosTareo[0]['ncondicion'];
                personal.value = data.datosTareo[0]['npersonal'];
                especialidad.value = data.datosTareo[0]['cespecialidad'];
                manoobra.value = data.datosTareo[0]['nmanoobra'];
                proyecto_actual.value = data.datosTareo[0]['cproyecto'];
                fase_actual.value = data.datosTareo[0]['cfase'];
                ubicacion.value = data.datosTareo[0]['cubicacion'];
                regimen_trabajo.value = data.datosTareo[0]['cregimen'];
                ingreso_obra.value = data.datosTareo[0]['fingreso'];
                salida_obra.value = data.datosTareo[0]['fsalida'];
                retorno_programado.value = data.datosTareo[0]['fretorno'];
                dias_goce.value = data.datosTareo[0]['dgoce'];
                dias_libre.value = data.datosTareo[0]['dlibre'];
                dias_campo.value = data.datosTareo[0]['dcampo'];
                dias_reales.value = data.datosTareo[0]['dreales'];
                observaciones.value = data.datosTareo[0]['cobservaciones'];
                motivo_descanso.value = data.datosTareo[0]['cdescanso'];
                //fecha_cese.value = data.datosTareo[0]['fcese'];
                motivo_cese.value = data.datosTareo[0]['cmotivocese'];
                turnodia.value = data.datosTareo[0]['turnodia'];
                regimen.value       = data.datosTareo[0]['nregimen']; 
                especificacion_contrato.value = data.datosTareo[0]['nespecificacion'];
                document.getElementById("existeTerceroTareoData").value = "1";
            }else{
                
                encargado.value = '';
                condicion.value = -1;
                personal.value = -1;
                especialidad.value = '';
                manoobra.value = -1;
                /* proyecto_actual.value = -1; */
                fase_actual.value = '';
                ubicacion.value = '';
               /*  regimen_trabajo.value = -1; */
                ingreso_obra.value = '';
                salida_obra.value = '';
                retorno_programado.value = '';
                 dias_goce.value = ''; 
                dias_libre.value = '';
                dias_campo.value = '';
                dias_reales.value = '';
                observaciones.value = '';
                motivo_descanso.value = '';
                regimen.value = -1; 
                especificacion_contrato.value = -1;
                //fecha_cese.value = data.datosTareo[0]['fcese'];
                motivo_cese.value = '';
                turnodia.value='';
                document.getElementById("existeTerceroTareoData").value = 0;
            }
            let valor,index = 1,activos = 0,descanso = 0,medico = 0,color_fondo;

            data.tareo.forEach(element =>{
                color_fondo = "#fff";

                if (element.estado == 'A'){
                    activos++;
                    color_fondo = "#92CDDC"
                }

                valor = "p"+element.dia;
                document.getElementById(valor).value = element.estado;
                document.getElementById(valor).style.backgroundColor = color_fondo;
            })

            document.getElementById('activo').value = activos;
            document.getElementById('existeTercero').value = 1;
        }
        else {
            document.getElementById("data_matriz").reset();
            documento_tercero.value = data.datos.numeroDocumento;
            paterno.value           = data.datos.apellidoPaterno;
            materno.value           = data.datos.apellidoMaterno;
            nombres.value           = data.datos.nombres;
            dpto.value              = '';
            prov.value              = '';
            dist.value              = '';
            document.getElementById("existeTercero").value = "0";
        }
    });
}
/* export const buscarDatosTerceros = (dni) =>{
    let formData = new FormData();
    
    formData.append('funcion','buscarDatosTercero');
    formData.append('dni',dni);

    try {
        fetch('../inc/busquedas.inc.php',{
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {

            paterno.value           = data.datos[0]['paterno'];
            materno.value           = data.datos[0]['materno'];
            nombres.value           = data.datos[0]['nombres'];
            cargo.value             = data.datos[0]['cargo'];
            correo.value            = data.datos[0]['correo'];
            codigo.value            = data.datos[0]['cut'];
            nacimiento.value        = data.datos[0]['nacimiento'];
            direccion.value         = data.datos[0]['direccion'];
            fecha_ingreso.value     = data.datos[0]['ingreso'];
            estado.value            = data.datos[0]['estado'];
            grupo.value             = data.datos[0]['sangre'];
            planilla.value          = data.datos[0]['regimen'];
            nacionalidad.value      = data.datos[0]['pais'];
            telefono.value          = data.datos[0]['telefono'];
            proyecto.value          = data.datos[0]['proyecto'];
            proyecto_actual.value   = data.datos[0]['proyecto'];

            dpto.value          = data.ubigeo['dpto'];
            prov.value          = data.ubigeo['prov'];
            dist.value          = data.ubigeo['dist'];

            procedencia.value   = data.datos[0]['cod_pais'] == 144 ? data.origen['dpto'] : data.datos[0]['pais'];

            if (data.datosTareo.length > 0) {
                encargado.value = data.datosTareo[0]['cencargado'];
                condicion.value = data.datosTareo[0]['ncondicion'];
                personal.value = data.datosTareo[0]['npersonal'];;
                especialidad.value = data.datosTareo[0]['cespecialidad'];
                manoobra.value = data.datosTareo[0]['nmanoobra'];
                proyecto_actual.value = data.datosTareo[0]['cproyecto'];
                fase_actual.value = data.datosTareo[0]['cfase'];
                ubicacion.value = data.datosTareo[0]['cubicacion'];
                regimen_trabajo.value = data.datosTareo[0]['cregimen'];
                ingreso_obra.value = data.datosTareo[0]['fingreso'];
                salida_obra.value = data.datosTareo[0]['fsalida'];
                retorno_programado.value = data.datosTareo[0]['fretorno'];
                dias_goce.value = data.datosTareo[0]['dgoce'];
                dias_libre.value = data.datosTareo[0]['dlibre'];
                dias_campo.value = data.datosTareo[0]['dcampo'];
                dias_reales.value = data.datosTareo[0]['dreales'];
                observaciones.value = data.datosTareo[0]['cobservaciones'];
                motivo_descanso.value = data.datosTareo[0]['cdescanso'];
                //fecha_cese.value = data.datosTareo[0]['fcese'];
                motivo_cese.value = data.datosTareo[0]['cmotivocese'];
            }else{
                document.getElementById("data_matriz")[0].reset;
            }

            let valor,index = 1,activos = 0,descanso = 0,medico = 0,color_fondo;

            data.tareo.forEach(element =>{
                color_fondo = "#fff";

                if (element.estado == 'A'){
                    activos++;
                    color_fondo = "#92CDDC"
                }

                valor = "p"+index++;
                document.getElementById(valor).value = element.estado;
                document.getElementById(valor).style.backgroundColor = color_fondo;
            })

            document.getElementById('activo').value = activos;
        })
    } catch (error) {
        console.log(error.message);
    }
    

    return true;
} */

    
export const listarProyectos = async (select) =>{
    const formData = new FormData();
        formData.append("funcion","obtenerProyectos");
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
                    option.value = element.ccodproy;
                    option.innerHTML = element.cdesproy;
    
                    select.appendChild(option);
               })
               let option = document.createElement("option");
                    option.value = "390000";
                    option.innerHTML = "390000 EPC RECAPEX II";
    
                    select.appendChild(option);
            })
        } catch (error) {
            console.log(error.message);
        }
}
export const listarRegimen = async (select) =>{
    const formData = new FormData();
        formData.append("funcion","obtenerRegimen");
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
                     option.value = element.idreg; 
                     option.dataset.diasgoce=element.diasgoce; 
                     option.dataset.periodo=element.periodo;
                    option.innerHTML = element.cdescrip;

                    select.appendChild(option);

               });
               select.addEventListener('change',async ()=>{
                const selectgoce = select.options[select.selectedIndex];
                const diasgoce = selectgoce.dataset.diasgoce || "";
                const diacampo = selectgoce.dataset.periodo || "";
                document.getElementById("dias_goce").value = diasgoce;
                document.getElementById("dias_campo").value = diacampo;
               })
               })
               /* selectRegimen.addEventListener("change", (e) => {
                const selectRegimen = data.find(item => item.idreg == e.target.value);
                if (selectRegimen) {
                    iDiasGoce.value = selectRegimen.diasgoce;  // Asigna el valor al input de texto
                } else {
                    iDiasGoce.value = ""; // Si no hay selección válida, limpiar el campo
                }
              /*  let option = document.createElement("option");
                     option.value = ""; 
                    option.innerHTML = "2x1";
    
                )    select.appendChild(option); 
            }); */
        } catch (error) {
            console.log(error.message);
        }
}




