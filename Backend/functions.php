<?php
define("MB", 1048576);

function fillterRequest($requestname)
{
  return  htmlspecialchars(strip_tags($_POST[$requestname]));
}
function imageUpload($imageRequest)
{
  global $magErorr;
  $imagename    = rand(100 , 100000000) . $_FILES[$imageRequest]['name'];
  $imagetmp     = $_FILES[$imageRequest]['tmp_name'];
  $imagesize    = $_FILES[$imageRequest]['size'];
  $allowex      = array("jpg", "png", "gif", "mp3", "pdf" , "txt");
  $stingtoarray = explode(".", $imagename);
  $ext          = end($stingtoarray);
  $ext          = strtolower($ext);
  if (!empty($imagename) && !in_array($ext, $allowex)) {
    $magErorr[] = "File is empty of not supported";
  }
  if($imagesize  > 2 * MB){
    $magErorr[] = "Size Error" ;
  }
  if(empty($magErorr)){
    move_uploaded_file($imagetmp , "../upload/" . $imagename);
    return $imagename ; 
}else{
 return "fail" ; 
}
  }


  function deleteFile($dicrection , $imagename){
    if(file_exists($dicrection . "/". $imagename)){
      unlink($dicrection . "/". $imagename) ; 
    }
  }
  {
    function checkAuthenticate(){
      if (isset($_SERVER['PHP_AUTH_USER'])  && isset($_SERVER['PHP_AUTH_PW'])) {
    
        if ($_SERVER['PHP_AUTH_USER'] != "amryousef1995" ||  $_SERVER['PHP_AUTH_PW'] != "A@nbe123"){
            header('WWW-Authenticate: Basic realm="My Realm"');
            header('HTTP/1.0 401 Unauthorized');
            echo 'Page Not Found';
            exit;
        }
    } else {
        exit;
    }
    }
       
    }
