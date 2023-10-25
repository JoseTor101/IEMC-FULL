<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "metro";

$connection = mysqli_connect($servername, $username, $password, $dbname);
$error = mysqli_connect_error();
if($error) {
    die("Connect failed" . "<br></br>" . $error);
}
?>