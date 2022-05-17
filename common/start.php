<?php
error_reporting(E_ALL);

date_default_timezone_set('Asia/Singapore');
session_start();

//********** Required Files **********//
require("common/config.php");
require("common/paths.php");
require("common/db.php");
require("common/alerts.php");
require("common/validation.php");
require("common/forms.php");
require("common/app.php");
require("common/functions.php");

// start database connection
$conn = SetDatabaseConnection();

?>