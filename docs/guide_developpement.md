# Guide de développement HSE2026

## Objectif

Le projet HSE2026 est une version production orientée entreprise pour un système HSE industriel.

## Structure

- database/HSE_DB_Production.sql : base SQL Server
- src/WinDev : modules de fenêtres WinDev
- docs : documentation technique

## Étapes de mise en œuvre

1. Créer la base SQL Server
2. Exécuter le script HSE_DB_Production.sql
3. Créer le projet WinDev 2025
4. Importer les écrans dans `src/WinDev`
5. Configurer la chaîne de connexion
6. Tester le login admin/admin123
7. Vérifier les modules incidents, audits, actions, rapports, risques

## Sécurité recommandée

- mots de passe hashés
- journaux d'activité
- droits par profil
- validation des champs
- logs de modification
- filtrage de données par site

## Règles métier

- un incident ouvert reste visible jusqu'à clôture
- les actions en retard doivent apparaître dans les alertes
- les audits non conformes doivent être visibles dans le dashboard
- les risques critiques nécessitent validation

## Reporting

- Excel pour export analytique
- PDF pour rapports formels
