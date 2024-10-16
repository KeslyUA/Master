<?php
    require_once('connect.inc.php');

    /*var_dump ($_FILES);
    return false;*/

    if ( isset( $_POST )) {
         if ($_POST['funcion'] === "importarArchivo") {
             echo json_encode(importarArchivo($pdo)); 
         }
    }

     function importarArchivo($pdo){
        try {
            require_once("../libs/PHPExcel/PHPExcel.php");

            $directorio_temporal  = '../documentos/temp/temp.xlsx';
            $archivo_temporal = $_FILES['archivo']['tmp_name'];
            $nombre_archivo = $_FILES['archivo']['name'];

            //if ( move_uploaded_file($directorio_temporal,$archivo_temporal) ) {
                $rows = 7;
                $fila = 7;
                $datos = [];
                $item = []; 

                $document = PHPExcel_IOFactory::load($archivo_temporal);
                $activeSheetData = $document->getActiveSheet()->toArray(null, true, true, true);

                $nregs = count($activeSheetData);

                $total_proceso  = $nregs - 6;

                for ($i=0; $i < $total_proceso; $i++) {
                    
                    $item['documento']  = $activeSheetData[$fila]["C"];
                    $item['ubicacion']  = $activeSheetData[$fila]["D"];
                    $item['estado']     = $activeSheetData[$fila]["E"];
                    $item['ingreso']    = $activeSheetData[$fila]["F"];

                    $fila++;

                    array_push($datos, $item);
                }

                return array("datos"=>$datos);
            //}

        } catch (PDOException $th) {
            echo "Error: " . $th->getMessage;
            return false;
        }
     }
?>