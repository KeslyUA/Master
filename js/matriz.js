const ingreso_obra = document.getElementById("ingreso_obra");

export const buscarDatos = (dni) =>{
    let formData = new FormData();
    
    formData.append('funcion','buscarDatosColaborador');
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
}

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
            console.log(data);
            console.log(document.getElementById("data_matriz"));
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
export const asd = (dni) =>{
    const formData = new FormData();
    formData.append("funcion","asd");
    formData.append("dni", dni);
    fetch('../inc/busquedas.inc.php',{
        method: 'POST',
        body:formData
    })
    .then(response => response.json())
    .then(data => {
        console.log(data);
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
            ubigeo.value            = data.datos['ubigeo'];
            empresa.value           = data.datos['empresa'];

            dpto.value          = data.ubigeo['dpto'];
            prov.value          = data.ubigeo['prov'];
            dist.value          = data.ubigeo['dist'];

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
                document.getElementById("data_matriz")[0].reset();
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

    
export const listarProyectos = (select) =>{
    const formData = new FormData();
        formData.append("funcion","obtenerProyectos");
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
                    option.value = element.ccodproy;
                    option.innerHTML = element.cdesproy;
    
                    select.appendChild(option);
               })
            })
        } catch (error) {
            console.log(error.message);
        }
}