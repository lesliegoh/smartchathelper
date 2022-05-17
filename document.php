<?php
include_once("common/start.php");
include_once("common/session.php");

// add new file
if (isset($_POST['fileUpload'])) {

    $targetFolder = PATH_Storage($accountID, "1");

    $mypdfFile = $_FILES['pdfFile'];
    $errorMessage = CheckUploadFile($targetFolder, $mypdfFile, false, false);

    if($errorMessage == "")
    {
        $tmpFilePath = $_FILES['pdfFile']['tmp_name'];
        if ($tmpFilePath != "") {

            // destination file
            $destFilename = $_FILES['pdfFile']['name'];
            $targetFile = $targetFolder . $destFilename;

            $result = move_uploaded_file($tmpFilePath, $targetFile);
            if($result)
            {
                // summarize pdf
                $cmd = "python3 -m py.summarizepdf $targetFile";
                $exec = shell_exec($cmd);

                $fileSummary = $exec;

                $arr = array(
                    "accountID_FK" => $accountID,
                    "userID_FK" => $userID,
                    "message" => $destFilename,
                    "dateCreated" => MySQLDateTime("now"),
                    "isDeleted" => 0,
                    "isPicture" => 0,
                    "isFile" => 1,
                    "pictureLabel" => "",
                    "fileSummary" => $fileSummary
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
                AlertWindow("We have encountered an error uploading the File");
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
<div class="p-0 m-0">Document Summary (PDF)</div>
<div class="p-0 m-0" style="font-weight:normal; font-size: 10pt;">see how our smart chat helper summarizes a pdf document</div>
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
echo '<input type="file" id="pdfFile" name="pdfFile" accept=".pdf" onChange="makeFileList();">';
echo '<label class="custom-file-label" id="newFileList" for="pdfFile">Choose file</label>';
echo '</div>';

echo '</div>';
echo '<div class="col-md-2 text-right">';

echo HTML_Button("fileUpload", "Upload", "btn btn-info", false, "", false, false);

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
<h4>Uploaded Documents</h4>
<p>PDF Files and Documents that were previously uploaded to this chat:</p>
<?php
$query = "SELECT * FROM messages WHERE accountID_FK = ? AND isDeleted = 0 AND isFile = 1 ORDER BY dateCreated ASC";
$result = PDO_PreparedSelect_Array($conn, $query, array($accountID));
if($result)
{
    $i = 1;

    echo '<div class="row pt-3 px-3">';
    echo '<div class="accordion" id="accordionExample">';
    foreach($result as $row)
    {
        echo '<div class="card mb-1">';
        echo '<div class="card-header p-0" id="heading'.$i.'">';

        echo '<div class="media" data-toggle="collapse" data-target="#collapse'.$i.'" aria-expanded="true" aria-controls="collapse'.$i.'" style="cursor:pointer">';
        echo '<i class="far fa-file-pdf fa-fw fa-3x text-info ml-0 pl-0"></i>';
        echo '<div class="media-body">';
        echo '<h5 class="mt-0">'.$row['message'].'</h5>';
        echo '</div>';
        echo '<i class="fas fa-chevron-down fa-fw pl-4 pt-1 pr-4"></i>';
        echo '</div>';

        echo '</div>';
        echo '<div id="collapse'.$i.'" class="collapse" aria-labelledby="heading'.$i.'" data-parent="#accordionExample">';
        echo '<div class="card-body">';
        echo '<p>'.$row['fileSummary'].'</p>';
        echo '</div>';

        echo '</div>';
        echo '</div>';

        $i++;
    }
    echo '</div>';
    echo '</div>';
}
else
{
    echo '<div class="mt-3 p-4" style="background-color:#eee; color:#111; font-size:12pt">';
    echo "There are no documents in this chat";
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
        var input = document.getElementById("pdfFile");
        var label = document.getElementById("newFileList");

        label.innerText = input.files[0].name;
    }
</script>