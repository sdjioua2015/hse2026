USE master;
GO

IF DB_ID('HSE_DB') IS NOT NULL
BEGIN
    ALTER DATABASE HSE_DB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE HSE_DB;
END
GO

CREATE DATABASE HSE_DB;
GO

USE HSE_DB;
GO

CREATE TABLE T_Entreprise (
    IDEntreprise INT IDENTITY(1,1) PRIMARY KEY,
    Nom NVARCHAR(200) NOT NULL,
    Adresse NVARCHAR(250) NULL,
    Telephone NVARCHAR(50) NULL,
    Email NVARCHAR(150) NULL,
    Actif BIT DEFAULT 1
);

CREATE TABLE T_Site (
    IDSite INT IDENTITY(1,1) PRIMARY KEY,
    IDEntreprise INT NOT NULL,
    Libelle NVARCHAR(200) NOT NULL,
    Adresse NVARCHAR(250) NULL,
    CodeSite NVARCHAR(50) NULL,
    Zone NVARCHAR(100) NULL,
    Actif BIT DEFAULT 1,
    CONSTRAINT FK_Site_Entreprise FOREIGN KEY (IDEntreprise) REFERENCES T_Entreprise(IDEntreprise)
);

CREATE TABLE T_Departement (
    IDDepartement INT IDENTITY(1,1) PRIMARY KEY,
    IDSite INT NOT NULL,
    Libelle NVARCHAR(150) NOT NULL,
    CodeDepartement NVARCHAR(50) NULL,
    Actif BIT DEFAULT 1,
    CONSTRAINT FK_Departement_Site FOREIGN KEY (IDSite) REFERENCES T_Site(IDSite)
);

CREATE TABLE T_Profil (
    IDProfil INT IDENTITY(1,1) PRIMARY KEY,
    Libelle NVARCHAR(100) NOT NULL,
    Description NVARCHAR(250) NULL
);

CREATE TABLE T_Droit (
    IDDroit INT IDENTITY(1,1) PRIMARY KEY,
    IDProfil INT NOT NULL,
    Module NVARCHAR(100) NOT NULL,
    Lecture BIT DEFAULT 1,
    Ecriture BIT DEFAULT 0,
    Suppression BIT DEFAULT 0,
    CONSTRAINT FK_Droit_Profil FOREIGN KEY (IDProfil) REFERENCES T_Profil(IDProfil)
);

CREATE TABLE T_Utilisateur (
    IDUtilisateur INT IDENTITY(1,1) PRIMARY KEY,
    Login NVARCHAR(50) NOT NULL UNIQUE,
    MotDePasse NVARCHAR(255) NOT NULL,
    Nom NVARCHAR(100) NOT NULL,
    Prenom NVARCHAR(100) NOT NULL,
    Email NVARCHAR(150) NULL,
    IDProfil INT NOT NULL,
    Actif BIT DEFAULT 1,
    DateCreation DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Utilisateur_Profil FOREIGN KEY (IDProfil) REFERENCES T_Profil(IDProfil)
);

CREATE TABLE T_Personnel (
    IDPersonnel INT IDENTITY(1,1) PRIMARY KEY,
    Matricule NVARCHAR(50) NOT NULL UNIQUE,
    Nom NVARCHAR(100) NOT NULL,
    Prenom NVARCHAR(100) NOT NULL,
    Poste NVARCHAR(150) NULL,
    IDSite INT NOT NULL,
    IDDepartement INT NULL,
    DateEmbauche DATE NULL,
    Sexe NVARCHAR(20) NULL,
    Actif BIT DEFAULT 1,
    CONnuHSE BIT DEFAULT 0,
    CONSTRAINT FK_Personnel_Site FOREIGN KEY (IDSite) REFERENCES T_Site(IDSite),
    CONSTRAINT FK_Personnel_Departement FOREIGN KEY (IDDepartement) REFERENCES T_Departement(IDDepartement)
);

CREATE TABLE T_TypeIncident (
    IDTypeIncident INT IDENTITY(1,1) PRIMARY KEY,
    Libelle NVARCHAR(150) NOT NULL,
    Description NVARCHAR(250) NULL,
    Actif BIT DEFAULT 1
);

CREATE TABLE T_Gravite (
    IDGravite INT IDENTITY(1,1) PRIMARY KEY,
    Libelle NVARCHAR(50) NOT NULL,
    Valeur INT NOT NULL
);

CREATE TABLE T_Incident (
    IDIncident INT IDENTITY(1,1) PRIMARY KEY,
    CodeIncident NVARCHAR(50) NOT NULL UNIQUE,
    IDTypeIncident INT NOT NULL,
    IDGravite INT NOT NULL,
    IDSite INT NOT NULL,
    IDPersonnel INT NULL,
    DateIncident DATETIME NOT NULL,
    HeureIncident TIME NULL,
    Description NVARCHAR(500) NOT NULL,
    CauseProbable NVARCHAR(500) NULL,
    MesuresImmediates NVARCHAR(500) NULL,
    Statut NVARCHAR(50) DEFAULT 'Ouvert',
    DateCreation DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Incident_Type FOREIGN KEY (IDTypeIncident) REFERENCES T_TypeIncident(IDTypeIncident),
    CONSTRAINT FK_Incident_Gravite FOREIGN KEY (IDGravite) REFERENCES T_Gravite(IDGravite),
    CONSTRAINT FK_Incident_Site FOREIGN KEY (IDSite) REFERENCES T_Site(IDSite),
    CONSTRAINT FK_Incident_Personnel FOREIGN KEY (IDPersonnel) REFERENCES T_Personnel(IDPersonnel)
);

CREATE TABLE T_Audit (
    IDAudit INT IDENTITY(1,1) PRIMARY KEY,
    CodeAudit NVARCHAR(50) NOT NULL UNIQUE,
    IDSite INT NOT NULL,
    DateAudit DATETIME NOT NULL,
    Responsable NVARCHAR(150) NULL,
    Statut NVARCHAR(50) DEFAULT 'Planifie',
    Commentaire NVARCHAR(500) NULL,
    TypeAudit NVARCHAR(100) NULL,
    CONSTRAINT FK_Audit_Site FOREIGN KEY (IDSite) REFERENCES T_Site(IDSite)
);

CREATE TABLE T_PointAudit (
    IDPointAudit INT IDENTITY(1,1) PRIMARY KEY,
    IDAudit INT NOT NULL,
    Libelle NVARCHAR(200) NOT NULL,
    Conforme BIT DEFAULT 0,
    Observation NVARCHAR(500) NULL,
    NiveauRisque NVARCHAR(50) NULL,
    CONSTRAINT FK_PointAudit_Audit FOREIGN KEY (IDAudit) REFERENCES T_Audit(IDAudit)
);

CREATE TABLE T_Action (
    IDAction INT IDENTITY(1,1) PRIMARY KEY,
    CodeAction NVARCHAR(50) NOT NULL UNIQUE,
    IDIncident INT NULL,
    IDAudit INT NULL,
    Libelle NVARCHAR(200) NOT NULL,
    Description NVARCHAR(500) NULL,
    Responsable NVARCHAR(150) NULL,
    DateDebut DATE NULL,
    DateEcheance DATE NULL,
    Statut NVARCHAR(50) DEFAULT 'En cours',
    Priorite NVARCHAR(50) NULL,
    TypeAction NVARCHAR(100) NULL,
    CONSTRAINT FK_Action_Incident FOREIGN KEY (IDIncident) REFERENCES T_Incident(IDIncident),
    CONSTRAINT FK_Action_Audit FOREIGN KEY (IDAudit) REFERENCES T_Audit(IDAudit)
);

CREATE TABLE T_Risque (
    IDRisque INT IDENTITY(1,1) PRIMARY KEY,
    IDSite INT NOT NULL,
    Libelle NVARCHAR(200) NOT NULL,
    Description NVARCHAR(500) NULL,
    Probabilite INT NOT NULL,
    Gravite INT NOT NULL,
    Criticite INT NOT NULL,
    Statut NVARCHAR(50) DEFAULT 'Ouvert',
    DateCreation DATETIME DEFAULT GETDATE(),
    Responsable NVARCHAR(150) NULL,
    CONSTRAINT FK_Risque_Site FOREIGN KEY (IDSite) REFERENCES T_Site(IDSite)
);

CREATE TABLE T_Habilitation (
    IDHabilitation INT IDENTITY(1,1) PRIMARY KEY,
    IDPersonnel INT NOT NULL,
    Libelle NVARCHAR(200) NOT NULL,
    DateObtention DATE NULL,
    DateExpiration DATE NULL,
    Valide BIT DEFAULT 1,
    CONSTRAINT FK_Habilitation_Personnel FOREIGN KEY (IDPersonnel) REFERENCES T_Personnel(IDPersonnel)
);

CREATE TABLE T_Document (
    IDDocument INT IDENTITY(1,1) PRIMARY KEY,
    Titre NVARCHAR(200) NOT NULL,
    TypeDoc NVARCHAR(100) NULL,
    CheminFichier NVARCHAR(500) NULL,
    DateCreation DATETIME DEFAULT GETDATE(),
    IDSite INT NULL,
    VersionDoc NVARCHAR(50) NULL,
    CONSTRAINT FK_Document_Site FOREIGN KEY (IDSite) REFERENCES T_Site(IDSite)
);

CREATE TABLE T_Notification (
    IDNotification INT IDENTITY(1,1) PRIMARY KEY,
    IDUtilisateur INT NULL,
    Titre NVARCHAR(200) NOT NULL,
    Message NVARCHAR(500) NOT NULL,
    DateNotification DATETIME DEFAULT GETDATE(),
    Lu BIT DEFAULT 0,
    CONSTRAINT FK_Notification_Utilisateur FOREIGN KEY (IDUtilisateur) REFERENCES T_Utilisateur(IDUtilisateur)
);

CREATE TABLE T_Session (
    IDSession INT IDENTITY(1,1) PRIMARY KEY,
    IDUtilisateur INT NOT NULL,
    DateConnexion DATETIME DEFAULT GETDATE(),
    DateDeconnexion DATETIME NULL,
    IPAddress NVARCHAR(100) NULL,
    CONSTRAINT FK_Session_Utilisateur FOREIGN KEY (IDUtilisateur) REFERENCES T_Utilisateur(IDUtilisateur)
);

CREATE TABLE T_Log (
    IDLog INT IDENTITY(1,1) PRIMARY KEY,
    IDUtilisateur INT NULL,
    DateAction DATETIME DEFAULT GETDATE(),
    Action NVARCHAR(200) NOT NULL,
    Details NVARCHAR(500) NULL,
    CONSTRAINT FK_Log_Utilisateur FOREIGN KEY (IDUtilisateur) REFERENCES T_Utilisateur(IDUtilisateur)
);

CREATE TABLE T_Parametre (
    Cle NVARCHAR(100) PRIMARY KEY,
    Valeur NVARCHAR(250) NULL
);
GO

INSERT INTO T_Profil (Libelle, Description)
VALUES
('Admin', 'Administration complète'),
('Responsable HSE', 'Gestion HSE complète'),
('Superviseur', 'Suivi terrain et actions'),
('Utilisateur', 'Consultation et saisie');
GO

INSERT INTO T_Gravite (Libelle, Valeur)
VALUES
('Mineur', 1),
('Modéré', 2),
('Sérieux', 3),
('Majeur', 4),
('Très grave', 5);
GO

INSERT INTO T_TypeIncident (Libelle, Description)
VALUES
('Accident du travail', 'Accident sur le lieu de travail'),
('Incident sans blessé', 'Incident sans conséquence physique'),
('Problème environnemental', 'Déversement ou pollution'),
('Non-conformité', 'Écart par rapport au protocole'),
('Risque majeur', 'Situation critique');
GO

INSERT INTO T_Entreprise (Nom, Adresse, Telephone, Email)
VALUES
('Industrie HSE SA', 'Dakar', '+221 000 000 000', 'contact@industriehse.sn');
GO

INSERT INTO T_Site (IDEntreprise, Libelle, Adresse, CodeSite, Zone)
VALUES
(1, 'Site Dakar', 'Dakar', 'DK-01', 'Production'),
(1, 'Atelier Maintenance', 'Dakar', 'DK-02', 'Maintenance'),
(1, 'Site Saint-Louis', 'Saint-Louis', 'SL-01', 'Logistique');
GO

INSERT INTO T_Utilisateur (Login, MotDePasse, Nom, Prenom, Email, IDProfil, Actif)
VALUES
('admin', 'admin123', 'Administrateur', 'Principal', 'admin@industriehse.sn', 1, 1),
('hse', 'hse123', 'HSE', 'Manager', 'hse@industriehse.sn', 2, 1),
('superviseur', 'sup123', 'Superviseur', 'Test', 'sup@industriehse.sn', 3, 1),
('user', 'user123', 'Utilisateur', 'Standard', 'user@industriehse.sn', 4, 1);
GO

INSERT INTO T_Droit (IDProfil, Module, Lecture, Ecriture, Suppression)
VALUES
(1, 'Incidents', 1, 1, 1),
(1, 'Audits', 1, 1, 1),
(1, 'Actions', 1, 1, 1),
(1, 'Risques', 1, 1, 1),
(1, 'Rapports', 1, 1, 1),
(1, 'Administration', 1, 1, 1),
(2, 'Incidents', 1, 1, 0),
(2, 'Audits', 1, 1, 0),
(2, 'Actions', 1, 1, 0),
(2, 'Rapports', 1, 1, 0),
(3, 'Incidents', 1, 1, 0),
(3, 'Actions', 1, 1, 0),
(3, 'Rapports', 1, 1, 0);
GO

CREATE PROCEDURE sp_Login
    @Login NVARCHAR(50),
    @MotDePasse NVARCHAR(255)
AS
BEGIN
    SELECT *
    FROM T_Utilisateur
    WHERE Login = @Login
      AND MotDePasse = @MotDePasse
      AND Actif = 1;
END;
GO

CREATE PROCEDURE sp_Dashboard_HSE
AS
BEGIN
    SELECT
        (SELECT COUNT(*) FROM T_Incident) AS TotalIncidents,
        (SELECT COUNT(*) FROM T_Audit) AS TotalAudits,
        (SELECT COUNT(*) FROM T_Action) AS TotalActions,
        (SELECT COUNT(*) FROM T_Risque) AS TotalRisques,
        (SELECT COUNT(*) FROM T_Action WHERE DateEcheance < CAST(GETDATE() AS DATE) AND Statut <> 'Termine') AS ActionsRetard;
END;
GO
