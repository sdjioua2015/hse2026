# HSE2026 - Guide d'installation

## Prérequis

- WinDev 2025 ou supérieur
- SQL Server 2019 ou supérieur
- .NET Framework 4.7.2+
- Windows 7 SP1 ou supérieur

## Étapes d'installation

### 1. Préparation de la base de données

1. Ouvrir SQL Server Management Studio
2. Créer une nouvelle base de données : `HSE_DB`
3. Exécuter le script :
   ```
   database/HSE_DB_Production.sql
   ```
4. Vérifier la création des tables et des données de test

### 2. Importation du projet WinDev

1. Ouvrir WinDev 2025
2. Aller à Fichier > Ouvrir
3. Sélectionner `src/WinDev/hse2026.prj`
4. Attendre la compilation complète

### 3. Configuration de la connexion

1. Éditer les paramètres de connexion SQL Server
2. Serveur : localhost (ou votre serveur SQL Server)
3. Base de données : HSE_DB
4. Authentification : SQL ou Windows

### 4. Test du login

1. Compiler le projet
2. Exécuter l'application
3. Utiliser les identifiants :
   - Login : `admin`
   - Mot de passe : `admin123`

### 5. Déploiement

1. Générer l'exécutable : Projet > Générer l'exécutable
2. Choisir le dossier de distribution
3. Créer le fichier d'installation
4. Distribuer aux utilisateurs

## Structure du projet

```
hse2026/
├── database/
│   └── HSE_DB_Production.sql
├── docs/
│   ├── guide_developpement.md
│   └── INSTALL.md
├── src/
│   └── WinDev/
│       ├── hse2026.prj
│       ├── HSE2026_PRODUCTION_COMPLETE.wl
│       ├── HSE2026_THEME_VISUEL.wl
│       ├── HSE2026_DASHBOARD.wl
│       └── README_WINDEV.md
├── mockups/
│   └── dashboard-kpi-industrial.svg
└── README.md
```

## Comptes d'essai

| Login | Mot de passe | Profil | Accès |
|-------|-------------|--------|-------|
| admin | admin123 | Admin | Tous les modules |
| hse | hse123 | Responsable HSE | Incidents, Audits, Actions, Rapports |
| superviseur | sup123 | Superviseur | Incidents, Actions, Rapports |
| user | user123 | Utilisateur | Consultation et saisie |

## Résolution des problèmes

### Erreur de connexion SQL Server
- Vérifier que SQL Server est en cours d'exécution
- Vérifier les paramètres de connexion
- Vérifier les droits de l'utilisateur SQL

### Erreur de compilation WinDev
- Vérifier la version de WinDev (2025 minimum)
- Vérifier les dépendances .NET
- Supprimer le cache WinDev et recompiler

### Fenêtres qui ne s'ouvrent pas
- Vérifier que tous les fichiers .wl sont importés
- Vérifier les noms des contrôles dans les procédures
- Vérifier les logs de compilation

## Support

Pour toute question ou problème :
- Consulter la documentation dans `docs/`
- Vérifier les fichiers sources dans `src/WinDev/`
- Exécuter les tests unitaires

## Licence

Projet de gestion HSE industriel - Version production
