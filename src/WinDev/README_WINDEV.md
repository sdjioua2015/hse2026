# Structure du projet HSE2026 - WinDev 2025

## Fichiers WinDev

### Écrans principaux

1. **FEN_Login_Production.wl**
   - Connexion utilisateur
   - Validation des identifiants
   - Création de session
   - Enregistrement dans les logs

2. **FEN_Dashboard_Production.wl**
   - Tableau de bord KPI
   - Alertes urgentes
   - Synthèse par site
   - Évolution mensuelle
   - Menu de navigation

3. **FEN_Incidents_Production.wl**
   - Saisie d'incidents
   - Recherche d'incidents
   - Liste des incidents
   - Modification du statut

4. **FEN_Audits_Production.wl**
   - Gestion des audits
   - Points de contrôle
   - Conformité
   - Observations

5. **FEN_Actions_Production.wl**
   - Actions correctives/préventives
   - Gestion des priorités
   - Suivi de l'échéance
   - Clôture d'actions

6. **FEN_Risques_Production.wl**
   - Évaluation des risques
   - Calcul de criticité
   - Matrice de risques
   - Suivi des risques

## Procédures principales

### Initialisation
- `InitialiserDashboard()` : charge tous les KPI
- `InitialiserIncidents()` : initialise les combos et la liste
- `InitialiserAudits()` : prépare les audit
s
- `InitialiserActions()` : charge les actions
- `InitialiserRisques()` : initialise les risques

### Chargement de données
- `ChargerKPIProduction()` : calcul des indicateurs
- `ChargerAlertesProduction()` : extraction des alertes
- `ChargerSyntheseParSite()` : synthèse multi-sites
- `ChargerEvolutionMensuelle()` : tendances
- `ChargerCombosIncident()` : remplissage des listes
- `ChargerListeIncidents()` : affichage des incidents

### Actions utilisateur
- `BTN_AjouterIncident_Click()` : création d'incident
- `BTN_AjouterAudit_Click()` : création d'audit
- `BTN_AjouterAction_Click()` : création d'action
- `BTN_AjouterRisque_Click()` : création de risque
- `BTN_CloturerAction_Click()` : clôture d'action
- `BTN_Deconnexion_Click()` : fermeture de session

## Base de données

Tables principales :
- T_Utilisateur
- T_Incident
- T_Audit
- T_Action
- T_Risque
- T_Site
- T_Log
- T_Session

## Sécurité

- Login/Mot de passe
- Profils utilisateur (Admin, HSE, Superviseur, Utilisateur)
- Droits par module
- Journalisation complète
- Sessions sécurisées

## Compilation WinDev

1. Ouvrir le projet `hse2026.prj`
2. Importer les fichiers `.wl` dans WinDev
3. Compiler le projet
4. Exécuter l'application
5. Se connecter avec admin/admin123

## Déploiement

- Exécutable WinDev autonome
- Distribution client-serveur
- Mise à jour automatique possible
