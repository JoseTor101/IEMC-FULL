<?php
// Validate session
session_start();
$session = $_SESSION['session'];

if ($session) {
    // Entradas
    $nombre = $_POST['name'];
    $correo = $_POST['location'];
    $telefono = $_POST['station_id'];
    $cedula = $_POST['employees'];
    $clave = $_POST['password'];

    // SQL Query
    $query = "UPDATE user SET 
                nombre = '$nombre', 
                clave = '$clave', 
                correo = '$correo', 
                telefono = '$telefono', 
                cedula = '$cedula' 
                WHERE nombre = '$session'";

    // DB config
    include "../configs/database.php";

    // Query handler
    $res = mysqli_query($connection, $query);
    if ($res) {
        $_SESSION["session"] = $nombre;
        header("location:../editar_info.html");
    } else {
        echo("No se pudo actualizar los datos");
    }

    // Close connection
    mysqli_close($connection);
} else {
    echo("No hay una sesión válida");
}
?>
