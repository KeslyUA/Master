import { buscarDatosColaboradorTercero, buscarDatos, buscarDatosTerceroDB, buscarDatosTerceros, listarProyectos } from "./matriz.js";
import { calcularfechas, mostrarMensaje } from "./funciones.js";
import { buscarDatosUsuarios } from "./usuarios.js";
import { buscarProyectos, getColaboradorRegistro, getTareo, getTareosByFecha, listarPadron, listarPadronByFecha, listarPadronTerceros, listarPadronTercerosByFecha } from "./padron.js";
import { listarFases, listarFasesByProyecto, listarFasesTable, listarProyectosFasesTable } from "./fases.js";
import { listarEncargados, listarEncargadosByProyecto, listarEncargadosProyectoTable, listarEncargadosTable } from "./encargados.js";
import { listarUbicaciones, listarUbicacionesTable } from "./ubicacion.js";
import { listarEspecialidades, listarEspecialidadesTable } from "./especialidad.js";

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

const ubigeo = document.getElementById("ubigeo");
const empresa = document.getElementById("empresa");
const documento_tercero = document.getElementById("documento_tercero");
const sucursal = document.getElementById("sucursal");

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

const regimen = document.getElementById("regimen");
const especificacion_contrato = document.getElementById("especificacion_contrato");


let username = localStorage.getItem("username");
if (!(username == "admin" || username == "adminrrhh")) {
    document.getElementById("usuarios").style.display = 'none';
}
listarProyectos(document.getElementById("proyecto_actual"));
listarUbicaciones(document.getElementById("ubicacion"));
listarEspecialidades(document.getElementById("especialidad"));

document.addEventListener('DOMContentLoaded', datosUsuarioCabecera);

document.addEventListener('focusin', (e) => {
    if (e.target.matches(".select") && (e.target.id === "select_proyectos" || e.target.id === "select_proyectos_terceros")) {
        buscarProyectos(e.target);
    } else if (e.target.matches(".select") && e.target.id === "proyecto") {
        listarProyectos(e.target);
    }
})

document.addEventListener('keypress', async (e) => {
    if (e.target.id == 'documento') {
        if (e.keyCode === 13) {
            await buscarDatos(e.target.value);
            /* listarFasesByProyecto(document.getElementById("fase_actual"), document.getElementById("proyecto_actual").value)
            listarEncargadosByProyecto(document.getElementById("encargado"), document.getElementById("proyecto_actual").value) */
        }
    } else if (e.target.id == 'regimen_trabajo') {
        if (e.keyCode === 13) {
            const regimen = e.target.value.split('/');

            const salida_de_obra = calcularfechas(document.getElementById('ingreso_obra').value, regimen[0]);
            const retorno_programado = calcularfechas(salida_de_obra, regimen[1]);

            document.getElementById('salida_obra').value = salida_de_obra;
            document.getElementById('retorno_programado').value = retorno_programado;
        }
    } else if (e.target.id == 'dias_goce') {
        if (e.keyCode === 13) {
            const valor = parseInt(e.target.value);

            for (let i = 1; i <= valor; i++) {
                let pos = 'p' + i;
                document.getElementById(pos).value = 'A';
            }
        }
    } else if (e.target.id == 'user_doc') {
        if (e.keyCode === 13) {
            buscarDatosUsuarios(e.target.value);
        }
    } else if (e.target.id == 'ubicacion_padron') {
        buscar(document.getElementById(e.target.id).value);
    } else if (e.target.id == 'documento_tercero') {
        if (e.keyCode === 13) {
            /* buscarDatosTerceros(e.target.value); */
            /* let datoTercero = await buscarDatosTerceroDB(e.target.value);
            if(!datoTercero){
                buscarDatosTerceros(e.target.value);
            } */
            buscarDatosColaboradorTercero(e.target.value);
        }
    }
})

document.addEventListener('click', async (e) => {
    if (e.target.matches(".opciones")) {
        e.preventDefault();

        opcionesMenu.forEach(element => {
            element.classList.remove('menu_selected');
        });

        e.target.closest('li').classList.add('menu_selected');

        //////PARA CARGAR LA PAGINA EXTERNA//////
        LoadElement(e.target.id + '.php');
        if (e.target.id == "terceros") {
            setTimeout(() => {
                listarProyectos(document.getElementById("proyecto"));
                listarProyectos(document.getElementById("proyecto_actual"));
                listarEncargados(document.getElementById("encargado"));
                listarUbicaciones(document.getElementById("ubicacion"));
                listarEspecialidades(document.getElementById("especialidad"));
            }, 100); // Ajusta el tiempo según sea necesario
        } else if (e.target.id == "matriz") {
            setTimeout(() => {
                listarProyectos(document.getElementById("proyecto_actual"));
                listarEncargados(document.getElementById("encargado"));
                listarUbicaciones(document.getElementById("ubicacion"));
                listarEspecialidades(document.getElementById("especialidad"));
            }, 100);
        } else if (e.target.id == "ubicaciones") {
            setTimeout(() => {
                listarUbicacionesTable();
            }, 100);
        } else if (e.target.id == "especialidades") {
            setTimeout(() => {
                listarEspecialidadesTable();
            }, 100);
        }
        return false;
    } else if (e.target.matches(".botones")) {
        e.preventDefault();

        if (e.target.closest('a').id == 'grabarDatos')
            grabarDatosMatriz();
        else if (e.target.closest('a').id == 'hojaSalida')
            hojaSalida(proyecto_actual.value);
        else if (e.target.closest('a').id == 'reporteDiario')
            reporteMatriz();
        else if (e.target.closest('a').id == 'grabarDatosUsuario')
            grabarDatosUsuario();
        else if (e.target.closest('a').id == "agregaProyectosUsuario")
            agregaProyectosUsuario();
        else if (e.target.closest('a').id == "agregaProyectosFases")
            agregaProyectoFase();
        else if (e.target.closest('a').id == "agregaFases")
            agregaFase();
        else if (e.target.closest('a').id == "agregaEncargados")
            agregaEncargado();
        else if (e.target.closest('a').id == "agregaUbicacion")
            agregaUbicacion();
        else if (e.target.closest('a').id == "agregaEncargadosProyecto")
            agregaEncargadoProyectos();
        else if (e.target.closest('a').id == "agregaEspecialidad")
            agregaEspecialidad();
        else if (e.target.closest('a').id == "grabarDatosPadron")
            grabarDatosTareo(codigo_costos.value);
        else if (e.target.closest('a').id == "cargarDatosPadron")
            fileUpload.click();
        else if (e.target.closest('a').id == "descargarPlantilla")
            obtenerDatosPadron();
        else if (e.target.closest('a').id == "descargarReporteTareo")
            obtenerReportePadron();
        /* generarReportePadron(); */
        else if (e.target.closest('a').id == "grabarDatosTerceros")
            grabarDatosMatrizTerceros();
        else if (e.target.closest('a').id == "grabarDatosFases")
            grabarDatosFaseOrProyectoFase();
        else if (e.target.closest('a').id == "grabarDatosEncargados")
            grabarDatosEncargadoOrEncargadoProyectos();
        else if (e.target.closest('a').id == "grabarDatosUbicacion")
            grabarDatosUbicacion();
        else if (e.target.closest('a').id == "grabarDatosEspecialidad")
            grabarDatosEspecialidad();
        return false;
    } else if (e.target.matches(".select")) {
        codigo_costos.value = e.target.value;
    } else if (e.target.matches(".modal__body")) {
        vistaPreliminarHojaSalida.setAttribute('src', "");
        modalHojaSalida.style.display = 'none';
    } else if (e.target.matches(".item_click_remove")) {
        if (e.target.closest('a').id == "deleteProyecto") {
            deleteProyectoUsuario(e.target.closest('a'));
        }

    } else if (e.target.matches(".tablinks")) {
        if (e.target.closest('button')) {
            const ref_id = e.target.getAttribute("ref-id")
            openCity(e, ref_id)
            if (ref_id == "FasesTabContent") {
                listarFasesTable();
            } else if (ref_id == "ProyectoFasesTabContent") {
                listarProyectosFasesTable();
            } else if (ref_id == "EncargadosTabContent") {
                listarEncargadosTable();
            } else if (ref_id == "EncargadosProyectoTabContent") {
                listarEncargadosProyectoTable();
            }
        }
    } else if (e.target.matches(".actions")) {
        if (e.target && e.target.id === 'editEncargado') {
            e.preventDefault();

            // Encontrar la fila a la que pertenece el botón
            const row = e.target.closest('tr');
            if (row) {
                const cells = row.querySelectorAll('td');

                // Convertir las celdas editables en inputs
                const cnumdocCell = cells[1];
                const cnombrecompletoCell = cells[2];

                const cnumdocValue = cnumdocCell.textContent.trim();
                const cnombrecompletoValue = cnombrecompletoCell.textContent.trim();

                cnumdocCell.innerHTML = `<input type="text" value="${cnumdocValue}" class="edit-input" />`;
                cnombrecompletoCell.innerHTML = `<input type="text" value="${cnombrecompletoValue}" class="edit-input" />`;

                // Cambiar el icono de edición a guardar
                const editButton = row.querySelector('#editEncargado');
                editButton.innerHTML = `Guardar`;
                editButton.id = 'saveEncargado'; // Cambiar el id para manejar la acción de guardar
            }
        } else if (e.target && e.target.id === 'saveEncargado') {
            e.preventDefault();
            // Encontrar la fila a la que pertenece el botón
            const row = e.target.closest('tr');
            if (row) {
                const cells = row.querySelectorAll('td');

                // Obtener los valores de los inputs
                const cnumdocInput = cells[1].querySelector('input').value.trim();
                const cnombrecompletoInput = cells[2].querySelector('input').value.trim();
                const idEncargado = row.getAttribute("data-id")
                const user = localStorage.getItem('username')

                // Reemplazar los inputs con los nuevos valores
                cells[1].textContent = cnumdocInput;
                cells[2].textContent = cnombrecompletoInput;

                // Cambiar el icono de guardar a edición
                const saveButton = row.querySelector('#saveEncargado');
                saveButton.innerHTML = `Editar`;
                saveButton.id = 'editEncargado'; // Cambiar el id para manejar la acción de edición
                let formData = new FormData();
                formData.append("funcion", "actualizarEncargado");
                formData.append("encargado", JSON.stringify({ nombres: cnombrecompletoInput, numdoc: cnumdocInput, idEncargado: idEncargado, user: user }))
                try {
                    fetch('../inc/grabar.inc.php', {
                        method: 'POST',
                        body: formData
                    })
                        .then(response => response.json())
                        .then(data => {
                        })
                } catch (error) {
                    console.log(error.message);
                }
            }
        } else if (e.target && e.target.id === 'deleteEncargado'){
            e.preventDefault();
            Swal.fire({
                title: "¿Estás seguro de eliminar este jefe inmediato?",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "Si, Eliminar!",
                cancelButtonText: "No, Cancelar"
              }).then((result) => {
                if (result.isConfirmed) {
                    const row = e.target.closest('tr');
                    if (row) {
                        const idEncargado = row.getAttribute("data-id")

                        const user = localStorage.getItem('username')

                        let formData = new FormData();
                        formData.append("funcion", "eliminarEncargado");
                        formData.append("encargado", JSON.stringify({ user: user, idEncargado: idEncargado }))
                        try {
                            fetch('../inc/grabar.inc.php', {
                                method: 'POST',
                                body: formData
                            })
                                .then(response => response.json())
                                .then(data => {
                                })
                        } catch (error) {
                            console.log(error.message);
                        }
                    }
                  Swal.fire({
                    title: "Eliminado!",
                    text: "Haz eliminado esta fase del proyecto",
                    icon: "success"
                  });
                }
              });
        } else if (e.target && e.target.id === 'editFase') {
            e.preventDefault();

            // Encontrar la fila a la que pertenece el botón
            const row = e.target.closest('tr');
            if (row) {
                const cells = row.querySelectorAll('td');

                // Convertir las celdas editables en inputs
                const cnombrefaseCell = cells[1];
                const cdescripcionCell = cells[2];

                const cnombrefaseValue = cnombrefaseCell.textContent.trim();
                const cdescripcionValue = cdescripcionCell.textContent.trim();

                cnombrefaseCell.innerHTML = `<input type="text" value="${cnombrefaseValue}" class="edit-input" />`;
                cdescripcionCell.innerHTML = `<input type="text" value="${cdescripcionValue}" class="edit-input" />`;

                // Cambiar el icono de edición a guardar
                const editButton = row.querySelector('#editFase');
                editButton.innerHTML = `Guardar`;
                editButton.id = 'saveFase'; // Cambiar el id para manejar la acción de guardar
            }
        } else if (e.target && e.target.id === 'saveFase') {
            e.preventDefault();
            // Encontrar la fila a la que pertenece el botón
            const row = e.target.closest('tr');
            if (row) {
                const cells = row.querySelectorAll('td');

                // Obtener los valores de los inputs
                const cnombreFaseInput = cells[1].querySelector('input').value.trim();
                const cdescripcionInput = cells[2].querySelector('input').value.trim();
                const idFase = document.getElementById("saveFase").getAttribute("data-id")
                const user = localStorage.getItem('username')

                // Reemplazar los inputs con los nuevos valores
                cells[1].textContent = cnombreFaseInput;
                cells[2].textContent = cdescripcionInput;

                // Cambiar el icono de guardar a edición
                const saveButton = row.querySelector('#saveFase');
                saveButton.innerHTML = `Editar`;
                saveButton.id = 'editFase'; // Cambiar el id para manejar la acción de edición
                let formData = new FormData();
                formData.append("funcion", "actualizarFase");
                formData.append("fase", JSON.stringify({ nombre: cnombreFaseInput, descripcion: cdescripcionInput, idFase: idFase, user: user }))
                try {
                    fetch('../inc/grabar.inc.php', {
                        method: 'POST',
                        body: formData
                    })
                        .then(response => response.json())
                        .then(data => {
                        })
                } catch (error) {
                    console.log(error.message);
                }
            }
        } else if (e.target && e.target.id === 'deleteFase') {
            e.preventDefault();
            Swal.fire({
                title: "¿Estás seguro de eliminar esta fase?",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "Si, Eliminar!",
                cancelButtonText: "No, Cancelar"
              }).then((result) => {
                if (result.isConfirmed) {
                    const row = e.target.closest('tr');
                    if (row) {
                        const idFase = row.getAttribute("data-id")

                        const user = localStorage.getItem('username')

                        let formData = new FormData();
                        formData.append("funcion", "eliminarFase");
                        formData.append("fase", JSON.stringify({ user: user, idFase: idFase }))
                        try {
                            fetch('../inc/grabar.inc.php', {
                                method: 'POST',
                                body: formData
                            })
                                .then(response => response.json())
                                .then(data => {
                                })
                        } catch (error) {
                            console.log(error.message);
                        }
                    }
                  Swal.fire({
                    title: "Eliminado!",
                    text: "Haz eliminado esta fase del proyecto",
                    icon: "success"
                  });
                }
              });
        } else if (e.target && e.target.id === 'editProyectoFase'){
            e.preventDefault();

            // Encontrar la fila a la que pertenece el botón
            const row = e.target.closest('tr');
            if (row) {
                const cells = row.querySelectorAll('td');

                // Convertir las celdas editables en inputs
                const fila = cells[0];
                const cproyectoCell = cells[1];
                const cfaseCell = cells[2];

                const formData = new FormData();
                let dataProyectoFaseById;
                formData.append("funcion", "obtenerProyectosFasesById");
                formData.append("id", row.getAttribute("data-id"));

                try {
                    await fetch('../inc/busquedas.inc.php', {
                        method: 'POST',
                        body: formData
                    })
                        .then(response => response.json())
                        .then(data => {
                           dataProyectoFaseById = data;
                        })
                } catch (error) {
                    console.log(error.message);
                }


                const cproyectoValue = cproyectoCell.textContent.trim();
                const cfaseValue = cfaseCell.textContent.split(" ")[0].trim();

                cproyectoCell.innerHTML = `<select name="select_proyectoFase" class="select_proyectoFase" data-id="proyecto-${fila}" style="width: 100%">
                        <option value="-1">Seleccionar</option>
                    </select>`;
                cfaseCell.innerHTML = `<select name="select_fase" class="select_fase" data-id="fase-${fila}" style="width: 100%">
                        <option value="-1">Seleccionar 1</option>
                    </select>`;

                const selectProyecto = document.querySelector(`.select_proyectoFase[data-id="proyecto-${fila}"]`);
                const selectFase = document.querySelector(`.select_fase[data-id="fase-${fila}"]`);

                await listarProyectos(selectProyecto);  
                await listarFases(selectFase);
                
                selectProyecto.value = dataProyectoFaseById[0].codigoProyecto
                selectFase.value = dataProyectoFaseById[0].idFase

                const editButton = row.querySelector('#editProyectoFase');
                editButton.innerHTML = `Guardar`;
                editButton.id = 'saveProyectoFase';
            }
        } else if (e.target && e.target.id === 'saveProyectoFase'){
            e.preventDefault();
            // Encontrar la fila a la que pertenece el botón
            const row = e.target.closest('tr');
            if (row) {
                const cells = row.querySelectorAll('td');

                // Obtener los valores de los selects
                const cproyectoSelect = cells[1].querySelector('select');
                const cfaseSelect = cells[2].querySelector('select');

                const cproyectoText = cproyectoSelect.options[cproyectoSelect.selectedIndex].text.split(" ")[0].trim();
                const cfaseText = cfaseSelect.options[cfaseSelect.selectedIndex].text.trim();

                const cproyecto = cproyectoSelect.value;
                const idFase = cfaseSelect.value;
                const idProyectoFase = row.getAttribute("data-id")
                const user = localStorage.getItem('username')

                // Reemplazar los inputs con los nuevos valores
                cells[1].textContent = cproyectoText;
                cells[2].textContent = cfaseText;

                // Cambiar el icono de guardar a edición
                const saveButton = row.querySelector('#saveProyectoFase');
                saveButton.innerHTML = `Editar`;
                saveButton.id = 'editProyectoFase'; // Cambiar el id para manejar la acción de edición
                let formData = new FormData();
                formData.append("funcion", "actualizarProyectoFase");
                formData.append("fase", JSON.stringify({ proyecto: cproyecto, fase: idFase, idProyectoFase: idProyectoFase, user: user }))
                try {
                    fetch('../inc/grabar.inc.php', {
                        method: 'POST',
                        body: formData
                    })
                        .then(response => response.json())
                        .then(data => {
                        })
                } catch (error) {
                    console.log(error.message);
                }
            }
        } else if (e.target && e.target.id === 'deleteProyectoFase'){
            e.preventDefault();
            Swal.fire({
                title: "¿Estás seguro de eliminar esta fase del proyecto?",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "Si, Eliminar!",
                cancelButtonText: "No, Cancelar"
              }).then((result) => {
                if (result.isConfirmed) {
                    const row = e.target.closest('tr');
                    if (row) {
                        const idProyectoFase = row.getAttribute("data-id")

                        const user = localStorage.getItem('username')

                        let formData = new FormData();
                        formData.append("funcion", "eliminarProyectoFase");
                        formData.append("proyectoFase", JSON.stringify({ user: user, idProyectoFase: idProyectoFase }))
                        try {
                            fetch('../inc/grabar.inc.php', {
                                method: 'POST',
                                body: formData
                            })
                                .then(response => response.json())
                                .then(data => {
                                })
                        } catch (error) {
                            console.log(error.message);
                        }
                    }
                  Swal.fire({
                    title: "Eliminado!",
                    text: "Haz eliminado esta fase del proyecto",
                    icon: "success"
                  });
                }
              });
            
        } else if (e.target && e.target.id === 'editEncargadoProyecto'){
            e.preventDefault();

            // Encontrar la fila a la que pertenece el botón
            const row = e.target.closest('tr');
            if (row) {
                const cells = row.querySelectorAll('td');

                // Convertir las celdas editables en inputs
                const fila = cells[0];
                const cproyectoCell = cells[1];
                const cencargadoCell = cells[2];

                const formData = new FormData();
                let dataEncargadoProyectoById;
                formData.append("funcion", "obtenerEncargadosProyectoById");
                formData.append("id", row.getAttribute("data-id"));

                try {
                    await fetch('../inc/busquedas.inc.php', {
                        method: 'POST',
                        body: formData
                    })
                        .then(response => response.json())
                        .then(data => {
                            dataEncargadoProyectoById = data;
                        })
                } catch (error) {
                    console.log(error.message);
                }

                const cproyectoValue = cproyectoCell.textContent.trim();
                const cencargadoValue = cencargadoCell.textContent.split(" ")[0].trim();

                cproyectoCell.innerHTML = `<select name="select_proyectoEncargado" class="select_proyectoEncargado" data-id="proyecto-${fila}" style="width: 100%">
                        <option value="-1">Seleccionar</option>
                    </select>`;
                cencargadoCell.innerHTML = `<select name="select_encargado" class="select_encargado" data-id="encargado-${fila}" style="width: 100%">
                        <option value="-1">Seleccionar 1</option>
                    </select>`;

                const selectProyecto = document.querySelector(`.select_proyectoEncargado[data-id="proyecto-${fila}"]`);
                const selectEncargado = document.querySelector(`.select_encargado[data-id="encargado-${fila}"]`);

                await listarProyectos(selectProyecto);  
                await listarEncargados(selectEncargado);
                
                selectProyecto.value = dataEncargadoProyectoById[0].codigoProyecto
                selectEncargado.value = dataEncargadoProyectoById[0].idEncargado

                const editButton = row.querySelector('#editEncargadoProyecto');
                editButton.innerHTML = `Guardar`;
                editButton.id = 'saveEncargadoProyecto';
            }
        }else if (e.target && e.target.id === 'saveEncargadoProyecto'){
            e.preventDefault();
            // Encontrar la fila a la que pertenece el botón
            const row = e.target.closest('tr');
            if (row) {
                const cells = row.querySelectorAll('td');

                // Obtener los valores de los selects
                const cproyectoSelect = cells[1].querySelector('select');
                const cencargadoSelect = cells[2].querySelector('select');

                const cproyectoText = cproyectoSelect.options[cproyectoSelect.selectedIndex].text.split(" ")[0].trim();
                const cencargadoText = cencargadoSelect.options[cencargadoSelect.selectedIndex].text.trim();

                const cproyecto = cproyectoSelect.value;
                const idEncargado = cencargadoSelect.value;
                const idEncargadoProyecto = row.getAttribute("data-id")
                const user = localStorage.getItem('username')

                // Reemplazar los inputs con los nuevos valores
                cells[1].textContent = cproyectoText;
                cells[2].textContent = cencargadoText;

                // Cambiar el icono de guardar a edición
                const saveButton = row.querySelector('#saveEncargadoProyecto');
                saveButton.innerHTML = `Editar`;
                saveButton.id = 'editEncargadoProyecto'; // Cambiar el id para manejar la acción de edición
                let formData = new FormData();
                formData.append("funcion", "actualizarEncargadoProyecto");
                formData.append("proyectoEncargado", JSON.stringify({ proyecto: cproyecto, encargado: idEncargado, idProyectoEncargado: idEncargadoProyecto, user: user }))
                try {
                    fetch('../inc/grabar.inc.php', {
                        method: 'POST',
                        body: formData
                    })
                        .then(response => response.json())
                        .then(data => {
                        })
                } catch (error) {
                    console.log(error.message);
                }
            }
        }else if (e.target && e.target.id === 'deleteEncargadoProyecto'){
            e.preventDefault();
            Swal.fire({
                title: "¿Estás seguro de eliminar este jefe inmediato del proyecto?",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "Si, Eliminar!",
                cancelButtonText: "No, Cancelar"
              }).then((result) => {
                if (result.isConfirmed) {
                    const row = e.target.closest('tr');
                    if (row) {
                        const idProyectoEncargado = row.getAttribute("data-id")

                        const user = localStorage.getItem('username')

                        let formData = new FormData();
                        formData.append("funcion", "eliminarProyectoEncargado");
                        formData.append("proyectoEncargado", JSON.stringify({ user: user, idProyectoEncargado: idProyectoEncargado }))
                        try {
                            fetch('../inc/grabar.inc.php', {
                                method: 'POST',
                                body: formData
                            })
                                .then(response => response.json())
                                .then(data => {
                                })
                        } catch (error) {
                            console.log(error.message);
                        }
                    }
                  Swal.fire({
                    title: "Eliminado!",
                    text: "Haz eliminado esta fase del proyecto",
                    icon: "success"
                  });
                }
            });
        } else if (e.target && e.target.id === 'editEspecialidad'){
            e.preventDefault();

            // Encontrar la fila a la que pertenece el botón
            const row = e.target.closest('tr');
            if (row) {
                const cells = row.querySelectorAll('td');

                // Convertir las celdas editables en inputs
                const cespecialidadCell = cells[1];

                const cespecialidadValue = cespecialidadCell.textContent.trim();

                cespecialidadCell.innerHTML = `<input type="text" value="${cespecialidadValue}" class="edit-input" />`;

                // Cambiar el icono de edición a guardar
                const editButton = row.querySelector('#editEspecialidad');
                editButton.innerHTML = `Guardar`;
                editButton.id = 'saveEspecialidad'; // Cambiar el id para manejar la acción de guardar
            }
        }else if (e.target && e.target.id === 'saveEspecialidad') {
            e.preventDefault();
            // Encontrar la fila a la que pertenece el botón
            const row = e.target.closest('tr');
            if (row) {
                const cells = row.querySelectorAll('td');

                // Obtener los valores de los inputs
                const cespecialidadInput = cells[1].querySelector('input').value.trim();
                const idEspecialidad = row.getAttribute("data-id")
                const user = localStorage.getItem('username')

                // Reemplazar los inputs con los nuevos valores
                cells[1].textContent = cespecialidadInput;

                // Cambiar el icono de guardar a edición
                const saveButton = row.querySelector('#saveEspecialidad');
                saveButton.innerHTML = `Editar`;
                saveButton.id = 'editEspecialidad'; // Cambiar el id para manejar la acción de edición
                let formData = new FormData();
                formData.append("funcion", "actualizarEspecialidad");
                formData.append("especialidad", JSON.stringify({ cespecialidad: cespecialidadInput, user: user, idEspecialidad: idEspecialidad }))
                try {
                    fetch('../inc/grabar.inc.php', {
                        method: 'POST',
                        body: formData
                    })
                        .then(response => response.json())
                        .then(data => {
                        })
                } catch (error) {
                    console.log(error.message);
                }
            }
        }else if (e.target && e.target.id === 'deleteEspecialidad'){
            e.preventDefault();
            Swal.fire({
                title: "¿Estás seguro de eliminar esta especialidad?",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "Si, Eliminar!",
                cancelButtonText: "No, Cancelar"
              }).then((result) => {
                if (result.isConfirmed) {
                    const row = e.target.closest('tr');
                    if (row) {
                        const idEspecialidad = row.getAttribute("data-id")

                        const user = localStorage.getItem('username')

                        let formData = new FormData();
                        formData.append("funcion", "eliminarEspecialidad");
                        formData.append("especialidad", JSON.stringify({ user: user, idEspecialidad: idEspecialidad }))
                        try {
                            fetch('../inc/grabar.inc.php', {
                                method: 'POST',
                                body: formData
                            })
                                .then(response => response.json())
                                .then(data => {
                                })
                        } catch (error) {
                            console.log(error.message);
                        }
                    }
                  Swal.fire({
                    title: "Eliminado!",
                    text: "Haz eliminado esta fase del proyecto",
                    icon: "success"
                  });
                }
            });
        }else if (e.target && e.target.id === 'editUbicacion'){
            e.preventDefault();

            // Encontrar la fila a la que pertenece el botón
            const row = e.target.closest('tr');
            if (row) {
                const cells = row.querySelectorAll('td');

                // Convertir las celdas editables en inputs
                const cespecialidadCell = cells[1];

                const cespecialidadValue = cespecialidadCell.textContent.trim();

                cespecialidadCell.innerHTML = `<input type="text" value="${cespecialidadValue}" class="edit-input" />`;

                // Cambiar el icono de edición a guardar
                const editButton = row.querySelector('#editUbicacion');
                editButton.innerHTML = `Guardar`;
                editButton.id = 'saveUbicacion'; // Cambiar el id para manejar la acción de guardar
            }
        }else if (e.target && e.target.id === 'saveUbicacion') {
            e.preventDefault();
            // Encontrar la fila a la que pertenece el botón
            const row = e.target.closest('tr');
            if (row) {
                const cells = row.querySelectorAll('td');

                // Obtener los valores de los inputs
                const cubicacionInput = cells[1].querySelector('input').value.trim();
                const idUbicacion = row.getAttribute("data-id")
                const user = localStorage.getItem('username')

                // Reemplazar los inputs con los nuevos valores
                cells[1].textContent = cubicacionInput;

                // Cambiar el icono de guardar a edición
                const saveButton = row.querySelector('#saveUbicacion');
                saveButton.innerHTML = `Editar`;
                saveButton.id = 'editUbicacion'; // Cambiar el id para manejar la acción de edición
                let formData = new FormData();
                formData.append("funcion", "actualizarUbicacion");
                formData.append("ubicacion", JSON.stringify({ cubicacion: cubicacionInput, user: user, idUbicacion: idUbicacion }))
                try {
                    fetch('../inc/grabar.inc.php', {
                        method: 'POST',
                        body: formData
                    })
                        .then(response => response.json())
                        .then(data => {
                        })
                } catch (error) {
                    console.log(error.message);
                }
            }
        }else if (e.target && e.target.id === 'deleteUbicacion'){
            e.preventDefault();
            Swal.fire({
                title: "¿Estás seguro de eliminar esta especialidad?",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "Si, Eliminar!",
                cancelButtonText: "No, Cancelar"
              }).then((result) => {
                if (result.isConfirmed) {
                    const row = e.target.closest('tr');
                    if (row) {
                        const idUbicacion = row.getAttribute("data-id")

                        const user = localStorage.getItem('username')

                        let formData = new FormData();
                        formData.append("funcion", "eliminarUbicacion");
                        formData.append("ubicacion", JSON.stringify({ user: user, idUbicacion: idUbicacion }))
                        try {
                            fetch('../inc/grabar.inc.php', {
                                method: 'POST',
                                body: formData
                            })
                                .then(response => response.json())
                                .then(data => {
                                })
                        } catch (error) {
                            console.log(error.message);
                        }
                    }
                  Swal.fire({
                    title: "Eliminado!",
                    text: "Haz eliminado esta fase del proyecto",
                    icon: "success"
                  });
                }
            });
        }
    }
})

document.addEventListener('change', async (e) => {
    if (e.target.matches(".select") && e.target.id === "select_proyectos") {
        listarPadron(e.target.value);
    } if (e.target.matches(".select") && e.target.id === "select_proyectos_terceros") {
        let selectedText = e.target.options[e.target.selectedIndex].text;
        listarPadronTerceros(e.target.value, selectedText);
    } if (e.target.matches(".select") && e.target.id === "select_proyectoFase") {

    } if (e.target.matches(".select") && e.target.id === "select_fase") {
    }
    if (e.target.matches(".select") && e.target.id === "proyecto_actual") {
        await listarFasesByProyecto(document.getElementById("fase_actual"), document.getElementById("proyecto_actual").value)
        await listarEncargadosByProyecto(document.getElementById("encargado"), document.getElementById("proyecto_actual").value)
    }
    if (e.target.matches(".archivo")) {
        actualizarPadronExcel(fileUpload.files[0]);
    } if (e.target.id == "fecha_proceso") {
        /* getTareosByFecha(codigo_costos.value, e.target.value); */
        if (e.target.getAttribute("esTercero") == 1) {
            let selectProy = document.getElementById("select_proyectos_terceros");
            let selectedText = selectProy.options[selectProy.selectedIndex].text;
            listarPadronTercerosByFecha(codigo_costos.value, selectedText, e.target.value)
        } else {
            listarPadronByFecha(codigo_costos.value, e.target.value);
            document.getElementById("fecha_text").textContent = 'Fecha de Proceso: ' + e.target.value;
        }
    } //calcula dias de campo
    if (e.target.id == "salida_obra") {
        const ultimoDiaIngreso = new Date(document.getElementById("salida_obra").value);
        const hoy = new Date();

        const diferenciaEnMilisegundos = hoy - ultimoDiaIngreso;
        ultimoDiaIngreso.setHours(0, 0, 0, 0);
        hoy.setHours(0, 0, 0, 0);

        const diferenciaEnDias = Math.round(diferenciaEnMilisegundos / (1000 * 60 * 60 * 24));

        document.getElementById("dias_campo").value = diferenciaEnDias;

        const partes = document.getElementById("regimen_trabajo").value.split(/[/xX]/);
        const numerador = parseInt(partes[0].trim());
        const denominador = parseInt(partes[1].trim());

        // Verificar que ambos sean números y el denominador no sea cero
        if (!isNaN(numerador) && !isNaN(denominador) && denominador !== 0) {
            const resultado = numerador / denominador;
            document.getElementById("dias_goce").value = parseInt(document.getElementById("dias_campo").value / resultado);
            document.getElementById("")
        }

        const retorno = new Date(document.getElementById("salida_obra").value);

        retorno.setDate(retorno.getDate() + parseInt(document.getElementById("dias_goce").value) + 1)

        const anio = retorno.getFullYear();
        const mes = (retorno.getMonth() + 1).toString().padStart(2, '0'); // Mes con dos dígitos
        const dia = retorno.getDate().toString().padStart(2, '0'); // Día con dos dígitos

        document.getElementById("retorno_programado").value = `${anio}-${mes}-${dia}`;
    }
    if (e.target.id == "regimen_trabajo") {
        const partes = e.target.value.split(/[/xX]/)
        const numerador = parseInt(partes[0].trim());
        const denominador = parseInt(partes[1].trim());

        // Verificar que ambos sean números y el denominador no sea cero
        if (!isNaN(numerador) && !isNaN(denominador) && denominador !== 0) {
            const resultado = numerador / denominador;
            document.getElementById("dias_goce").value = parseInt(document.getElementById("dias_campo").value / resultado);
        }
    }
    if (e.target.id == "dias_campo") {
        const partes = document.getElementById("regimen_trabajo").value.split(/[/xX]/);
        const numerador = parseInt(partes[0].trim());
        const denominador = parseInt(partes[1].trim());

        // Verificar que ambos sean números y el denominador no sea cero
        if (!isNaN(numerador) && !isNaN(denominador) && denominador !== 0) {
            const resultado = numerador / denominador;
            document.getElementById("dias_goce").value = parseInt(e.target.value / resultado);
        }
    }
})

function reporteMatriz() {
    let formData = new FormData();
    formData.append("funcion", "reporteDiario");

    fetch('../inc/reportes.inc.php', {
        method: 'POST',
        body: formData
    })
        .then(response => response.json())
        .then(data => {
            window.open("http://localhost/master/documentos/reportes/reportediario.xlsx");
        })
}

function grabarDatosMatriz() {
    //serializar los formulario en javascript
    const datos = new URLSearchParams(new FormData(document.getElementById("data_matriz")));
    datos.append("funcion", "grabar");
    datos.append("user", localStorage.getItem("username"));
    fetch('../inc/grabar.inc.php', {
        method: 'POST',
        body: datos
    })
        .then(response => response.json())
        .then(data => {
            Swal.fire({
                icon: "success",
                title: "Guardado Correctamente",
                text: "Se han guardado los registros exitosamente"
            });
            document.getElementById("existe").value = 1
        });

}

function grabarDatosUsuario() {
    try {
        if (document.getElementById("user_doc").value == "") throw new Error('Por favor elija un usuario');
        if (document.getElementById('usuario').value == "") throw new Error('Escribe el usuario');
        if (document.getElementById('clave').value == "") throw new Error('Escriba la clave');
        if (document.getElementById('estado_user').value == "-1") throw new Error('Indique el estado del usuario');

        //serializar los formulario en javascript
        const datos = new URLSearchParams(new FormData(document.getElementById("data_usuarios")));
        datos.append("funcion", "grabarUsuario");
        datos.append("proyectos", JSON.stringify(datosProyectos()))

        fetch('../inc/grabar.inc.php', {
            method: 'POST',
            body: datos
        })
            .then(response => response.json())
            .then(data => {
                Swal.fire({
                    icon: "success",
                    title: "Guardado Correctamente",
                    text: "Se han guardado los registros exitosamente"
                });
            });

    } catch (error) {
        /* mostrarMensaje(error.message,"msj_error"); */
        Swal.fire({
            icon: "error",
            title: "Error!",
            text: "Ha ocurrido un error"
        });
    }
}

function grabarDatosFase() {
    try {
        //serializar los formulario en javascript
        const datos = new URLSearchParams(new FormData(document.getElementById("data_fases")));
        datos.append("funcion", "grabarFase");
        datos.append("fases", JSON.stringify(datosFases()))

        fetch('../inc/grabar.inc.php', {
            method: 'POST',
            body: datos
        })
            .then(response => response.json())
            .then(data => {
                Swal.fire({
                    icon: "success",
                    title: "Guardado Correctamente",
                    text: "Se han guardado los registros exitosamente"
                });
            });

    } catch (error) {
        /* mostrarMensaje(error.message,"msj_error"); */
        Swal.fire({
            icon: "error",
            title: "Error!",
            text: "Ha ocurrido un error"
        });
    }
}


function grabarDatosProyectoFase() {
    try {
        //serializar los formulario en javascript
        const datos = new URLSearchParams(new FormData(document.getElementById("data_fases")));
        datos.append("funcion", "grabarProyectoFase");
        datos.append("proyectoFases", JSON.stringify(datosProyectoFases()))

        fetch('../inc/grabar.inc.php', {
            method: 'POST',
            body: datos
        })
            .then(response => response.json())
            .then(data => {
                Swal.fire({
                    icon: "success",
                    title: "Guardado Correctamente",
                    text: "Se han guardado los registros exitosamente"
                });
            });

    } catch (error) {
        /* mostrarMensaje(error.message,"msj_error"); */
        Swal.fire({
            icon: "error",
            title: "Error!",
            text: "Ha ocurrido un error"
        });
    }
}

function grabarDatosFaseOrProyectoFase() {
    const funcion = document.getElementById("function").value;
    if (funcion == "grabarFase") {
        grabarDatosFase();
    } else if (funcion == "grabarProyectoFase") {
        grabarDatosProyectoFase();
    }
}

function grabarDatosEncargados() {
    try {
        //serializar los formulario en javascript
        const datos = new URLSearchParams(new FormData(document.getElementById("data_fases")));
        datos.append("funcion", "grabarEncargado");
        datos.append("encargados", JSON.stringify(datosEncargados()))

        fetch('../inc/grabar.inc.php', {
            method: 'POST',
            body: datos
        })
            .then(response => response.json())
            .then(data => {
                Swal.fire({
                    icon: "success",
                    title: "Guardado Correctamente",
                    text: "Se han guardado los registros exitosamente"
                });
            });

    } catch (error) {
        /* mostrarMensaje(error.message,"msj_error"); */
        Swal.fire({
            icon: "error",
            title: "Error!",
            text: "Ha ocurrido un error" + error.message
        });
    }
}

function grabarDatosEncargadoProyectos() {
    try {
        //serializar los formulario en javascript
        const datos = new URLSearchParams(new FormData(document.getElementById("data_fases")));
        datos.append("funcion", "grabarEncargadoProyecto");
        datos.append("encargadosProyecto", JSON.stringify(datosEncargadoProyectos()))

        fetch('../inc/grabar.inc.php', {
            method: 'POST',
            body: datos
        })
            .then(response => response.json())
            .then(data => {
                Swal.fire({
                    icon: "success",
                    title: "Guardado Correctamente",
                    text: "Se han guardado los registros exitosamente"
                });
            });

    } catch (error) {
        /* mostrarMensaje(error.message,"msj_error"); */
        Swal.fire({
            icon: "error",
            title: "Error!",
            text: "Ha ocurrido un error" + error.message
        });
    }
}

function grabarDatosEncargadoOrEncargadoProyectos() {
    const funcion = document.getElementById("function").value;
    if (funcion == "grabarEncargado") {
        grabarDatosEncargados();
    } else if (funcion == "grabarEncargadoProyecto") {
        grabarDatosEncargadoProyectos();
    }
}

function grabarDatosUbicacion() {
    try {
        //serializar los formulario en javascript
        const datos = new URLSearchParams(new FormData(document.getElementById("data_fases")));
        datos.append("funcion", "grabarUbicacion");
        datos.append("ubicaciones", JSON.stringify(datosUbicacion()))

        fetch('../inc/grabar.inc.php', {
            method: 'POST',
            body: datos
        })
            .then(response => response.json())
            .then(data => {
                Swal.fire({
                    icon: "success",
                    title: "Guardado Correctamente",
                    text: "Se han guardado los registros exitosamente"
                });
            });

    } catch (error) {
        /* mostrarMensaje(error.message,"msj_error"); */
        Swal.fire({
            icon: "error",
            title: "Error!",
            text: "Ha ocurrido un error" + error.message
        });
    }
}

function grabarDatosEspecialidad() {
    try {
        //serializar los formulario en javascript
        const datos = new URLSearchParams(new FormData(document.getElementById("data_fases")));
        datos.append("funcion", "grabarEspecialidad");
        datos.append("especialidades", JSON.stringify(datosEspecialidad()))

        fetch('../inc/grabar.inc.php', {
            method: 'POST',
            body: datos
        })
            .then(response => response.json())
            .then(data => {
                Swal.fire({
                    icon: "success",
                    title: "Guardado Correctamente",
                    text: "Se han guardado los registros exitosamente"
                });
            });

    } catch (error) {
        Swal.fire({
            icon: "error",
            title: "Error!",
            text: "Ha ocurrido un error" + error.message
        });
    }
}

function agregaProyectosUsuario() {
    const cuerpo = document.getElementById("tablaProyectosBody");

    let fila = document.querySelector("#tablaProyectosBody").getElementsByTagName("tr").length + 1;

    let row = `<tr data-grabado="0">
                <td>${fila++}</td>
                <td><input type="number"></td>
                <td><input type="value"></td>
                <td><a href="#" class="item_click_remove texto_centro" ><i class="fas fa-trash-alt"></i></a></td>
            </tr>`;

    cuerpo.insertRow(-1).outerHTML = row;
}

function agregaProyectoFase() {
    const cuerpo = document.getElementById("tablaProyectosFasesBody");

    let fila = document.querySelector("#tablaProyectosFasesBody").getElementsByTagName("tr").length + 1;

    let row = `<tr data-grabado="0">
                <td>${fila++}</td>
                <td>
                    <select name="select_proyectoFase" class="select_proyectoFase" data-id="proyecto-${fila}" style="width: 100%">
                        <option value="-1">Seleccionar</option>
                    </select>
                </td>
                <td>
                    <select name="select_fase" class="select_fase" data-id="fase-${fila}" style="width: 100%">
                        <option value="-1">Seleccionar 1</option>
                    </select>
                </td>
                <td><a href="#" class="item_click_remove texto_centro" ><i class="fas fa-trash-alt"></i></a></td>
            </tr>`;

    cuerpo.insertRow(-1).outerHTML = row;
    const selectNuevoProyecto = document.querySelector(`.select_proyectoFase[data-id="proyecto-${fila}"]`);
    const selectNuevoFase = document.querySelector(`.select_fase[data-id="fase-${fila}"]`);

    // Llenar el select de proyecto y fase para la nueva fila
    listarProyectos(selectNuevoProyecto);  // Asume que listarProyectos llena el select con datos de la base de datos
    listarFases(selectNuevoFase);  // Asume que listarFases llena el select con datos de la base de datos
}

function agregaFase() {
    const cuerpo = document.getElementById("tablaFasesBody");

    let fila = document.querySelector("#tablaFasesBody").getElementsByTagName("tr").length + 1;

    let row = `<tr data-grabado="0">
                <td>${fila++}</td>
                <td>
                    <input type="text">
                </td>
                <td>
                    <input type="text">
                </td>
                <td><a href="#" class="item_click_remove texto_centro" ><i class="fas fa-trash-alt"></i></a></td>
            </tr>`;

    cuerpo.insertRow(-1).outerHTML = row;
}

function agregaEncargado() {
    const cuerpo = document.getElementById("tablaEncargadosBody");

    let fila = document.querySelector("#tablaEncargadosBody").getElementsByTagName("tr").length + 1;

    let row = `<tr data-grabado="0">
                <td>${fila++}</td>
                <td>
                    <input type="text">
                </td>
                <td>
                    <input type="text">
                </td>
                <td><a href="#" class="item_click_remove texto_centro" ><i class="fas fa-trash-alt"></i></a></td>
            </tr>`;

    cuerpo.insertRow(-1).outerHTML = row;
}

function agregaEncargadoProyectos() {
    const cuerpo = document.getElementById("tablaEncargadosProyectoBody");

    let fila = document.querySelector("#tablaEncargadosProyectoBody").getElementsByTagName("tr").length + 1;

    let row = `<tr data-grabado="0">
                <td>${fila++}</td>
                <td>
                    <select name="select_proyectoFase" class="select_proyectoFase" data-id="proyecto-${fila}" style="width: 100%">
                        <option value="-1">Seleccionar</option>
                    </select>
                </td>
                <td>
                    <select name="select_encargado" class="select_encargado" data-id="encargado-${fila}" style="width: 100%">
                        <option value="-1">Seleccionar 1</option>
                    </select>
                </td>
                <td><a href="#" class="item_click_remove texto_centro" ><i class="fas fa-trash-alt"></i></a></td>
            </tr>`;

    cuerpo.insertRow(-1).outerHTML = row;
    const selectNuevoProyecto = document.querySelector(`.select_proyectoFase[data-id="proyecto-${fila}"]`);
    const selectNuevoFase = document.querySelector(`.select_encargado[data-id="encargado-${fila}"]`);

    // Llenar el select de proyecto y fase para la nueva fila
    listarProyectos(selectNuevoProyecto);  // Asume que listarProyectos llena el select con datos de la base de datos
    listarEncargados(selectNuevoFase);  // Asume que listarFases llena el select con datos de la base de datos
}

function agregaUbicacion() {
    const cuerpo = document.getElementById("tablaUbicacionesBody");

    let fila = document.querySelector("#tablaUbicacionesBody").getElementsByTagName("tr").length + 1;

    let row = `<tr data-grabado="0">
                <td>${fila++}</td>
                <td>
                    <input type="text">
                </td>
                <td><a href="#" class="item_click_remove texto_centro" ><i class="fas fa-trash-alt"></i></a></td>
            </tr>`;

    cuerpo.insertRow(-1).outerHTML = row;
    document.getElementById("tablaUbicacionesBody");
    tablaUbicacionesBody.addEventListener('click', eliminarFila);
}
function eliminarFila(event) {
    const fila = event.target.closest('tr');
    fila.remove();
}

function agregaEspecialidad() {
    const cuerpo = document.getElementById("tablaEspecialidadesBody");

    let fila = document.querySelector("#tablaEspecialidadesBody").getElementsByTagName("tr").length + 1;

    let row = `<tr data-grabado="0">
                <td>${fila++}</td>
                <td>
                    <input type="text">
                </td>
                <td><a href="#" class="item_click_remove texto_centro" id="eliminarFila"  ><i class="fas fa-trash-alt"></i></a></td>
            </tr>`;

    cuerpo.insertRow(-1).outerHTML = row;
    const deleteButton = row.querySelector(".eliminarFila");
    deleteButton.addEventListener("click", () => eliminar(deleteButton));
}

function eliminar(button) {
    
    const row = button.closest("tr");

   
    if (row) {
        row.remove();
    }
}

function LoadElement(page) {
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function () {
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

        if (fila[i].dataset.grabado === "0") {
            dato['item'] = fila[i].cells[0].innerHTML;
            dato['codigo'] = fila[i].cells[1].children[0].value;
            dato['descripcion'] = fila[i].cells[2].children[0].value;

            DATOS.push(dato);

            fila[i].setAttribute("data-grabado", "1");
        }
    }

    return DATOS;
}

const datosFases = () => {
    let fila = document.querySelector("#tablaFasesBody").getElementsByTagName("tr"),
        nreg = fila.length;

    let DATOS = [];

    for (let i = 0; i < nreg; i++) {
        let dato = {};

        if (fila[i].dataset.grabado === "0") {
            dato['item'] = fila[i].cells[0].innerHTML;
            dato['nombre'] = fila[i].cells[1].children[0].value;
            dato['descripcion'] = fila[i].cells[2].children[0].value;

            DATOS.push(dato);

            fila[i].setAttribute("data-grabado", "1");
        }
    }

    return DATOS;
}

const datosProyectoFases = () => {
    let fila = document.querySelector("#tablaProyectosFasesBody").getElementsByTagName("tr"),
        nreg = fila.length;

    let DATOS = [];

    for (let i = 0; i < nreg; i++) {
        let dato = {};

        if (fila[i].dataset.grabado === "0") {
            dato['item'] = fila[i].cells[0].innerHTML;
            dato['proyecto'] = fila[i].cells[1].children[0].value;
            dato['fase'] = fila[i].cells[2].children[0].value;

            DATOS.push(dato);

            fila[i].setAttribute("data-grabado", "1");
        }
    }

    return DATOS;
}


const datosEncargados = () => {
    let fila = document.querySelector("#tablaEncargadosBody").getElementsByTagName("tr"),
        nreg = fila.length;

    let DATOS = [];

    for (let i = 0; i < nreg; i++) {
        let dato = {};

        if (fila[i].dataset.grabado === "0") {
            dato['item'] = fila[i].cells[0].innerHTML;
            dato['numdoc'] = fila[i].cells[1].children[0].value;
            dato['nombres'] = fila[i].cells[2].children[0].value;
            /* dato['paterno'] = fila[i].cells[3].children[0].value;
            dato['materno'] = fila[i].cells[4].children[0].value; */

            DATOS.push(dato);

            fila[i].setAttribute("data-grabado", "1");
        }
    }

    return DATOS;
}

const datosEspecialidad = () => {
    let fila = document.querySelector("#tablaEspecialidadesBody").getElementsByTagName("tr"),
        nreg = fila.length;

    let DATOS = [];

    for (let i = 0; i < nreg; i++) {
        let dato = {};

        if (fila[i].dataset.grabado === "0") {
            dato['item'] = fila[i].cells[0].innerHTML;
            dato['especialidad'] = fila[i].cells[1].children[0].value;

            DATOS.push(dato);

            fila[i].setAttribute("data-grabado", "1");
        }
    }

    return DATOS;
}

const datosEncargadoProyectos = () => {
    let fila = document.querySelector("#tablaEncargadosProyectoBody").getElementsByTagName("tr"),
        nreg = fila.length;

    let DATOS = [];

    for (let i = 0; i < nreg; i++) {
        let dato = {};

        if (fila[i].dataset.grabado === "0") {
            dato['item'] = fila[i].cells[0].innerHTML;
            dato['proyecto'] = fila[i].cells[1].children[0].value;
            dato['encargado'] = fila[i].cells[2].children[0].value;

            DATOS.push(dato);

            fila[i].setAttribute("data-grabado", "1");
        }
    }

    return DATOS;
}

const datosUbicacion = () => {
    let fila = document.querySelector("#tablaUbicacionesBody").getElementsByTagName("tr"),
        nreg = fila.length;

    let DATOS = [];

    for (let i = 0; i < nreg; i++) {
        let dato = {};

        if (fila[i].dataset.grabado === "0") {
            dato['item'] = fila[i].cells[0].innerHTML;
            dato['ubicacion'] = fila[i].cells[1].children[0].value;

            DATOS.push(dato);

            fila[i].setAttribute("data-grabado", "1");
        }
    }

    return DATOS;
}

function datosUsuarioCabecera() {
    let nro_doc = localStorage.getItem("documento"),
        formData = new FormData();

    formData.append("funcion", "buscarDatosUsuarioSistema");
    formData.append("dni", nro_doc);

    try {
        fetch('../inc/busquedas.inc.php', {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                document.getElementById("nombreUsuarioSistema").outerHTML = data.datos[0].nombres + ' ' + data.datos[0].paterno;
                document.getElementById("cargoUsuarioSistema").innerHTML = data.datos[0].cargo;
                document.getElementById("correoUsuarioSistema").innerHTML = data.datos[0].correo;
                document.querySelector('.img_user').style.backgroundImage = `url("https://rrhhperu.sepcon.net/postulanterrhh/documentos/jpg/${data.foto.data}")`
            })
    } catch (error) {
        console.log(error.message);
    }

}

async function grabarDatosTareo(proyecto) {
    const fecha = new Date();
    const fechaFormateada = fecha.toLocaleDateString('en-CA');
    const fechaProceso = document.getElementById("fecha_proceso").value;


    let formData = new FormData();
    let lisTable = datosTareoPersonal(); //obtener tareos de la tabla de la vista
    let listTareoToday = await getTareo(); //obtener tareos del dia

    if (fechaFormateada == fechaProceso) {

        const listNoRegistrado = getDocumentosNoRegistrados(listTareoToday, lisTable);

        //Agregar en la tabla los no registrados del dia de hoy
        if (listNoRegistrado.length > 0) {
            grabarNoRegistrados(listNoRegistrado);
        }

        const listStatesChanged = obtenerEstadosCambiados(lisTable, listTareoToday);

        //actualizar estado si encuentra estados diferentes
        if (listStatesChanged.length > 0) {
            actualizarDatosTareo(listStatesChanged)
        }
        /* let cc = document.getElementById("select_proyectos");
        listarPadron(cc.value); */
    } else {
        let tareosByFecha = await getTareosByFecha(proyecto, fechaProceso);
        if(tareosByFecha.length>0){
            const listStatesChanged = obtenerEstadosCambiados(lisTable, tareosByFecha);
            if (listStatesChanged.length > 0) {
                actualizarDatosTareo(listStatesChanged);
            }
        }else {
            const listNoRegistrado = getDocumentosNoRegistrados(tareosByFecha, lisTable);
            if (listNoRegistrado.length > 0) {
                grabarNoRegistradosByFecha(listNoRegistrado, fechaProceso)
            }
            
        }
        
    }

    function getDocumentosNoRegistrados(listaDeTareosDeHoy, listaTabla) {
        const documentosRegistrados = listaDeTareosDeHoy.map(item => item.nrodoc);

        // Filtrar los elementos de lista1 que no están en nrodocLista2
        const documentosNoRegistrados = listaTabla.filter(item => !documentosRegistrados.includes(item.documento));
        documentosNoRegistrados.map(item => {
            item.fingreso = item.fingreso.trim() === '' ? null : item.fingreso;
        })
        return documentosNoRegistrados;
    }

    async function grabarNoRegistrados(NoRegistrados) {
        formData.append("funcion", "grabarEstadosPersonal");
        formData.append("proyecto", proyecto);
        formData.append("datosTareo", JSON.stringify(NoRegistrados));
        Swal.showLoading();
        await fetch('../inc/grabar.inc.php', {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                if (data) {
                    Swal.fire({
                        icon: "success",
                        title: "Guardado Correctamente",
                        text: "Se han guardado los registros exitosamente"
                    });
                } else {
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

    async function grabarNoRegistradosByFecha(NoRegistrados, fechaProceso) {
        formData.append("funcion", "grabarEstadosPersonalByFecha");
        formData.append("proyecto", proyecto);
        formData.append("fechaProceso", fechaProceso)
        formData.append("datosTareo", JSON.stringify(NoRegistrados));
        Swal.showLoading();
        await fetch('../inc/grabar.inc.php', {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                if (data) {
                    Swal.fire({
                        icon: "success",
                        title: "Guardado Correctamente",
                        text: "Se han guardado los registros exitosamente"
                    });
                } else {
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
    async function actualizarDatosTareo(datosActualizar) {
        formData.set("funcion", "actualizarEstadoPersonal");
        formData.append("updateDatosTareo", JSON.stringify(datosActualizar));
        Swal.showLoading();
        await fetch('../inc/grabar.inc.php', {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    Swal.fire({
                        icon: "success",
                        title: "Guardado Correctamente",
                        text: "Se han guardado los registros exitosamente"
                    });
                } else {
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

    function obtenerEstadosCambiados(listaTabla, tareosDeHoy) {
        const lisTableStates = listaTabla.map(item => {
            return { nrodoc: item.documento, estado: item.estado };
        })

        //obtener tareos de hoy y comparar

        /* const filterData = lisTable.filter(item => item.estado !== 'A'); */

        //Obtener listado de tareos que tienen diferente estado al ya registrado en la base de datos
        const result = tareosDeHoy.filter(item2 => {
            const match = listaTabla.find(item1 => item1.documento === item2.nrodoc);
            if (match != undefined) {
                match.fingreso = match.fingreso.trim() === '' ? null : match.fingreso;
                return match && (match.estado !== item2.estado || match.fingreso != item2.fingreso); // Devolver solo si el estado es diferente
            }

        }).map(item2 => {
            const match = listaTabla.find(item1 => item1.documento === item2.nrodoc);

            /* const result = match.fingreso != null ? { ...item2, estado: match.estado, fingreso: match.fingreso } : {...item2, estado: match.estado}; */
            return { ...item2, estado: match.estado, fingreso: match.fingreso, item: match.item };
        })
        return result;
    }
}

const  obtenerDatosPadron = () => {
    let fila = document.querySelector("#tablaPersonalBody").getElementsByTagName("tr"),
        nreg = fila.length,
        formData = new FormData();

    let DATOS = [];

    for (let i = 0; i < nreg; i++) {
        if (window.getComputedStyle(fila[i]).display !== 'none') {
            let dato = {};

            dato['item'] = fila[i].cells[0].innerHTML;
            dato['nombres'] = fila[i].cells[1].innerHTML;
            dato['documento'] = fila[i].cells[2].innerHTML;
            dato['ubicacion'] = fila[i].cells[3].innerHTML;
            dato['estado'] = fila[i].cells[5].children[0].value;

            DATOS.push(dato);
        }

    }

    formData.append("padron", JSON.stringify(DATOS));
    formData.append("funcion", "plantillaExcel");

    fetch('../inc/exportar.inc.php', {
        method: 'POST',
        body: formData
    })
        .then(response => response.json())
        .then(data => {
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

    formData.append("funcion", "obtenerTareosProyectoColaborador");
    formData.append("proyecto", codigo_costos.value)
    formData.append("fechaProceso", document.getElementById("fecha_proceso").value)

    await fetch('../inc/busquedas.inc.php', {
        method: 'POST',
        body: formData
    })
        .then(response => response.json())
        .then(data => {
            datosReporte = data;
        })

    for (let i = 0; i < nreg; i++) {
        if (window.getComputedStyle(fila[i]).display !== 'none') {
            let dato = {};

            dato['item'] = fila[i].cells[0].innerHTML;
            dato['nombres'] = fila[i].cells[1].innerHTML;
            dato['documento'] = fila[i].cells[2].innerHTML;
            dato['proyecto'] = fila[i].cells[3].innerHTML;
            dato['ubicacion'] = fila[i].cells[4].innerHTML.trim();
            dato['cargo'] = datosReporte.colaboradoresProyecto.find(item => item.dni == dato['documento'])?.cargo;
            dato['tareos'] = datosReporte.tareos.filter(item => item.nrodoc == dato['documento']).flatMap(item => item.estados.split(','));
            let tareosDatos = datosReporte.tareos.filter(item => item.nrodoc == dato['documento']);

            // Crear las listas de 'tareos' y 'numDias' de una vez
            let diasTareo = {};
            tareosDatos.forEach(item => {
                let dias = item.dias.split(',');
                let estados = item.estados.split(',');

                dias.forEach((dia, index) => {
                    diasTareo[dia] = estados[index];
                });
            });

            // Asignar la estructura de 'estadosDia'
            dato['estadosDia'] = diasTareo;
            let diasUbicacion = {};
            tareosDatos.forEach(item => {
                let dias = item.dias.split(',');
                let ubicaciones = item.ubicaiones.split(',');
                dias.forEach((dia, index) => {
                    diasUbicacion[dia] = ubicaciones[index];
                })
            })
            dato['ubicacionesDia'] = diasUbicacion;

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
            dato['fechaProceso'] = document.getElementById("fecha_proceso").value
            dato['fase'] = datosReporte.fases.find(fase => fase.nrodoc == dato['documento'])?.fase
            dato['codFase'] = datosReporte.fases.find(fase => fase.nrodoc == dato['documento'])?.cfase
            dato['regimen'] = datosReporte.datosTareo.find(item => item.nddoc == dato['documento'])?.regimen ?? 'No Especificado'
            dato['manoObra'] = datosReporte.datosTareo.find(item => item.nddoc == dato['documento'])?.mano_obra ?? 'No Especificado'
            dato['cut'] = datosReporte.colaboradoresProyecto.find(item => item.dni == dato['documento'])?.cut;
            dato['ingresoObra'] = datosReporte.datosTareo.find(item => item.nddoc == dato['documento'])?.fingreso ?? ''
            dato['ingreso'] = datosReporte.colaboradoresProyecto.find(item => item.dni == dato['documento'])?.ingreso;
            dato['tipoPersonal'] = datosReporte.datosTareo.find(item => item.nddoc == dato['documento'])?.tipoPersonal ?? ''
            dato['procedencia'] = datosReporte.colaboradoresProyecto.find(item => item.dni == dato['documento'])?.dataColab.datos[0].cod_pais == 144 ? datosReporte.colaboradoresProyecto.find(item => item.dni == dato['documento'])?.dataColab.origen['dpto'] :datosReporte.colaboradoresProyecto.find(item => item.dni == dato['documento'])?.dataColab.datos[0].pais;
            dato['diasCampo'] = datosReporte.datosTareo.find(item => item.nddoc == dato['documento'])?.diasCampo
            DATOS.push(dato);
        }

    }
    //const filtradoPorFechaIngreso = DATOS.filter(d => new Date(d.ingreso) <= new Date().setHours(0, 0, 0, 0))
    //console.log(filtradoPorFechaIngreso)
    await PlantillaTareoExcel(JSON.stringify(DATOS), document.getElementById("fecha_proceso").value)
    Swal.close();
}

async function PlantillaTareoExcel(padron, fechaProceso) {
    const workbook = new ExcelJS.Workbook();
    const worksheet = workbook.addWorksheet('Tareo Reporte', {
        views: [{ state: "frozen", xSplit: 5, ySplit: 7 }]
    });

    const datos = JSON.parse(padron);
    const nreg = datos.length;
    const groupByFase = _.groupBy(datos, item => item.codFase)

    const arrayOrdenado = Object.entries(groupByFase)
  .sort(([claveA], [claveB]) => claveA.localeCompare(claveB)); // Ordenar por clave

    // Convertir el array de nuevo a objeto
    const groupByFaseOrdenado = Object.fromEntries(arrayOrdenado);

    const titleStyle = {
        font: {
            name: 'Arial',
            size: 12,
            bold: true
        }
    }

    const headerStyle = {
        fill: {
            type: 'pattern',
            pattern: 'solid',
            fgColor: { argb: '44749F' },
            bgColor: { argb: '44749F' }
        },
        border: {
            top: { style: 'thin' },
            left: { style: 'thin' },
            bottom: { style: 'thin' },
            right: { style: 'thin' }
        },
        alignment: {
            horizontal: 'center',
            vertical: 'middle',
            wrapText: true
        },
        font: {
            name: 'Arial',
            size: 10,
            color: { argb: 'FFFFFF' },
            bold: true
        }
    }

    const dataStyle = {
        alignment: {
            horizontal: 'center',
            vertical: 'middle',
            //wrapText: true
        },
        border: {
            top: { style: 'thin' },
            left: { style: 'thin' },
            bottom: { style: 'thin' },
            right: { style: 'thin' }
        }
    }

    const dataStyleSecondary = {
        alignment: {
            horizontal: 'left',
            vertical: 'middle',
            //wrapText: true
        },
        border: {
            top: { style: 'thin' },
            left: { style: 'thin' },
            bottom: { style: 'thin' },
            right: { style: 'thin' }
        }
    }

    const faseStyle = {
        fill: {
            type: 'pattern',
            pattern: 'solid',
            fgColor: { argb: 'B6DDE8' },
            bgColor: { argb: 'B6DDE8' }
        },
        border: {
            top: { style: 'thin' },
            left: { style: 'thin' },
            bottom: { style: 'thin' },
            right: { style: 'thin' }
        },
        font: {
            name: 'Arial',
            size: 10,
            color: { argb: '000000' },
            bold: true
        }
    }

    const extraStyle = {
        font: {
            name: 'Arial',
            size: 10,
            color: { argb: 'FFFF00' },
            bold: true
        },
        alignment: {
            horizontal: 'center',
            vertical: 'middle',
            wrapText: true
        },
        fill: {
            type: 'pattern',
            pattern: 'solid',
            fgColor: { argb: '002060' },
            bgColor: { argb: '002060' }
        }
    }

    const columns = [
        { width: 10 },
        { width: 5 },
        { width: 8 },
        { width: 15 },
        { width: 45 },
        { width: 15 },
        { width: 12 },
        { width: 6 },
        { width: 14 },
        { width: 8 },
        { width: 40 },
        { width: 18 },
        { width: 25 },
        { width: 15 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 4 },
        { width: 15 },
        { width: 15 },
    ];

    const headersValue = ['ITEM', 'N°', 'CODIGO', 'DNI', 'APELLIDOS Y NOMBRES', 'PROCEDENCIA', 'F.INGRESO', 'TIPO', 'Último Ingreso a Obra', 'Dias en Campo', 'CARGO', 'FASE ACTUAL', 'PROYECTO ACTUAL', 'UBICACIÓN', '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', 'DA', 'DD', 'DF', 'DM', 'DV', 'DP', 'DT', 'Régimen', 'Mano de Obra']

    /* const bgColorStatesValue = {
        'A': '92CDDC',
        'D': 'FF0000',
        'TI': '7030A0',
        'TS': '0070C0',
        'M': 'F5B1DD',
        'LCG': '00B0F0',
        'LSG': 'CCFFCC',
        'SUSP': 'CCC0DA',
        'V': 'FFFF00',
        'TTR': 'FFC000',
        'PU': 'CCC0DA',
        'PI': 'C5DEB5',
        'L': '92D050',
        'TI-S': '7030A0',
        'TS-S': '0070C0'
    } */

        const bgColorStatesValue = {
            'A': { label: 'ACTIVO', color: '92CDDC' },
            'D': { label: 'DESCANSO', color: 'FF0000' },
            'TI': { label: 'TRANSITO INGRESO A OBRA', color: '7030A0' },
            'TS': { label: 'TRANSITO SALIDA DE OBRA', color: '0070C0' },
            'M': { label: 'DESCANSO MEDICO', color: 'F5B1DD' },
            'LCG': { label: 'LICENCIA CON GOCE DE HABER', color: '00B0F0' },
            'LSG': { label: 'LICENCIA SIN GOCE DE HABER', color: 'CCFFCC' },
            'SUSP': { label: 'SUSPENDIDO', color: 'CCC0DA' },
            'V': { label: 'VACACIONES', color: 'FFFF00' },
            'TTR': { label: 'TELETRABAJO', color: 'FFC000' },
            'PU': { label: 'PUCALLPA', color: 'CCC0DA' },
            'PI': { label: 'PISCO', color: 'C5DEB5' },
            'L': { label: 'LIMA', color: '92D050' },
            'TI-S': { label: 'TRANSITO INGRESO A OBRA- STAND BY', color: '7030A0' },
            'TS-S': { label: 'TRANSITO SALIDA DE OBRA- STAND BY', color: '0070C0' }
        };

    const bgColorStatesMap = new Map(Object.entries(bgColorStatesValue));

    worksheet.columns = columns;

    worksheet.getCell('A2').value = `SEPCON S.A.C`
    worksheet.getCell('A3').value = `TAREOS - CONTROL DE ASISTENCIA REPORTE ${datos[0].proyecto} ${fechaProceso}`;
    worksheet.getCell('A2').style = titleStyle
    worksheet.getCell('A3').style = titleStyle

    /* worksheet.getCell('A5').style = headerStyle */
    worksheet.mergeCells('C5:F5')
    worksheet.mergeCells('L5:N5')
    worksheet.mergeCells('O5:AS5')
    worksheet.mergeCells('AT5:AZ5')
    worksheet.mergeCells('BA5:BA6')
    worksheet.mergeCells('BB5:BB6')

    worksheet.getCell('C5').value = 'DATOS PERSONALES'
    worksheet.getCell('L5').value = 'MAQUINARIA Y EQUIPOS'
    worksheet.getCell('O5').value = 'CONTROL DE ASISTENCIA'
    worksheet.getCell('AT5').value = 'TOTALES'

    worksheet.getRow(5).eachCell({ includeEmpty: true }, (cell) => {
        cell.style = headerStyle;
    });

    worksheet.getRow(6).values = headersValue

    worksheet.getRow(6).eachCell(cell => {
        cell.style = headerStyle
    })

    worksheet.getCell('BA6').style = extraStyle
    worksheet.getCell('BB6').style = extraStyle


    let fila = 7;
    let indexItem = 1;

    for (const fase in groupByFaseOrdenado) {
        worksheet.getCell(`BB${fila}`).value = ' '
        worksheet.getRow(fila).eachCell({ includeEmpty: true },(cell) => {
            cell.style = dataStyle
        })
        /* fila++ */
        worksheet.getCell(`BB${fila}`).value = ' '
        worksheet.getRow(fila).eachCell({ includeEmpty: true },(cell) => {
            cell.style = dataStyle
        })
        const dataByFase = groupByFaseOrdenado[fase]
        worksheet.getCell(`A${fila}`).style = faseStyle
        worksheet.getCell(`B${fila}`).style = faseStyle
        worksheet.getCell(`C${fila}`).style = faseStyle
        worksheet.getCell(`D${fila}`).style = faseStyle
        worksheet.getCell(`E${fila}`).style = faseStyle

        worksheet.getCell(`A${fila}`).value = dataByFase[0].codFase
        worksheet.getCell(`B${fila}`).value = dataByFase[0].fase
        
        fila++
        for (let i = 0; i < dataByFase.length; i++) {
            /* worksheet.getRow(fila).style = dataStyle */
            
            const item = dataByFase[i];

            /* // Insertar una nueva fila
            worksheet.insertRow(fila, [
                item.item,
                item.documento,
                item.nombres,
                item.proyecto,
                item.ubicacion,
                item.cargo,
            ]); */
            worksheet.getCell(fila, 1).value = indexItem
            worksheet.getCell(fila, 2).value = i+1;
            worksheet.getCell(fila, 3).value = item.cut
            worksheet.getCell(fila, 4).value = item.documento
            worksheet.getCell(fila, 5).value = item.nombres
            worksheet.getCell(fila, 6).value = item.procedencia
            let fechaIngreso = new Date(item.ingreso)
            fechaIngreso.setDate(fechaIngreso.getDate()+1)
            worksheet.getCell(fila, 7).value = !isNaN(fechaIngreso) ? fechaIngreso.toLocaleDateString('es-PE',{
                timeZone: 'America/Lima',
                day: '2-digit',
                month: '2-digit',
                year: 'numeric'
            }) : ''
            worksheet.getCell(fila, 8).value = item.tipoPersonal.substr(0,1)
            let fechaIngresoObra = new Date(item.ingresoObra)
            fechaIngresoObra.setDate(fechaIngresoObra.getDate()+1)
            worksheet.getCell(fila, 9).value = !isNaN(fechaIngresoObra) ? fechaIngresoObra.toLocaleDateString('es-PE', {
                timeZone: 'America/Lima',
                day: '2-digit',
                month: '2-digit',
                year: 'numeric'
            }) : ''
            worksheet.getCell(fila, 10).value = item.diasCampo

            worksheet.getCell(fila, 12).value = item.fase
            worksheet.getCell(fila, 13).value = item.proyecto
            worksheet.getCell(fila, 14).value = item.ubicacion
            worksheet.getCell(fila, 11).value = item.cargo

            

            // Llenar celdas para los días (A, D, F, M, V, P, total)
            worksheet.getCell(`AT${fila}`).value = item.dias.A || 0;
            worksheet.getCell(`AU${fila}`).value = item.dias.D || 0;
            worksheet.getCell(`AV${fila}`).value = item.dias.F || 0;
            worksheet.getCell(`AW${fila}`).value = item.dias.M || 0;
            worksheet.getCell(`AX${fila}`).value = item.dias.V || 0;
            worksheet.getCell(`AY${fila}`).value = item.dias.P || 0;
            worksheet.getCell(`AZ${fila}`).value = item.dias.total || 0;

            // Llenar celdas para régimen y mano de obra
            worksheet.getCell(`BA${fila}`).value = item.regimen || '';
            worksheet.getCell(`BB${fila}`).value = toTitleCase(item.manoObra) || '';

            setStyleInCells(fila, 1, 4, dataStyle)
            setStyleInCells(fila, 5, 14, dataStyleSecondary)
            setStyleInCells(fila, 15, 52, dataStyle)
            setStyleInCells(fila, 7, 10, dataStyle)
            setStyleInCells(fila, 53, 54, dataStyleSecondary)

            // Llenar las celdas para los estados por día
            for (const dia in item.estadosDia) {
                const estado = item.estadosDia[dia];
                const color = bgColorStatesMap.get(estado)?.color
                const columna = 14 + parseInt(dia); // Ajustar columna según el día
                worksheet.getCell(fila, columna).value = estado;
                worksheet.getCell(fila, columna). style = {
                    fill : {
                        type: 'pattern',
                        pattern: 'solid',
                        fgColor: { argb: color },
                        bgColor: { argb: color }
                    },
                    alignment : {
                        horizontal: 'center',
                        vertical: 'middle'
                    },
                    border: {
                        top: { style: 'thin' },
                        left: { style: 'thin' },
                        bottom: { style: 'thin' },
                        right: { style: 'thin' }
                    }
                }
            }
            indexItem++;
            fila++; // Avanzar a la siguiente fila
        }

        
    }
    
    const leyenda = Object.keys(bgColorStatesValue);
    fila++
    const countByTipoPersonal = _.countBy(datos, dato => dato.tipoPersonal);
    const countByUbicacion = _.countBy(datos, dato => dato.ubicacion);
    worksheet.getCell(fila, 7).value = 'Foraneos'
    worksheet.getCell(fila, 8).value = countByTipoPersonal.FORANEO ?? 0 
    worksheet.getCell(fila+1, 7).value = 'Extranjeros'
    worksheet.getCell(fila+1, 8).value = countByTipoPersonal.EXTRANJERO ?? 0
    worksheet.getCell(fila+2, 7).value = 'Locales'
    worksheet.getCell(fila+2, 8).value = countByTipoPersonal.LOCAL ?? 0
    worksheet.getCell(fila+3, 7).value = 'Total'
    worksheet.getCell(fila+3, 8).value = datos.length
    setStyleInCells(fila, 7, 8, dataStyle)
    setStyleInCells(fila+1, 7, 8, dataStyle)
    setStyleInCells(fila+2, 7, 8, dataStyle)
    setStyleInCells(fila+3, 7, 8, dataStyle)

    const contadorEstadosPorDia = contarEstadosPorDia(datos)
    const contadorUbicacionesPorDia = contarUbicacionesPorDia(datos)
    const ubicacionesSet = new Set();
    for (const ubicacion in contadorUbicacionesPorDia){
        const ubicaciones = Object.keys(contadorUbicacionesPorDia[ubicacion])
        ubicaciones.forEach(u => {
            ubicacionesSet.add(u);
        })
    }
    const ubicacionesArray =Array.from(ubicacionesSet);
    for (let index = 0; index < leyenda.length; index++) {
        let leyendaItem = bgColorStatesValue[leyenda[index]]
        worksheet.getCell(fila, 4).value = leyenda[index]
        worksheet.getCell(fila, 5).value = leyendaItem.label
        let color = leyendaItem.color
        setStyleInCells(fila, 4, 5, {
            fill : {
                type: 'pattern',
                pattern: 'solid',
                fgColor: { argb: color },
                bgColor: { argb: color }
            },
            alignment : {
                horizontal: 'center',
                vertical: 'middle'
            },
            border: {
                top: { style: 'thin' },
                left: { style: 'thin' },
                bottom: { style: 'thin' },
                right: { style: 'thin' }
            },
            font: {
                name: 'Arial',
                size: 10,
                color: { argb: '#000000' },
                bold: true
            }
        })
        for (const dia in contadorEstadosPorDia){
            worksheet.getCell(fila, 14 + parseInt(dia)).value = contadorEstadosPorDia[dia][leyenda[index]] ?? 0
            worksheet.getCell(fila, 14 + parseInt(dia)).style = dataStyle
        }
        fila++
    }
    fila++
    ubicacionesArray.forEach((ubicacion, index) => {
        worksheet.getCell(fila+index, 14).value = ubicacion
        worksheet.getCell(fila+index, 14).style = {
            fill: {
                type: 'pattern',
                pattern: 'solid',
                fgColor: { argb: 'D8E4BC' },
                bgColor: { argb: 'D8E4BC' }
            },
            alignment: {
                horizontal: 'left',
                vertical: 'middle',
            },
            border: {
                top: { style: 'thin' },
                left: { style: 'thin' },
                bottom: { style: 'thin' },
                right: { style: 'thin' }
            }
        }
    })
    for (const dia in contadorEstadosPorDia){
        ubicacionesArray.forEach((ubicacion, index) => {
            worksheet.getCell(fila+index, 14+parseInt(dia)).value = contadorUbicacionesPorDia[dia][ubicacion]??0
            worksheet.getCell(fila+index, 14+parseInt(dia)).style = {
                fill: {
                    type: 'pattern',
                    pattern: 'solid',
                    fgColor: { argb: 'D8E4BC' },
                    bgColor: { argb: 'D8E4BC' }
                },
                alignment: {
                    horizontal: 'center',
                    vertical: 'middle',
                },
                border: {
                    top: { style: 'thin' },
                    left: { style: 'thin' },
                    bottom: { style: 'thin' },
                    right: { style: 'thin' }
                }
            }
        })
    }
    /* for (const ubicacion in countByUbicacion){
        worksheet.getCell(fila, 14).value = ubicacion
        worksheet.getCell(fila, 14).style = {
            fill: {
                type: 'pattern',
                pattern: 'solid',
                fgColor: { argb: 'D8E4BC' },
                bgColor: { argb: 'D8E4BC' }
            },
            alignment: {
                horizontal: 'left',
                vertical: 'middle',
            },
            border: {
                top: { style: 'thin' },
                left: { style: 'thin' },
                bottom: { style: 'thin' },
                right: { style: 'thin' }
            }
        }
        worksheet.getCell(fila, 15).value = countByUbicacion[ubicacion]
        worksheet.getCell(fila, 15).style = {
            fill: {
                type: 'pattern',
                pattern: 'solid',
                fgColor: { argb: 'D8E4BC' },
                bgColor: { argb: 'D8E4BC' }
            },
            alignment: {
                horizontal: 'center',
                vertical: 'middle',
            },
            border: {
                top: { style: 'thin' },
                left: { style: 'thin' },
                bottom: { style: 'thin' },
                right: { style: 'thin' }
            }
        }
        fila++
    } */


    const buffer = await workbook.xlsx.writeBuffer();
    const blob = new Blob([buffer], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" });

    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'datos_personalizados.xlsx';
    a.click();
    URL.revokeObjectURL(url);

    function setStyleInCells(fila, columnaInicio, columnaFinal, estilo){
        for (let index = columnaInicio; index <= columnaFinal; index++) {
            worksheet.getCell(fila, index).style = estilo;
        }
    }

    function sumarEstados(array) {
        const estados = {};
      
        array.forEach(objeto => {
          for (const estado in objeto.dias) {
            if (estado !== 'total') { // Ignoramos la propiedad 'total'
              estados[estado] = (estados[estado] || 0) + objeto.dias[estado]; 
            }
          }
        });
      
        return estados;
    }

    function contarEstadosPorDia(array) {
        const resultado = {};
      
        array.forEach(objeto => {
          for (const dia in objeto.estadosDia) {
            const estado = objeto.estadosDia[dia];
            
            if (!resultado[dia]) {
              resultado[dia] = {};
            }
      
            resultado[dia][estado] = (resultado[dia][estado] || 0) + 1;
          }
        });
      
        return resultado;
    }

    function contarUbicacionesPorDia(array) {
        const resultado = {};
      
        array.forEach(objeto => {
          for (const dia in objeto.ubicacionesDia) {
            const ubicacion = objeto.ubicacionesDia[dia].trim();
            
            if (!resultado[dia]) {
              resultado[dia] = {};
            }
      
            resultado[dia][ubicacion] = (resultado[dia][ubicacion] || 0) + 1;
          }
        });
        return resultado;
    }

}

function toTitleCase(str) {
    return str
        .toLowerCase()  // Convertimos todo el texto a minúsculas
        .split(' ')  // Separamos el string en un array de palabras
        .map((word, index) => {
            // Capitalizamos la primera palabra, o cualquier palabra que no sea una excepción
            if (index === 0) {
                return word.charAt(0).toUpperCase() + word.slice(1);
            }
            return word;  // Si es una palabra de excepción, la dejamos en minúsculas
        })
        .join(' ');  // Unimos el array de nuevo en un string
}

const generarReportePadron = async () => {
    Swal.fire({
        title: "Generando el reporte",
        html: "Se están cargando los datos del reporte, por favor, espere",
        timerProgressBar: true,
        didOpen: () => {
            Swal.showLoading();
        }
    })
    let formData = new FormData();
    formData.append("funcion", "obtenerTareosProyectoColaborador");
    formData.append("proyecto", codigo_costos.value)

    let dataReporte;
    let datos = [];

    await fetch('../inc/busquedas.inc.php', {
        method: 'POST',
        body: formData
    })
        .then(response => response.json())
        .then(data => {
            dataReporte = data;
        })

    let colaboradores = [...dataReporte.colaboradoresProyecto, ...dataReporte.colaboradoresProyectoTerceros];

    /* colaboradores += dataReporte.colaboradoresProyectoTerceros; */
    colaboradores.forEach((item, index) => {
        let dato = {};
        dato['item'] = index + 1;
        dato['nombres'] = `${item.paterno} ${item.materno} ${item.nombres}`;
        dato['documento'] = item.dni;
        dato['proyecto'] = item.proyecto;
        dato['ubicacion'] = item.sucursal;
        dato['cargo'] = item.cargo;
        dato['tareos'] = dataReporte.tareos.filter(item => item.nrodoc == dato['documento']).flatMap(item => item.estados.split(','));
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
        dato['regimen'] = dataReporte.datosTareo.find(item => item.nddoc == dato['documento'])?.regimen;
        dato['manoObra'] = dataReporte.datosTareo.find(item => item.nddoc == dato['documento'])?.mano_obra;
        datos.push(dato);
    })
    formData.append("padron", JSON.stringify(datos));
    formData.append("funcion", "plantillaTareoExcel");

    await fetch('../inc/exportar.inc.php', {
        method: 'POST',
        body: formData
    })
        .then(response => response.json())
        .then(data => {
            window.open(`..${data.archivo}`);
        })
    Swal.close();
}

const datosTareoPersonal = () => {
    let fila = document.querySelector("#tablaPersonalBody").getElementsByTagName("tr"),
        nreg = fila.length;

    let DATOS = [];

    for (let i = 0; i < nreg; i++) {
        let dato = {};

        //if ( fila[i].dataset.grabado  === "0" ) {
        dato['documento'] = fila[i].cells[2].innerHTML;
        dato['ubicacion'] = fila[i].cells[4].innerHTML;
        dato['estado'] = fila[i].cells[5].children[0].value;
        dato['fingreso'] = fila[i].cells[7].children[0].value;

        DATOS.push(dato);

        /* fila[i].setAttribute("data-grabado", "1"); */
        //}   
    }


    return DATOS;
}

const actualizarPadronExcel = (archivo) => {
    try {
        const formData = new FormData();
        formData.append("funcion", 'importarArchivo');
        formData.append("archivo", archivo);

        let fila = document.querySelector("#tablaPersonalBody").getElementsByTagName("tr");

        fetch('../inc/importar.inc.php', {
            method: 'POST',
            body: formData,
            cache: 'no-store'
        })
            .then(response => response.json())
            .then(data => {
                data.datos.forEach(function (valor, indice) {
                    const filaIndex = [...fila].findIndex(f => f.cells[2].innerHTML == valor.documento)
                    if (fila[filaIndex].cells[2].innerHTML == valor.documento) {
                        /* fila[indice].cells[4].innerHTML = valor.ubicacion; */
                        fila[filaIndex].cells[5].children[0].value = valor.estado;
                        /* if(valor.ingreso != null){
                            fila[indice].cells[7].children[0].value = valor.ingreso;
                        } */
                        fila[filaIndex].cells[7].children[0].value = valor.ingreso != null ? valor.ingreso : ''
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
    let input, filter, table, tr, td, i, j, visible;

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

const hojaSalida = (proyecto) => {
    try {

        if (documento.value == "") throw new Error("Escribe el nro. de documento");

        const datos = new URLSearchParams(new FormData(document.getElementById("data_matriz")));

        datos.append("funcion", "hojaSalida");
        datos.append("proyecto", proyecto);

        fetch('../inc/reportes.inc.php', {
            method: 'POST',
            body: datos
        })
            .then(response => response.json())
            .then(data => {
                modalHojaSalida.style.display = 'block';
                vistaPreliminarHojaSalida.setAttribute('src', data);
            })
    } catch (error) {
        mostrarMensaje(error.message, "msj_error");
    }
}

const readExcel = (e) => {
    const file = e.target.files[0];
    const reader = new FileReader();

    reader.onload = function (event) {
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

document.getElementById("toggleMenu").addEventListener("click", function (e) {
    e.preventDefault();/*  */
    document.getElementById("menu").classList.toggle('active');
})

function grabarDatosMatrizTerceros() {
    //serializar los formulario en javascript
    const datos = new URLSearchParams(new FormData(document.getElementById("data_matriz")));
    datos.append("funcion", "grabarTerceros");

    fetch('../inc/grabar.inc.php', {
        method: 'POST',
        body: datos
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                Swal.fire({
                    icon: "success",
                    title: "Guardado Correctamente",
                    text: "Se han guardado los registros exitosamente"
                });
            } else {
                Swal.fire({
                    icon: "error",
                    title: "Error!",
                    text: "Ha ocurrido un error"
                });
            }
        });
}

/* document.getElementById("ubigeo").addEventListener("blur", function() {
    console.log("El campo ha perdido el foco");
    getUbigeo(); // Asegúrate de que esta función esté definida
}); */
document.addEventListener("focusout", (e) => {
    if (e.target.id == 'ubigeo') {
        getUbigeo();
    }
})
function getUbigeo() {
    let ubigeo = document.getElementById("ubigeo").value;
    const formData = new FormData();
    formData.append("funcion", "obtenerUbigeo");
    formData.append("ubigeo", ubigeo);
    fetch('../inc/busquedas.inc.php', {
        method: 'POST',
        body: formData
    })
        .then(response => response.json())
        .then(data => {
            document.getElementById("dist").value = data.ubigeo.dist;
            document.getElementById("dpto").value = data.ubigeo.dpto;
            document.getElementById("prov").value = data.ubigeo.prov;
        });
}

function obtenerTercero(dni) {
    const formData = new FormData();
    formData.append("funcion", "obtenerTercero");
    formData.append("dni", dni);
    fetch('../inc/busquedas.inc.php', {
        method: 'POST',
        body: formData
    })
        .then(response => response.json())
        .then(data => {
        });
}

function deleteProyectoUsuario(e) {
    let id = e.getAttribute('id-reg');
    let formData = new FormData()
    formData.append("funcion", "actualizarAccesoProyecto");
    formData.append("idreg", id)
    fetch('../inc/grabar.inc.php', {
        method: 'POST',
        body: formData
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                Swal.fire({
                    icon: "success",
                    title: "Guardado Correctamente",
                    text: "Se han guardado los registros exitosamente"
                });
            } else {
                Swal.fire({
                    icon: "error",
                    title: "Error!",
                    text: "Ha ocurrido un error"
                });
            }

        })
}

function openCity(evt, cityName) {
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }
    document.getElementById(cityName).style.display = "block";
    evt.target.className += " active";
    if (cityName == "FasesTabContent") {
        document.getElementById("function").value = "grabarFase"
    } else if (cityName == "ProyectoFasesTabContent") {
        document.getElementById("function").value = "grabarProyectoFase"
    } else if (cityName == "EncargadosTabContent") {
        document.getElementById("function").value = "grabarEncargado"
    } else if (cityName == "EncargadosProyectoTabContent") {
        document.getElementById("function").value = "grabarEncargadoProyecto"
    }
}