<?php
include "../connect.php";



$noteid = fillterRequest("id");
$imagename = fillterRequest("imagename");


$stmt = $con->prepare("DELETE FROM notes WHERE notes_id = ?");

$stmt->execute(array($noteid));

$count = $stmt->rowCount();
if($count>0){
    deleteFile("../upload/", $imagename);
    echo json_encode(array("status" =>"sucess"));
}else{
    echo json_encode(array("status" =>"fail"));
}