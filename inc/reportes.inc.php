<?php 
    date_default_timezone_set('America/Lima');
    setlocale(LC_TIME, 'es_VE.UTF-8','esp');

    require_once("connect.inc.php");

    if (isset($_POST['funcion'])){
        if ($_POST['funcion'] == "reporteDiario")
            echo json_encode(reporteDiario($pdo));
        if ($_POST['funcion'] == "hojaSalida")
            echo json_encode(hojaSalida($pdo,$_POST));
    }

    function reporteDiario($pdo){
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
        $objPHPExcel->getActiveSheet()->setCellValue('A3','TAREOS LIMA - CONTROL DE ASISTENCIA REPORTE POR PROYECTO ACTUAL');

        $objPHPExcel->getActiveSheet()->setCellValue('A5','DATOS PERSONALES');
        $objPHPExcel->getActiveSheet()->setCellValue('A5','MAQUINARIAS Y EQUIPOS');
        $objPHPExcel->getActiveSheet()->setCellValue('Z5','CONTROL DE ASISTENCIA AGOSTO 2024');
        $objPHPExcel->getActiveSheet()->setCellValue('AV5','TOTALES');

        $objPHPExcel->getActiveSheet()->setCellValue('A6','ITEM');
        $objPHPExcel->getActiveSheet()->setCellValue('B6','N°');
        $objPHPExcel->getActiveSheet()->setCellValue('C6','CODIGO');
        $objPHPExcel->getActiveSheet()->setCellValue('D6','DNI');
        $objPHPExcel->getActiveSheet()->setCellValue('E6','APELLIDOS Y NOMBRES');
        $objPHPExcel->getActiveSheet()->setCellValue('F6','PROCEDENCIA');
        $objPHPExcel->getActiveSheet()->setCellValue('G6','F.INGRESO');
        $objPHPExcel->getActiveSheet()->setCellValue('H6','TIPO');
        $objPHPExcel->getActiveSheet()->setCellValue('I6','ULTIMO INGREOS A OBRA');
        $objPHPExcel->getActiveSheet()->setCellValue('J6','DIAS LABORADOS');
        $objPHPExcel->getActiveSheet()->setCellValue('K6','CARGO');
        $objPHPExcel->getActiveSheet()->setCellValue('L6','FASE ACTUAL');
        $objPHPExcel->getActiveSheet()->setCellValue('M6','PROYECTO ACTUAL');
        $objPHPExcel->getActiveSheet()->setCellValue('N6','UBICACION');
        $objPHPExcel->getActiveSheet()->setCellValue('O6','01');
        $objPHPExcel->getActiveSheet()->setCellValue('P6','02');
        $objPHPExcel->getActiveSheet()->setCellValue('Q6','03');
        $objPHPExcel->getActiveSheet()->setCellValue('R6','04');
        $objPHPExcel->getActiveSheet()->setCellValue('S6','05');
        $objPHPExcel->getActiveSheet()->setCellValue('T6','06');
        $objPHPExcel->getActiveSheet()->setCellValue('U6','07');
        $objPHPExcel->getActiveSheet()->setCellValue('V6','08');
        $objPHPExcel->getActiveSheet()->setCellValue('W6','09');
        $objPHPExcel->getActiveSheet()->setCellValue('X6','10');
        $objPHPExcel->getActiveSheet()->setCellValue('Y6','11');
        $objPHPExcel->getActiveSheet()->setCellValue('Z6','12');
        $objPHPExcel->getActiveSheet()->setCellValue('AA6','13');
        $objPHPExcel->getActiveSheet()->setCellValue('AB6','14');
        $objPHPExcel->getActiveSheet()->setCellValue('AC6','15');
        $objPHPExcel->getActiveSheet()->setCellValue('AD6','16');
        $objPHPExcel->getActiveSheet()->setCellValue('AE6','17');
        $objPHPExcel->getActiveSheet()->setCellValue('AF6','18');
        $objPHPExcel->getActiveSheet()->setCellValue('AG6','19');
        $objPHPExcel->getActiveSheet()->setCellValue('AH6','20');
        $objPHPExcel->getActiveSheet()->setCellValue('AI6','21');
        $objPHPExcel->getActiveSheet()->setCellValue('AJ6','22');
        $objPHPExcel->getActiveSheet()->setCellValue('AK6','23');
        $objPHPExcel->getActiveSheet()->setCellValue('AL6','24');
        $objPHPExcel->getActiveSheet()->setCellValue('AM6','25');
        $objPHPExcel->getActiveSheet()->setCellValue('AN6','26');
        $objPHPExcel->getActiveSheet()->setCellValue('AO6','27');
        $objPHPExcel->getActiveSheet()->setCellValue('AP6','28');
        $objPHPExcel->getActiveSheet()->setCellValue('AQ6','29');
        $objPHPExcel->getActiveSheet()->setCellValue('AR6','30');
        $objPHPExcel->getActiveSheet()->setCellValue('AS6','31');
        $objPHPExcel->getActiveSheet()->setCellValue('AT6','DA');
        $objPHPExcel->getActiveSheet()->setCellValue('AU6','DD');
        $objPHPExcel->getActiveSheet()->setCellValue('AV6','DF');
        $objPHPExcel->getActiveSheet()->setCellValue('AW6','DM');
        $objPHPExcel->getActiveSheet()->setCellValue('AX6','DV');
        $objPHPExcel->getActiveSheet()->setCellValue('AY6','DP');
        $objPHPExcel->getActiveSheet()->setCellValue('AZ6','DT');
        $objPHPExcel->getActiveSheet()->setCellValue('BA6','REGIMEN');
        $objPHPExcel->getActiveSheet()->setCellValue('BB6','MANO DE OBRA');

        $sql = "SELECT
                    tb_tareo.ndoc,
                    UPPER(tb_tareo.d1) AS d1,
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
                    tb_tareo.fregsys,
                    tb_datostareo.ncondicion,
                    tb_datostareo.cespecialidad,
                    tb_datostareo.cproyecto,
                    tb_datostareo.cubicacion,
                    tb_datostareo.cregimen,
                    tb_datostareo.fingreso,
                    tb_datostareo.cobservaciones 
                FROM
                    tb_tareo
                    LEFT JOIN tb_datostareo ON tb_tareo.ndoc = tb_datostareo.nddoc
                WHERE tb_datostareo.fingreso IS NOT NULL
                ORDER BY
                    tb_tareo.fregsys ASC";
        
        $statement = $pdo->query($sql);
        $statement -> execute();

        $fila = 7;
        $item = 1;

        while ($row = $statement->fetch() ){
            $objPHPExcel->getActiveSheet()->setCellValue('A'.$fila,$item++);
            $objPHPExcel->getActiveSheet()->setCellValue('D'.$fila,$row['ndoc']);
            $objPHPExcel->getActiveSheet()->setCellValue('G'.$fila,$row['fingreso']);
            $objPHPExcel->getActiveSheet()->setCellValue('M'.$fila,$row['cproyecto']);
            $objPHPExcel->getActiveSheet()->setCellValue('N'.$fila,$row['cubicacion']);
            $objPHPExcel->getActiveSheet()->setCellValue('O'.$fila,$row['d1']);
            $objPHPExcel->getActiveSheet()->setCellValue('P'.$fila,$row['d2']);
            $objPHPExcel->getActiveSheet()->setCellValue('Q'.$fila,$row['d3']);
            $objPHPExcel->getActiveSheet()->setCellValue('R'.$fila,$row['d4']);
            $objPHPExcel->getActiveSheet()->setCellValue('S'.$fila,$row['d5']);
            $objPHPExcel->getActiveSheet()->setCellValue('T'.$fila,$row['d6']);
            $objPHPExcel->getActiveSheet()->setCellValue('Y'.$fila,$row['d7']);
            $objPHPExcel->getActiveSheet()->setCellValue('V'.$fila,$row['d8']);
            $objPHPExcel->getActiveSheet()->setCellValue('W'.$fila,$row['d9']);
            $objPHPExcel->getActiveSheet()->setCellValue('X'.$fila,$row['d10']);
            $objPHPExcel->getActiveSheet()->setCellValue('Y'.$fila,$row['d11']);
            $objPHPExcel->getActiveSheet()->setCellValue('Z'.$fila,$row['d12']);
            $objPHPExcel->getActiveSheet()->setCellValue('AA'.$fila,$row['d13']);
            $objPHPExcel->getActiveSheet()->setCellValue('AB'.$fila,$row['d14']);
            $objPHPExcel->getActiveSheet()->setCellValue('AC'.$fila,$row['d15']);
            $objPHPExcel->getActiveSheet()->setCellValue('AD'.$fila,$row['d16']);
            $objPHPExcel->getActiveSheet()->setCellValue('AE'.$fila,$row['d17']);
            $objPHPExcel->getActiveSheet()->setCellValue('AF'.$fila,$row['d18']);
            $objPHPExcel->getActiveSheet()->setCellValue('AG'.$fila,$row['d19']);
            $objPHPExcel->getActiveSheet()->setCellValue('AH'.$fila,$row['d20']);
            $objPHPExcel->getActiveSheet()->setCellValue('AI'.$fila,$row['d21']);
            $objPHPExcel->getActiveSheet()->setCellValue('AJ'.$fila,$row['d22']);
            $objPHPExcel->getActiveSheet()->setCellValue('AK'.$fila,$row['d23']);
            $objPHPExcel->getActiveSheet()->setCellValue('AL'.$fila,$row['d24']);
            $objPHPExcel->getActiveSheet()->setCellValue('AM'.$fila,$row['d25']);
            $objPHPExcel->getActiveSheet()->setCellValue('AN'.$fila,$row['d26']);
            $objPHPExcel->getActiveSheet()->setCellValue('AO'.$fila,$row['d27']);
            $objPHPExcel->getActiveSheet()->setCellValue('AP'.$fila,$row['d28']);
            $objPHPExcel->getActiveSheet()->setCellValue('AQ'.$fila,$row['d29']);
            $objPHPExcel->getActiveSheet()->setCellValue('AR'.$fila,$row['d30']);
            $objPHPExcel->getActiveSheet()->setCellValue('AS'.$fila,$row['d31']);
            $fila++;
        }


        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel,'Excel2007');
        $objWriter->save('../documentos/reportes/reportediario.xlsx');

        return array("archivo"=>"/documentos/reportes/reportediario.xlxs");
    }

    function hojaSalida($pdo,$datos){
        require_once('../libs/Fpdf/fpdf.php');

        $archivo = $datos['documento']."-".date('d-m-Y').'.pdf';
        $ruta = '../documentos/hojasalida/';
        
        $nombre = $datos['paterno']." ".$datos['materno']." ".$datos['nombres'];
        $fecha = strftime('%A %e de %B de %Y');

        $pdf = new FPDF();
        $pdf->AddPage();
        $pdf->SetFont('Arial','B',8);

        
        $pdf->Image('../assets/logosp.png',12,12,25);
        $pdf->SetXY(160,10);
        $pdf->Cell(13,5,utf8_decode("Código :"),0,0,"C");
        $pdf->Cell(13,5,$datos['codigo'],0,1,"C");

        $pdf->SetXY(10,30);
        $pdf->Cell(13,5,utf8_decode("SEPCON PERÚ"),0,1,"L");
        $pdf->Cell(13,5,utf8_decode($datos['proyecto']),0,1,"L");
        $pdf->Ln(2);

        $pdf->Cell(40,5,utf8_decode("LUGAR Y FECHA:"),0,0,"L");
        $pdf->Cell(80,5,utf8_decode($datos['jsubicacion']),0,0,"L");
        $pdf->Cell(40,5,$fecha,0,1,"L");
        $pdf->Ln(2);

        $pdf->Cell(40,5,utf8_decode("APELLIDOS Y NOMBRES:"),0,0,"L");
        $pdf->Cell(80,5,utf8_decode($nombre),0,0,"L");
        $pdf->Cell(40,5,utf8_decode("DNI:"),0,0,"L");
        $pdf->Cell(80,5,$datos['documento'],0,1,"L");
        $pdf->Ln(2);

        $pdf->Cell(40,5,utf8_decode("CARGO :"),0,0,"L");
        $pdf->Cell(80,5,utf8_decode($datos['cargo']),0,0,"L");
        $pdf->Cell(40,5,utf8_decode("FECHA DE INGRESO:"),0,0,"L");
        $pdf->Cell(80,5,utf8_decode($datos['ingreso_obra']),0,1,"L");
        $pdf->Ln(1);

        $pdf->Cell(40,5,utf8_decode("FRENTE DE TRABAJO :"),0,0,"L");
        $pdf->Cell(80,5,utf8_decode($datos['frentetrabajo']),0,0,"L");
        $pdf->Cell(40,5,utf8_decode("FECHA DE CESE :"),0,0,"L");
        $pdf->Cell(80,5,utf8_decode($datos['fecha_cese']),0,1,"L");
        $pdf->Ln(1);

        $pdf->Cell(40,5,utf8_decode("SALIDA A PARTIR DEL :"),0,0,"L");
        $pdf->Cell(80,5,utf8_decode($datos['salida_obra']),0,0,"L");
        $pdf->Cell(40,5,utf8_decode("FECHA DE RETORNO :"),0,0,"L");
        $pdf->Cell(80,5,utf8_decode($datos['retorno_programado']),0,1,"L");
        $pdf->Ln(1);

        $pdf->Cell(40,5,utf8_decode("MOTIVO"),0,1,"L");
        $pdf->Ln(2);

        $pdf->Cell(40,5,utf8_decode("INGRESO :"),0,0,"L");
        $pdf->Cell(20,5,utf8_decode(""),1,0,"L");
        $pdf->SetX(100);
        $pdf->Cell(40,5,utf8_decode("CESE :"),0,0,"L");
        $pdf->Cell(20,5,utf8_decode(""),1,1,"L");
        $pdf->Ln(2);

        $pdf->Cell(40,5,utf8_decode("PERMISO :"),0,0,"L");
        $pdf->Cell(20,5,utf8_decode(""),1,0,"L");
        $pdf->SetX(100);
        $pdf->Cell(40,5,utf8_decode("AMONESTACION :"),0,0,"L");
        $pdf->Cell(20,5,utf8_decode(""),1,1,"L");
        $pdf->Ln(2);

        $pdf->Cell(40,5,utf8_decode("DESCANSO MEDICO :"),0,0,"L");
        $pdf->Cell(20,5,utf8_decode(""),1,0,"L");
        $pdf->SetX(100);
        $pdf->Cell(40,5,utf8_decode("VACACIONES :"),0,0,"L");
        $pdf->Cell(20,5,utf8_decode(""),1,1,"L");
        $pdf->Ln(2);

        $pdf->Cell(40,5,utf8_decode("BAJADA PROGRAMADA :"),0,0,"L");
        $pdf->Cell(20,5,utf8_decode(""),1,0,"L");
        $pdf->SetX(100);
        $pdf->Cell(40,5,utf8_decode("OTROS :"),0,0,"L");
        $pdf->Cell(20,5,utf8_decode(""),1,1,"L");
        $pdf->Ln(2);

        $pdf->Cell(20,5,utf8_decode("MOTIVO DE CESE :"),0,1,"L");
        $pdf->SetX(35);
        $pdf->Multicell(170,5,$datos['motivocs']);
        $pdf->Ln(2);

        $pdf->Cell(40,5,utf8_decode("OBSERVACIONES :"),0,1,"L");
        $pdf->SetX(40);
        $pdf->Multicell(150,5,$datos["observaciones"]);
        $pdf->Ln(2);

        $pdf->Cell(30,5,utf8_decode("NOTA :"),0,0,"L");
        $pdf->Cell(33,5,utf8_decode("SE LE RECUERDA :"),0,1,"L");

        $pdf->SetX(40);
        $pdf->Multicell(150,5,"AL REGRESAR DE SUS DESCANSO, REPORTARSE OBLIGATORIAMENTE A LA OFICINA DE RECURSOS HUMANOS DE LA SEDE, ASIMISMO, PRESENTARSE A SU DE TRABAJO EL MISMO DÍA DE SU LLEGADA");
        $pdf->Ln(1);
        $pdf->SetX(40);
        $pdf->Multicell(150,5,"DE NO CUMPLIR CON LO SOLICITADO SE LE EMPEZARA A TAREAR DESDE EL DIA Y HORA QUE SE REPORTO.");

        $pdf->SetY(250);

        $pdf->SetX(20);
        $pdf->Cell(80,5,"","B",0,"C");
        $pdf->SetX(120);
        $pdf->Cell(80,5,"","B",1,"C");

        $pdf->SetX(20);
        $pdf->Cell(80,5,"RECURSOS HUMANOS",0,0,"C");
        $pdf->SetX(120);
        $pdf->Cell(80,5,utf8_decode($nombre),0,1,"C");

        $pdf->SetX(20);
        $pdf->Cell(80,5,utf8_decode($datos["proyecto"]),0,0,"C");
        $pdf->SetX(120);
        $pdf->Cell(80,5,"D.N.I: ".$datos['documento'],0,1,"C");
        $pdf->SetX(120);
        $pdf->Cell(80,5,"TELEFONO: ".$datos['telefono'],0,1,"C");

        $archivo = $ruta.$archivo;

        $pdf->Output($archivo,'F');

        return array($archivo);

    }
?>