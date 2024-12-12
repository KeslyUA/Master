<?php
    $random = rand(0,999999);
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/all.css">
    <link rel="stylesheet" href="../css/main.css?v<?php echo $random; ?>">
    <title>Panel</title>
</head>
<body>
    <div class="modal_mensaje msj_info" id="mensaje__sistema">
        <span id="mensaje_texto"></span>
    </div>
    <div class="modal" id="hojaSalidaModal">
        <div class="modal__body">
            <div class="ventana__interna">
                <iframe src="" id="vistaPreliminarHojaSalida"></iframe>
            </div>
        </div>    
    </div>
    <input type="hidden" name="codigo_costos" id="codigo_costos">
    <input type="file" name="fileUpload" id="fileUpload" accept=".xls,.xlsx,.ods" class="oculto archivo">
    <section>
        <div class="logo">
            <img src="../assets/logosp.png" alt="logoSepcon">
        </div>
        <div class="header">
            <div class="text_user">
                <p><strong id="nombreUsuarioSistema"></strong></p>
                <p id="cargoUsuarioSistema"></p>
                <p id="correoUsuarioSistema"></p>
            </div>
            <div class="img_user">
                
            </div>
        </div>
        <div id="menu" class="menu">
            <a href="#" id="toggleMenu"><i class="fas fa-bars"></i></a>
           <ul id="menuList" >
                <li class="menu_selected"><a href="matriz" id="matriz" class="opciones">Matriz Personal</a></li>
                <li><a href="padron" id="padron" class="opciones">Listado del Padron</a></li>
                <li><a href="encargados"  id="encargados" class="opciones">Encargados</a></li>
                <li><a href="fases" id="fases" class="opciones">Fases</a></li>
                <li><a href="ubicaciones" id="ubicaciones" class="opciones">Ubicacion</a></li>
                <li><a href="especialidades" id="especialidades" class="opciones">Especialidad</a></li>
                <li><a href="#" class="opciones">Configuraciones</a></li>
                <li><a href="terceros" id="terceros" class="opciones">Matriz Personal (Terceros)</a></li>
                <li><a href="padronterceros" id="padronterceros" class="opciones">Lista del Padron (Terceros)</a></li>
                <li><a href="usuarios" id="usuarios" class="opciones">Permisos de Usuarios</a></li>
           </ul>
        </div>
        <div class="loader">
            <?php require_once('../php/matriz.php') ?>
        </div>
    </section>
    <script src="../js/sweetalert2@11.js"></script>
    <script src="../js/es-toolkit@^1.js" ></script>
    <script src="../js/exceljs.min.js"></script>
    <script src="../js/panel.js?v<?php echo $random; ?>" type="module"></script>
</body>
</html>