<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>jugadores</title>
    <?php include 'links.php';
    links("jugadores");
    ?>
    <style>
        .img_jug {
            margin-left: 0;
        }
    </style>
</head>
<body>
<?php
session_start();
if (!isset($_SESSION["conectado"])) {
    header("location:index.php");
} else {
    include 'cabecera.php';
    include 'conexionproyecto.php';
    if (!isset($_SESSION['deporte'])) {
        echo "<p style='color: red'>Selecciona un deporte</p>";
    } else {
        $lista = "";
        $consulta_equipos = "SELECT idequipo, nombre_eq,deporte_iddeporte from equipo;";
        foreach ($db->query($consulta_equipos) as $fila) {
            if ($fila{'deporte_iddeporte'} == $_SESSION['deporte']) {

                $idequipo = $fila['idequipo'];
                $nombre_eq = $fila['nombre_eq'];
                $lista .= "<li value=\"" . $idequipo . "\"><a href=?equipo=" . $idequipo . ">" . $nombre_eq . "</a></li>";
            }
        }

//_-----------------------------------------------------------------------_\\
        if (isset($_GET['equipo'])) {
            $_SESSION['equipo_select']=$_GET['equipo'];
        }

        if (isset($_GET['temporada_select'])) {
            $_SESSION['temporada_select']=$_GET['temporada_select'];
        }
        if (isset($_SESSION['equipo_select'])) {
            $temporadas = "";
            $consulta_temporada = "select idtemporada,ano_principio,ano_fin from temporada, temporada_equipo where idequipo_temeq = " . $_SESSION['equipo_select'] . " and idtemporada_temeq = idtemporada order by  idtemporada desc;";
            foreach ($db->query($consulta_temporada) as $fila) {
                $idtemporada = $fila['idtemporada'];
                $principio = $fila['ano_principio'];
                $fin = $fila['ano_fin'];
                $temporadas .= "<option value=\"" . $idtemporada . "\">" . $principio . "-" . $fin . "</option>";
            }
        }

        if (isset($_SESSION['equipo_select']) && isset($_SESSION['temporada_select'])) {
            $equipo = $_SESSION['equipo_select'];
            $temporada = $_SESSION['temporada_select'];
            $jugadores = "";
            $consulta_jugadores = "SELECT idjugador, alias_jug from jugador,jugador_equipo_temporada  where idequipo_jet= " . @$equipo . " and jugador_idjugador=idjugador and temporada_idtemporada = " . @$temporada;
            foreach ($db->query($consulta_jugadores) as $fila) {
                $idjugador = $fila['idjugador'];
                $alias_jug = $fila['alias_jug'];
                $jugadores .= "<option value=\"" . $idjugador . "\">" . $alias_jug . "</option>";
            }
        }
//_-------------------------------------------------------------_\\
        @$jugador_actual = $_GET['jugador_select'];
        if (isset($jugador_actual)) {
            $info_jug = "";
            $id_jug = (int)$_GET['jugador_select'];
            $consulta = "SELECT nombre_jug, apellido_jug, alias_jug, fechanac_jug, nacionalidad_jug, numero_jug_jet, nombre_eq, nombre_pos, nombre_div 
              from jugador , jugador_equipo_temporada, equipo, posicion, temporada_equipo, division
             where Jugador_idjugador=" . $id_jug . " and idjugador = " . $id_jug . " and idequipo_jet= idequipo
              and idposicion_jet = idposicion and idequipo_temeq = idequipo and iddivision_temeq = iddivision ";
            foreach ($db->query($consulta) as $fila) {
                $nombre_jug = $fila['nombre_jug'];
                $apellido_jug = $fila['apellido_jug'];
                $alias_jug_lista = $fila['alias_jug'];
                $fechanac_jug = $fila['fechanac_jug'];
                $nacionalidad_jug = $fila['nacionalidad_jug'];
                $numero_jug = $fila['numero_jug_jet'];
                $equipo_jug = $fila['nombre_eq'];
                $idposicion_jug = $fila['nombre_pos'];
                $liga_jug = $fila['nombre_div'];

            }

        }
        if (isset($_SESSION['temporada_select'])) {
            $temporada1 = "select ano_principio,ano_fin from temporada where idtemporada = " . @$_SESSION['temporada_select'];
            $temporada2 = "";
            foreach ($db->query($temporada1) as $fila) {
                $ano_principio = $fila['ano_principio'];
                $ano_fin = $fila['ano_fin'];
                $temporada2 = "$ano_principio - $ano_fin";
            }
        }

        ?>
        <div>
            <div class="container">
                <div class="row">
                    <div class="col-md-3">
                        <ul id="menu_lateral">
                            <?php echo $lista ?>
                        </ul>
                    </div>
                    <div class="col-md-8">
                        <form>
                            <select name="temporada_select" id="temporada_select">
                                <option value="0" selected>Seleccione una temporada</option>
                                <?php echo $temporadas ?>
                                </optgroup>
                            </select>
                            <button type="submit">Seleccionar Temporada</button>
                        </form>
                        <form>
                            <select name="jugador_select" id="jugador_select">
                                <optgroup label="Recuerde seleccionar un equipo">
                                    <option value="0" selected="">Seleccione un jugador</option>
                                    <?php echo @$jugadores ?>
                                </optgroup>
                            </select>
                            <button type="submit">Seleccionar Jugador</button>
                        </form>

                        <p>Temporada seleccionada:<b> <?php echo @$temporada2; ?></b></p>

                        <div class="table-responsive">
                            <table class="table">
                                <img class="img_jug" src="assets/img/descarga.png"/>
                                <p>Posición:</p>
                                <p><?php echo @$idposicion_jug ?></p>
                                <thead>
                                <tr>
                                    <th>Nombre</th>
                                    <th class="col-md-8">Apellido</th>
                                </tr>
                                </thead>

                                <tr>
                                    <td><?php echo @$nombre_jug ?></td>
                                    <td><?php echo @$apellido_jug ?></td>
                                </tr>
                                <thead>
                                <tr>
                                    <th>Alias</th>
                                    <th>Equipo</th>
                                </tr>
                                </thead>
                                <tr>
                                    <td><?php echo @$alias_jug_lista ?></td>
                                    <td><?php echo @$equipo_jug ?></td>
                                </tr>
                                <thead>
                                <tr>
                                    <th>Nacionalidad</th>
                                    <th>Número</th>
                                </tr>
                                </thead>
                                <tr>
                                    <td><?php echo @$nacionalidad_jug ?></td>
                                    <td><?php echo @$numero_jug ?></td>
                                </tr>
                                <thead>
                                <tr>
                                    <th>Fecha Nacimiento</th>
                                    <th>Liga</th>
                                </tr>
                                </thead>
                                <tr>
                                    <td><?php echo @$fechanac_jug ?></td>
                                    <td><?php echo @$liga_jug ?></td>
                                </tr>


                            </table>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <?php
    }
}
include 'pie.php'; ?>
</body>

</html>
