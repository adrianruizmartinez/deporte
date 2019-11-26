<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>jugadores</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/styles_jugadores.css">
    <!-- Cabecera y pie-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Cookie">
    <link rel="stylesheet" href="assets/css/Navigation-with-Button.css">
    <link rel="stylesheet" href="assets/css/Pretty-Header.css">
    <link rel="stylesheet" href="assets/css/styles_cabecera.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700">
    <link rel="stylesheet" href="assets/css/Footer-Dark.css">
    <link rel="stylesheet" href="assets/css/Header-Blue.css">
    <link rel="stylesheet" href="assets/css/Navigation-with-Button_cabecera.css">
    <style>
        img {
            margin-left: 0px;
        }
    </style>
</head>

<body>
<?php include 'cabecera.php'; ?>
<?php include 'conexionproyecto.php'; ?>
<?php
//Lista de equipos
$lista = "";
$consulta_equipos = "SELECT idequipo, nombre_eq from equipo;";
foreach ($db->query($consulta_equipos) as $fila) {
    $idequipo = $fila['idequipo'];
    $nombre_eq = $fila['nombre_eq'];
    $lista .= "<li value=\"" . $idequipo . "\">" . $nombre_eq . "</li>";
}
//_-----------------------------------------------------------------------
$jugadores = "";
$consulta_jugadores = "SELECT idjugador, alias_jug from jugador";
foreach ($db->query($consulta_jugadores) as $fila) {
    $idjugador = $fila['idjugador'];
    $alias_jug = $fila['alias_jug'];
    $jugadores .= "<option value=\"" . $idjugador . "\">" . $alias_jug . "</option>";
}
//_----------------------------------------------------------
$info_jug = "";
$consulta_infojug = "SELECT * from jugador where idjugador=1";
foreach ($db->query($consulta_infojug) as $fila) {
    $idposicion_jug = $fila['idposicion_jug'];
    $idjugador = $fila['idjugador'];
    $nombre_jug = $fila['nombre_jug'];
    $apellido_jug = $fila['apellido_jug'];
    $alias_jug = $fila['alias_jug'];
    $fecha_nac_jug = $fila['fecha_nac_jug'];
    $nacionalidad_jug = $fila['nacionalidad_jug'];
    $numero_jug = $fila['numero_jug'];
    $equipos_jug = $fila['equipos_jug'];
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
                <select>
                    <optgroup label="Recuerde seleccionar un equipo">
                        <option value="0" selected="">Seleccione un jugador</option>
                        <?php echo $jugadores ?>
                    </optgroup>
                </select>
                <div class="table-responsive">
                    <table class="table">
                        <img src="#">
                        <p>a</p>
                        <p>a</p>
                        <thead>
                        <tr>
                            <th>Nombre</th>
                            <th class="col-md-8">Apellido</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td><?php echo $nombre_jug ?></td>
                            <td><?php echo $apellido_jug ?></td>
                        </tr>
                        <thead>
                        <tr>
                            <th>Alias</th>
                            <th>Equipo</th>
                        </tr>
                        </thead>
                        <tr>
                            <td>peta</td>
                            <td>Villanueva del Arzobispo</td>
                        </tr>
                        <thead>
                        <tr>
                            <th>Nacionalidad</th>
                            <th>Número</th>
                        </tr>
                        </thead>
                        <tr>
                            <td>Español</td>
                            <td>8</td>
                        </tr>
                        <thead>
                        <tr>
                            <th>Fecha Nacimiento</th>
                            <th>Liga</th>
                        </tr>
                        </thead>
                        <tr>
                            <td>13/07/2000</td>
                            <td>Liga Santander</td>
                        </tr>

                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </div>
</div>
<?php include 'pie.php'; ?>
</body>

</html>