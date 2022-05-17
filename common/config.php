<?php

//----- database functions
function SetDatabaseConnection() {
    $host = '127.0.0.1';
    $dtbs = 'smartchathelper';
    $user = 'root';
    $pass = 'password';
    $char = 'utf8';

    $dsn = "mysql:host=$host;dbname=$dtbs;charset=$char;port=3306";

    $options = array(
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false
    );

    $conn = new PDO($dsn, $user, $pass, $options);
    return $conn;
}

//----- file path functions
function PATH_Server()
{
    return "/home/";
}

function PATH_Root() {
    return "/home/smartchathelper/";
}

function PATH_Host() {
    return "http://www.smartchathelper.com/";
}


//----- file size
function UploadFileSize()
{
    return 5120000;
}

?>