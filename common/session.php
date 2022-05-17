<?php
// check whether this is a logout request
if(isset($_GET['logout']))
{
    session_unset();
    session_destroy();
    
    echo "<script language='JavaScript'>window.alert('Thank you for using the Smart Chat Helper!\\nSee you again soon...');window.location='index.php'</script>";
}

// verify that the session exists
if (!isset($_SESSION['smartchat-UserID']) || $_SESSION['smartchat-UserID'] == "" || $_SESSION['smartchat-UserID'] == "0") {
    
    session_unset();
    session_destroy();
        
    echo "<script language='JavaScript'>window.alert('Your session has expired.\\nPlease login again...');window.location='index.php'</script>";
}

//********** Session Variables **********//
$userID = $_SESSION['smartchat-UserID'];
$userName = $_SESSION['smartchat-Name'];

$accountID = $_SESSION['smartchat-AccountID'];
?>