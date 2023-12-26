<?php
include "../connect.php";


$noteid = fillterRequest("id");
$notetitle = fillterRequest("title");
$notecontent = fillterRequest("content");
$imagename = fillterRequest("imagename");




if(isset($_FILES['file'])){
    deleteFile("../upload/", $imagename);
    $imagename = imageUpload("file");
    
}


$stmt = $con->prepare("UPDATE `notes` SET
 `notes_title`=?,
 `notes_content`=? , notes_image = ?
   WHERE notes_id =?");

$stmt->execute(array($notetitle, $notecontent, $imagename ,$noteid ));

$count = $stmt->rowCount();
if($count>0){
    echo json_encode(array("status" =>"sucess"));
}else{
    echo json_encode(array("status" =>"fail"));
}