<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <form id="padron_usuarios" name="padron_usuarios"></form>
    <div class="modal_mensaje msj_info" id="mensaje__sistema">
        <span id="mensaje_texto"></span>
    </div>
    <section>
        <div class="separator">
            <div class="titulo">
                <span>CENTRO DE COSTOS</span>
                <div class="btnOpciones">   
                    <a href="#" id="grabarDatosPadron"><i class="fas fa-save botones"></i><p>Grabar</p></a>
                    <a href="#" id="cargarDatosPadron"><i class="fas fa-file-excel botones"></i><p>Cargar Datos</p></a>
                    <a href="#" id="descargarPlantilla"><i class="fas fa-download botones"></i><p>Descargar Plantilla</p></a>
                </div>
            </div>
            <div class="cuerpo">
                <div class="cuatro_columnas contenedor_proyectos">
                    <label for="select_proyectos">Proyecto :</label>
                    <select name="select_proyectos" id="select_proyectos" class="select">
                        <option value="-1">Seleccionar</option>
                    </select>
                </div>
                <div class="cuatro_columnas">
                    <label for="ubicacion_usuario">Ubicacion:</label>
                    <input type="text" id="ubicacion_usuario" name="ubicacion_usuario">
                </div>
                <div class="cuatro_columnas">
                    <label for="ubicacion_padron">Filtro:</label>
                    <input type="text" id="ubicacion_padron" name="ubicacion_padron">
                </div>
            </div>
        </div>
        <div class="separator">
            <div class="titulo">
                <span>PERSONAL VINCULADO</span>
                <div class="btnOpciones">   
                    <a href="#" id="agregaProyectosUsuario"><i class="far fa-calendar-plus botones"></i></a>
                </div>
            </div>
            <div class="cuerpo_tabla">
                <table id="tablaPersonal">
                    <thead>
                        <tr>
                            <th width="3%">...</th>
                            <th width="30%">Nombres</th>
                            <th width="15%">Documento</th>
                            <th width="30%">Proyecto</th>
                            <th width="15%">Ubicación</th>
                            <th width="5%">Estado</th>
                            <th width="5%">Fecha<br>Ingreso</th>
                        </tr>
                    </thead>
                    <tbody id="tablaPersonalBody">

                    </tbody>
                </table>
            </div>
        </div>
    </section>
</body>
</html>