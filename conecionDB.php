<?php
    // Parámetros iniciales de la conexión
    $host = "localhost";
    $user = "root";
    $password = "";
    $database = "Medellin_Tours";

    // Opciones para la conexión con la base de datos
    $options = array(
        PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES 'UTF8'",
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_OBJ
    );

    try {
        $conexion = new PDO("mysql:host=".$host.";dbname=".$database, $user, $password, $options);
        echo "Conexion exitosa";
    } catch (PDOException $error) {
        echo "Error: ".$error->getMessage();
        die();
    }
?>