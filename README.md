# HSE2026

Application de gestion HSE (Hygiène, Sécurité, Environnement) en architecture Client/Serveur, pensée pour WinDev 2025 + SQL Server.

## Objectif

Le système permet de gérer de manière centralisée :
- incidents et accidents
- audits et inspections
- actions correctives
- risques et criticité
- habilitations et formations
- documents et procédures
- rapports et dashboards KPI
- administration et sécurité

## Architecture

- Client : WinDev 2025
- Base de données : SQL Server
- Modèle : Client/Serveur
- Sécurité : profils, droits et journaux
- Reporting : Excel / PDF

## Dossiers

- `database/` : scripts SQL de base de données
- `docs/` : spécification et guide de développement
- `src/WinDev/` : modules WLanguage / code d’écran
- `mockups/` : maquettes visuelles des écrans

## Comptes d’essai

- Admin : `admin` / `admin123`
- Responsable HSE : `hse` / `hse123`
- Superviseur : `superviseur` / `sup123`
- Utilisateur : `user` / `user123`

## Modules de la version production

- Tableau de bord KPI
- Gestion du personnel
- Gestion des incidents
- Gestion des audis
- Gestion des actions
- Gestion des risques
- Gestion des habilitations
- Gestion des documents
- Rapports Excel / PDF
- Administration utilisateurs et droits

## Base de données

Le script principal est :
- `database/HSE_DB_Production.sql`

## Exemple d’écran WinDev

- `src/WinDev/FEN_Dashboard_KPI_Complete.txt`
- `src/WinDev/FEN_Incidents_Industrial.txt`
- `src/WinDev/FEN_Audits_Industrial.txt`
- `src/WinDev/FEN_Actions_Industrial.txt`
- `src/WinDev/FEN_Rapports_Industrial.txt`

## Licence

Projet de démonstration / application de gestion HSE en environnement industriel.
