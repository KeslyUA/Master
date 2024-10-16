<?php 
     date_default_timezone_set('America/Lima');

    require_once("connect.inc.php");

    if (isset($_POST['funcion'])){
        if ($_POST['funcion'] == "login")
            echo json_encode(login($pdo,$_POST['username'],$_POST['password']));
    }

    function login($pdo,$username,$password){
        $respuesta = false;
        $respuesta  = false;
        $mensaje    = 'Usuario o clave incorrectos';
        $clase      = 'msj_error';

        try {
            $sql="SELECT 
                    cm_users.idreg,
                    cm_users.cusername,
                    cm_users.cuserdoc,
                    cm_users.cusermail
                FROM
                    cm_users
                WHERE 
                    cm_users.nflgactivo = 1
                AND cm_users.cusername = ?
                AND cm_users.cuserpass = SHA1(?)
                LIMIT 1";

            $statement = $pdo->prepare($sql);
            $statement -> execute(array($username,$password));
            $results = $statement ->fetchAll();
            $rowaffect = $statement->rowCount($sql);

            if ($rowaffect > 0){
                return array('username' =>$results[0]['cusername'],
                            'nro_doc'=>$results[0]['cuserdoc'],
                            'mail'=>$results[0]['cusermail'],
                            'respuesta'=>true);
            }else{
                return array('respuesta'=>false, 
                            'mensaje'=>$mensaje, 
                            'clase'=>'msj_error');
            }

        }  catch (PDOException $th) {
            echo "Error: " . $th->getMessage;
        }
    }

?>