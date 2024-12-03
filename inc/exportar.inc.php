<?php 
     date_default_timezone_set('America/Lima');

    require_once("connect.inc.php");
    ini_set('memory_limit', '1024M'); // Incrementa a 1 GB o el valor que necesites


    if (isset($_POST['funcion'])){
        if ($_POST['funcion'] == "plantillaExcel")
            echo json_encode(plantillaExcel($_POST['padron']));
        else if($_POST['funcion'] == "plantillaTareoExcel")
            echo json_encode(newPlantillaTareoExcel($_POST['padron'], $_POST['fechaProceso']));
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

    function plantillaTareoExcel($padron,$fechaProceso){
        require_once("../libs/PHPExcel/PHPExcel.php");
        $archivoTemplate = '../documentos/plantillas/plantillaReporteTareo.xlsx';
        $objPHPExcel = PHPExcel_IOFactory::load($archivoTemplate);

        // Acceder a la hoja activa o seleccionar una específica
        $hoja = $objPHPExcel->getActiveSheet();

        // Sobrescribir datos en las celdas que necesites
        
        /* $hoja->setCellValue('B1', 'Nuevo Encabezado 2');
        $hoja->setCellValue('C1', 'Nuevo Encabezado 3');
        $hoja->setCellValue('A2', 'Nuevo Dato 1');
        $hoja->setCellValue('B2', 'Nuevo Dato 2');
        $hoja->setCellValue('C2', 'Nuevo Dato 3'); */

        $fila = 7;

        $datos = json_decode($padron);
        $nreg = count($datos);
        $hoja->setCellValue('A3', 'TAREOS - CONTROL DE ASISTENCIA REPORTE '.$datos[0]->proyecto.' '.$fechaProceso);
        for ($i=0; $i < $nreg; $i++) { 
            $columna = 6;
            $objPHPExcel->getActiveSheet()->setCellValue('A'.$fila,$datos[$i]->item);
            $objPHPExcel->getActiveSheet()->setCellValue('B'.$fila,$datos[$i]->nombres);
            $objPHPExcel->getActiveSheet()->setCellValue('C'.$fila,$datos[$i]->documento);
            $objPHPExcel->getActiveSheet()->setCellValue('D'.$fila,$datos[$i]->proyecto);
            $objPHPExcel->getActiveSheet()->setCellValue('E'.$fila,$datos[$i]->ubicacion);
            $objPHPExcel->getActiveSheet()->setCellValue('F'.$fila,$datos[$i]->cargo);
            foreach($datos[$i]->tareos as $tareo) {
                $objPHPExcel->getActiveSheet()->setCellValue(PHPExcel_Cell::stringFromColumnIndex($columna).$fila, $tareo);
                $columna++; // Incrementamos la columna para cada tareo
            }
            $objPHPExcel->getActiveSheet()->setCellValue('AL' . $fila, isset($datos[$i]->dias->A) ? $datos[$i]->dias->A : 0);
            $objPHPExcel->getActiveSheet()->setCellValue('AM' . $fila, isset($datos[$i]->dias->D) ? $datos[$i]->dias->D : 0);
            $objPHPExcel->getActiveSheet()->setCellValue('AN' . $fila, isset($datos[$i]->dias->F) ? $datos[$i]->dias->F : 0);
            $objPHPExcel->getActiveSheet()->setCellValue('AO' . $fila, isset($datos[$i]->dias->M) ? $datos[$i]->dias->M : 0);
            $objPHPExcel->getActiveSheet()->setCellValue('AP' . $fila, isset($datos[$i]->dias->V) ? $datos[$i]->dias->V : 0);
            $objPHPExcel->getActiveSheet()->setCellValue('AQ' . $fila, isset($datos[$i]->dias->P) ? $datos[$i]->dias->P : 0);
            $objPHPExcel->getActiveSheet()->setCellValue('AR' . $fila, isset($datos[$i]->dias->total) ? $datos[$i]->dias->total : 0);
            $fila++;
        }

        // Guardar el archivo sobrescribiendo el archivo original o creando uno nuevo
        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
        $nombreArchivoModificado = 'reporte_tareos_'.date("Y-m-d"); // Puedes sobrescribir o generar uno nuevo

        // Guardar el archivo
        $objWriter->save('../documentos/reportes/'.$nombreArchivoModificado.'.xlsx');

        // Si deseas ofrecerlo para descarga
        /* header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header('Content-Disposition: attachment;filename="'.$nombreArchivoModificado.'.xlsx'.'"');
        header('Cache-Control: max-age=0'); */
        /* $objWriter->save('php://output'); */
        /* exit; */
        return array("archivo"=>"/documentos/reportes/".$nombreArchivoModificado.".xlsx");
    }

    function newPlantillaTareoExcel($padron, $fechaProceso) {
        require_once("../libs/PHPExcel/PHPExcel.php");
        $archivoTemplate = '../documentos/plantillas/newPlantillaReporteTareo.xlsx';
        $objPHPExcel = PHPExcel_IOFactory::load($archivoTemplate);
    
        // Acceder a la hoja activa o seleccionar una específica
        $hoja = $objPHPExcel->getActiveSheet();
    
        $fila = 10;
    
        $datos = json_decode($padron);
        $nreg = count($datos);
        $hoja->setCellValue('A3', 'TAREOS - CONTROL DE ASISTENCIA REPORTE ' . $datos[0]->proyecto . ' ' . $fechaProceso);
    
        for ($i = 0; $i < $nreg; $i++) {
            // Insertar una nueva fila en la posición actual
            $hoja->insertNewRowBefore($fila, 1);
            $hoja->getStyle("A$fila:E$fila")->getFill()->setFillType(PHPExcel_Style_Fill::FILL_NONE);

    
            
            $hoja->setCellValue('A' . $fila, $datos[$i]->item);
            $hoja->setCellValue('E' . $fila, $datos[$i]->nombres);
            $hoja->setCellValue('D' . $fila, $datos[$i]->documento);
            $hoja->setCellValue('M' . $fila, $datos[$i]->proyecto);
            $hoja->setCellValue('N' . $fila, $datos[$i]->ubicacion);
            $hoja->setCellValue('K' . $fila, $datos[$i]->cargo);
    
            /* foreach ($datos[$i]->tareos as $tareo) {
                $hoja->setCellValue(PHPExcel_Cell::stringFromColumnIndex($columna) . $fila, $tareo);
                $columna++;
            } */
           foreach($datos[$i]->estadosDia as $dia=>$estado){
            $columna = 13;
            $columna = $columna + $dia;
            $hoja->setCellValue(PHPExcel_Cell::stringFromColumnIndex($columna) . $fila, $estado);
           }
    
            $hoja->setCellValue('AT' . $fila, isset($datos[$i]->dias->A) ? $datos[$i]->dias->A : 0);
            $hoja->setCellValue('AU' . $fila, isset($datos[$i]->dias->D) ? $datos[$i]->dias->D : 0);
            $hoja->setCellValue('AV' . $fila, isset($datos[$i]->dias->F) ? $datos[$i]->dias->F : 0);
            $hoja->setCellValue('AW' . $fila, isset($datos[$i]->dias->M) ? $datos[$i]->dias->M : 0);
            $hoja->setCellValue('AX' . $fila, isset($datos[$i]->dias->V) ? $datos[$i]->dias->V : 0);
            $hoja->setCellValue('AY' . $fila, isset($datos[$i]->dias->P) ? $datos[$i]->dias->P : 0);
            $hoja->setCellValue('AZ' . $fila, isset($datos[$i]->dias->total) ? $datos[$i]->dias->total : 0);

            $hoja->setCellValue('BA' . $fila, isset($datos[$i]->regimen) ? $datos[$i]->regimen : '');
            $hoja->setCellValue('BB' . $fila, isset($datos[$i]->manoObra) ? $datos[$i]->manoObra : '');
    
            $fila++;
        }
    
        // Guardar el archivo sobrescribiendo el archivo original o creando uno nuevo
        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
        $nombreArchivoModificado = 'reporte_tareos_' .$fechaProceso;
    
        // Guardar el archivo
        $objWriter->save('../documentos/reportes/' . $nombreArchivoModificado . '.xlsx');
    
        return array("archivo" => "/documentos/reportes/" . $nombreArchivoModificado . ".xlsx");
    }
    
?>