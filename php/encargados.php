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
        <input type="hidden" name="function" id="function" >
        <div class="separator">
            <div class="titulo">
                <span>JEFES INMEDIATOS</span>
                <div class="btnOpciones">
                    <a href="#" id="grabarDatosEncargados">
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
            <div class="tab">  
                <button class="tablinks" ref-id="EncargadosTabContent">Jefes Inmediatos</button>
                <button class="tablinks" ref-id="EncargadosProyectoTabContent">Jefes Inmediatos por Proyecto</button>    
            </div>
            <div>
                <div id="EncargadosTabContent" class="tabcontent">
                    <div class="separator">
                        <div class="titulo">
                            <span>LISTA DE JEFES INMEDIATOS</span>
                            <div class="btnOpciones">
                                <a href="#" id="agregaEncargados">
                                    <i class="far fa-calendar-plus botones"></i>
                                    <p>Agregar<br>Encargados</p>
                                </a>
                            </div>
                        </div>
                        <div class="cuatro_columnas">
                            <label for="ubicacion_encargados">Filtro:</label>
                            <input type="text" id="ubicacion_encargados" name="ubicacion_encargados" class="ubicacion_encargados"><i class="fas fa-search" style=" color: #777;padding: 10px;"></i>
                        </div>

                        <div class="cuerpo_tabla">
                            <table id="tablaEncargados">
                                <thead>
                                    <tr>
                                        <th width="15%">Item</th>
                                        <th width="30%">N° Documento</th>
                                        <th width="15%">Nombre Completo</th>
                                        <th width="10%">...</th>
                                    </tr>
                                </thead>
                                <tbody id="tablaEncargadosBody">

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div id="EncargadosProyectoTabContent" class="tabcontent">
                <div class="separator">
                        <div class="titulo">
                            <span>LISTA DE JEFES INMEDIATOS POR PROYECTO</span>
                            <div class="btnOpciones">
                                <a href="#" id="agregaEncargadosProyecto">
                                    <i class="far fa-calendar-plus botones"></i>
                                    <p>Asignar<br>Encargados</p>
                                </a>
                            </div>
                        </div>
                        <div class="cuatro_columnas">
                            <label for="ubicacion_JefesProyecto">Filtro:</label>
                            <input type="text" id="ubicacion_JefesProyecto" name="ubicacion_JefesProyecto" class="ubicacion_JefesProyecto"><i class="fas fa-search" style=" color: #777;padding: 10px;"></i>
                        </div>

                        <div class="cuerpo_tabla">
                            <table id="tablaEncargadosProyecto">
                                <thead>
                                    <tr>
                                        <th width="15%">Item</th>
                                        <th width="15%">Proyecto</th>
                                        <th width="60%">Encargado</th>
                                        <th width="10%">...</th>
                                    </tr>
                                </thead>
                                <tbody id="tablaEncargadosProyectoBody">

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>

</html>