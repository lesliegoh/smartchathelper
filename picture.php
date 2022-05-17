<?php
include_once("common/start.php");
include_once("common/session.php");

// add new image
if (isset($_POST['photoUpload'])) {

    $targetFolder = PATH_Storage($accountID, "1");

    $myImageFile = $_FILES['imageFile'];
    $errorMessage = CheckUploadFile($targetFolder, $myImageFile, true, false);

    if($errorMessage == "")
    {
        $tmpFilePath = $_FILES['imageFile']['tmp_name'];
        if ($tmpFilePath != "") {

            // destination file
            $destFilename = GenerateRandomFileName($_FILES['imageFile']['name']);
            $targetFile = $targetFolder . $destFilename;

            $result = move_uploaded_file($tmpFilePath, $targetFile);
            if($result)
            {
                // label image
                $cmd = "python3 -m py.labelphoto $targetFile";
                $exec = shell_exec($cmd);

                $imageLabel = $exec;

                $arr = array(
                    "accountID_FK" => $accountID,
                    "userID_FK" => $userID,
                    "message" => $destFilename,
                    "dateCreated" => MySQLDateTime("now"),
                    "isDeleted" => 0,
                    "isPicture" => 1,
                    "isFile" => 0,
                    "pictureLabel" => $imageLabel,
                    "fileSummary" => ""
                );

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
                AlertWindow("We have encountered an error uploading the Photo");
            }

            // delete file
            // unlink($targetFile);
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
<div class="p-0 m-0">Picture Labelling</div>
<div class="p-0 m-0" style="font-weight:normal; font-size: 10pt;">see how our smart chat helper labels and classifies each photo you upload to the chat</div>
</div>
</div>
</div>
</div>

<div class="container pt-5 px-0">
<div class="row">

<div class="col-md-6">
<?php
SetChat($conn, $accountID, $userID, false);

// upload photo
echo '<div class="row">';
echo '<div class="col-md-10">';

echo '<div class="custom-file mb-4">';
echo '<input type="file"  id="imageFile" name="imageFile" accept=".jpg,.jpeg,.png" onChange="makeFileList();">';
echo '<label class="custom-file-label" id="newFileList" for="imageFile">Choose file</label>';
echo '</div>';

echo '</div>';
echo '<div class="col-md-2 text-right">';

echo HTML_Button("photoUpload", "Upload", "btn btn-info", false, "", false, false);

echo '</div>';
echo '</div>';
?>
<small>
    <strong>NOTE</strong><br>
This current demo only allows a one way chat. To implement the full chat features with other users, please download our Github repo and implement the Smart Chat Helper on your servers.
<br><br>

</small>
</div>
<div class="col-md-6">
<h4>Uploaded Photos</h4>
<p>Pictures and images that were previously uploaded to this chat:</p>
<?php
$query = "SELECT * FROM messages WHERE accountID_FK = ? AND isDeleted = 0 AND isPicture = 1 ORDER BY dateCreated ASC";
$result = PDO_PreparedSelect_Array($conn, $query, array($accountID));
if($result)
{
    echo '<div class="row pt-3 px-3">';
    foreach($result as $row)
    {
        echo '<div class="col-md-2 text-center p-2 m-1" style="border: 1px solid #ccc">';

        $imgPath = PATH_Storage($accountID, 2).$row['message'];
        echo "<img src='$imgPath' style='height:70px; width:70px'>";
        
        echo '<p class="p-0 m-0">'.$row['pictureLabel'].'</p>';
        echo '</div>';
    }

    echo '</div>';
}
else
{
    echo '<div class="mt-3 p-4" style="background-color:#eee; color:#111; font-size:12pt">';
    echo "There are no photos in this chat";
    echo '</div>';
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
    function makeFileList() {
        var input = document.getElementById("imageFile");
        var label = document.getElementById("newFileList");

        label.innerText = input.files[0].name;
    }
</script>