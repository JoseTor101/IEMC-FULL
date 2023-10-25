<?php
// DB config
include "../configs/database.php";

function generarCodigoUnico($longitud = 10) {
    $caracteres = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $codigo = '';

    for ($i = 0; $i < $longitud; $i++) {
        $codigo .= $caracteres[rand(0, strlen($caracteres) - 1)];
    }

    return $codigo;
}

session_start();
$session = $_SESSION['session'];

if($session){
    // SQL Query
    $query = "SELECT nombre, correo, telefono, cedula, clave FROM user WHERE nombre = '$session'";
    $result = mysqli_query($connection, $query);

    if ($result && mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_assoc($result);
        // Assign values to variables
        $nombre = $row['nombre'];
        $cedula = $row['cedula'];        
        $correo = $row['correo'];
        setcookie('correo', $correo, 0, '/'); // La cookie de sesión se guarda para el dominio actual
    } 

// Entries

    $codigoCita = generarCodigoUnico(10);
    $fecha_prestacion = $_POST['fecha_prestacion'];
    $fecha_final = $_POST['fecha_final'];
    $nombre_dispositivo = $_POST['nombre_dispositivo'];
    $modelo_dispositivo = $_POST['modelo_dispositivo'];
    $especificaciones = $_POST['especificaciones'];
    $serv = $_POST['serv'];
    //$service = $_POST['servicio'];

    //SQL query
    $query = "INSERT INTO citas (codigo_cita, nombre, cedula, fecha_prestacion, fecha_final, nombre_dispositivo, modelo_dispositivo, especificaciones, servicio) 
    VALUES ('$codigoCita','$nombre', '$cedula', '$fecha_prestacion', '$fecha_final', '$nombre_dispositivo', '$modelo_dispositivo', '$especificaciones', '$serv')";

    foreach ($_POST as $key => $value) {
        echo $key . " => " . $value . "<br>";
    }
    //SQL query


    // Query handler
    $res = mysqli_query($connection, $query);
    if($res){
        header("location:../solicitudes.html");
        echo("Hola");
    }else{
        echo("Solicitud inválida");
    }

    // Close query
    mysqli_free_result($res);
    mysqli_close($connection);

}

?>