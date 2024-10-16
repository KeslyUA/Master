<?php 
     date_default_timezone_set('America/Lima');

    require_once("connect.inc.php");

    if (isset($_POST['funcion'])){
        if ($_POST['funcion'] == "plantillaExcel")
            echo json_encode(plantillaExcel($_POST['padron']));
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
?>