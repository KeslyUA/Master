<?php 
     date_default_timezone_set('America/Lima');

    require_once("connect.inc.php");

    if (isset($_POST['funcion'])){
        if ($_POST['funcion'] == "plantillaExcel")
            echo json_encode(plantillaExcel($_POST['padron']));
        else if($_POST['funcion'] == "plantillaTareoExcel")
            echo json_encode(plantillaTareoExcel());
    }

    function plantillaExcel($padron){
        require_once("../libs/PHPExcel/PHPExcel.php");
        
        $objPHPExcel = new PHPExcel();
                $objPHPExcel->getProperties()
                    ->setCreator("Sical")
                    ->setLastModifiedBy("Sical")
                    ->setTitle("Cargo Plan")
                    ->setSubject("Template excel")
                    ->setDescription("Cargo Plan Valorizado")
                    ->setKeywords("Template excel");

        $objPHPExcel->getActiveSheet()->setCellValue('A2','SEPCON S.A.C');
        $objPHPExcel->getActiveSheet()->setCellValue('A3','PLANTILLA DE TAREOS');

        $objPHPExcel->getActiveSheet()->setCellValue('A5','REGISTRO');
        $objPHPExcel->getActiveSheet()->setCellValue('C5','FECHA PROCESO:');
       
        $objPHPExcel->getActiveSheet()->setCellValue('A6','ITEM');
        $objPHPExcel->getActiveSheet()->setCellValue('B6','NOMBRE');
        $objPHPExcel->getActiveSheet()->setCellValue('C6','DNI/CE');
        $objPHPExcel->getActiveSheet()->setCellValue('D6','UBICACION');
        $objPHPExcel->getActiveSheet()->setCellValue('E6','ESTADO');
        $objPHPExcel->getActiveSheet()->setCellValue('F6','FECHA INGRESO');

        $fila = 7;

        $datos = json_decode($padron);
        $nreg = count($datos);

        for ($i=0; $i < $nreg; $i++) { 
            $objPHPExcel->getActiveSheet()->setCellValue('A'.$fila,$datos[$i]->item);
            $objPHPExcel->getActiveSheet()->setCellValue('B'.$fila,$datos[$i]->nombres);
            $objPHPExcel->getActiveSheet()->setCellValue('C'.$fila,$datos[$i]->documento);
            $objPHPExcel->getActiveSheet()->setCellValue('D'.$fila,$datos[$i]->ubicacion);
            $objPHPExcel->getActiveSheet()->setCellValue('E'.$fila,$datos[$i]->estado);
            //$objPHPExcel->getActiveSheet()->setCellValue('F'.$fila,$datos[$i]->ingreso);

            $fila++;
        }

        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel,'Excel2007');
        $objWriter->save('../documentos/plantillas/plantillaRegistros.xlsx');

        return array("archivo"=>"/documentos/plantillas/plantillaRegistros.xlxs");
    }

    function plantillaTareoExcel(){
        require_once("../libs/PHPExcel/PHPExcel.php");
        
        /* $objPHPExcel = new PHPExcel();
                $objPHPExcel->getProperties()
                    ->setCreator("Sical")
                    ->setLastModifiedBy("Sical")
                    ->setTitle("Cargo Plan")
                    ->setSubject("Template excel")
                    ->setDescription("Cargo Plan Valorizado")
                    ->setKeywords("Template excel");

        $objPHPExcel->getActiveSheet()->setCellValue('A2','SEPCON S.A.C');
        $objPHPExcel->getActiveSheet()->setCellValue('A3','TAREOS - CONTROL DE ASISTENCIA REPORTE POR PROYECTO ACTUAL '.date("Y-m-d")); */

        /* $objPHPExcel->getActiveSheet()->setCellValue('A5','REGISTRO');
        $objPHPExcel->getActiveSheet()->setCellValue('C5','FECHA PROCESO:');
       
        $objPHPExcel->getActiveSheet()->setCellValue('A6','ITEM');
        $objPHPExcel->getActiveSheet()->setCellValue('B6','NOMBRE');
        $objPHPExcel->getActiveSheet()->setCellValue('C6','DNI/CE');
        $objPHPExcel->getActiveSheet()->setCellValue('D6','UBICACION');
        $objPHPExcel->getActiveSheet()->setCellValue('E6','ESTADO');
        $objPHPExcel->getActiveSheet()->setCellValue('F6','FECHA INGRESO'); */

        /* $fila = 7; */

        /* $datos = json_decode($padron);
        $nreg = count($datos);

        for ($i=0; $i < $nreg; $i++) { 
            $objPHPExcel->getActiveSheet()->setCellValue('A'.$fila,$datos[$i]->item);
            $objPHPExcel->getActiveSheet()->setCellValue('B'.$fila,$datos[$i]->nombres);
            $objPHPExcel->getActiveSheet()->setCellValue('C'.$fila,$datos[$i]->documento);
            $objPHPExcel->getActiveSheet()->setCellValue('D'.$fila,$datos[$i]->ubicacion);
            $objPHPExcel->getActiveSheet()->setCellValue('E'.$fila,$datos[$i]->estado);
            //$objPHPExcel->getActiveSheet()->setCellValue('F'.$fila,$datos[$i]->ingreso);

            $fila++;
        }
 */
        /* $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel,'Excel2007');
        $objWriter->save('../documentos/plantillas/plantillaReporteTareo.xlsx');

        return array("archivo"=>"/documentos/plantillas/plantillaReporteTareo.xlsx"); */
        $archivoTemplate = '../documentos/plantillas/plantillaReporteTareo.xlsx';
        $objPHPExcel = PHPExcel_IOFactory::load($archivoTemplate);

        // Acceder a la hoja activa o seleccionar una específica
        $hoja = $objPHPExcel->getActiveSheet();

        // Sobrescribir datos en las celdas que necesites
        $hoja->setCellValue('A3', 'Nuevo Encabezado 1');
        /* $hoja->setCellValue('B1', 'Nuevo Encabezado 2');
        $hoja->setCellValue('C1', 'Nuevo Encabezado 3');
        $hoja->setCellValue('A2', 'Nuevo Dato 1');
        $hoja->setCellValue('B2', 'Nuevo Dato 2');
        $hoja->setCellValue('C2', 'Nuevo Dato 3'); */

        // Puedes modificar cualquier celda dentro de la plantilla
        // Ejemplo: Modificar un rango de celdas
        $hoja->setCellValue('A10', 'Información Actualizada');
        $hoja->setCellValue('B10', 'Otro Dato Actualizado');

        // Guardar el archivo sobrescribiendo el archivo original o creando uno nuevo
        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
        $nombreArchivoModificado = 'reporte_tareos_'.date("Y-m-d"); // Puedes sobrescribir o generar uno nuevo

        // Guardar el archivo en el servidor
        $objWriter->save('../documentos/plantillas/'.$nombreArchivoModificado.'.xlsx');

        // Si deseas ofrecerlo para descarga
        /* header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header('Content-Disposition: attachment;filename="'.$nombreArchivoModificado.'.xlsx'.'"');
        header('Cache-Control: max-age=0'); */
        /* $objWriter->save('php://output'); */
        /* exit; */
        return array("archivo"=>"/documentos/plantillas/".$nombreArchivoModificado.".xlsx");
    }
?>