<?php
    // SQL Query
    $query = "SELECT * FROM station";

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
        echo json_encode($data);
    }else{
        echo("Ocurrió un error");
    }

    // Close query
    mysqli_free_result($res);
    mysqli_close($connection);
?>
