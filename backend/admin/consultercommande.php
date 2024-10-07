<?php
include "../connect.php";

$vendeurID = filterRequest('vendeurID'); // ID du vendeur sélectionné
$dateSaisie = filterRequest('dateSaisie'); // Date saisie par le responsable

$result = $con->query("
    SELECT CONCAT(cl.Nomc, ' ', cl.Prenomc) AS client, cl.Adressec,
           GROUP_CONCAT(CONCAT( '(Nom:',p.Nomp,' ',p.Typep, ' ',p.Prixp, ')' , '(Quantité:', q.Quantite, ')' , '(Prix: ', p.Prixp * q.Quantite * p.Typep,')') SEPARATOR ';') AS produits,
           pf.prixR AS prix_commande,
           s.Noms AS secteur, a.VehiculeID  
    FROM secteur s, affectation a, client cl, produit p, quantite q, facture f, factureprix pf
    WHERE s.SecteurID = cl.SecteurID
      AND s.SecteurID = a.SecteurID
      AND a.VendeurID = f.VendeurID
      AND f.FactureID = q.FactureID
      AND q.ProduitID = p.ProduitID 
      AND f.ClientID = cl.ClientID
      AND pf.FactureID=f.FactureID
      AND a.VendeurID = $vendeurID
      AND a.Datea = '$dateSaisie'
      AND f.Datef = '$dateSaisie'
    GROUP BY cl.ClientID
");

if ($result) {
    $commandes = array();

    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        $commandes[] = $row; 
      
   
    }
    echo json_encode( array("status" => "success", "data" => $commandes));
  
}  