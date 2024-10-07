<?php

include "../connect.php";

$id = filterRequest("id");
//$cin = filterRequest("cin");
$cin=sha1($_POST['cin']);
 $type = "admin";

$stmt = $con->prepare("SELECT * FROM users WHERE id = ? ");
$stmt->execute(array($id));
$count = $stmt->rowCount();
if ($count > 0) {
    printFailure("id");
} else {
    $data = array(
        "id" => $id,
        "cin" =>  $cin,
        "type" => $type,
      
    );
    insertData("users" , $data) ; 
}
