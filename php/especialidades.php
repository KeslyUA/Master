<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <form id="data_fases" name="data_fases"></form>
    <div class="modal_mensaje msj_info" id="mensaje__sistema">
        <span id="mensaje_texto"></span>
    </div>
    <section>
        <input type="hidden" name="existe" id="existe" form="data_fases">
        <input type="hidden" name="function" id="function">
        <div class="separator">
            <div class="titulo">
                <span>ESPECIALIDADES</span>
                <div class="btnOpciones">
                    <a href="#" id="grabarDatosEspecialidad">
                        <i class="fas fa-save botones"></i>
                        <p>Grabar</p>
                    </a>
                </div>
            </div>
            <!-- <div class="cuerpo">
                <div class="seis_columnas">
                    <label for="proyectos">Proyectos :</label>
                    <select name="proyectos" id="proyectos" form="data_fases" class="select">
                        <option value="-1">Seleccionar</option>
                    </select>
                </div>
                <div class="dos_columnas">
                    <label for="fases">Fases :</label>
                    <select name="fases" id="fases" form="data_fases" class="select">
                        <option value="-1">Seleccionar</option>
                    </select>
                </div>
            </div> -->
        </div>
        <div class="separator">

            <div class="titulo">
                <span>LISTA DE ESPECIALIDADES</span>
                <div class="btnOpciones">
                    <a href="#" id="agregaEspecialidad">
                        <i class="far fa-calendar-plus botones"></i>
                        <p>Agregar<br>Especialidad</p>
                    </a>
                </div>
            </div>


            <div class="cuerpo_tabla">
                <table id="tablaEspecialidades">
                    <thead>
                        <tr>
                            <th width="15%">Item</th>
                            <th width="30%">Especialidad</th>
                            <th width="10%">...</th>
                        </tr>
                    </thead>
                    <tbody id="tablaEspecialidadesBody">

                    </tbody>
                </table>
            </div>
        </div>

    </section>
</body>

</html>