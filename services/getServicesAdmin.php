<?php
// Validate session
session_start();
$session = $_SESSION['session'];

if ($session) {
    // SQL Query
    $query = "SELECT nombre, codigo_cita, servicio, fecha_prestacion, fecha_creacion, modelo_dispositivo, nombre_dispositivo FROM citas";

    // DB config
    include "../configs/database.php";

    // Query handler
    $res = mysqli_query($connection, $query);
    if ($res) {
        $data = [];
        while ($row = mysqli_fetch_assoc($res)) {
            $data[] = $row;
        }

        header('Content-Type: application/json; charset=utf-8');
        echo json_encode($data);
    } else {
        echo("Ocurrió un error: " . mysqli_error($connection));
    }

    // Close query
    mysqli_free_result($res);
    mysqli_close($connection);
} else {
    echo("No hay una sesión válida");
}
?>
