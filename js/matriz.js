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