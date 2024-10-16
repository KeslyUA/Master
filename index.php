<?php
    $random = rand(0,999999);
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/all.css">
    <link rel="stylesheet" href="css/login.css?v<?php echo $random; ?>">
    <title>Master de trabajadores SEPCON</title>
</head>
<body>
    <div class="modal_mensaje msj_info" id="mensaje__sistema">
        <span id="mensaje_texto"></span>
    </div>
    <section>
        <div class="contenedor">
            <div class="formulario">
                <form id="formLogin">
                    <h2>Iniciar Session</h2>
                    <div class="input-contenedor">
                        <i class="far fa-user"></i>
                        <input type="text" name="login__name" id="login__name" required>
                        <label for="#">Nombre</label>
                    </div>
                    <div class="input-contenedor">
                        <i class="fas fa-unlock"></i>
                        <input type="password" name="login__password" id="login__password" required>
                        <label for="#">Contraseña</label>
                    </div>
                    <div>
                        <button type="button" id="bntLogin">Acceder</button>
                    </div>
                </form>
            </div>
        </div>
    </section>
    <script src="js/login.js?v<?php echo $random; ?>" type="module"></script>
</body>
</html>