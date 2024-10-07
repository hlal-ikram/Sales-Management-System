<?php

include '../connect.php';

$table = "users";
$id = filterRequest("id");

//$imageold  = filterRequest("imageold");

$imageU =imageUpload("../upload/users", "files");
//  deleteFile("../../upload/users"  ,$imageold) ; 
    $data = array(
     "imageU"=> $imageU,
    );
updateData($table, $data, "id='$id'");
?>   




