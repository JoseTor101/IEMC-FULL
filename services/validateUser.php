<?php
// Entries
$name = $_POST['name'];
$password = $_POST['password'];

// SQL Query
$query = "SELECT id, codigo FROM user WHERE nombre = '$name' and clave = '$password'";

// DB config
session_start();
include "../configs/database.php";

// Query handler
$res = mysqli_query($connection, $query);
$rows = mysqli_num_rows($res);

if ($rows) {
    $_SESSION['session'] = $name;
    $user = mysqli_fetch_assoc($res);
    $userCode = $user['codigo'];

    // Redirigir según el tipo de usuario
    if ($userCode === '1') {  // Código '1' para usuario administrador
        header('Location: ../menu_admin.html');
        exit();
    } else {
        header('Location: ../menu.html');
        exit();
    }
} else {
    echo("Nombre de usuario o contraseña incorrectos. No se pudo iniciar sesión.");
}

// Close query
mysqli_free_result($res);
mysqli_close($connection);
?>
