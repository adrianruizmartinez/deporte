<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>clasificacion</title>


    <?php include "links.php";
    links("clasificacion");
    ?>
    <script type="text/javascript">
        $(function() {
//Usa la libreria tablesorter para ordenar la tabla
            $("table").tablesorter({
                //El primer numero indica la columna que se quiera ordenar y el segundo numero el orden

             sortList: [[2,1], [4,1],[9,1]],
                //Estilos de la tabla
                theme : "bootstrap",

                widthFixed: true,

                widgets : [ "filter", "columns", "zebra" ],

                widgetOptions : {
                  zebra : ["even", "odd"],


                    columns: [ "primary", "secondary", "tertiary" ],

                    filter_reset : ".reset",

                    filter_cssFilter: [
                        'form-control',
                        'form-control',
                        'form-control custom-select', // select needs custom class names :(
                        'form-control',
                        'form-control',
                        'form-control',
                        'form-control'
                    ]

                }
            })


        });
    </script>
</head>

<body>
<?php
session_start();
if (!isset($_SESSION["conectado"])) {
    header("location:index.php");
} else {
    include 'cabecera.php';
    //Si no ha seleccionado ningun deporte le pedimos al usuario que seleccione un deporte
    if (!isset($_SESSION['deporte'])) {
        echo "<p style='color: red'>Selecciona un deporte</p>";
    } else {
        include 'conexionproyecto.php';
        $lista = "";
        if (@$_SESSION['deporte'] != null) {
    //Muestra los equipos del deporte que selecciona el usuario
            $consulta_equipos = "SELECT idequipo, nombre_eq from equipo where deporte_iddeporte =" . $_SESSION['deporte'] . " ;";
            $n = 1;
            function consultarDeporte($db, $id_equipo)
            {
                $consulta_equipo = "select deporte_iddeporte from equipo where idequipo = " . $id_equipo;
                foreach ($db->query($consulta_equipo) as $fila) {
                    $deporte = $fila['deporte_iddeporte'];
                }
                return $deporte;
            }

            function calcular_puntos($db, $idequipo)
            {
                //Calcula los puntos de todos los equipos
                $contador = 0;
                $goles_favor = 0;
                $goles_contra = 0;
                $puntos = 0;
                $jugados = 0;
                $ganados = 0;
                $empates = 0;
                $perdidos = 0;
                $partidos = "";
                $consulta_puntos = "SELECT local_cal, visitante_cal, goleslocal_cal, golesvisitante_cal, idtemporada_cal from calendario where idtemporada_cal = 1 and local_cal = " . $idequipo . " or visitante_cal = " . $idequipo;
                foreach ($db->query($consulta_puntos) as $fila) {
                    $local_cal = $fila['local_cal'];
                    $visitante_cal = $fila['visitante_cal'];
                    if ($fila['goleslocal_cal'] !== null) {
                        $goleslocal_cal = $fila['goleslocal_cal'];
                        $golesvisitante_cal = $fila['golesvisitante_cal'];
                        $jugados += 1;

                    }

                    if ($local_cal == $idequipo) {
                        $goles_favor += $goleslocal_cal;
                        $goles_contra += $golesvisitante_cal;

                    } else {
                        $goles_favor += $golesvisitante_cal;
                        $goles_contra += $goleslocal_cal;

                    }
//Añade los puntos correspondientes segun si gana empata o pierde y le añade el icono correspondientes
                    if ($local_cal == $idequipo && $goleslocal_cal > $golesvisitante_cal || $visitante_cal == $idequipo && $golesvisitante_cal > $goleslocal_cal) {
                        $puntos += 3;
                        $ganados += 1;
                        if ($contador < 5) {
                            $partidos .= "<i style=\"font-size:24px; color:green\"  class=\"fa\">&#xf058;</i>";
                            $contador += 1;

                        }
                    } else if ($goleslocal_cal == $golesvisitante_cal) {
                        $puntos += 1;
                        $empates += 1;
                        if ($contador < 5) {
                            $partidos .= "<i style=\"font-size:24px; color:black\" class=\"fa\">&#xf056;</i>";
                            $contador += 1;
                        }
                    } else {
                        if ($contador < 5) {
                            $partidos .= "<i style=\"font-size:24px; color:red\" class=\"fa\">&#xf00d;</i>";
                            $contador += 1;
                            $perdidos += 1;
                        }
                    }

                }
                if ($jugados == 0) {
                    //Si un equipo no ha jugado ningun partido devuelve 0 puntos y todo lo demas vacio

                    return "<td>0</td><td></td><td></td></td><td></td><td></td><td></td><td></td><td></td><td></td>";

                }
                //Devuelve los datos de los equipos
                return "<td>$puntos</td><td>$jugados</td><td>$ganados</td><td>$empates</td><td>$perdidos</td><td>" . @$goles_favor . "</td><td>" . @$goles_contra . "</td><td>" . (int)(@$goles_favor - @$goles_contra) . "</td><td>" . $partidos . "</td>";

            }

            foreach ($db->query($consulta_equipos) as $fila) {
                if (consultarDeporte($db, $fila['idequipo']) == $_SESSION['deporte']) {
                    $idequipo = $fila['idequipo'];
                    $nombre_eq = $fila['nombre_eq'];
                    $lista .= "<tr><td>" . 1 . "</td><td></img class=\"escudo\"> " . $nombre_eq . "</td>" . calcular_puntos($db, $idequipo) . "</tr>";
                }
            }

        }


        ?>
        <div class="table-responsive">
            <table  class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th >Posición</th>
                    <th >Equipo</th>
                    <th>Puntos</th>
                    <th>PJ</th>
                    <th>PG</th>
                    <th>PE</th>
                    <th>PP</th>
                    <th>GF</th>
                    <th>GC</th>
                    <th>DG</th>
                    <th>Ultimos 5 partidos</th>
                </tr>
                </thead>
                <tbody>
                <?php echo @$lista ?>
                </tbody>
            </table>
        </div>
        <?php
    }
}
include 'pie.php'; ?>

</body>

</html>