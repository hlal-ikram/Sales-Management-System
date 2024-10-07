<?php
include "../connect.php";
 $idv=filterRequest("idv");
$list = array();
$result = $con->query("SELECT *  FROM  users  where id='$idv' ");
if ($result) {
    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        $list[] = $row;
    }
    echo json_encode(array("status" => "success", "data" => $list));
}
?>
