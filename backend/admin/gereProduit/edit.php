<?php

include '../../connect.php';

$table = "produit";

$ProduitID = filterRequest("ProduitID");

$Nomp = filterRequest("Nomp");
$Prixp = filterRequest("Prixp"); 
$Typep = filterRequest("Typep"); 

$imageold  = filterRequest("imageold");


$Imagep =   imageUpload("../../upload/produits", "files");

if ($Imagep == "empty") {
    $data = array(
        "Nomp" => $Nomp,
        "PrixP" => $Prixp,
             "Typep" => $Typep,
    );
} else {
   deleteFile("../../upload/produits"  ,$imageold) ; 
    $data = array(
        "Nomp" => $Nomp,
        "PrixP" => $Prixp,
       "Typep" => $Typep,
        "Imagep"   => $Imagep,
    );
}

updateData($table, $data, "ProduitID = $ProduitID");
?>
