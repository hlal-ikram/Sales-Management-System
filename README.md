# 🌾 Système de Gestion des Ventes 🌾

Une application mobile et desktop complète développée pour **Minoterie Othmane**, visant à rationaliser les processus de vente et le suivi des performances. Ce système permet aux responsables de superviser efficacement le personnel de vente, de gérer les inventaires de produits, d'assigner des secteurs et des véhicules aux vendeurs, et de suivre les commandes et les performances. L'application offre aux vendeurs une interface intuitive pour gérer les clients, passer des commandes et générer des factures, avec une intégration de géolocalisation en temps réel.

---

## 🚀 Fonctionnalités

### Pour les Responsables :
- **👥 Gestion des Employés** : Ajouter, modifier, bloquer/débloquer les vendeurs et autres employés.
- **📦 Gestion des Produits** : Ajouter, mettre à jour et supprimer des produits avec images et descriptions.
- **🚗 Assignation de Secteurs et de Véhicules** : Assigner des vendeurs à des secteurs et véhicules spécifiques pour leurs itinéraires de vente.
- **📊 Supervision des Commandes** : Surveiller les commandes de vente et les métriques de performance des vendeurs.
- **📅 Gestion du Planning** : Visualiser le planning quotidien des activités des vendeurs.

### Pour les Vendeurs :
- **🏷️ Gestion des Clients** : Ajouter de nouveaux clients avec localisation GPS en temps réel.
- **📝 Passage de Commandes** : Gérer les commandes de produits avec une limite sur la capacité de chargement du véhicule.
- **🧾 Génération de Factures** : Générer et imprimer automatiquement des factures pour les clients.
- **📈 Suivi des Performances** : Consulter les secteurs prévus, les itinéraires à venir et les tâches de livraison.

---

## 🛠️ Technologies Utilisées
- **Frontend** : Flutter (Dart)
- **Backend** : PHP (avec API REST)
- **Base de Données** : MySQL
- **Géolocalisation** : Intégrée avec le GPS pour la capture d'adresse client en temps réel.

---

## 📥 Installation

### Prérequis :
- Installer [Flutter](https://flutter.dev/docs/get-started/install) et s'assurer que Dart est configuré.
- Installer [XAMPP](https://www.apachefriends.org/index.html) pour un environnement local PHP et MySQL.

### Étapes :
1. **Cloner le dépôt :**
   ```bash
   git clone https://github.com/hlal-ikram/Sales-Management-System.git
2. **Naviguer vers le répertoire du projet :**
    ```bash
    cd Sales-Management-System
3. **Configurer le backend :**
    - Déplacer les fichiers PHP dans le dossier htdocs de votre XAMPP.
    - Démarrer Apache et MySQL via XAMPP.
    - Créer la base de données nécessaire et importer le fichier SQL fourni dans le dépôt.
4. **Configurer l'application Flutter :**
    - Naviguer vers le répertoire du projet Flutter :
       ```bash
       cd my_pfe-main
       ```
    - Installer les dépendances Flutter :
       ```bash
       flutter pub get
       ```
    - Exécuter l'application :
       ```bash
       flutter run
       ```
## 📝 Utilisation
**Pour les Responsables :**
 - Se connecter au système pour gérer les produits, les vendeurs et les commandes.
 - Assigner des secteurs et des véhicules aux vendeurs pour une allocation efficace des tâches.
 <br>

**Pour les Vendeurs :**
 - Utiliser l'application mobile pour consulter les itinéraires assignés, ajouter des clients, passer des commandes et générer des factures.

