<?php
include "../connect.php";



$id = fillterRequest("id");



$stmt = $con->prepare("SELECT * FROM notes WHERE `notes_users` =?  ");

$stmt->execute(array($id));
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

$count = $stmt->rowCount();
if($count>0){
    echo json_encode(array("status" =>"sucess" , "data" =>$data));
}else{
    echo json_encode(array("status" =>"fail"));
}