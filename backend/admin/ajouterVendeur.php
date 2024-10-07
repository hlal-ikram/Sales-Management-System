<?php

include "../connect.php";

$id = filterRequest("id");
//$cin = filterRequest("cin");
$cin=sha1($_POST['cin']);
 $type = "vendeur";
 $nomv = filterRequest("nomv");
 $prenomv = filterRequest("prenomv");
 $telev = filterRequest("telev");



$stmt = $con->prepare("SELECT * FROM users WHERE id = ?  ");
$stmt->execute(array($id));
$count = $stmt->rowCount();
if ($count > 0) {
    printFailure("id ");
} else {

    $data = array(
        "id" => $id,
        "cin" =>  $cin,
        "type" => $type,
      
    );
    insertDatasansSu("users" , $data) ; 

    $datav = array(
        "idV" => $id,
        "Cinv" =>  $cin,
        "Nomv" => $nomv,
        "Prenomv" => $prenomv,
        "Telephonev" => $telev,

      
    );
    insertData("vendeur" , $datav) ; 
}
