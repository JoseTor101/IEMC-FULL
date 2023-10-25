<?php
// Validate session
session_start();
$session = $_SESSION['session'];

if($session){
    // SQL Query
    $query = "SELECT nombre, correo, telefono, cedula, clave FROM user WHERE nombre = '$session'";

    // DB config
    include "../configs/database.php";

    // Query handler
    $res = mysqli_query($connection, $query);
    if($res){
        $data = [];
        while ($row = mysqli_fetch_assoc($res)) {
            $data[] = $row;
        };

        header('Content-Type: application/json; charset=utf-8');
        echo json_encode($data[0]);
    }else{
        echo("Ocurrió un error");
    }

    // Close query
    mysqli_free_result($res);
    mysqli_close($connection);
}else{
    echo("No hay una session valida");
}
?>
