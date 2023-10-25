<?php

if(!isset($_SESSION['session'])) {
  header("Location: ./login.html"); // Redirige si el usuario no ha iniciado sesión
  exit;
}
?>
