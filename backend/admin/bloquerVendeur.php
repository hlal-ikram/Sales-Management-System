<?php 


     
include "../connect.php";

$id=filterRequest("id");
$action = filterRequest('action');

if ($action == '0') {
    // Requête pour bloquer le vendeur
    $query = "UPDATE users SET service = 0 WHERE id = ?";
} elseif ($action ==' 1') {
    // Requête pour débloquer le vendeur
    $query = "UPDATE users SET service = 1 WHERE id = ?";
}


$stmt = $con->prepare($query);
$stmt->bindParam(1, $id);
$stmt->execute();
$count = $stmt->rowCount();


if ($count > 0) {
    echo json_encode(array("status" => "success"));
} else {
    echo json_encode(array("status" => "failure"));
}


?>

