<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>estadistica</title>

    <?php include 'links.php';
    links("estadisticas");
    ?>


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
        //Si no ha seleccionado ningun deporte le pedimos al usuario que seleccione un deporte

        echo "<p style='color: red'>Selecciona un deporte</p>";
    } else {
        if (@$_SESSION['deporte'] != null) {
            function consultarDeporte($db, $id_equipo)
            {
                $consulta_equipo = "select deporte_iddeporte from equipo where idequipo = " . $id_equipo;

                foreach ($db->query($consulta_equipo) as $fila) {
                    $deporte = $fila['deporte_iddeporte'];
                }
                return $deporte;
            }

            function listar($db, $tipo)
            {

                $lista = "";
                //Muestra el jugado y la cantidad de una incidencia
                $consulta_inc = "SELECT idjugador1_inc, count(idjugador1_inc) as cantidad_inc from incidencia where idtincidencia_inc = " . $tipo . "  GROUP BY  idjugador1_inc order by cantidad_inc desc limit 5;";
                foreach ($db->query($consulta_inc) as $fila) {
                    $jugador = $fila['idjugador1_inc'];
                    $cantidad_inc = $fila['cantidad_inc'];

                    $consulta_jug = "SELECT idjugador, alias_jug, nombre_eq,idequipo FROM jugador, jugador_equipo_temporada, equipo where idjugador = " . $jugador . " and Jugador_idjugador = idjugador and idequipo_jet = idequipo;";
                    foreach ($db->query($consulta_jug) as $fila) {
                        if (consultarDeporte($db, $fila{'idequipo'}) == @$_SESSION['deporte']) {
                            $jugador = $fila['alias_jug'];
                            $equipo = $fila['nombre_eq'];
                        } else {
                            //Si no ha seleccionado un deporte no sale nada y se sale del bucle
                            exit();

                        }
                    }


                    $lista .= "<tr><td>" . $jugador . "</td><td>" . $equipo . "</td><td>" . $cantidad_inc . "</td></tr>";


                }

                return $lista;
            }
        }
    }
}
?>
<div id="goles-puntos">
    <div class="table-responsive">
        <table class="table">
            <thead class="tcabecera">
            <tr>
                <th>Nombre</th>
                <th>Equipo</th>
                <th>Goles</th>
            </tr>

            </thead>
            <tbody>
            <?php  echo listar($db, 1); ?>
            </tbody>


            <thead class="tcabecera">
            <tr>
                <th>Nombre</th>
                <th>Equipo</th>
                <th>Asistencias</th>
            </tr>
            </thead>
            <tbody>
            <?php  echo listar($db, 2); ?>
            </tbody>


            <thead class="tcabecera">
            <tr>
                <th>Nombre</th>
                <th>Equipo</th>
                <th>Tarjeta Amarilla</th>
            </tr>
            </thead>
            <tbody>
            <?php echo listar($db, 4); ?>
            </tbody>


            <thead class="tcabecera">
            <tr>
                <th>Nombre</th>
                <th>Equipo</th>
                <th>Tarjeta Roja</th>
            </tr>
            </thead>
            <tbody>
            <?php echo listar($db, 3); ?>
            </tbody>


            <thead class="tcabecera">
            <tr>
                <th>Nombre</th>
                <th>Equipo</th>
                <th>Expulsiones</th>
            </tr>
            </thead>
            <tbody>
            <?php  echo listar($db, 9); ?>
            </tbody>


            <thead class="tcabecera">
            <tr>
                <th>Nombre</th>
                <th>Equipo</th>
                <th>Exclusiones</th>
            </tr>
            </thead>
            <tbody>
            <?php  echo listar($db, 1); ?>
            </tbody>
        </table>
    </div>
</div>

<?php include 'pie.php'; ?>

</body>

</html>
