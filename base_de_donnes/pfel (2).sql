-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : jeu. 20 juil. 2023 à 20:57
-- Version du serveur : 10.4.25-MariaDB
-- Version de PHP : 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `pfel`
--

-- --------------------------------------------------------

--
-- Structure de la table `affectation`
--

CREATE TABLE `affectation` (
  `Datea` date DEFAULT NULL,
  `AffectationID` int(11) NOT NULL,
  `VehiculeID` varchar(50) DEFAULT NULL,
  `VendeurID` int(11) DEFAULT NULL,
  `SecteurID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `affectation`
--

INSERT INTO `affectation` (`Datea`, `AffectationID`, `VehiculeID`, `VendeurID`, `SecteurID`) VALUES
('2023-06-12', 89, '5432hh', 92, 3),
('2023-06-12', 90, '5432hh', 92, 1),
('2023-06-13', 91, '5432hh', 92, 1),
('2023-06-14', 92, '5432hh', 92, 3),
('2023-06-16', 93, 'GT66', 92, 1),
('2023-06-17', 100, '5432hh', 92, 1),
('2023-06-18', 101, 'GT66', 92, 3),
('2023-06-19', 102, '5432hh', 92, 3),
('2023-06-22', 112, 'tTTT66897', 92, 2),
('2023-06-20', 113, 'tTTT66897', 95, 2),
('2023-06-20', 115, 'tTTT66897', 94, 1),
('2023-06-20', 116, '5432hh', 94, 1),
('2023-06-23', 117, '5432hh', 92, 2),
('2023-06-23', 118, 'GT66', 94, 1),
('2023-07-20', 119, '5432hh', 92, 1);

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

CREATE TABLE `client` (
  `Adressec` varchar(150) DEFAULT NULL,
  `Nomc` varchar(50) DEFAULT NULL,
  `Prenomc` varchar(50) DEFAULT NULL,
  `ClientID` int(11) NOT NULL,
  `SecteurID` int(11) DEFAULT NULL,
  `telephone` varchar(50) DEFAULT NULL,
  `etat` int(50) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`Adressec`, `Nomc`, `Prenomc`, `ClientID`, `SecteurID`, `telephone`, `etat`) VALUES
('zen9a 3 appartement 4 numero 43', 'wdghiri', 'mohammed', 1, 1, '0566667905', 1),
('zen9a adarisa', 'zerhoni', 'soufian', 2, 1, '08888888', 1),
('DERB OMAR', 'HACHMI', 'MJID', 3, 2, '0999996745', 1),
('zen9a 3', 'SALHI', 'IMAD', 4, 2, '07548765443', 1),
('SECTEUR A', 'FAHD', 'AMIR', 5, 3, '07555555555', 1),
('1600 Amphitheatre Pkwy, Mountain View, 94043', 'mansori', 'mohammed', 28, 3, '069999999', 1),
('1600 Amphitheatre Pkwy, Mountain View, 94043', 'SEFRIIWI', 'HMDI', 29, 5, '066666666', 1),
('Faculté des Sciences et Techniques de Fès B.P. 2202 – Route d’Imouzzer، Fes, Fes, ', 'HMDI', 'YAZID', 45, 4, '0612345678', 1),
('Faculté des Sciences et Techniques de Fès B.P. 2202 – Route d’Imouzzer، Fes, Fes, ', 'lotfi', 'yahya', 50, 3, '0647986321', 1),
('Faculté des Sciences et Techniques de Fès B.P. 2202 – Route d’Imouzzer، Fes, Fes, ', 'OTHMANI', 'OTHMAN', 51, 2, '0567894321', 1),
('Faculté des Sciences et Techniques de Fès B.P. 2202 – Route d’Imouzzer، Fes, Fes, ', 'hasan', 'oii', 53, 2, '0698824759', 1);

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

CREATE TABLE `commande` (
  `Datec` date DEFAULT NULL,
  `CommandeID` int(11) NOT NULL,
  `VendeurID` int(11) DEFAULT NULL,
  `VehiculeID` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `commande`
--

INSERT INTO `commande` (`Datec`, `CommandeID`, `VendeurID`, `VehiculeID`) VALUES
('2023-06-23', 21, 92, '5432hh'),
('2023-07-20', 22, 92, '5432hh');

-- --------------------------------------------------------

--
-- Structure de la table `commandetonnage`
--

CREATE TABLE `commandetonnage` (
  `CommandeID` int(11) NOT NULL,
  `tonnagedepart` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `date`
--

CREATE TABLE `date` (
  `DateID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `facture`
--

CREATE TABLE `facture` (
  `Datef` date DEFAULT NULL,
  `FactureID` int(11) NOT NULL,
  `ClientID` int(11) DEFAULT NULL,
  `VendeurID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `facture`
--

INSERT INTO `facture` (`Datef`, `FactureID`, `ClientID`, `VendeurID`) VALUES
('2023-06-23', 5, 4, 92);

-- --------------------------------------------------------

--
-- Structure de la table `factureprix`
--

CREATE TABLE `factureprix` (
  `FactureID` int(11) NOT NULL,
  `prix` float NOT NULL,
  `prixR` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `factureprix`
--

INSERT INTO `factureprix` (`FactureID`, `prix`, `prixR`) VALUES
(1, 115, 115),
(2, 180, 180),
(3, 20, 20),
(4, 20, 20),
(5, 180, 180);

-- --------------------------------------------------------

--
-- Structure de la table `produit`
--

CREATE TABLE `produit` (
  `Nomp` varchar(50) DEFAULT NULL,
  `Prixp` double(10,2) DEFAULT NULL,
  `Typep` int(11) DEFAULT NULL,
  `ProduitID` int(11) NOT NULL,
  `Imagep` varchar(255) DEFAULT NULL,
  `etat` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `produit`
--

INSERT INTO `produit` (`Nomp`, `Prixp`, `Typep`, `ProduitID`, `Imagep`, `etat`) VALUES
('Semoule grosse', 3.00, 25, 28, '26001.jpg', 1),
('Semoule groose ', 8.00, 10, 29, '77292.jpg', 1),
('SEmoule fine', 5.00, 5, 30, '51853.jpg', 1),
('Finot', 3.00, 10, 31, '25264.jpg', 1),
('Farine complete', 2.00, 5, 32, '16275.jpg', 1),
('FARINE PREMIER', 6.00, 5, 33, '50438.jpg', 1),
('FARINEE BLU', 12.50, 5, 34, '6889FARINE NORMALE.jpg', 0);

-- --------------------------------------------------------

--
-- Structure de la table `quantite`
--

CREATE TABLE `quantite` (
  `Quantite` int(11) DEFAULT NULL,
  `QuantiteID` int(11) NOT NULL,
  `ProduitID` int(11) DEFAULT NULL,
  `FactureID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `quantite`
--

INSERT INTO `quantite` (`Quantite`, `QuantiteID`, `ProduitID`, `FactureID`) VALUES
(3, 1, 32, 1),
(2, 2, 31, 1),
(1, 3, 30, 1),
(3, 4, 33, 2),
(3, 5, 31, 2),
(2, 6, 32, 3),
(2, 7, 32, 4),
(3, 8, 32, 5),
(3, 9, 33, 5),
(2, 10, 31, 5);

-- --------------------------------------------------------

--
-- Structure de la table `quantitecom`
--

CREATE TABLE `quantitecom` (
  `Quantite` int(11) NOT NULL,
  `QuantiteID` int(11) NOT NULL,
  `ProduitID` int(11) NOT NULL,
  `CommandeID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `quantitecom`
--

INSERT INTO `quantitecom` (`Quantite`, `QuantiteID`, `ProduitID`, `CommandeID`) VALUES
(5, 105, 32, 21),
(2, 106, 33, 21),
(38, 107, 28, 21),
(7, 108, 32, 22);

-- --------------------------------------------------------

--
-- Structure de la table `secteur`
--

CREATE TABLE `secteur` (
  `Noms` varchar(50) DEFAULT NULL,
  `SecteurID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `secteur`
--

INSERT INTO `secteur` (`Noms`, `SecteurID`) VALUES
('wislan', 1),
('majat', 2),
('hajeb', 3),
('hamriya', 4),
('lehdim', 5);

-- --------------------------------------------------------

--
-- Structure de la table `string`
--

CREATE TABLE `string` (
  `StringID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` varchar(155) NOT NULL,
  `cin` varchar(155) NOT NULL,
  `service` int(10) NOT NULL DEFAULT 1,
  `type` varchar(10) NOT NULL,
  `imageU` varchar(200) DEFAULT 'null.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `cin`, `service`, `type`, `imageU`) VALUES
('hanane23', '28be40a6b112895079c1106c62d6a242b05b2e99', 1, 'admin', '7396AVATAR3.jpg'),
('1234', '2abd55e001c524cb2cf6300a89ca6366848a77d5', 0, 'vendeur', 'null.png'),
('SOBHI', '3244f8e7767708d7e5e6412a3740293ea192b10e', 1, 'vendeur', 'null.png'),
('YAZIDI', '4a5e4a46388181774b883370a55c698bc046df8e', 1, 'vendeur', 'null.png'),
('AYMANEE23', '8cb2237d0679ca88db6464eac60da96345513964', 1, 'vendeur', 'null.png'),
('ffff7777', 'eceb2b4fbd3ef6c65cd11fa39122f5de4f53dd65', 0, 'vendeur', 'null.png'),
('ikram23', 'f583e206cc5800d5f37340e4b010ba6efcb41139', 1, 'vendeur', 'null.png');

-- --------------------------------------------------------

--
-- Structure de la table `vehicule`
--

CREATE TABLE `vehicule` (
  `Tonagemax` double(10,2) DEFAULT NULL,
  `VehiculeID` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `vehicule`
--

INSERT INTO `vehicule` (`Tonagemax`, `VehiculeID`) VALUES
(1000.00, '5432hh'),
(56.00, 'tTTT66897'),
(88.00, 'GT66');

-- --------------------------------------------------------

--
-- Structure de la table `vendeur`
--

CREATE TABLE `vendeur` (
  `Cinv` varchar(50) NOT NULL,
  `Nomv` varchar(50) DEFAULT NULL,
  `Prenomv` varchar(50) DEFAULT NULL,
  `Telephonev` varchar(50) DEFAULT NULL,
  `VendeurID` int(11) NOT NULL,
  `idV` varchar(155) NOT NULL,
  `service` int(10) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `vendeur`
--

INSERT INTO `vendeur` (`Cinv`, `Nomv`, `Prenomv`, `Telephonev`, `VendeurID`, `idV`, `service`) VALUES
('f583e206cc5800d5f37340e4b010ba6efcb41139', 'hlal', 'ikram', '0608390714', 92, 'ikram23', 1),
('4a5e4a46388181774b883370a55c698bc046df8e', 'yazidi', 'marwa', '0698741279', 93, 'YAZIDI', 1),
('3244f8e7767708d7e5e6412a3740293ea192b10e', 'SOBHI', 'MONIR', '0756321579', 94, 'SOBHI', 1),
('eceb2b4fbd3ef6c65cd11fa39122f5de4f53dd65', 'Lehlo', 'omar', '0685432178', 95, 'ffff7777', 1),
('2abd55e001c524cb2cf6300a89ca6366848a77d5', 'tarik', 'lmoayid', '0765136890', 96, '1234', 1),
('8cb2237d0679ca88db6464eac60da96345513964', 'aymane', 'aymaeee', '0678954328', 97, 'AYMANEE23', 1);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `affectation`
--
ALTER TABLE `affectation`
  ADD PRIMARY KEY (`AffectationID`),
  ADD KEY `FK_Affectation_Secteur` (`SecteurID`);

--
-- Index pour la table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`ClientID`),
  ADD KEY `FK_Client_Secteur` (`SecteurID`),
  ADD KEY `idx_ClientID` (`ClientID`);

--
-- Index pour la table `commande`
--
ALTER TABLE `commande`
  ADD PRIMARY KEY (`CommandeID`),
  ADD KEY `FK_Commande_saisi` (`VendeurID`),
  ADD KEY `FK_Commande_charger` (`VehiculeID`);

--
-- Index pour la table `date`
--
ALTER TABLE `date`
  ADD PRIMARY KEY (`DateID`);

--
-- Index pour la table `facture`
--
ALTER TABLE `facture`
  ADD PRIMARY KEY (`FactureID`),
  ADD KEY `FK_Facture_effectue` (`ClientID`),
  ADD KEY `FK_Facture_enregister` (`VendeurID`);

--
-- Index pour la table `produit`
--
ALTER TABLE `produit`
  ADD PRIMARY KEY (`ProduitID`);

--
-- Index pour la table `quantite`
--
ALTER TABLE `quantite`
  ADD PRIMARY KEY (`QuantiteID`),
  ADD KEY `FK_Quantite_Produit` (`ProduitID`),
  ADD KEY `FK_Quantite_Facture` (`FactureID`);

--
-- Index pour la table `quantitecom`
--
ALTER TABLE `quantitecom`
  ADD PRIMARY KEY (`QuantiteID`);

--
-- Index pour la table `secteur`
--
ALTER TABLE `secteur`
  ADD PRIMARY KEY (`SecteurID`);

--
-- Index pour la table `string`
--
ALTER TABLE `string`
  ADD PRIMARY KEY (`StringID`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`cin`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Index pour la table `vendeur`
--
ALTER TABLE `vendeur`
  ADD PRIMARY KEY (`VendeurID`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `affectation`
--
ALTER TABLE `affectation`
  MODIFY `AffectationID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT pour la table `client`
--
ALTER TABLE `client`
  MODIFY `ClientID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT pour la table `commande`
--
ALTER TABLE `commande`
  MODIFY `CommandeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT pour la table `facture`
--
ALTER TABLE `facture`
  MODIFY `FactureID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `produit`
--
ALTER TABLE `produit`
  MODIFY `ProduitID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT pour la table `quantite`
--
ALTER TABLE `quantite`
  MODIFY `QuantiteID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `quantitecom`
--
ALTER TABLE `quantitecom`
  MODIFY `QuantiteID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT pour la table `secteur`
--
ALTER TABLE `secteur`
  MODIFY `SecteurID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `vendeur`
--
ALTER TABLE `vendeur`
  MODIFY `VendeurID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `affectation`
--
ALTER TABLE `affectation`
  ADD CONSTRAINT `FK_Affectation_Secteur` FOREIGN KEY (`SecteurID`) REFERENCES `secteur` (`SecteurID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_Affectation_Vendeur` FOREIGN KEY (`VendeurID`) REFERENCES `vendeur` (`VendeurID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_Affectation_lier` FOREIGN KEY (`VehiculeID`) REFERENCES `vehicule` (`VehiculeID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `client`
--
ALTER TABLE `client`
  ADD CONSTRAINT `FK_Client_Secteur` FOREIGN KEY (`SecteurID`) REFERENCES `secteur` (`SecteurID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `commande`
--
ALTER TABLE `commande`
  ADD CONSTRAINT `FK_Commande_charger` FOREIGN KEY (`VehiculeID`) REFERENCES `vehicule` (`VehiculeID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_Commande_saisi` FOREIGN KEY (`VendeurID`) REFERENCES `vendeur` (`VendeurID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `facture`
--
ALTER TABLE `facture`
  ADD CONSTRAINT `FK_Facture_effectue` FOREIGN KEY (`ClientID`) REFERENCES `client` (`ClientID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_Facture_enregister` FOREIGN KEY (`VendeurID`) REFERENCES `vendeur` (`VendeurID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `quantite`
--
ALTER TABLE `quantite`
  ADD CONSTRAINT `FK_Quantite_Facture` FOREIGN KEY (`FactureID`) REFERENCES `facture` (`FactureID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_Quantite_Produit` FOREIGN KEY (`ProduitID`) REFERENCES `produit` (`ProduitID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `vendeur`
--
ALTER TABLE `vendeur`
  ADD CONSTRAINT `vendeur_users_1` FOREIGN KEY (`idV`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `vendeur_users_c` FOREIGN KEY (`Cinv`) REFERENCES `users` (`cin`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
