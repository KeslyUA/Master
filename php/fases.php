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
                <span>FASES</span>
                <div class="btnOpciones">
                    <a href="#" id="grabarDatosFases">
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
                <button class="tablinks" ref-id="FasesTabContent">Fases</button>
                <button class="tablinks" ref-id="ProyectoFasesTabContent">Proyectos y Fases</button>    
            </div>
            <div>
                <div id="FasesTabContent" class="tabcontent">
                    <div class="separator">
                        <div class="titulo">
                            <span>LISTA DE FASES</span>
                            <div class="btnOpciones">
                                <a href="#" id="agregaFases">
                                    <i class="far fa-calendar-plus botones"></i>
                                    <p>Agregar<br>Fases</p>
                                </a>
                            </div>
                        </div>


                        <div class="cuerpo_tabla">
                            <table id="tablaFases">
                                <thead>
                                    <tr>
                                        <th width="15%">Item</th>
                                        <th width="15%">Nombre</th>
                                        <th width="60%">Descripcion</th>
                                        <th width="10%">...</th>
                                    </tr>
                                </thead>
                                <tbody id="tablaFasesBody">

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div id="ProyectoFasesTabContent" class="tabcontent">
                <div class="separator">
                        <div class="titulo">
                            <span>LISTA DE PROYECTOS Y FASES</span>
                            <div class="btnOpciones">
                                <a href="#" id="agregaProyectosFases">
                                    <i class="far fa-calendar-plus botones"></i>
                                    <p>Asignar<br>Fases</p>
                                </a>
                            </div>
                        </div>


                        <div class="cuerpo_tabla">
                            <table id="tablaProyectosFases">
                                <thead>
                                    <tr>
                                        <th width="15%">Item</th>
                                        <th width="15%">Proyecto</th>
                                        <th width="60%">Fase</th>
                                        <th width="10%">...</th>
                                    </tr>
                                </thead>
                                <tbody id="tablaProyectosFasesBody">

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div id="Tokyo" class="tabcontent">
                    <h3>Tokyo</h3>
                    <p>Tokyo is the capital of Japan.</p>
                </div>
            </div>
        </div>

    </section>
</body>

</html>