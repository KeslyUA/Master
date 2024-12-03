<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <form action="" id="data_matriz" name="data_matriz"></form>
    <section>
        <div class="separator">
            <div class="titulo">
                <span>DATOS PERSONALES DEL TRABAJADOR (TERCEROS)</span>
                <div class="btnOpciones">   
                    <a href="#" id="grabarDatosTerceros"><i class="fas fa-save botones"></i><p>Grabar</p></a>
                    <a href="#" id="hojaSalida"><i class="far fa-file-pdf botones"></i><p>Hoja Salida</p></a>
                    <a href="#" id="reporteDiario"><i class="fas fa-file-excel botones"></i><p>Reporte Diario</p></a>
<!--                     <a href="#" class="botones"><i class="fas fa-window-close botones"></i><p>Botones</p></a>
 -->                </div>
            </div>
            <div class="cuerpo">
                <input type="hidden" name="existeTercero" id="existeTercero" form="data_matriz">
                <input type="hidden" name="existeTerceroTareoData" id="existeTerceroTareoData" form="data_matriz">
                <div class="dos_columnas">
                    <label for="documento_tercero">D.Identidad :</label>
                    <input type="text" name="documento_tercero" id="documento_tercero" form="data_matriz">
                </div>
                <div class="dos_columnas">
                    <label for="paterno">Ap.Paterno:</label>
                    <input type="text" name="paterno" id="paterno" form="data_matriz">
                </div>
               <div class="dos_columnas">
                    <label for="materno">Ap.Materno :</label>
                    <input type="text" name="materno" id="materno"  form="data_matriz">
                </div>
                <div  class="tres_columnas">
                    <label for="nombres">Nombres :</label>
                    <input type="text" name="nombres" id="nombres"  form="data_matriz">
                </div>
                 <div class="dos_columnas">
                    <label for="nacimiento">F.Nacimiento :</label>
                    <input type="date" name="nacimiento" id="nacimiento"  form="data_matriz">
                </div>
                <div class="dos_columnas">
                    <label for="codigo">Código :</label>
                    <input type="text" name="codigo" id="codigo"  form="data_matriz">
                </div>
                <div class="dos_columnas">
                    <label for="grupo">Grupo Sanguineo:</label>
                    <input type="text" name="grupo" id="grupo"  form="data_matriz">
                </div>
                <div class="dos_columnas">
                    <label for="planilla">Planilla:</label>
                    <input type="text" name="planilla" id="planilla"  form="data_matriz">
                </div>
                <div class="tres_columnas">
                    <label for="cargo">Cargo :</label>
                    <input type="text" name="cargo" id="cargo"  form="data_matriz">
                </div>
                <div class="tres_columnas">
                    <label for="nacionalidad">Nacionalidad :</label>
                    <input type="text" name="nacionalidad" id="nacionalidad"  form="data_matriz">
                </div>
                <!-- <div class="dos_columnas">
                    <label for="ubigeo">Ubigeo :</label>
                    <input type="text" name="ubigeo" id="ubigeo" form="data_matriz">
                </div> -->
                <!-- <div class="dos_columnas">
                    <label for="procedencia">Procedencia :</label>
                    <input type="text" name="procedencia" id="procedencia" >
                </div> -->
                <div class="dos_columnas">
                    <label for="estado">Estado :</label>
                    <input type="text" name="estado" id="estado"  form="data_matriz">
                </div>
                <div class="dos_columnas">
                    <label for="telefono">Teléfono :</label>
                    <input type="text" name="telefono" id="telefono"  form="data_matriz">
                </div>
                <div class="tres_columnas">
                    <label for="correo">Correo Electrónico :</label>
                    <input type="text" name="correo" id="correo"  form="data_matriz">
                </div>
                <div class="tres_columnas">
                    <label for="direccion">Direccion :</label>
                    <input type="text" name="direccion" id="direccion" form="data_matriz">
                </div>
                <div class="cuatro_columnas">
                    <label for="dpto">Dpto :</label>
                    <input type="text" name="dpto" id="dpto" form="data_matriz">
                </div>
                <div class="cuatro_columnas">
                    <label for="prov">Prov :</label>
                    <input type="text" name="prov" id="prov" form="data_matriz">
                </div>
                <div class="cuatro_columnas">
                    <label for="dist">Dist :</label>
                    <input type="text" name="dist" id="dist" form="data_matriz">
                </div>
                <div class="dos_columnas">
                    <label for="fecha_ingreso">Fecha Ingreso :</label>
                    <input type="date" name="fecha_ingreso" id="fecha_ingreso" form="data_matriz">
                </div>
                <div class="dos_columnas">
                    <label for="inicio_contrato">Inicio contrato :</label>
                    <input type="date" name="inicio_contrato" id="inicio_contrato" form="data_matriz">
                </div>
                <div class="dos_columnas">
                    <label for="fin_contrato">Fin Contrato :</label>
                    <input type="date" name="fin_contrato" id="fin_contrato" form="data_matriz">
                </div>
                <div class="cuatro_columnas">
                    <label for="proyecto">Proyecto :</label>
                    <!-- <input type="text" name="proyecto" id="proyecto" form="data_matriz"> -->
                    <select name="proyecto" id="proyecto" form="data_matriz" class="select">
                        <option value="-1">Seleccionar</option>
                    </select>
                </div>
                <div class="dos_columnas">
                    <label for="sucursal">Sucursal :</label>
                    <input type="text" name="sucursal" id="sucursal" form="data_matriz">
                </div>
                <div class="dos_columnas">
                    <label for="empresa">Empresa :</label>
                    <input type="text" name="empresa" id="empresa" form="data_matriz">
                </div>
            </div>
        </div>
        <div class="separator">
            <div class="titulo">
                <span>DATOS DEL EMPLEADOR</span>
            </div>
            <div class="cuerpo">
                <div class="tres_columnas">
                    <label for="encargado">Encargado :</label>
                    <!-- <input type="text" name="encargado" id="encargado" form="data_matriz"> -->
                    <select name="encargado" id="encargado" form="data_matriz">
                        <option value="-1">Seleccionar</option>
                    </select>
                </div>
                <div class="dos_columnas">
                    <label for="condicion">Condicion :</label>
                    <select name="condicion" id="condicion" form="data_matriz">
                        <option value="-1">Seleccionar</option>
                        <option value="2">Obrero</option>
                        <option value="3">Staff</option>
                        <option value="4">Tercero</option>
                    </select>
                </div>
                <div class="dos_columnas">
                    <label for="personal">Personal :</label>
                    <select name="personal" id="personal" form="data_matriz">
                        <option value="-1">Seleccionar</option>
                        <option value="9">Foreaneo</option>
                        <option value="10">Local</option>
                        <option value="11">Extranjero</option>
                    </select>
                </div>
                <div class="tres_columnas">
                    <label for="especialidad">Especialidad :</label>
                    <input type="text" name="especialidad" id="especialidad" form="data_matriz">
                </div>
                <div class="dos_columnas">
                    <label for="manoobra">Mano de Obra :</label>
                    <select name="manoobra" id="manoobra" form="data_matriz">
                        <option value="-1">Seleccionar</option>
                        <option value="6">Directa</option>
                        <option value="7">indirecta</option>
                    </select>
                </div>
                <div class="seis_columnas">
                    <label for="proyecto_actual">Proyecto Actual :</label>
                    <!-- <input type="text" name="proyecto_actual" id="proyecto_actual" form="data_matriz"> -->
                    <select name="proyecto_actual" id="proyecto_actual" form="data_matriz" class="select">
                        <option value="-1">Seleccionar</option>
                    </select>
                </div>
                <div class="seis_columnas">
                    <label for="fase_actual">Fase Actual :</label>
                    <!-- <input type="text" name="fase_actual" id="fase_actual" form="data_matriz"> -->
                    <select name="fase_actual" id="fase_actual" form="data_matriz" class="select">
                        <option value="-1">Seleccionar</option>
                    </select>
                </div>
                <div class="cuatro_columnas">
                    <label for="ubicacion">Ubicacion :</label>
                    <input type="text" name="ubicacion" id="ubicacion" form="data_matriz">
                </div>
                <div class="dos_columnas">
                    <label for="regimen_trabajo">Regimen Trabajo:</label>
                    <input type="text" name="regimen_trabajo" id="regimen_trabajo" form="data_matriz">
                </div>
                <div class="dos_columnas">
                    <label for="ingreso_obra">Ingreso Obra :</label>
                    <input type="date" name="ingreso_obra" id="ingreso_obra" value="<?php echo date("Y-m-d"); ?>" min="<?php echo date("Y-m-d"); ?>" form="data_matriz">
                </div>
                <div class="dos_columnas">
                    <label for="salida_obra">Salida Obra :</label>
                    <input type="date" name="salida_obra" id="salida_obra" form="data_matriz">
                </div>
                <div class="dos_columnas">
                    <label for="retorno_programado">Retorno Programado :</label>
                    <input type="date" name="retorno_programado" id="retorno_programado" form="data_matriz">
                </div>
                <div class="dos_columnas">
                    <label for="dias_goce">Dias Goce :</label>
                    <input type="number" name="dias_goce" id="dias_goce" form="data_matriz">
                </div>
                <div class="dos_columnas">
                    <label for="dias_libre">Días Libre :</label>
                    <input type="number" name="dias_libre" id="dias_libre" form="data_matriz">
                </div>
                <div class="dos_columnas">
                    <label for="dias_campo">Dias Campo :</label>
                    <input type="number" name="dias_campo" id="dias_campo" form="data_matriz">
                </div>
                <div class="dos_columnas">
                    <label for="dias_reales">Dias Reales Tomados :</label>
                    <input type="number" name="dias_reales" id="dias_reales" form="data_matriz">
                </div>
                <div class="dos_columnas">
                    <label for="fecha_cese">Fecha Cese :</label>
                    <input type="date" name="fecha_cese" id="fecha_cese" form="data_matriz">
                </div>
                <div class="dos_columnas">
                <label for="motivo_cese">Motivo Cese :</label>
                    <select name="motivo_cese" id="motivo_cese" form="data_matriz">
                        <option value="-1">Seleccionar</option>
                        <option value="29">Renuncia Voluntario</option>
                        <option value="30">Termino de Obra</option>
                        <option value="31">Termino de Contrato</option>
                        <option value="32">Termino de Fase</option>
                        <option value="33">Abandono de  Trabajo</option>
                    </select>
                </div>

                <div class="ocho_columnas">
                    <label for="observaciones">Observaciones :</label>
                    <textarea name="observaciones" id="observaciones" form="data_matriz"></textarea>
                </div>
                <div class="cuatro_columnas">
                <label for="motivo_descanso">Motivo de descanso :</label>
                    <select name="motivo_descanso" id="motivo_descanso" form="data_matriz">
                        <option value="-1">Seleccionar</option>
                        <option value="21">Ingreso</option>
                        <option value="22">Permiso</option>
                        <option value="23">Descanso Medico</option>
                        <option value="24">Bajada Programada</option>
                        <option value="25">Cese</option>
                        <option value="26">Amonestacion</option>
                        <option value="27">Vacaciones</option>
                        <option value="28">Otros</option>
                    </select>
                </div>
                <div class="dos_columnas">
                    <label for="regimen">Regimen :</label>
                    <select name="regimen" id="regimen" form="data_matriz">
                        <option value="-1">Seleccionar</option>
                        <option value="12">Civil</option>
                        <option value="13">Comun</option>
                    </select>
                </div>
                <div class="dos_columnas">
                    <label for="especificacion_contrato">Especificacion Contrato :</label>
                    <select name="especificacion_contrato" id="especificacion_contrato" form="data_matriz">
                        <option value="-1">Seleccionar</option>
                        <option value="14">Facilidades</option>
                        <option value="15">Soporte</option>
                        <option value="16">Civil</option>
                        <option value="17">Mecanica</option>
                        <option value="18">E&I</option>
                        <option value="19">Directo</option>
                        <option value="19">Indirecto</option>
                    </select>
                </div>
            </div>
        </div>
        
        <div class="separator">
            <div class="titulo">
                <span>CURSOS - CERTIFICACIONES (SEGÚN EL CARGO QUE OCUPE)</span>
                <a href="#"><img src = "../assets/error.svg"/></a>
            </div>
            <div class="cuerpo">
                <div class="tres_columnas">
                    <label for="curso_seguridad">Cursos Seguridad :</label>
                    <select name="curso_seguridad" id="curso_seguridad">
                        <option value="-1">Seleccionar</option>
                        <option value="1">AISLAMIENTO DE ENERGÍAS PELIGROSAS</option>
                        <option value="2">CONTROL DEL TRABAJO</option>
                        <option value="3">CURSO BÁSICO DE SEGURIDAD</option>
                        <option value="4">ESPACIOS CONFINADOS</option>
                        <option value="5">INDUCCIÓN AL TERMINAL MARÍTIMO PISCO</option>
                        <option value="6">INDUCCIÓN ASUNTOS COMUNITARIO</option>
                        <option value="7">INDUCCIÓN MALVINAS</option>
                        <option value="8">INDUCCIÓN PISCO</option>
                        <option value="9">INVESTIGACIÓN DE EVENTOS NO DESEADOS</option>
                        <option value="10">MANEJO Y CONTROL DE EMERGENCIA CON MATERIALES PELIGROSOS</option>
                        <option value="11">PLAN DE MANEJO DE INCIDENTES</option>
                        <option value="12">TARJETAS DE OBSERVACION PREVENTIVA (TOP)</option>
                        <option value="13">TRABAJO EN ALTURA</option>
                        <option value="14">ZANJAS Y EXCAVACIONES</option>
                    </select>
                </div>
                
                <div class="tres_columnas">
                    <label for="certificaciones">Certificaciones :</label>
                    <input type="text" name="certificaciones" id="certificaciones">
                </div>
                <div class="tres_columnas">
                    <label for="manejo_defensivo">Curso manejo defensivo :</label>
                    <input type="text" name="manejo_defensivo" id="manejo_defensivo">
                </div>
                <div class="tres_columnas">
                    <label for="licencia_conducir">Categoria Licencia Conducir :</label>
                    <select name="licencia_conducir" id="licencia_conducir">
                        <option value="-1">Seleccionar</option>
                        <option value="1">A1</option>
                        <option value="2">A3C</option>
                        <option value="3">A2</option>
                    </select>
                </div>
                
                <div class="tres_columnas">
                    <label for="incio_seguridad">Fecha inicio :</label>
                    <input type="date" name="inicio_seguridad" id="inicio_seguridad">
                </div>
                <div class="tres_columnas">
                    <label for="inicio_certificacion">Fecha inicio :</label>
                    <input type="date" name="inicio_certificacion" id="inicio_certificacion">
                </div>
                <div class="tres_columnas">
                    <label for="inicio_manejo">Fecha inicio :</label>
                    <input type="date" name="inicio_manejo" id="inicio_manejo">
                </div>
                <div class="tres_columnas">
                    <label for="inicio_vigencia">Inic. Vigencia :</label>
                    <input type="date" name="inicio_vigencia" id="inicio_vigencia">
                </div>

                <div class="tres_columnas">
                    <label for="termino_seguridad">Fecha Termino :</label>
                    <input type="date" name="termino_seguridad" id="termino_seguridad">
                </div>
                <div class="tres_columnas">
                    <label for="termino_certificacion">Fecha Termino :</label>
                    <input type="date" name="termino_certificacion" id="termino_certificacion">
                </div>
                <div class="tres_columnas">
                    <label for="termino_manejo">Fecha Termino :</label>
                    <input type="date" name="termino_manejo" id="termino_manejo">
                </div>
                <div class="tres_columnas">
                    <label for="termino_vigencia">Term.vigencia :</label>
                    <input type="date" name="termino_vigencia" id="termino_vigencia">
                </div>
                <div class="tres_columnas opciones">
                    <button>Grabar</button>
                </div>
                <div class="tres_columnas opciones">
                    <button>Grabar</button>
                </div>
                <div class="tres_columnas opciones">
                    <button>Grabar</button>
                </div>
                <div class="tres_columnas opciones">
                    <button>Grabar</button>
                </div>
            </div>
        </div>
        <div class="separator">
            <div class="titulo">
                <span>RECORD DE DIAS TRABAJADOS</span>
                <span>F = Falta / A = Asistio / D = Descanso / M = D. Médico / V = Vacaciones  / P = Permiso</span>
            </div>
            <div class="cuerpo">
                <div class="ocho_columnas columnas_dias">
                    <?php for ($i=1; $i < 32; $i++) { ?>
                        <div class="valorpuntaje">
                            <p><?php echo $i; ?></p>
                            <input type="text" name="p<?php echo $i; ?>" id="p<?php echo $i; ?>" form="data_matriz">
                        </div>
                    <?php }?>
                </div>
                <div class="cuatro_columnas columnas_totales">
                    <div class="totales">
                        <label for="activo" style="background:#92CDDC" title="ACTIVO">A</label>
                        <input type="text" name="activo" id="activo">
                    </div>
                    <div class="totales">
                        <label for="descanso" style="background:#FF0000" title="DESCANSO">D</label>
                        <input type="text" name="descanso" id="descanso">
                    </div>
                    <div class="totales">
                        <label for="descanso_medico" style="background:#F5B1DD" title="DESCANSO MEDICO">DM</label>
                        <input type="text" name="descanso_medico" id="descanso_medico">
                    </div>
                    <div class="totales">
                        <label for="transito_ingreso" style="background:#7030A0" title="TRANSITO INGRESO">TI</label>
                        <input type="text" name="transito_ingreso" id="transito_ingreso">
                    </div>
                    <div class="totales">
                        <label for="transito_salida" style="background:#0070C0" title="TRANSITO SALIDA">TS</label>
                        <input type="text" name="transito_salida" id="transito_salida">
                    </div>
                    <div class="totales">
                        <label for="licencia_con_goce" style="background:#00B0F0" title="LICENCIA CON GOCE">LCG</label>
                        <input type="text" name="licencia_con_goce" id="licencia_con_goce">
                    </div>
                    <div class="totales">
                        <label for="licencia_sin_goce" style="background:#CCFFCC" title="LICENCIA SIN GOCE">LSG</label>
                        <input type="text" name="licencia_sin_goce" id="licencia_sin_goce">
                    </div>
                    <div class="totales">
                        <label for="suspendido" style="background:#CCC0DA" title="SUSPENDIDO">S</label>
                        <input type="text" name="suspendido" id="suspendido">
                    </div>
                    <div class="totales">
                        <label for="vacaciones" style="background:#FFFF00" title="VACACIONES">V</label>
                        <input type="text" name="vacaciones" id="vacaciones">
                    </div>
                    <div class="totales">
                        <label for="pucallpa" style="background:#CCC0DA" title="PUCALLPA">PU</label>
                        <input type="text" name="pucallpa" id="pucallpa">
                    </div>
                    <div class="totales">
                        <label for="lima" style="background:#92D050" title="LIMA">L</label>
                        <input type="text" name="lima" id="lima">
                    </div>
                    <div class="totales">
                        <label for="ingreso_standby" style="background:#548235" title="TRANSITO INGRESO STAND BY">TIS</label>
                        <input type="text" name="ingreso_standby" id="ingreso_standby">
                    </div>
                    <div class="totales">
                        <label for="salida_standby" style="background:#FBE5D6" title="TRANSITO SALIDA STAND BY">TSS</label>
                        <input type="text" name="salida_standby" id="salida_standby">
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>