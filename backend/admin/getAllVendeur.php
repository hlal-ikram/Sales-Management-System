<?php
// $result = $con->query("SELECT * FROM vendeur ");
include "../connect.php";
$data = array();
// $list = array();
$result = $con->query("SELECT v.Nomv, v.Prenomv, v.idV, u.service
FROM vendeur v
INNER JOIN users u ON v.idV = u.id
ORDER BY u.service DESC");
if ($result) {
    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        $data[] = $row;
    }
    // echo json_encode($data);
    echo json_encode(array("status" => "success", "data" => $data));

}
?>





