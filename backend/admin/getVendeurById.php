<?php
include "../connect.php";
 $idv=filterRequest("idv");
$list = array();
$result = $con->query("SELECT v.* ,u.imageU FROM vendeur v, users u where idV='$idv' and v.idV=u.id");
if ($result) {
    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        $list[] = $row;
    }
    echo json_encode(array("status" => "success", "data" => $list));
}
?>
