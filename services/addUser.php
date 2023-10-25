<?php
// Entries
$nombre = $_POST['name'];
$correo = $_POST['location'];
$telefono =$_POST['station_id'];
$cedula = $_POST['employees'];
$clave = $_POST['password'];

// SQL Query
$query = "INSERT INTO user (correo, nombre, telefono, cedula, clave) 
VALUES ('$correo','$nombre','$telefono', '$cedula', '$clave')";

// DB config
include "../configs/database.php";

// Query handler
$res = mysqli_query($connection, $query);
if($res){
    header("location:../register.html");
}else{
    echo("No se pudo registrar");
}

// Close query
mysqli_free_result($res);
mysqli_close($connection);
?>