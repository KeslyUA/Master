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
        else if ($_POST['funcion'] == "grabarEstadosPersonalByFecha")
            echo json_encode(grabarEstadosPersonalByFecha($pdo,$_POST));
        else if ($_POST['funcion'] == "actualizarEstadoPersonal")
            echo json_encode(actualizarEstadoPersonal($pdo,$_POST));
        else if ($_POST['funcion'] == "grabarDatosTerceros")
            echo json_encode(grabarDatosTerceros($pdo,$_POST));
        else if ($_POST['funcion'] == "actualizarAccesoProyecto")
            echo json_encode(actualizarAccesoProyecto($pdo, $_POST['idreg']));
        else if ($_POST['funcion'] == "grabarTerceros")
            echo json_encode(grabarTerceros($pdo, $_POST));
        else if ($_POST['funcion'] == "grabarFase")
            echo json_encode(grabarFase($pdo, $_POST));
        else if ($_POST['funcion'] == "grabarProyectoFase")
            echo json_encode(grabarProyectoFase($pdo, $_POST));
        else if ($_POST['funcion'] == "grabarEncargado")
            echo json_encode(grabarEncargado($pdo, $_POST));
        else if ($_POST['funcion'] == "grabarEncargadoProyecto") {
            echo json_encode(grabarEncargadoProyecto($pdo, $_POST));
        }else if ($_POST['funcion'] == "actualizarEncargado") {
            echo json_encode((actualizarEncargado($pdo, $_POST)));
        }else if ($_POST['funcion'] == "actualizarFase") {
            echo json_encode(actualizarFase($pdo, $_POST));
        }else if ($_POST['funcion'] == "grabarUbicacion") {
            echo json_encode(grabarUbicacion($pdo, $_POST));
        }else if ($_POST['funcion'] == "grabarEspecialidad") {
            echo json_encode(grabarEspecialidad($pdo, $_POST));
        }
    }

    function grabar($pdo,$datos){
        if($datos['existe'] == 1){
            $datosTareo = actualizarDatosTareo($pdo,$datos);
            $historico = grabarDatosTareoHistorico($pdo, $datos);
            return array("mensaje"=>"Registro Actualizado");
        }else{
            $datosTareo = grabarDatosTareo($pdo,$datos);
            /* $tareo = grabarTareo($pdo,$datos); */
            $historico = grabarDatosTareoHistorico($pdo, $datos);
            return array("mensaje"=>"Registro Creado");
        }
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
                                                  tb_datostareo.dreales = ?,
                                                  tb_datostareo.cobservaciones = ?,
                                                  tb_datostareo.cdescanso = ?,
                                                  tb_datostareo.fcese = ?,
                                                  tb_datostareo.cmotivocese = ?,
                                                  tb_datostareo.nregimen = ?,
                                                  tb_datostareo.nespecificacion = ?";
            
            $statement = $pdo->prepare($sql);
            $nddoc = isset($datos['documento']) ? $datos['documento'] : (isset($datos['documento_tercero']) ? $datos['documento_tercero'] : null);

            $statement -> execute(array($nddoc,
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
                                        $datos['dias_campo'],
                                        $datos['dias_reales'],
                                        $datos['observaciones'],
                                        $datos['motivo_descanso'],
                                        $datos['fecha_cese'],
                                        $datos['motivo_cese'],
                                        $datos['regimen'],
                                        $datos['especificacion_contrato']));

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

    function actualizarDatosTareo($pdo, $datos){
        try {
            $resultado = false;

            $sql = "UPDATE tb_datostareo SET tb_datostareo.cencargado = ?,
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
                                                  tb_datostareo.dreales = ?,
                                                  tb_datostareo.cobservaciones = ?,
                                                  tb_datostareo.cdescanso = ?,
                                                  tb_datostareo.fcese = ?,
                                                  tb_datostareo.cmotivocese = ?,
                                                  tb_datostareo.nregimen = ?,
                                                  tb_datostareo.nespecificacion = ?
                        WHERE tb_datostareo.nddoc = ?";
            
            $statement = $pdo->prepare($sql);

            $nddoc = isset($datos['documento']) ? $datos['documento'] : (isset($datos['documento_tercero']) ? $datos['documento_tercero'] : null);

            
            $statement -> execute(array($datos['encargado'],
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
                                        $datos['dias_campo'],
                                        $datos['dias_reales'],
                                        $datos['observaciones'],
                                        $datos['motivo_descanso'],
                                        $datos['fecha_cese'],
                                        $datos['motivo_cese'],
                                        $datos['regimen'],
                                        $datos['especificacion_contrato'],
                                        $nddoc
                                       ));

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
                            tb_tareos.cubicacion = ?,
                            tb_tareos.fingreso = ?";
                
                $statement = $pdo->prepare($sql);
                $statement -> execute(array($tareos[$i]->documento,
                                            $datos['proyecto'],
                                            $mes,
                                            $anio,
                                            $fecha,
                                            $tareos[$i]->estado,
                                            $tareos[$i]->ubicacion,
                                            $tareos[$i]->fingreso));

                /* var_dump($statement->errorInfo()); */
            }

            return array("registros"=>$nreg);
            
        } catch (PDOException $th) {
            echo "Error: " . $th->getMessage;
            return false;
        }
    }
    function grabarEstadosPersonalByFecha($pdo,$datos){
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
                            tb_tareos.cubicacion = ?,
                            tb_tareos.fingreso = ?";
                
                $statement = $pdo->prepare($sql);
                $statement -> execute(array($tareos[$i]->documento,
                                            $datos['proyecto'],
                                            $mes,
                                            $anio,
                                            $fecha,
                                            $tareos[$i]->estado,
                                            $tareos[$i]->ubicacion,
                                            $tareos[$i]->fingreso));

                /* var_dump($statement->errorInfo()); */
            }

            return array("registros"=>$nreg);
            
        } catch (PDOException $th) {
            echo "Error: " . $th->getMessage;
            return false;
        }
    }
    function actualizarEstadoPersonal($pdo, $datos){
        try {
            $tareos         = json_decode($datos['updateDatosTareo']);
            $nreg           = count($tareos);
            $fecha          = date("Y-m-D"); 

            $fecha_actual = getdate();

            $mes = $fecha_actual['mon'];
            $anio = $fecha_actual['year'];

            for ($i=0; $i < $nreg; $i++) { 
                /* $sql = "UPDATE tb_tareos 
                        SET fregsys = CURRENT_TIMESTAMP(),
                            estado = ?,
                            fingreso = ?,
                        WHERE idreg = ? AND nrodoc = ?";
                
                $statement = $pdo->prepare($sql);
                $statement -> execute(array($tareos[$i]->estado,
                                            $tareos[$i]->fingreso,
                                            $tareos[$i]->idreg,
                                            $tareos[$i]->nrodoc)); */
                                            if ($tareos[$i]->fingreso === null) {
                                                $sql = "UPDATE tb_tareos 
                                                        SET fmodificacion = CURRENT_TIMESTAMP(),
                                                            estado = ?,
                                                            fingreso = NULL
                                                        WHERE idreg = ? AND nrodoc = ?";
                                                
                                                $params = [
                                                    $tareos[$i]->estado,
                                                    $tareos[$i]->idreg,
                                                    $tareos[$i]->nrodoc
                                                ];
                                            } else {
                                                $sql = "UPDATE tb_tareos 
                                                        SET fmodificacion = CURRENT_TIMESTAMP(),
                                                            estado = ?,
                                                            fingreso = ?
                                                        WHERE idreg = ? AND nrodoc = ?";
                                                
                                                $params = [
                                                    $tareos[$i]->estado,
                                                    $tareos[$i]->fingreso,
                                                    $tareos[$i]->idreg,
                                                    $tareos[$i]->nrodoc
                                                ];
                                            }
                                             $statement = $pdo->prepare($sql);
        $statement->execute($params);

                /* var_dump($statement->errorInfo()); */
            }
            if($statement->rowcount() > 0){
                return ['success' => true, 'msg' => 'Guardado Exitosamente'];
            }else{
                return ['success' => false, 'msg' => 'Error en el guardado', 'datos'=> $tareos];
            }
            
            /* return array("registros"=>$cont); */
            
        } catch (PDOException $th) {
            echo "Error: " . $th->getMessage;
            return ['success' => false, 'msg' => $th->getMessage()];
            /* return false; */
        }
    }

    function grabarDatosTareoHistorico($pdo, $datos) {
        try {
            $resultado = false;

            $sql = "INSERT INTO tb_datostareo_historico SET tb_datostareo_historico.nddoc = ?,
                                                  tb_datostareo_historico.cencargado = ?,
                                                  tb_datostareo_historico.ncondicion = ?,
                                                  tb_datostareo_historico.npersonal = ?,
                                                  tb_datostareo_historico.cespecialidad = ?,
                                                  tb_datostareo_historico.nmanoobra = ?,
                                                  tb_datostareo_historico.cproyecto = ?,
                                                  tb_datostareo_historico.cfase = ?,
                                                  tb_datostareo_historico.cubicacion = ?,
                                                  tb_datostareo_historico.cregimen = ?,
                                                  tb_datostareo_historico.fingreso = ?,
                                                  tb_datostareo_historico.fsalida = ?,
                                                  tb_datostareo_historico.fretorno = ?,
                                                  tb_datostareo_historico.dgoce = ?,
                                                  tb_datostareo_historico.dlibre = ?,
                                                  tb_datostareo_historico.dcampo = ?,
                                                  tb_datostareo_historico.dreales = ?,
                                                  tb_datostareo_historico.cobservaciones = ?,
                                                  tb_datostareo_historico.cdescanso = ?,
                                                  tb_datostareo_historico.fcese = ?,
                                                  tb_datostareo_historico.cmotivocese = ?,
                                                  tb_datostareo_historico.nregimen = ?,
                                                  tb_datostareo_historico.nespecificacion = ?";
            
            $statement = $pdo->prepare($sql);
            $nddoc = isset($datos['documento']) ? $datos['documento'] : (isset($datos['documento_tercero']) ? $datos['documento_tercero'] : null);

            $statement -> execute(array($nddoc,
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
                                        $datos['dias_campo'],
                                        $datos['dias_reales'],
                                        $datos['observaciones'],
                                        $datos['motivo_descanso'],
                                        $datos['fecha_cese'],
                                        $datos['motivo_cese'],
                                        $datos['regimen'],
                                        $datos['especificacion_contrato']));

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
    function grabarDatosTerceros($pdo, $datos){
        try {
            $sql = "INSERT INTO tb_datosterceros 
                    SET tb_datosterceros.dni=?,
                        tb_datosterceros.paterno=?,
                        tb_datosterceros.materno=?,
                        tb_datosterceros.nombres=?,
                        tb_datosterceros.nacimiento=?,
                        tb_datosterceros.cut=?,
                        tb_datosterceros.sucursal=?,
                        tb_datosterceros.sangre=?,
                        tb_datosterceros.regimen=?,
                        tb_datosterceros.cargo=?,
                        tb_datosterceros.pais=?,
                        tb_datosterceros.estado=?,
                        tb_datosterceros.telefono=?,
                        tb_datosterceros.correo=?,
                        tb_datosterceros.direccion=?,
                        tb_datosterceros.departamento=?,
                        tb_datosterceros.provincia=?,
                        tb_datosterceros.distrito=?,
                        tb_datosterceros.proyecto=?,
                        tb_datosterceros.empresa=?";

            /* $activo = $datos['estado_user'] == "01" ? 1 : 0; */
            $valores = [
                $datos['documento_tercero'] ?: null, // Si es vacío, se convierte en null
                $datos['paterno'] ?: null,
                $datos['materno'] ?: null,
                $datos['nombres'] ?: null,
                $datos['nacimiento'] ?: null,
                $datos['codigo'] ?: null,
                $datos['sucursal'] ?: null,
                $datos['grupo'] ?: null,
                $datos['planilla'] ?: null,
                $datos['cargo'] ?: null,
                $datos['nacionalidad'] ?: null,
                $datos['estado'] ?: null,
                $datos['telefono'] ?: null,
                $datos['correo'] ?: null,
                $datos['direccion'] ?: null,
                $datos['dpto']?:null,
                $datos['prov']?:null,
                $datos['dist']?:null,
                $datos['proyecto'] ?: null,
                $datos['empresa'] ?: null
            ];

            $statement = $pdo->prepare($sql);
            $statement -> execute($valores);
                                    
            // Verificar si se insertaron filas
            /* if ($statement->rowCount() > 0) {
                return ['success'=> true, 'message' => "Datos insertados correctamente", 'datos'=>$datos];
            } else {
                return ['success'=> false, 'message' => "No se insentaron datos", 'datos'=>$datos];
            } */
           return true;
        } catch (PDOException $th) {
            /* return ['message' => "Error: " . $th->getMessage()]; */
            return false;
        }
    }
    function actualizarDatosTerceros($pdo, $datos){
        try {
            $sql = "UPDATE tb_datosterceros 
                    SET tb_datosterceros.paterno=?,
                        tb_datosterceros.materno=?,
                        tb_datosterceros.nombres=?,
                        tb_datosterceros.nacimiento=?,
                        tb_datosterceros.cut=?,
                        tb_datosterceros.sucursal=?,
                        tb_datosterceros.sangre=?,
                        tb_datosterceros.regimen=?,
                        tb_datosterceros.cargo=?,
                        tb_datosterceros.pais=?,
                        tb_datosterceros.estado=?,
                        tb_datosterceros.telefono=?,
                        tb_datosterceros.correo=?,
                        tb_datosterceros.direccion=?,
                        tb_datosterceros.departamento=?,
                        tb_datosterceros.provincia=?,
                        tb_datosterceros.distrito=?,
                        tb_datosterceros.proyecto=?,
                        tb_datosterceros.empresa=?
                    WHERE tb_datosterceros.dni=?";

            /* $activo = $datos['estado_user'] == "01" ? 1 : 0; */
            $valores = [
                $datos['paterno'] ?: null,
                $datos['materno'] ?: null,
                $datos['nombres'] ?: null,
                $datos['nacimiento'] ?: null,
                $datos['codigo'] ?: null,
                $datos['sucursal'] ?: null,
                $datos['grupo'] ?: null,
                $datos['planilla'] ?: null,
                $datos['cargo'] ?: null,
                $datos['nacionalidad'] ?: null,
                $datos['estado'] ?: null,
                $datos['telefono'] ?: null,
                $datos['correo'] ?: null,
                $datos['direccion'] ?: null,
                $datos['dpto']?:null,
                $datos['prov']?:null,
                $datos['dist']?:null,
                $datos['proyecto'] ?: null,
                $datos['empresa'] ?: null,
                $datos['documento_tercero']
            ];

            $statement = $pdo->prepare($sql);
            $statement -> execute($valores);
                                    
            // Verificar si se insertaron filas
            /* if ($statement->rowCount() > 0) {
                return ['success'=> true, 'message' => "Datos actualizados correctamente", 'datos'=>$datos];
            } else {
                return ['success'=> false, 'message' => "No se actualizaron datos", 'datos'=>$datos];
            } */
           return true;
        } catch (PDOException $th) {
            /* return ['message' => "Error: " . $th->getMessage()]; */
            return false;
        }
    }
    function grabarTerceros($pdo, $datos){
        if ($datos['existeTercero'] == 0) {
            $dataTercero = grabarDatosTerceros($pdo, $datos);
            $mensajeTercero = "Datos de tercero guardados correctamente";
        } else {
            $dataTercero = actualizarDatosTerceros($pdo, $datos);
            $mensajeTercero = "Datos de tercero actualizados correctamente";
        }
    
        if ($datos['existeTerceroTareoData'] == 0) {
            $datoTareo = grabarDatosTareo($pdo, $datos);
            $mensajeTareo = "Datos de tareo guardados correctamente";
        } else {
            $datoTareo = actualizarDatosTareo($pdo, $datos);
            $mensajeTareo = "Datos de tareo actualizados correctamente";
        }
    
        return ['success' => true, 'message' => "$mensajeTercero. $mensajeTareo"];
        /* return $result; */
        
    }
    function actualizarAccesoProyecto($pdo,$idreg): array{
        try {
            $sql = "UPDATE tm_userproyectos
                    SET tm_userproyectos.nflgactivo = 0
                    WHERE idreg = ?";
            
            $statement = $pdo->prepare($sql);
            $statement -> execute(array($idreg));

            if ($statement->rowCount() > 0) {
                return ['success'=> true];
            } else {
                return ['success'=> false];
            } 
                            
        } catch (PDOException $th) {
            /* echo "Error: " . $th->getMessage; */
            return ['success'=> false, 'message' => "Error: " . $th->getMessage()];
            /* return false; */
        }
    }

    function grabarFase($pdo, $datos){
        try {
            $fases = json_decode($datos['fases']);
            $nreg = count($fases);

            for ($i=0; $i < $nreg; $i++) { 
                try {
                    $sql = "INSERT INTO tb_fases
                            SET tb_fases.cnombre = ?,
                                tb_fases.cdescripcion = ?";

                    $statement = $pdo->prepare($sql);
                    $statement -> execute(array($fases[$i]->nombre,
                                                $fases[$i]->descripcion));

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

    function grabarProyectoFase($pdo, $datos){
        try {
            $fases = json_decode($datos['proyectoFases']);
            $nreg = count($fases);

            for ($i=0; $i < $nreg; $i++) { 
                try {
                    $sql = "INSERT INTO tb_proyectofases
                            SET tb_proyectofases.ccodigoproyecto = ?,
                                tb_proyectofases.idfase = ?";

                    $statement = $pdo->prepare($sql);
                    $statement -> execute(array($fases[$i]->proyecto,
                                                $fases[$i]->fase));

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

    function grabarEncargado($pdo, $datos){
        try {
            $encargados = json_decode($datos['encargados']);
            $nreg = count($encargados);

            for ($i=0; $i < $nreg; $i++) { 
                try {
                    $sql = "INSERT INTO tb_encargados
                            SET tb_encargados.cnumdoc = ?,
                                tb_encargados.cnombrecompleto = ?";

                    $statement = $pdo->prepare($sql);
                    $statement -> execute(array($encargados[$i]->numdoc,
                                                $encargados[$i]->nombres));

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

    function grabarEncargadoProyecto($pdo, $datos){
        try {
            $encargados = json_decode($datos['encargadosProyecto']);
            $nreg = count($encargados);

            for ($i=0; $i < $nreg; $i++) { 
                try {
                    $sql = "INSERT INTO tb_encargadoproyectos
                            SET tb_encargadoproyectos.ccodigoproyecto = ?,
                                tb_encargadoproyectos.idencargado = ?";

                    $statement = $pdo->prepare($sql);
                    $statement -> execute(array($encargados[$i]->proyecto,
                                                $encargados[$i]->encargado));

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

    function grabarUbicacion($pdo, $datos){
        try {
            $ubicaciones = json_decode($datos['ubicaciones']);
            $nreg = count($ubicaciones);

            for ($i=0; $i < $nreg; $i++) { 
                try {
                    $sql = "INSERT INTO tb_ubicacion
                            SET tb_ubicacion.cubicacion = ?";

                    $statement = $pdo->prepare($sql);
                    $statement -> execute(array($ubicaciones[$i]->ubicacion));

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

    function grabarEspecialidad($pdo, $datos){
        try {
            $especialidades = json_decode($datos['especialidades']);
            $nreg = count($especialidades);

            for ($i=0; $i < $nreg; $i++) { 
                try {
                    $sql = "INSERT INTO tb_especialidad
                            SET tb_especialidad.cespecialidad = ?";

                    $statement = $pdo->prepare($sql);
                    $statement -> execute(array($especialidades[$i]->especialidad));

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

    function actualizarEncargado($pdo, $datos) {
        try {
            $encargados = json_decode($datos['encargado']);


        
                try {
                    $sql = "UPDATE tb_encargados
                            SET
                            tb_encargados.cnombrecompleto = ?,
                            tb_encargados.cnumdoc = ?
                            WHERE tb_encargados.idencargado = ?";

                    $statement = $pdo->prepare($sql);
                    $statement -> execute(array($encargados->nombres,
                        $encargados->numdoc,
                        $encargados->idEncargado));

                    //var_dump($statement->errorInfo());

                } catch (PDOException $th) {
                    echo "Error: " . $th->getMessage;
                    return false;
                }

            //var_dump($proyectos[0]->codigo);

        } catch (PDOException $th) {
            echo "Error: " . $th->getMessage;
        }
    }

    function actualizarFase($pdo, $datos) {
        try {
            $fase = json_decode($datos['fase']);


        
                try {
                    $sql = "UPDATE tb_fases
                            SET
                            tb_fases.cnombre = ?,
                            tb_fases.cdescripcion = ?
                            WHERE tb_fases.idfase = ?";

                    $statement = $pdo->prepare($sql);
                    $statement -> execute(array($fase->nombre,
                        $fase->descripcion,
                        $fase->idFase));

                    //var_dump($statement->errorInfo());

                } catch (PDOException $th) {
                    echo "Error: " . $th->getMessage;
                    return false;
                }

            //var_dump($proyectos[0]->codigo);

        } catch (PDOException $th) {
            echo "Error: " . $th->getMessage;
        }
    }

?>