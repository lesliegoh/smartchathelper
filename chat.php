<?php
include_once("common/start.php");
include_once("common/session.php");

$textSummary = "";
if (isset($_POST['summarizeChat'])) {

    $cmd = "python3 -m py.summarizechat $accountID";
    $exec = shell_exec($cmd);

    $textSummary = $exec;
}

// add new chat
if (isset($_POST['newChat'])) {

    $arr = array(
        "accountID_FK" => $accountID,
        "userID_FK" => $userID,
        "message" => PrepareDBVariables('newChatMessage'),
        "dateCreated" => MySQLDateTime("now"),
        "isDeleted" => 0,
        "isPicture" => 0,
        "isFile" => 0,
        "pictureLabel" => "",
        "fileSummary" => ""
    );

    // validate
    $errorMessage = "";
    if(IsBlankField($arr['message']))
    {
        $errorMessage .= "Please enter a message\\n";
    }

    // save to database
    if ($errorMessage == "") {

        $conn->beginTransaction();

        $query = PDO_Query_Insert('messages', $arr);
        $result = PDO_PartialTransaction_Insert($conn, $query, $arr, false);

        if ($result) {

            $conn->commit();
            ReloadWindow();
        }
        else
        {
            $conn->rollback();
            AlertWindow("There has been a problem adding the new chat");
        }
    }
    else
    {
        AlertWindow($errorMessage);
    }
}
?>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<?php include("meta.php"); ?>
<title>The Smart Chat Helper | App</title>
</head>

<body>
<?php include("navbar.php"); ?>

<form method="post" enctype="multipart/form-data">
<main role="main">

<!-- Main jumbotron for a primary marketing message or call to action -->
<div class="jumbotron1">
<div class="container">
<div class="row">
<div class="col-md-12 p-0 pt-2">
<div class="p-0 m-0">Chat Summarization</div>
<div class="p-0 m-0" style="font-weight:normal; font-size: 10pt;">see how our smart chat helper summarizes messages that you have missed</div>
</div>
</div>
</div>
</div>

<div class="container pt-5 px-0">
<div class="row">

<div class="col-md-6">
<div class="card" style="border: 1px solid #ccc">
<div class="ps-container ps-theme-default ps-active-y" id="chat-content" style="overflow-y: scroll !important; height:400px !important;">
<?php
$query = "SELECT * FROM messages WHERE accountID_FK = ? AND isDeleted = 0 AND isPicture = 0 AND isFile = 0 ORDER BY dateCreated ASC";
$result = PDO_PreparedSelect_Array($conn, $query, array($accountID));
if($result)
{
    $isToday = false;
    foreach($result as $row)
    {
        // check whether it's today
        if(DisplayDate($row['dateCreated']) == DisplayDate(date("now")))
        {
            if(!$isToday)
            {
                echo '<div class="media media-meta-day">Today</div>';
                $isToday = true;
            }
        }

        if($row['userID_FK'] == $userID)
        {
            echo '<div class="media media-chat">';
            echo '<img class="avatar" src="https://img.icons8.com/color/36/000000/administrator-male.png" alt="...">';
            
        }
        else
        {
            echo '<div class="media media-chat media-chat-reverse">';
        }

        echo '<div class="media-body">';
        echo utf8_decode($row['message']);
        echo '<p class="meta"><time datetime="2018">'.DisplayDateTime($row['dateCreated']).'</time></p>';
        echo '</div>';

        echo '</div>';
    }
}
?>
<div class="ps-scrollbar-x-rail" style="left: 0px; bottom: 0px;"><div class="ps-scrollbar-x" tabindex="0" style="left: 0px; width: 0px;"></div></div><div class="ps-scrollbar-y-rail" style="top: 0px; height: 0px; right: 2px;"><div class="ps-scrollbar-y" tabindex="0" style="top: 0px; height: 2px;"></div></div></div>

<div class="publisher bt-1 border-light">
<img class="avatar avatar-xs" src="https://img.icons8.com/color/36/000000/administrator-male.png" alt="...">
<input name="newChatMessage" class="publisher-input" type="text" placeholder="Write something">
<?php
echo HTML_Button("newChat", '<i class="fa fa-paper-plane text-primary"></i>', "", false, "", false, false);
?>
</div>

</div>
<small>
    <strong>NOTE</strong><br>
This current demo only allows a one way chat. To implement the full chat features with other users, please download our Github repo and implement the Smart Chat Helper on your servers.
<br><br>
The Smart Chat Summarization function will summarize the entire conversation thread as a demonstration. If you do not see your new messages being summarized, it means that your new sentences are not of higher importance than the existing ones.
</small>
</div>
<div class="col-md-6">
<h4>Summarize Chat</h4>
<p>See how our chat summarization works by clicking on the button below:</p>
<?php
echo HTML_Button("summarizeChat", "Summarize Chat Messages", "btn btn-info mb-3", false, "", false, false);

// show text summary
if($textSummary != "")
{
    $textSummary = substr($textSummary, 1, -1);

    $arrSummary = explode("', '", $textSummary);
    foreach($arrSummary as $sentence)
    {
        echo '<div class="mt-3 p-4" style="background-color:#eee; color:#111; font-size:12pt">';
        echo nl2br($sentence);
        echo '</div>';
    }
}
?>
</div>
</div>
</div>
</main>
</form>
<?php include("footer.php"); ?>
</body>
</html>
<script>
var objDiv = document.getElementById("chat-content");
objDiv.scrollTop = objDiv.scrollHeight;
</script>