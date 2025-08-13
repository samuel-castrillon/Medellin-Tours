<?php
    include "./conecionDB.php";

    /*
        Inserción de datos a la base de datos.
    */
    // Función para la creación del usuario
    function create($p_user_name, $p_user_lastname, $p_user_email, $p_user_phone, $p_user_birthdate, $p_user_city, $p_user_password, $p_conection){
        $sql = "INSERT INTO usuarios (nombre, apellido, email, telefono, fecha_nacimiento, ciudad_residencia, contraseña) VALUES (:name, :lastname, :email, :phone, :birthdate, :city, :password)";

        $query = $p_conection->prepare($sql);
        $query->bindParam(":name", $p_user_name);
        $query->bindParam(":lastname", $p_user_lastname);
        $query->bindParam(":email", $p_user_email);
        $query->bindParam(":phone", $p_user_phone);
        $query->bindParam(":birthdate", $p_user_birthdate);
        $query->bindParam(":city", $p_user_city);
        $query->bindParam(":password", $p_user_password);

        $query->execute();

        $registered = $p_conection->lastInsertId();
        if($registered > 0){
            echo "Se hizo el registro";
        } else {
            echo "No se hizo el registro";
        }
    }

    // Recuperación de los datos del formulario y llamado a la función
    if (isset($_POST)) {
        echo "Datos enviados correctamente.";
        $user_name = $_POST["user_name"];
        $user_lastname = $_POST["user_lastname"];
        $user_email = $_POST["user_email"];
        $user_phone = $_POST["user_phone"];
        $user_birthdate = $_POST["user_birthdate"];
        $user_city = $_POST["user_city"];
        $user_password = $_POST["user_password"];
        $user_password_confirm = $_POST["user_password_confirm"];
        create($user_name, $user_lastname, $user_email, $user_phone, $user_birthdate, $user_city, $user_password, $conection);
    }    
?>