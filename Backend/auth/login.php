<?php
include "../connect.php";



$useremail = fillterRequest('email');
$userpassword = fillterRequest('password');


$stmt = $con->prepare("SELECT * FROM users WHERE `email` = ?  AND `password` = ? ");

$stmt->execute(array($useremail , $userpassword));
$data = $stmt->fetch(PDO::FETCH_ASSOC);
$count = $stmt->rowCount();
if($count>0){
    echo json_encode(array("status" =>"sucess" , "data" =>$data));
}else{
    echo json_encode(array("status" =>"fail" ));
}