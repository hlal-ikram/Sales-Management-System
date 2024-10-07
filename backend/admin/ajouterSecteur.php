<?php

include "../connect.php";

$noms = filterRequest("noms");
    $datav = array(
        "Noms" => $noms,
    );
    insertData("secteur" , $datav) ; 

