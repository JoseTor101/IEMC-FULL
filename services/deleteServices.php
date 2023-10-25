<?php
session_start(); // Iniciar sesión

// Validar si se recibió el parámetro 'codigo_cita' en la URL
if (isset($_GET['codigo_cita'])) {
    $codigo_cita = $_GET['codigo_cita'];

    // Incluir archivo de configuración de la base de datos
    include "../configs/database.php";

    // Preparar la consulta SQL usando una consulta preparada
    $sql = "DELETE FROM citas WHERE codigo_cita = ?";
    $stmt = $connection->prepare($sql);

    if ($stmt) {
        // Vincular el parámetro a la consulta preparada
        $stmt->bind_param("i", $codigo_cita);

        // Ejecutar la consulta
        if ($stmt->execute()) {
            // Establecer mensaje de éxito en la variable de sesión
            $_SESSION['success_message'] = "Registro eliminado exitosamente";
        } else {
            $_SESSION['error_message'] = "Error al eliminar el registro: " . $stmt->error;
        }

        // Cerrar la consulta preparada
        $stmt->close();
    } else {
        $_SESSION['error_message'] = "Error en la consulta preparada: " . $connection->error;
    }

    // Cerrar la conexión a la base de datos
    $connection->close();

    // Redireccionar al usuario a la página de solicitudes
    header("Location: http://localhost/p/solicitudes.html");
    exit(); // Salir del script después de redirigir
} else {
    echo "ID de registro no válido";
}
?>
