# HSE2026 - Guide d'utilisation

## Accueil et connexion

1. Lancer l'application HSE2026
2. Entrer vos identifiants
3. Valider la connexion
4. Le dashboard s'affiche

## Dashboard principal

Le dashboard affiche :
- **KPI** : Incidents, Audits, Actions, Conformité
- **Alertes** : Actions en retard, risques critiques
- **Synthèse par site** : Incidents, Audits, Risques par site
- **Évolution mensuelle** : Tendances

### Actions depuis le dashboard

- Cliquer sur **Incidents** pour gérer les incidents
- Cliquer sur **Audits** pour gérer les audits
- Cliquer sur **Actions** pour gérer les actions correctives
- Cliquer sur **Risques** pour gérer les risques
- Cliquer sur **Déconnexion** pour quitter

## Gestion des incidents

### Ajouter un incident

1. Cliquer sur le bouton **Incidents** du dashboard
2. Remplir les champs :
   - Date et heure
   - Type d'incident
   - Gravité
   - Site
   - Description
   - Cause probable
   - Mesures immédiates
3. Cliquer sur **Ajouter incident**
4. L'incident est enregistré avec un code unique (INC-YYYYMMDD-XXXX)

### Rechercher un incident

1. Entrer le code dans le champ de recherche
2. Cliquer sur **Rechercher**
3. Les détails de l'incident s'affichent

### Modifier le statut

1. Sélectionner un statut dans la liste :
   - Ouvert
   - En traitement
   - Clôturé
2. Valider

## Gestion des audits

### Créer un audit

1. Cliquer sur **Audits** du dashboard
2. Remplir les champs :
   - Date de l'audit
   - Site
   - Responsable
   - Type (Interne/Externe/Audit client)
   - Statut
   - Commentaire
3. Cliquer sur **Ajouter audit**

### Ajouter des points de contrôle

1. Sélectionner l'audit
2. Entrer le point de contrôle
3. Cocher si conforme
4. Ajouter une observation
5. Cliquer sur **Ajouter point**

## Gestion des actions

### Créer une action

1. Cliquer sur **Actions** du dashboard
2. Remplir :
   - Libellé
   - Description
   - Responsable
   - Dates (début et échéance)
   - Statut (En cours, En retard, Terminé, Suspendu)
   - Priorité (Basse, Moyenne, Haute, Critique)
   - Type (Corrective, Préventive, Amélioration)
3. Cliquer sur **Ajouter action**

### Clôturer une action

1. Sélectionner l'action dans la liste
2. Cliquer sur **Clôturer**
3. Le statut devient "Terminé"

## Gestion des risques

### Évaluer un risque

1. Cliquer sur **Risques** du dashboard
2. Entrer :
   - Libellé du risque
   - Description
   - Site
   - Probabilité (1 à 5)
   - Gravité (1 à 5)
3. La criticité se calcule automatiquement (Probabilité × Gravité)
4. Ajouter un responsable
5. Cliquer sur **Ajouter risque**

### Matrice de risque

- **Criticité < 5** : Faible
- **Criticité 5-9** : Moyen
- **Criticité 10-15** : Élevé
- **Criticité > 15** : Critique

## Rapports et exports

### Générer un rapport Excel

1. Cliquer sur **Rapports**
2. Sélectionner la période
3. Cliquer sur **Exporter Excel**
4. Choisir le dossier de destination
5. Le rapport s'ouvre dans Excel

### Générer un rapport PDF

1. Cliquer sur **Rapports**
2. Sélectionner les options
3. Cliquer sur **Exporter PDF**
4. Le rapport est créé et prêt

## Gestion des utilisateurs (Admin)

### Ajouter un utilisateur

1. Cliquer sur **Paramètres**
2. Aller à **Administration**
3. Cliquer sur **Ajouter utilisateur**
4. Entrer :
   - Login
   - Mot de passe
   - Nom et prénom
   - Email
   - Profil
5. Valider

### Gérer les droits

1. Cliquer sur **Paramètres**
2. Aller à **Droits**
3. Sélectionner un profil
4. Cocher/décocher les permissions par module
5. Valider

## Conseils d'utilisation

- Toujours cocher "Terminé" sur un incident pour le clôturer
- Assigner une action immédiatement après un incident
- Revoir régulièrement les risques critiques
- Exporter les rapports mensuels pour archivage
- Utiliser les filtres pour affiner les recherches

## Raccourcis clavier

| Touche | Action |
|--------|--------|
| Ctrl+N | Nouveau |
| Ctrl+S | Sauvegarder |
| Ctrl+E | Exporter |
| Ctrl+Q | Quitter |
| F5 | Rafraîchir |

## Support et aide

- Consulter le menu Aide de l'application
- Vérifier la documentation
- Contacter l'administrateur système
