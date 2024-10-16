<?php 
    date_default_timezone_set('America/Lima');

    require_once("connect.inc.php");
    require_once("busquedas.inc.php");

    if (isset($_POST['funcion'])){
        if ($_POST['funcion'] == "grabar")
            echo json_encode(grabar($pdo,$_POST));
        else if ($_POST['funcion'] == "grabarUsuario")
            echo json_encode(grabarUsuario($pdo,$_POST));
        else if ($_POST['funcion'] == "grabarEstadosPersonal")
            echo json_encode(grabarEstadosPersonal($pdo,$_POST));
    }

    function grabar($pdo,$datos){
        $datosTareo = grabarDatosTareo($pdo,$datos);
        $tareo = grabarTareo($pdo,$datos);

        return array("mensaje"=>"Registro Creado");

    }

    function grabarDatosTareo($pdo,$datos){
        try {
            $resultado = false;

            $sql = "INSERT INTO tb_datostareo SET tb_datostareo.nddoc = ?,
                                                  tb_datostareo.cencargado = ?,
                                                  tb_datostareo.ncondicion = ?,
                                                  tb_datostareo.npersonal = ?,
                                                  tb_datostareo.cespecialidad = ?,
                                                  tb_datostareo.nmanoobra = ?,
                                                  tb_datostareo.cproyecto = ?,
                                                  tb_datostareo.cfase = ?,
                                                  tb_datostareo.cubicacion = ?,
                                                  tb_datostareo.cregimen = ?,
                                                  tb_datostareo.fingreso = ?,
                                                  tb_datostareo.fsalida = ?,
                                                  tb_datostareo.fretorno = ?,
                                                  tb_datostareo.dgoce = ?,
                                                  tb_datostareo.dlibre = ?,
                                                  tb_datostareo.dcampo = ?,
                                                  tb_datostareo.cobservaciones = ?,
                                                  tb_datostareo.cdescanso = ?,
                                                  tb_datostareo.fcese = ?,
                                                  tb_datostareo.cmotivocese = ?";
            
            $statement = $pdo->prepare($sql);
            $statement -> execute(array($datos['documento'],
                                        $datos['encargado'],
                                        $datos['condicion'],
                                        $datos['personal'],
                                        $datos['especialidad'],
                                        $datos['manoobra'],
                                        $datos['proyecto_actual'],
                                        $datos['fase_actual'],
                                        $datos['ubicacion'],
                                        $datos['regimen_trabajo'],
                                        $datos['ingreso_obra'],
                                        $datos['salida_obra'],
                                        $datos['retorno_programado'],
                                        $datos['dias_goce'],
                                        $datos['dias_libre'],
                                        $datos['dias_reales'],
                                        $datos['observaciones'],
                                        $datos['motivo_descanso'],
                                        $datos['fecha_cese'],
                                        $datos['motivo_cese']));

            $results = $statement ->fetchAll();
            $rowaffect = $statement->rowCount($sql);

            if ($rowaffect > 0) {
                return true;
            }

            return $resultado;

        }  catch (PDOException $th) {
            echo "Error: " . $th->getMessage;
            return false;
        }
    }

    function grabarTareo($pdo,$datos){
        try {
            $resultado = false;

            $sql="INSERT INTO tb_tareo SET tb_tareo.ndoc = ?,
                                           tb_tareo.ffecha = ?,
                                           tb_tareo.iduser = ?,
                                           tb_tareo.d1 = ?,
                                           tb_tareo.d2 = ?,
                                           tb_tareo.d3 = ?,
                                           tb_tareo.d4 = ?,
                                           tb_tareo.d5 = ?,
                                           tb_tareo.d6 = ?,
                                           tb_tareo.d7 = ?,
                                           tb_tareo.d8 = ?,
                                           tb_tareo.d9 = ?,
                                           tb_tareo.d10 = ?,
                                           tb_tareo.d11 = ?,
                                           tb_tareo.d12 = ?,
                                           tb_tareo.d13 = ?,
                                           tb_tareo.d14 = ?,
                                           tb_tareo.d15 = ?,
                                           tb_tareo.d16 = ?,
                                           tb_tareo.d17 = ?,
                                           tb_tareo.d18 = ?,
                                           tb_tareo.d19 = ?,
                                           tb_tareo.d20 = ?,
                                           tb_tareo.d21 = ?,
                                           tb_tareo.d22 = ?,
                                           tb_tareo.d23 = ?,
                                           tb_tareo.d24 = ?,
                                           tb_tareo.d25 = ?,
                                           tb_tareo.d26 = ?,
                                           tb_tareo.d27 = ?,
                                           tb_tareo.d28 = ?,
                                           tb_tareo.d29 = ?,
                                           tb_tareo.d30 = ?,
                                           tb_tareo.d31 = ?" ;
                                           
            $statement = $pdo->prepare($sql);
            $statement -> execute(array($datos['documento'],
                                        null,
                                        null,
                                        $datos['p1'],
                                        $datos['p2'],
                                        $datos['p3'],
                                        $datos['p4'],
                                        $datos['p5'],
                                        $datos['p6'],
                                        $datos['p7'],
                                        $datos['p8'],
                                        $datos['p9'],
                                        $datos['p10'],
                                        $datos['p11'],
                                        $datos['p12'],
                                        $datos['p13'],
                                        $datos['p14'],
                                        $datos['p15'],
                                        $datos['p16'],
                                        $datos['p17'],
                                        $datos['p18'],
                                        $datos['p19'],
                                        $datos['p20'],
                                        $datos['p21'],
                                        $datos['p22'],
                                        $datos['p23'],
                                        $datos['p24'],
                                        $datos['p25'],
                                        $datos['p26'],
                                        $datos['p27'],
                                        $datos['p28'],
                                        $datos['p29'],
                                        $datos['p30'],
                                        $datos['p31']));

            $results = $statement ->fetchAll();
            $rowaffect = $statement->rowCount($sql);

            if ($rowaffect > 0) {
                return true;
            }

            return $resultado;
                                           
        }  catch (PDOException $th) {
            echo "Error: " . $th->getMessage;
        }
    }

    function grabarUsuario($pdo,$datos){
        try {
            if( $datos['existe'] == "1"){
                actualizarAccesos($pdo,$datos);
            }else{
                agregarAccesos($pdo,$datos);
            }

            grabarProyectosUsuario($pdo,$datos);

        } catch (PDOException $th) {
            echo "Error: " . $th->getMessage;
            return false;
        }
    }

    function grabarProyectosUsuario($pdo,$datos){
        try {
            $proyectos = json_decode($datos['proyectos']);
            $nreg = count($proyectos);

            for ($i=0; $i < $nreg; $i++) { 
                try {
                    $sql = "INSERT INTO tm_userproyectos 
                            SET tm_userproyectos.ccodigo = ?,
                                tm_userproyectos.cdescripcion = ?,
                                tm_userproyectos.cdocumento = ?";

                    $statement = $pdo->prepare($sql);
                    $statement -> execute(array($proyectos[$i]->codigo,
                                                $proyectos[$i]->descripcion,
                                                $datos['user_doc']));

                    //var_dump($statement->errorInfo());

                } catch (PDOException $th) {
                    echo "Error: " . $th->getMessage;
                    return false;
                }
            }

            //var_dump($proyectos[0]->codigo);

        } catch (PDOException $th) {
            echo "Error: " . $th->getMessage;
        }
    }

    function agregarAccesos($pdo,$datos){
        try {
            $sql = "INSERT INTO cm_users 
                    SET cm_users.cusername=?,
                        cm_users.cuserpass=?,
                        cm_users.cuserdoc=?,
                        cm_users.nflgactivo=?";

            $activo = $datos['estado_user'] == "01" ? 1 : 0;
            
            $statement = $pdo->prepare($sql);
            $statement -> execute(array($datos['usuario'],
                                        SHA1($datos['clave']),
                                        $datos['user_doc'],
                                        $activo));

        } catch (PDOException $th) {
            echo "Error: " . $th->getMessage;
        }
    }

    function actualizarAccesos($pdo,$datos){
        try {
            $sql = "UPDATE cm_users 
                    SET cm_users.cusername=?,
                        cm_users.cuserpass=?,
                        cm_users.nflgactivo=?
                    WHERE cm_users.cuserdoc=?
                    LIMIT 1";

            $activo = $datos['estado_user'] == "01" ? 1 : 0;
            
            $statement = $pdo->prepare($sql);
            $statement -> execute(array($datos['usuario'],
                                        SHA1($datos['clave']),
                                        $datos['estado_user'],
                                        $datos['user_doc']));
                            
        } catch (PDOException $th) {
            echo "Error: " . $th->getMessage;
            return false;
        }
    }

    function grabarEstadosPersonal($pdo,$datos){
        try {
            $tareos         = json_decode($datos['datosTareo']);
            $nreg           = count($tareos);
            $fecha          = date("Y-m-D"); 

            $fecha_actual = getdate();
            $mes = $fecha_actual['mon'];
            $anio = $fecha_actual['year'];

            for ($i=0; $i < $nreg; $i++) { 
                $sql = "INSERT INTO tb_tareos 
                        SET tb_tareos.nrodoc = ?,
                            tb_tareos.cproyecto = ?,
                            tb_tareos.mes = ?,
                            tb_tareos.anio = ?,
                            tb_tareos.fecha = ?,
                            tb_tareos.estado = ?,
                            tb_tareos.cubicacion = ?";
                
                $statement = $pdo->prepare($sql);
                $statement -> execute(array($tareos[$i]->documento,
                                            $datos['proyecto'],
                                            $mes,
                                            $anio,
                                            $fecha,
                                            $tareos[$i]->estado,
                                            $tareos[$i]->ubicacion));

                var_dump($statement->errorInfo());
            }

            return array("registros"=>$nreg);
            
        } catch (PDOException $th) {
            echo "Error: " . $th->getMessage;
            return false;
        }
    }
    

?>