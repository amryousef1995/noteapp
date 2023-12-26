<?php
include "../connect.php";


$username = fillterRequest("username");
$email = fillterRequest("email");
$password = fillterRequest("password");


$stmt = $con->prepare("INSERT INTO
 `users`(`username`, `email`, `password`)
 VALUES (? , ? , ?)");

$stmt->execute(array($username , $email , $password));

$count = $stmt->rowCount();
if($count>0){
    echo json_encode(array("status" =>"sucess"));
}else{
    echo json_encode(array("status" =>"fail"));
}