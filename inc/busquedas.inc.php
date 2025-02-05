<?php
    require_once('connect.inc.php');

    if ( isset( $_POST )) {
        if ($_POST['funcion'] === "buscarDatosColaborador") {
            echo json_encode(buscarDatosColaborador($pdo,$_POST['dni'])); 
        } else if ($_POST['funcion'] === "buscarEmpleados") {
            echo json_encode(buscarEmpleados($pdo,$_POST['paterno']));
        }else if ($_POST['funcion'] === "existeDatosColaborador") {
            echo json_encode(existeDatosColaborador($pdo,$_POST['dni'])); 
        }else if ($_POST['funcion'] === "buscarDatosUsuarioSistema") {
            echo json_encode(buscarDatosUsuarioSistema($pdo,$_POST['dni'])); 
        }else if ($_POST['funcion'] === "proyectosUsuarios") {
            echo json_encode(proyectosUsuarios($pdo,$_POST['dni'])); 
        }else if ($_POST['funcion'] === "listarPadron") {
            echo json_encode(listarPadron($pdo,$_POST['costos'])); 
        }else if ($_POST['funcion'] === "estadoUsuarioPadron") {
            echo json_encode(estadoUsuarioPadron($pdo)); 
        }else if ($_POST['funcion'] === "validarColaborador"){
            echo json_encode(validarColaborador($pdo));
        }else if ($_POST['funcion'] === "tareosMaxFecha"){
            echo json_encode(tareosMaxFecha($pdo, $_POST['proyecto'], $_POST['tercero']));
        }else if ($_POST['funcion'] === "obtenerTareosProyectoColaborador"){
            echo json_encode(obtenerTareosProyectoColaborador($pdo,$_POST));
        }else if ($_POST['funcion'] === "buscarDatosTercero"){
            echo json_encode(buscarDatosTercero($_POST['dni']));
        }else if ($_POST['funcion'] === "obtenerUbigeo"){
            echo json_encode(obtenerUbigeo($_POST['ubigeo']));
        }else if ($_POST['funcion'] === "obtenerTercero"){
            echo json_encode(obtenerTercero($pdo, $_POST['dni']));
        }else if ($_POST['funcion'] === "buscarDatosColaboradorTercero"){
            echo json_encode(buscarDatosColaboradorTercero($pdo, $_POST['dni']));
        }else if ($_POST['funcion'] === "obtenerProyectos"){
            echo json_encode(obtenerProyectos($pdo));
        }else if ($_POST['funcion'] === "listarPadronTerceros"){
            echo json_encode(listarPadronTerceros($pdo, $_POST['proyecto']));
        }else if ($_POST['funcion'] === "getTareosByFecha"){
            echo json_encode(getTareosByFecha($pdo, $_POST));
        }else if ($_POST['funcion'] === "obtenerFases"){
            echo json_encode(obtenerFases($pdo));
        }else if ($_POST['funcion'] === "obtenerProyectosFases"){
            echo json_encode(obtenerProyectosFases($pdo));
        }else if ($_POST['funcion'] === "obtenerEncargados"){
            echo json_encode(obtenerEncargados($pdo));
        }else if ($_POST['funcion'] === "obtenerEncargadosProyecto"){
            echo json_encode(obtenerEncargadosProyecto($pdo));
        }else if ($_POST['funcion'] === "obtenerUbicaciones"){
            echo json_encode(obtenerUbicaciones($pdo));
        }else if ($_POST['funcion'] === "obtenerEspecialidades"){
            echo json_encode(obtenerEspecialidades(($pdo)));
        }else if ($_POST['funcion'] === "obtenerTodosDatosTareo"){
            echo json_encode(obtenerTodosDatosTareo($pdo));
        }else if ($_POST['funcion'] === "obtenerProyectosFasesById"){
            echo json_encode(obtenerProyectosFasesById($pdo, $_POST['id']));
        }else if ($_POST['funcion'] === "obtenerEncargadosProyectoById"){
            echo json_encode(obtenerEncargadosProyectoById($pdo, $_POST['id']));
        }else if($_POST['funcion']==="obtenerRegimen"){
            echo json_encode(obtenerRegimen($pdo));
        }
    }
 
    function buscarDatosColaborador($pdo,$doc){
        try {
            $url = "http://sicalsepcon.net/api/matrizworkerdataapi.php?documento=".$doc;
            $api = file_get_contents($url);
            $datos =  json_decode($api);

            $ubicacion = $datos[0]->ubigeo;
            $origen = $datos[0]->origen;
        
            $ubigeo = "http://sicalsepcon.net/api/ubigeoapi.php?ubigeo=$ubicacion";
            $apiUbigeo =  file_get_contents($ubigeo);
            $datosUbigeo = json_decode($apiUbigeo);

            $datosTareo = datosTareo($pdo,$doc);
            $tareo = tareoPadron($pdo,$doc);

            $origen = "http://sicalsepcon.net/api/ubigeoapi.php?ubigeo=$origen";
            $apiOrigen =  file_get_contents($origen);
            $datosOrigen = json_decode($apiOrigen);

            $foto = fotoUsuarioSistema($doc);

            return array("datos" => $datos,"ubigeo"=>$datosUbigeo,"origen"=>$datosOrigen,"datosTareo"=>$datosTareo,"tareo"=>$tareo, "foto"=>$foto);

        }  catch ( PDOException $e) {
            echo "Error: " . $e->getMessage;
            return false;
        }
    }
     function buscarEmpleados($pdo,$doc){
        try{
            $nombres = str_replace(" ","%20",$doc);
            $url = "http://sicalsepcon.net/api/nombresApipadron.php?nombres=".$nombres;
            $json_data = file_get_contents($url);
            $datos = json_decode($json_data);

            $nreg = count($datos);

            $existe = $nreg >= 1 ? true : false;
            if($existe){

                return array(
                    "datos"=>$datos,
                    "existe"=>$existe
                );
            }else {
                return array("existe" => $existe);
              }
         
        }catch (PDOException $th) {
            echo "Error: " . $th->getMessage();
            return false;
        }
    }  

    function ubigeoPadron($pdo, $doc){
        try {
            $url = "http://sicalsepcon.net/api/matrizworkerdataapi.php?documento=".$doc;
            $api = file_get_contents($url);
            $datos =  json_decode($api);

            $ubicacion = $datos[0]->ubigeo;
        
            $ubigeo = "http://sicalsepcon.net/api/ubigeoapi.php?ubigeo=$ubicacion";
            $apiUbigeo =  file_get_contents($ubigeo);
            $datosUbigeo = json_decode($apiUbigeo);

            return array("datos" => $datos,"origen"=>$datosUbigeo);

        }  catch ( PDOException $e) {
            echo "Error: " . $e->getMessage;
            return false;
        }
    }

    function datosTareo($pdo,$doc){
        $docData = [];

        try {
            $sql = "SELECT  tb_datostareo.nddoc,
                            tb_datostareo.cencargado,
                            tb_datostareo.ncondicion,
                            tb_datostareo.npersonal,
                            tb_datostareo.cespecialidad,
                            tb_datostareo.nmanoobra,
                            tb_datostareo.cproyecto,
                            tb_datostareo.cfase,
                            tb_datostareo.cubicacion,
                            tb_datostareo.cregimen,
                            tb_datostareo.fingreso,
                            tb_datostareo.fsalida,
                            tb_datostareo.fretorno,
                            tb_datostareo.dgoce,
                            tb_datostareo.dlibre,
                            tb_datostareo.dcampo,
                            tb_datostareo.dreales,
                            tb_datostareo.cobservaciones,
                            tb_datostareo.cdescanso,
                            tb_datostareo.fcese,
                            tb_datostareo.cmotivocese,
                            tb_datostareo.turno,
                            tb_datostareo.nregimen,
                            tb_datostareo.nespecificacion,
                            tb_datostareo.fregsys,
                            tb_datostareo.transitoingreso,
                            tb_datostareo.transitosalida

                        FROM
                            tb_datostareo 
                        WHERE
                            tb_datostareo.nddoc = ?
                        ORDER BY
                            tb_datostareo.fregsys DESC 
                        LIMIT 1";

                    $statement = $pdo->prepare($sql);
                    $statement -> execute(array($doc));

                    while($row = $statement->fetch(PDO::FETCH_ASSOC)){
                        $docData[] = $row;
                    }

                    return $docData;

                } catch ( PDOException $e) {
                    echo "Error: " . $e->getMessage;
                    return false;
                }
            }

            function tareo($pdo,$doc){
                $docData = [];

                try {
                    $sql = "SELECT  tb_tareo.idreg,
                                    tb_tareo.ndoc,
                                    tb_tareo.ffecha,
                                    tb_tareo.iduser,
                                    tb_tareo.d1,
                                    tb_tareo.d2,
                                    tb_tareo.d3,
                                    tb_tareo.d4,
                                    tb_tareo.d5,
                                    tb_tareo.d6,
                                    tb_tareo.d7,
                                    tb_tareo.d8,
                                    tb_tareo.d9,
                                    tb_tareo.d10,
                                    tb_tareo.d11,
                                    tb_tareo.d12,
                                    tb_tareo.d13,
                                    tb_tareo.d14,
                                    tb_tareo.d15,
                                    tb_tareo.d16,
                                    tb_tareo.d17,
                                    tb_tareo.d18,
                                    tb_tareo.d19,
                                    tb_tareo.d20,
                                    tb_tareo.d21,
                                    tb_tareo.d22,
                                    tb_tareo.d23,
                                    tb_tareo.d24,
                                    tb_tareo.d25,
                                    tb_tareo.d26,
                                    tb_tareo.d27,
                                    tb_tareo.d28,
                                    tb_tareo.d29,
                                    tb_tareo.d30,
                                    tb_tareo.d31,
                                    tb_tareo.d32,
                                    tb_tareo.d33,
                                    tb_tareo.d34,
                                    tb_tareo.fregsys 
                                FROM
                                    tb_tareo 
                                WHERE
                                    tb_tareo.ndoc = ? 
                                ORDER BY
                                    tb_tareo.fregsys DESC
                                LIMIT 1";

            $statement = $pdo->prepare($sql);
            $statement -> execute(array($doc));

            while($row = $statement->fetch(PDO::FETCH_ASSOC)){
                $docData[] = $row;
            }

            return $docData;
        } catch ( PDOException $e) {
            echo "Error: " . $e->getMessage;
            return false;
        }
    }

    function existeDatosColaborador($pdo,$doc){
        try {
            $sql = "SELECT COUNT(cm_users.idreg) AS usuario FROM cm_users WHERE cm_users.cuserdoc = ?";
            $statement = $pdo->prepare($sql);
            $statement -> execute(array($doc));
            $nro_registros = $statement->fetchAll();
            $dataAcceso = null;
            $dataProyectos = null;

            $url = "http://sicalsepcon.net/api/matrizworkerdataapi.php?documento=".$doc;
            $api = file_get_contents($url);
            $datos =  json_decode($api);

            if ( $nro_registros[0]['usuario'] > 0 ) {
                $dataAcceso = dataAccesos($pdo,$doc);
                $dataProyectos = proyectosUsuarios($pdo,$doc);
            }

            return array("datos" => $datos,"registros" => $nro_registros,"acceso"=>$dataAcceso,"proyectos"=>$dataProyectos);
        } catch ( PDOException $e) {
            echo "Error: " . $e->getMessage;
            return false;
        }
    }

    function dataAccesos($pdo,$doc){
        try {
            $docData = []; 

            $sql = "SELECT cm_users.cusername,
                            cm_users.cuserpass,
                            cm_users.cusermail,
                            DATE_FORMAT(cm_users.freg ,'%Y-%m-%d') AS freg,
                            cm_users.nflgactivo
                    FROM cm_users
                    WHERE cm_users.cuserdoc = ? ";
            
            $statement = $pdo->prepare($sql);
            $statement -> execute(array($doc));

            while($row = $statement->fetch(PDO::FETCH_ASSOC)){
                $docData[] = $row;
            }

            return $docData;
            
        } catch ( PDOException $e) {
            echo "Error: " . $e->getMessage;
            return false;
        }
    }

    function proyectosUsuarios($pdo,$doc){
        $sql = "SELECT tm_userproyectos.cdescripcion,
                       tm_userproyectos.ccodigo,
                       tm_userproyectos.idreg
                FROM tm_userproyectos
                WHERE tm_userproyectos.cdocumento = ?
                AND tm_userproyectos.nflgactivo = 1";
        
        $statement = $pdo->prepare($sql);
        $statement -> execute(array($doc));

        while($row = $statement->fetch(PDO::FETCH_ASSOC)){
            $docData[] = $row;
        }

        return $docData;
    }

    function buscarDatosUsuarioSistema($pdo,$doc){
        try {
            $url = "http://sicalsepcon.net/api/matrizworkerdataapi.php?documento=".$doc;
            $api = file_get_contents($url);
            $datos =  json_decode($api);
            $foto = fotoUsuarioSistema($doc);

            return array("datos" => $datos, "foto" => $foto);

        } catch ( PDOException $e) {
            echo "Error: " . $e->getMessage;
            return false;
        }
    }

    function fotoUsuarioSistema($doc){
        $dni = $doc;
        $url2 = 'http://rrhhperu.sepcon.net/api/postulantes/fotospostulantes.php';
                $json_permiso = file_get_contents($url2, false, stream_context_create([
                                        'http' => [
                                            'method' => 'POST',
                                            'header' => 'Content-Type: application/json',
                                            'content' => json_encode(['dni' => $dni])
                                        ]
                                    ]));
                $dato2 = json_decode($json_permiso);
        return $dato2;
    }

    function listarPadron($pdo,$costos){
        try {
            $url = "http://sicalsepcon.net/api/listapadronapi.php?cc=".$costos;
            $api = file_get_contents($url);
            $datos =  json_decode($api);

            return array("datos" => $datos);
        } catch ( PDOException $e) {
            echo "Error: " . $e->getMessage;
            return false;
        }
    }

    function listarUbicacion($pdo,$sede){
        try {
            $url = "http://sicalsepcon.net/api/listaubicacionapi.php?cs=".$sede;
            $api = file_get_contents($url);
            $datos =  json_decode($api);

            return array("datos" => $datos);
        } catch ( PDOException $e) {
            echo "Error: " . $e->getMessage;
            return false;
        }
    }

    function tareoPadron($pdo,$doc){

        $mes = date("n");
        $docData = [];

        $sql = "SELECT
                tb_tareos.nrodoc,
                tb_tareos.estado,
                DAY(tb_tareos.fregsys) AS dia,
                tb_tareos.mes,
                tb_tareos.anio 
            FROM
                tb_tareos 
            WHERE
                tb_tareos.nrodoc = ?
            AND 
                tb_tareos.mes = ?";
        
        $statement = $pdo->prepare($sql);
        $statement -> execute(array($doc, $mes));

        while($row = $statement->fetch(PDO::FETCH_ASSOC)){
            $docData[] = $row;
        }

        return $docData;
    }

    function estadoUsuarioPadron($pdo){
        $docData = [];
        date_default_timezone_set('America/Lima');
        $fecha = date("Y-m-d");

        $sql = "SELECT
                tb_tareos.idreg,
                tb_tareos.nrodoc,
                tb_tareos.estado,
                tb_tareos.fingreso
            FROM
                tb_tareos 
            WHERE
                DATE(tb_tareos.fregsys) = ?";
        
        $statement = $pdo->prepare($sql);
        $statement -> execute(array($fecha));

        while($row = $statement->fetch(PDO::FETCH_ASSOC)){
            $docData[] = $row;
        }

        return $docData;
    }

    function validarColaborador($pdo){
        $docData = [];

        $sql = "SELECT DISTINCT nrodoc FROM tb_tareos";
        
        $statement = $pdo->prepare($sql);
        $statement -> execute();

        while($row = $statement->fetch(PDO::FETCH_ASSOC)){
            $docData[] = $row;
        }

        return $docData;
    }

    function tareosMaxFecha($pdo, $proyecto, $tercero) {
        $docData = [];

        if($tercero == 1){
            $sql = "SELECT * FROM tb_tareos WHERE DATE(fregsys) = (SELECT DATE(MAX(fregsys)) FROM tb_tareos WHERE cproyecto = ? and nrodoc in (select distinct dni from tb_datosterceros)) and cproyecto  = ? and nrodoc in (select distinct dni from tb_datosterceros)";
        }else {
            $sql = "SELECT * FROM tb_tareos WHERE DATE(fregsys) = (SELECT DATE(MAX(fregsys)) FROM tb_tareos WHERE cproyecto = ? and nrodoc not in (select distinct dni from tb_datosterceros)) and cproyecto  = ? and nrodoc not in (select distinct dni from tb_datosterceros)";
        }
        /* $sql = "SELECT * FROM tb_tareos WHERE DATE(fregsys) = DATE_SUB(CURDATE(), INTERVAL 1 DAY)"; */
        /* $sql = "SELECT * FROM tb_tareos WHERE DATE(fregsys) = (SELECT DATE(MAX(fregsys)) FROM tb_tareos WHERE cproyecto = ?)"; */
        
        $statement = $pdo->prepare($sql);
        $statement -> execute(array($proyecto, $proyecto));

        while($row = $statement->fetch(PDO::FETCH_ASSOC)){
            $docData[] = $row;
        }

        return $docData;
    }

    function getTareosByFecha($pdo, $datos) {
        $docData = [];

        /* $sql = "SELECT * FROM tb_tareos WHERE DATE(fregsys) = DATE_SUB(CURDATE(), INTERVAL 1 DAY)"; */
        $sql = "SELECT * FROM tb_tareos WHERE DATE(fregsys) = ? AND cproyecto = ?" ;
        
        $statement = $pdo->prepare($sql);
        $statement -> execute(array($datos['fecha'], $datos['proyecto']));

        while($row = $statement->fetch(PDO::FETCH_ASSOC)){
            $docData[] = $row;
        }

        return $docData;
    }

    function obtenerTodosDatosTareo($pdo){
        $docData = [];

        /* $sql = "SELECT * FROM tb_tareos WHERE DATE(fregsys) = DATE_SUB(CURDATE(), INTERVAL 1 DAY)"; */
        $sql = "select tdt.nddoc, tdt.cubicacion, tub.cubicacion from tb_datostareo tdt
        inner join tb_ubicacion tub on tub.idubicacion = tdt.cubicacion" ;
        
        $statement = $pdo->prepare($sql);
        $statement -> execute();

        while($row = $statement->fetch(PDO::FETCH_ASSOC)){
            $docData[] = $row;
        }

        return $docData;
    }

    function obtenerTareosProyectoColaborador($pdo,$datos){
        try {
            $cc = $datos['proyecto'];
            $fechaProceso = new DateTime($datos['fechaProceso']);
            $mes = $fechaProceso->format('m');
            $tareos = [];
            $url = "http://sicalsepcon.net/api/listapadronapi.php?cc=".$cc;
            $api = file_get_contents($url);
            $colaboradoresProyecto =  json_decode($api);

            foreach($colaboradoresProyecto as $colab) {
                $dataColab = ubigeoPadron($pdo,$colab->dni);
                $colab->dataColab = $dataColab;
            }

            $colaboradoresProyectoTerceros = listarPadronTerceros($pdo, $cc);

            /* $sql = "SELECT nrodoc, GROUP_CONCAT(estado ORDER BY estado SEPARATOR ',') AS estados FROM tb_tareos where cproyecto = ? GROUP BY nrodoc"; */
            $sql = "SELECT nrodoc, 
                    GROUP_CONCAT(estado ORDER BY fregsys SEPARATOR ',') AS estados,
                    group_concat(day(fregsys) order by fregsys separator ',') as dias,
                    group_concat(cubicacion order by fregsys separator ',') as ubicaiones 
                    FROM tb_tareos where cproyecto = ? and month(fregsys) = ?
                    GROUP BY nrodoc";
            /* $sql = "SELECT t.nrodoc, td.cfase, concat(tf.cnombre,' ', tf.cdescripcion) as fase, GROUP_CONCAT(t.estado ORDER BY t.fregsys SEPARATOR ',') AS estados, group_concat(day(t.fregsys) order by t.fregsys separator ',') as dias 
                    FROM tb_tareos t
                    left join tb_datostareo td on td.nddoc = t.nrodoc
                    left join tb_fases tf on tf.idfase = td.cfase
                    where t.cproyecto = ? and month(t.fregsys) = ? GROUP BY t.nrodoc"; */
        
            $statement = $pdo->prepare($sql);
            $statement -> execute(array($cc, $mes));

            while($row = $statement->fetch(PDO::FETCH_ASSOC)){
                $tareos[] = $row;
            }

            $datosT = [];
            $sqlData = "SELECT nddoc, t.fingreso,t.dcampo as diasCampo,t.turno , personal.cdescripcion as tipoPersonal, 
            regimen.cdescripcion AS regimen, manoobra.cdescripcion AS mano_obra FROM tb_datostareo t LEFT JOIN tb_parametros regimen 
            ON regimen.idreg = t.nregimen AND regimen.nclase = 03 LEFT JOIN tb_parametros manoobra ON manoobra.idreg = t.nmanoobra 
            AND manoobra.nclase = 01 LEFT JOIN tb_parametros personal ON personal.idreg = t.npersonal and personal.nclase = 02 left join tb_tareos tareos on tareos.nrodoc = t.nddoc group by nddoc;";  
            //kes
           /*  $sqlData =" SELECT 
                t.fsalida, 
                DATEDIFF(t.fsalida, CURDATE()) AS dcampo,
             SUM(CASE WHEN t.fsalida = 'A' AND DATEDIFF(t.fsalida, CURDATE()) >= 0 THEN 1 ELSE 0 END) AS suma_condiciones
            FROM 
                tb_datostareo t 
            GROUP BY 
                t.fsalida, dcampo"
            ;   */

             //Eliminar tablas temporales (si existen) */
           /*  $pdo->exec("DROP TEMPORARY TABLE IF EXISTS temp_tareo_resultados;");
            $pdo->exec("DROP TEMPORARY TABLE IF EXISTS temp_tareo_validacion;");
            $pdo->exec("DROP TEMPORARY TABLE IF EXISTS temp_tareo_data;");

            //Crear tabla temp_tareo_resultados
            $pdo->exec("
            CREATE TEMPORARY TABLE temp_tareo_resultados AS 
            SELECT 
                nddoc, 
                t.fingreso,  
                personal.cdescripcion AS tipoPersonal, 
                regimen.cdescripcion AS regimen, 
                manoobra.cdescripcion AS mano_obra,
                turno 
            FROM tb_datostareo t 
            LEFT JOIN tb_parametros regimen 
                ON regimen.idreg = t.nregimen AND regimen.nclase = 03 
            LEFT JOIN tb_parametros manoobra 
                ON manoobra.idreg = t.nmanoobra AND manoobra.nclase = 01
            LEFT JOIN tb_parametros personal 
                ON personal.idreg = t.npersonal AND personal.nclase = 02;
            ");

            //Crear tabla temp_tareo_validacion
            $pdo->exec("
            CREATE TEMPORARY TABLE temp_tareo_validacion AS 
            SELECT 
                DISTINCT 
                t.nddoc, 
                t.fingreso, 
                tareos.estado, 
                tareos.fregsys, 
                (CASE 
                    WHEN tareos.estado = 'A' AND DATE(tareos.fregsys) >= DATE(t.fingreso) THEN 1
                    ELSE 0
                END) AS cumple_condicion
            FROM tb_datostareo t 
            LEFT JOIN tb_tareos tareos 
                ON tareos.nrodoc = t.nddoc
            WHERE DATE(tareos.fregsys) >= DATE(t.fingreso);
            ");

            //Crear tabla temp_tareo_data con el resultado final
            $pdo->exec("
            CREATE TEMPORARY TABLE temp_tareo_data AS 
            SELECT 
                nddoc,
                fingreso,
                tipoPersonal,
                regimen,
                mano_obra,
                turno,
                SUM(cumple_condicion) AS diasCampo 
            FROM (
                SELECT DISTINCT 
                    resultados.nddoc,
                    resultados.fingreso,
                    resultados.tipoPersonal,
                    resultados.regimen,
                    resultados.mano_obra,
                    validacion.estado,
                    validacion.fregsys,
                    resultados.turno,
                    validacion.cumple_condicion
                FROM temp_tareo_resultados resultados
                LEFT JOIN temp_tareo_validacion validacion
                ON resultados.nddoc = validacion.nddoc
            ) AS table_tareos
            GROUP BY nddoc;
            "); 
 */
            //Obtener los resultados de la tabla temporal
            /* $dataStatement = $pdo->query("SELECT * FROM temp_tareo_data;"); */
            $dataStatement=$pdo->prepare($sqlData);
            $dataStatement->execute();
            while($rowData = $dataStatement->fetch(PDO::FETCH_ASSOC)){
                $datosT[] = $rowData;
            }

            $datosFases = [];
            $sqlDataFases = "SELECT t.nrodoc, coalesce(td.cfase, 0) as idFase, coalesce(tf.cnombre,t.cproyecto) as cfase , coalesce(tf.cdescripcion, 'SIN FASE ASIGNADO') as fase
                            FROM tb_tareos t
                            left join tb_datostareo td on td.nddoc = t.nrodoc
                            left join tb_fases tf on tf.idfase = td.cfase
                            where t.cproyecto = ? and month(t.fregsys) = ? GROUP BY t.nrodoc
                            ORDER BY td.cfase";
            $dataFasesStatement = $pdo->prepare($sqlDataFases);
            $dataFasesStatement -> execute(array($cc, $mes));
            while($rowDataFasesStatement = $dataFasesStatement->fetch(PDO::FETCH_ASSOC)){
                $datosFases[] = $rowDataFasesStatement;
            }

            return array("colaboradoresProyecto" =>$colaboradoresProyecto,"colaboradoresProyectoTerceros" => $colaboradoresProyectoTerceros['datos'] ,"tareos"=>$tareos,"datosTareo" => $datosT, "fases"=>$datosFases);

        }  catch ( PDOException $e) {
            echo "Error: " . $e->getMessage;
            return false;
        }
    }

    function buscarDatosTercero($dni){
        // Datos
        $token = 'apis-token-11131.mkrQOQ0l78omH5r8C6plkKF7CpZ2ZFpx';
        // Iniciar llamada a API
        $curl = curl_init();

        // Buscar dni
        curl_setopt_array($curl, array(
        CURLOPT_URL => 'https://api.apis.net.pe/v2/reniec/dni?numero=' . $dni,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_SSL_VERIFYPEER => 0,
        CURLOPT_ENCODING => '',
        CURLOPT_MAXREDIRS => 2,
        CURLOPT_TIMEOUT => 0,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_CUSTOMREQUEST => 'GET',
        CURLOPT_HTTPHEADER => array(
            'Referer: https://apis.net.pe/consulta-dni-api',
            'Authorization: Bearer ' . $token
        ),
        ));

        $response = curl_exec($curl);

        curl_close($curl);
        // Datos listos para usar
        $persona = json_decode($response);
        return $persona;

    }
    function obtenerUbigeo($ubicacion){
        $ubigeo = "http://sicalsepcon.net/api/ubigeoapi.php?ubigeo=$ubicacion";
            $apiUbigeo =  file_get_contents($ubigeo);
            $datosUbigeo = json_decode($apiUbigeo);
        return ['ubigeo' => $datosUbigeo];
    }

    function obtenerTercero($pdo,$dni){
        $sql = "SELECT * FROM tb_datosterceros where dni=?";
        
        $statement = $pdo->prepare($sql);
        $statement -> execute(array($dni));
        $result = $statement->fetch(PDO::FETCH_ASSOC);
        return $result;
    }
    function obtenerRegimen($pdo){
        $docData=[];
        $sql="SELECT cdescrip,idreg,diasgoce,periodo from regimen";
        $statement = $pdo->prepare($sql);
        $statement -> execute();
        while($row = $statement->fetch(PDO::FETCH_ASSOC)){
            $docData[] = $row;
        }

        return $docData;
    }
    
    /* function obtenerDiasGoce($pdo){
        
    } */

    function buscarDatosColaboradorTercero ($pdo,$dni){
        $tercero = obtenerTercero($pdo, $dni);
        if ($tercero){
            /* $ubicacion = obtenerUbigeo($tercero['ubigeo']); */
            $ubicacion = [];
            $datosTareo = datosTareo($pdo, $dni);
            $tareo = tareoPadron($pdo,$dni);
            return ['exist' => true, 'datos'=>$tercero, 'datosTareo' => $datosTareo, 'tareo'=>$tareo];
        } else {
            $terceroApi = buscarDatosTercero($dni);
            return ['exist' => false, 'datos'=>$terceroApi];
        }
    }

    function obtenerProyectos($pdo){{
        $docData = [];

        /* $sql = "SELECT * FROM tb_tareos WHERE DATE(fregsys) = DATE_SUB(CURDATE(), INTERVAL 1 DAY)"; */
        $sql = "SELECT DISTINCT
                CONCAT(TRIM(ccodproy),'00') AS ccodproy, 
                CONCAT(CONCAT(TRIM(ccodproy),'00'),' ', TRIM(cdesproy), COALESCE(CONCAT(' / ',TRIM(cabrevia)),'')) AS cdesproy 
                FROM ibis.tb_proyectos
                WHERE ccodproy NOT LIKE '%.%'
                GROUP BY ccodproy";
        
        $statement = $pdo->prepare($sql);
        $statement -> execute();

        while($row = $statement->fetch(PDO::FETCH_ASSOC)){
            $docData[] = $row;
        }

        return $docData;
    }}

    function obtenerFases($pdo) {
        $docData = [];

        /* $sql = "SELECT * FROM tb_tareos WHERE DATE(fregsys) = DATE_SUB(CURDATE(), INTERVAL 1 DAY)"; */
        $sql = "SELECT idfase, cnombre, cdescripcion FROM tb_fases WHERE nflgactivo = 1 ORDER BY cnombre";
        
        $statement = $pdo->prepare($sql);
        $statement -> execute();

        while($row = $statement->fetch(PDO::FETCH_ASSOC)){
            $docData[] = $row;
        }

        return $docData;
    }

    function obtenerProyectosFases($pdo) {
        $docData = [];

        /* $sql = "SELECT * FROM tb_tareos WHERE DATE(fregsys) = DATE_SUB(CURDATE(), INTERVAL 1 DAY)"; */
        $sql = "SELECT 
                    tp.idproyectofase AS idProyectoFase, 
                    tp.ccodigoproyecto AS codigoProyecto, 
                    tf.idfase AS idFase, 
                    tf.cnombre AS nombreFase,
                    tf.cdescripcion as descripcionFase
                FROM tb_proyectofases tp 
                INNER JOIN tb_fases tf 
                ON tf.idfase = tp.idfase
                WHERE tp.nflgactivo = 1";
        
        $statement = $pdo->prepare($sql);
        $statement -> execute();

        while($row = $statement->fetch(PDO::FETCH_ASSOC)){
            $docData[] = $row;
        }

        return $docData;
    }

    function obtenerProyectosFasesById($pdo, $id){
        $docData = [];

        $sql = "SELECT 
                    tp.idproyectofase AS idProyectoFase, 
                    tp.ccodigoproyecto AS codigoProyecto, 
                    tf.idfase AS idFase, 
                    tf.cnombre AS nombreFase,
                    tf.cdescripcion as descripcionFase
                FROM tb_proyectofases tp 
                INNER JOIN tb_fases tf 
                ON tf.idfase = tp.idfase
                WHERE tp.idproyectofase = ?";
        
        $statement = $pdo->prepare($sql);
        $statement -> execute(array($id));

        while($row = $statement->fetch(PDO::FETCH_ASSOC)){
            $docData[] = $row;
        }

        return $docData;
    }

    function obtenerEncargadosProyectoById($pdo, $id){
        $docData = [];

        $sql = "SELECT 
                te.idencargadoproyecto idEncargadoProyecto,
                te.ccodigoproyecto codigoProyecto,
                te.idencargado idEncargado,
                te2.cnombrecompleto nombreCompleto
                FROM tb_encargadoproyectos te
                INNER JOIN tb_encargados te2 ON te2.idencargado = te.idencargado 
                WHERE te.idencargadoproyecto = ?";
        
        $statement = $pdo->prepare($sql);
        $statement -> execute(array($id));

        while($row = $statement->fetch(PDO::FETCH_ASSOC)){
            $docData[] = $row;
        }

        return $docData;
    }

    function obtenerEncargados($pdo) {
        $docData = [];

        /* $sql = "SELECT * FROM tb_tareos WHERE DATE(fregsys) = DATE_SUB(CURDATE(), INTERVAL 1 DAY)"; */
        $sql = "SELECT te.idencargado, te.cnumdoc, te.cnombres, te.capellidopat, te.capellidomat, te.cnombrecompleto 
        FROM tb_encargados te WHERE te.nflgactivo=1 order by te.cnombrecompleto";
        
        
        $statement = $pdo->prepare($sql);
        $statement -> execute();

        while($row = $statement->fetch(PDO::FETCH_ASSOC)){
            $docData[] = $row;
        }

        return $docData;
    }
    
    function obtenerUbicaciones($pdo) {
        $docData = [];

        /* $sql = "SELECT * FROM tb_tareos WHERE DATE(fregsys) = DATE_SUB(CURDATE(), INTERVAL 1 DAY)"; */
        $sql = "SELECT idubicacion, cubicacion, fregesys, nflgactivo FROM tb_ubicacion where  nflgactivo = 1 ORDER BY cubicacion;";
        
        $statement = $pdo->prepare($sql);
        $statement -> execute();

        while($row = $statement->fetch(PDO::FETCH_ASSOC)){
            $docData[] = $row;
        }

        return $docData;
    }

    function obtenerEspecialidades($pdo) {
        $docData = [];

        /* $sql = "SELECT * FROM tb_tareos WHERE DATE(fregsys) = DATE_SUB(CURDATE(), INTERVAL 1 DAY)"; */
        $sql = "SELECT idespecialidad, cespecialidad, fregsys, nflgactivo FROM tb_especialidad where  nflgactivo = 1 ORDER BY cespecialidad";
        
        $statement = $pdo->prepare($sql);
        $statement -> execute();

        while($row = $statement->fetch(PDO::FETCH_ASSOC)){
            $docData[] = $row;
        }

        return $docData;
    }

    function obtenerEncargadosProyecto($pdo){
        $docData = [];

        /* $sql = "SELECT * FROM tb_tareos WHERE DATE(fregsys) = DATE_SUB(CURDATE(), INTERVAL 1 DAY)"; */
        $sql = "SELECT 
                    tep.idencargadoproyecto, 
                    tep.ccodigoproyecto,
                    tep.idencargado,
                    te.cnombrecompleto AS nombreCompleto
                FROM 
                    tb_encargadoproyectos tep
                INNER JOIN 
                    tb_encargados te
                ON te.idencargado = tep.idencargado
                WHERE tep.nflgactivo = 1 ORDER BY cnombrecompleto";
        
        $statement = $pdo->prepare($sql);
        $statement -> execute();

        while($row = $statement->fetch(PDO::FETCH_ASSOC)){
            $docData[] = $row;
        }

        return $docData;
    }

    function listarPadronTerceros($pdo, $cc){
        $docData = [];

        /* $sql = "SELECT * FROM tb_tareos WHERE DATE(fregsys) = DATE_SUB(CURDATE(), INTERVAL 1 DAY)"; */
        $sql = "SELECT * FROM tb_datosterceros WHERE proyecto = ?";
        
        $statement = $pdo->prepare($sql);
        $statement -> execute(array($cc));

        while($row = $statement->fetch(PDO::FETCH_ASSOC)){
            $docData[] = $row;
        }

        return array("datos" => $docData);
    }
    // Recibir la consulta del usuario
/* $query = $_POST['query'] ?? '';

// Buscar datos en la base de datos
$stmt = $pdo->prepare("SELECT nombre FROM tu_tabla WHERE nombre LIKE :query LIMIT 10");
$stmt->execute(['query' => "%$query%"]);
$resultados = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Enviar resultados como JSON
echo json_encode(array_column($resultados, 'nombre'));
?> */