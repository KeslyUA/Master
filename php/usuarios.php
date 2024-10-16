<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <form id="data_usuarios" name="data_usuarios"></form>
    <div class="modal_mensaje msj_info" id="mensaje__sistema">
        <span id="mensaje_texto"></span>
    </div>
    <section>
        <input type="hidden" name="existe" id="existe" form="data_usuarios">
        <div class="separator">
            <div class="titulo">
                <span>DATOS PERSONALES DEL TRABAJADOR</span>
                <div class="btnOpciones">   
                    <a href="#" id="grabarDatosUsuario">
                        <i class="fas fa-save botones"></i>
                        <p>Grabar</p>
                    </a>
                </div>
            </div>
            <div class="cuerpo">
                <div class="dos_columnas">
                    <label for="user_doc">D.Identidad :</label>
                    <input type="text" name="user_doc" id="user_doc" form="data_usuarios">
                </div>
                <div class="dos_columnas">
                    <label for="user_paterno">Ap.Paterno:</label>
                    <input type="text" name="user_paterno" id="user_paterno" readonly>
                </div>
               <div class="dos_columnas">
                    <label for="materno">Ap.Materno :</label>
                    <input type="text" name="user_materno" id="user_materno" readonly>
                </div>
                <div  class="tres_columnas">
                    <label for="nombres">Nombres :</label>
                    <input type="text" name="user_nombres" id="user_nombres" readonly>
                </div>
                 <div class="dos_columnas">
                    <label for="registro">F.Registro :</label>
                    <input type="date" name="registro" id="registro" value="<?php echo date("Y-m-d");?>" readonly form="data_usuarios">
                </div>
                <div class="dos_columnas">
                    <label for="usuario">Usuario :</label>
                    <input type="text" name="usuario" id="usuario" form="data_usuarios">
                </div>
                <div class="cuatro_columnas">
                    <label for="clave">Clave :</label>
                    <input type="password" id="clave" name="clave" form="data_usuarios" autocomplete>
                </div>
                <div class="dos_columnas">
                    <label for="estado_user">Estado :</label>
                    <select name="estado_user" id="estado_user" form="data_usuarios">
                        <option value="-1">Seleccione una opcion</option>
                        <option value="01">Activo</option>
                        <option value="02">Inactivo</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="separator">
            <div class="titulo">
                <span>LISTA DE PROYECTOS Y FASES</span>
                <div class="btnOpciones">   
                    <a href="#" id="agregaProyectosUsuario">
                        <i class="far fa-calendar-plus botones"></i>
                        <p>Agregar<br>Proyecto</p>
                    </a>
                </div>
            </div>
            <div class="cuerpo_tabla">
                <table id="tablaProyectos">
                    <thead>
                        <tr>
                            <th width="15%">Item</th>
                            <th width="15%">Codigo</th>
                            <th width="60%">Descripcion</th>
                            <th width="10%">...</th>
                        </tr>
                    </thead>
                    <tbody id="tablaProyectosBody">

                    </tbody>
                </table>
            </div>
        </div>
    </section>
</body>
</html>