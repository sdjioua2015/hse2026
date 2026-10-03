// ====================================================
// GLOBAL_VARIABLES.wl
// Variables globales du projet HSE2026
// ====================================================

GLOBAL
    gUserID is int
    gUserNom is string
    gUserProfil is int
    gUserLogin is string
    gSessionID is int
    gCurrentSite is int
    gCurrentDate is date
END

// ====================================================
// FEN_LOGIN_PRODUCTION.wl
// Écran de connexion - Production HSE2026
// ====================================================

PROCEDURE FEN_Login_Production()
    Title = "HSE2026 - Connexion"
    Width = 600
    Height = 400
    CenterWindow()
    BackgroundColor = RGB(31, 78, 121)
END

PROCEDURE BTN_Connexion_Click()
    sLogin is string
    sPass is string
    iCount is int

    sLogin = EDT_Login
    sPass = EDT_MotDePasse

    IF sLogin = "" THEN
        Error("Le login est obligatoire")
        EDT_Login.SetFocus()
        RETURN
    END

    IF sPass = "" THEN
        Error("Le mot de passe est obligatoire")
        EDT_MotDePasse.SetFocus()
        RETURN
    END

    HReadSeekFirst(T_Utilisateur, Login, sLogin)
    IF HFound() = False THEN
        HAdd(T_Log)
        T_Log.IDUtilisateur = 0
        T_Log.Action = "Tentative de connexion échouée"
        T_Log.Details = "Login : " + sLogin
        T_Log.DateAction = DateSys()
        HSave(T_Log)
        Error("Utilisateur introuvable")
        RETURN
    END

    IF T_Utilisateur.MotDePasse <> sPass THEN
        HAdd(T_Log)
        T_Log.IDUtilisateur = 0
        T_Log.Action = "Tentative de connexion échouée"
        T_Log.Details = "Login : " + sLogin + " - Mot de passe incorrect"
        T_Log.DateAction = DateSys()
        HSave(T_Log)
        Error("Mot de passe incorrect")
        EDT_MotDePasse.Value = ""
        EDT_MotDePasse.SetFocus()
        RETURN
    END

    IF T_Utilisateur.Actif <> True THEN
        Error("Compte désactivé")
        RETURN
    END

    gUserID = T_Utilisateur.IDUtilisateur
    gUserNom = T_Utilisateur.Nom + " " + T_Utilisateur.Prenom
    gUserProfil = T_Utilisateur.IDProfil
    gUserLogin = T_Utilisateur.Login

    HAdd(T_Session)
    T_Session.IDUtilisateur = gUserID
    T_Session.DateConnexion = DateSys()
    T_Session.IPAddress = "127.0.0.1"
    HSave(T_Session)
    gSessionID = T_Session.IDSession

    HAdd(T_Log)
    T_Log.IDUtilisateur = gUserID
    T_Log.Action = "Connexion"
    T_Log.Details = "Connexion réussie de " + gUserNom
    T_Log.DateAction = DateSys()
    HSave(T_Log)

    Close()
    OpenWindow(FEN_Dashboard_Production)
END

PROCEDURE BTN_Quitter_Click()
    Close()
END

// ====================================================
// FEN_DASHBOARD_PRODUCTION.wl
// Écran Dashboard Production HSE2026
// ====================================================

PROCEDURE FEN_Dashboard_Production()
    Title = "HSE2026 - Tableau de bord"
    Width = 1400
    Height = 900
    BackgroundColor = RGB(244, 247, 251)
    PROCEDURE InitialiserDashboard()
END

PROCEDURE InitialiserDashboard()
    ChargerKPIProduction()
    ChargerAlertesProduction()
    ChargerSyntheseParSite()
    ChargerEvolutionMensuelle()
END

PROCEDURE ChargerKPIProduction()
    iIncidents is int = 0
    iAudits is int = 0
    iActions is int = 0
    iRisques is int = 0
    iRetards is int = 0
    iConformite is int = 0
    iTermines is int = 0

    HCount(T_Incident, iIncidents)
    HCount(T_Audit, iAudits)
    HCount(T_Action, iActions)
    HCount(T_Risque, iRisques)

    iRetards = 0
    iTermines = 0

    HReadFirst(T_Action)
    WHILE HFound() = True
        IF T_Action.DateEcheance < DateSys() AND T_Action.Statut <> "Termine" THEN
            iRetards = iRetards + 1
        END
        IF T_Action.Statut = "Termine" THEN
            iTermines = iTermines + 1
        END
        HReadNext(T_Action)
    END

    iConformite = 88

    EDT_IncidentsTotal.Value = iIncidents
    EDT_AuditsTotal.Value = iAudits
    EDT_ActionsTotal.Value = iActions
    EDT_RisquesTotal.Value = iRisques
    EDT_ActionsRetard.Value = iRetards
    EDT_TauxConformite.Value = iConformite
    EDT_ActionsTerminees.Value = iTermines
END

PROCEDURE ChargerAlertesProduction()
    TABLE_Alertes.DeleteAll()
    iLigne is int = 0

    HReadFirst(T_Action)
    WHILE HFound() = True
        IF T_Action.DateEcheance < DateSys() AND T_Action.Statut <> "Termine" THEN
            TABLE_Alertes.AddLine()
            TABLE_Alertes[iLigne + 1].Type = "CRITIQUE"
            TABLE_Alertes[iLigne + 1].Message = "Action en retard : " + T_Action.CodeAction
            TABLE_Alertes[iLigne + 1].Date = T_Action.DateEcheance
            TABLE_Alertes[iLigne + 1].Statut = "À traiter"
            iLigne = iLigne + 1
        END
        HReadNext(T_Action)
    END

    HReadFirst(T_Risque)
    WHILE HFound() = True
        IF T_Risque.Criticite >= 12 THEN
            TABLE_Alertes.AddLine()
            TABLE_Alertes[iLigne + 1].Type = "ALERTE"
            TABLE_Alertes[iLigne + 1].Message = "Risque critique : " + T_Risque.Libelle
            TABLE_Alertes[iLigne + 1].Date = DateSys()
            TABLE_Alertes[iLigne + 1].Statut = "À valider"
            iLigne = iLigne + 1
        END
        HReadNext(T_Risque)
    END
END

PROCEDURE ChargerSyntheseParSite()
    TABLE_SyntheseSites.DeleteAll()
    iLigne is int = 0

    HReadFirst(T_Site)
    WHILE HFound() = True
        iIncidents is int = 0
        iAudits is int = 0
        iRisques is int = 0

        HReadFirst(T_Incident)
        WHILE HFound() = True
            IF T_Incident.IDSite = T_Site.IDSite THEN
                iIncidents = iIncidents + 1
            END
            HReadNext(T_Incident)
        END

        HReadFirst(T_Audit)
        WHILE HFound() = True
            IF T_Audit.IDSite = T_Site.IDSite THEN
                iAudits = iAudits + 1
            END
            HReadNext(T_Audit)
        END

        HReadFirst(T_Risque)
        WHILE HFound() = True
            IF T_Risque.IDSite = T_Site.IDSite THEN
                iRisques = iRisques + 1
            END
            HReadNext(T_Risque)
        END

        TABLE_SyntheseSites.AddLine()
        TABLE_SyntheseSites[iLigne + 1].Site = T_Site.Libelle
        TABLE_SyntheseSites[iLigne + 1].Incidents = iIncidents
        TABLE_SyntheseSites[iLigne + 1].Audits = iAudits
        TABLE_SyntheseSites[iLigne + 1].Risques = iRisques
        iLigne = iLigne + 1

        HReadNext(T_Site)
    END
END

PROCEDURE ChargerEvolutionMensuelle()
    TABLE_Evolution.DeleteAll()
    iAnnee is int = Year(DateSys())
    iLigne is int = 0

    FOR iMois = 1 TO 12
        iIncidents is int = 0
        iAudits is int = 0
        iActions is int = 0

        HReadFirst(T_Incident)
        WHILE HFound() = True
            IF Month(T_Incident.DateIncident) = iMois AND Year(T_Incident.DateIncident) = iAnnee THEN
                iIncidents = iIncidents + 1
            END
            HReadNext(T_Incident)
        END

        HReadFirst(T_Audit)
        WHILE HFound() = True
            IF Month(T_Audit.DateAudit) = iMois AND Year(T_Audit.DateAudit) = iAnnee THEN
                iAudits = iAudits + 1
            END
            HReadNext(T_Audit)
        END

        HReadFirst(T_Action)
        WHILE HFound() = True
            IF Month(T_Action.DateDebut) = iMois AND Year(T_Action.DateDebut) = iAnnee THEN
                iActions = iActions + 1
            END
            HReadNext(T_Action)
        END

        TABLE_Evolution.AddLine()
        TABLE_Evolution[iLigne + 1].Mois = GetMonthName(iMois)
        TABLE_Evolution[iLigne + 1].Incidents = iIncidents
        TABLE_Evolution[iLigne + 1].Audits = iAudits
        TABLE_Evolution[iLigne + 1].Actions = iActions
        iLigne = iLigne + 1
    END
END

PROCEDURE BTN_OuvrirIncidents_Click()
    OpenWindow(FEN_Incidents_Production)
END

PROCEDURE BTN_OuvrirAudits_Click()
    OpenWindow(FEN_Audits_Production)
END

PROCEDURE BTN_OuvrirActions_Click()
    OpenWindow(FEN_Actions_Production)
END

PROCEDURE BTN_OuvrirRisques_Click()
    OpenWindow(FEN_Risques_Production)
END

PROCEDURE BTN_Deconnexion_Click()
    HReadSeekFirst(T_Session, IDSession, gSessionID)
    IF HFound() = True THEN
        T_Session.DateDeconnexion = DateSys()
        HSave(T_Session)
    END

    HAdd(T_Log)
    T_Log.IDUtilisateur = gUserID
    T_Log.Action = "Déconnexion"
    T_Log.Details = "Déconnexion de " + gUserNom
    T_Log.DateAction = DateSys()
    HSave(T_Log)

    gUserID = 0
    gUserNom = ""
    gUserProfil = 0
    gUserLogin = ""

    Close()
    OpenWindow(FEN_Login_Production)
END

// ====================================================
// FEN_INCIDENTS_PRODUCTION.wl
// Écran Gestion Incidents - Production HSE2026
// ====================================================

PROCEDURE FEN_Incidents_Production()
    Title = "HSE2026 - Gestion des incidents"
    Width = 1200
    Height = 800
    BackgroundColor = RGB(244, 247, 251)
    PROCEDURE InitialiserIncidents()
END

PROCEDURE InitialiserIncidents()
    ChargerCombosIncident()
    ChargerListeIncidents()
END

PROCEDURE ChargerCombosIncident()
    COMBO_TypeIncident.DeleteAll()
    HReadFirst(T_TypeIncident)
    WHILE HFound() = True
        COMBO_TypeIncident.Add(T_TypeIncident.Libelle)
        HReadNext(T_TypeIncident)
    END

    COMBO_Gravite.DeleteAll()
    HReadFirst(T_Gravite)
    WHILE HFound() = True
        COMBO_Gravite.Add(T_Gravite.Libelle)
        HReadNext(T_Gravite)
    END

    COMBO_SiteIncident.DeleteAll()
    HReadFirst(T_Site)
    WHILE HFound() = True
        COMBO_SiteIncident.Add(T_Site.Libelle)
        HReadNext(T_Site)
    END

    COMBO_StatutIncident.DeleteAll()
    COMBO_StatutIncident.Add("Ouvert")
    COMBO_StatutIncident.Add("En traitement")
    COMBO_StatutIncident.Add("Clôturé")
END

PROCEDURE ChargerListeIncidents()
    TABLE_Incidents.DeleteAll()
    iLigne is int = 0

    HReadFirst(T_Incident)
    WHILE HFound() = True
        TABLE_Incidents.AddLine()
        TABLE_Incidents[iLigne + 1].Code = T_Incident.CodeIncident
        TABLE_Incidents[iLigne + 1].Date = T_Incident.DateIncident
        TABLE_Incidents[iLigne + 1].Type = T_Incident.IDTypeIncident
        TABLE_Incidents[iLigne + 1].Site = T_Incident.IDSite
        TABLE_Incidents[iLigne + 1].Statut = T_Incident.Statut
        iLigne = iLigne + 1
        HReadNext(T_Incident)
    END
END

PROCEDURE BTN_AjouterIncident_Click()
    sCode is string
    iIDTypeIncident is int
    iIDGravite is int
    iIDSite is int

    IF EDT_DateIncident = "" THEN
        Error("La date de l'incident est obligatoire")
        EDT_DateIncident.SetFocus()
        RETURN
    END

    IF EDT_DescriptionIncident = "" THEN
        Error("La description est obligatoire")
        EDT_DescriptionIncident.SetFocus()
        RETURN
    END

    sCode = "INC-" + DateToString(DateSys(), "YYYYMMDD") + "-" + Random(1000, 9999)

    HAdd(T_Incident)
    T_Incident.CodeIncident = sCode
    T_Incident.IDTypeIncident = COMBO_TypeIncident.SelectedIndex + 1
    T_Incident.IDGravite = COMBO_Gravite.SelectedIndex + 1
    T_Incident.IDSite = COMBO_SiteIncident.SelectedIndex + 1
    T_Incident.DateIncident = EDT_DateIncident
    T_Incident.HeureIncident = EDT_HeureIncident
    T_Incident.Description = EDT_DescriptionIncident
    T_Incident.CauseProbable = EDT_CauseProbable
    T_Incident.MesuresImmediates = EDT_MesuresImmediates
    T_Incident.Statut = "Ouvert"
    HSave(T_Incident)

    IF HError() <> 0 THEN
        Error("Erreur lors de l'enregistrement")
    ELSE
        Info("Incident enregistré : " + sCode)
        ChargerListeIncidents()
        EDT_DescriptionIncident.Value = ""
        EDT_CauseProbable.Value = ""
        EDT_MesuresImmediates.Value = ""
    END
END

PROCEDURE BTN_RechercherIncident_Click()
    sCode is string
    sCode = EDT_CodeIncidentRecherche

    HReadSeekFirst(T_Incident, CodeIncident, sCode)
    IF HFound() THEN
        EDT_DescriptionIncident.Value = T_Incident.Description
        EDT_CauseProbable.Value = T_Incident.CauseProbable
        EDT_MesuresImmediates.Value = T_Incident.MesuresImmediates
        COMBO_StatutIncident.Value = T_Incident.Statut
        Info("Incident trouvé")
    ELSE
        Error("Incident non trouvé")
    END
END

PROCEDURE BTN_FermerIncidents_Click()
    Close()
END

// ====================================================
// FEN_AUDITS_PRODUCTION.wl
// Écran Gestion Audits - Production HSE2026
// ====================================================

PROCEDURE FEN_Audits_Production()
    Title = "HSE2026 - Gestion des audits"
    Width = 1200
    Height = 800
    BackgroundColor = RGB(244, 247, 251)
    PROCEDURE InitialiserAudits()
END

PROCEDURE InitialiserAudits()
    ChargerCombosAudit()
    ChargerListeAudits()
END

PROCEDURE ChargerCombosAudit()
    COMBO_SiteAudit.DeleteAll()
    HReadFirst(T_Site)
    WHILE HFound() = True
        COMBO_SiteAudit.Add(T_Site.Libelle)
        HReadNext(T_Site)
    END

    COMBO_TypeAudit.DeleteAll()
    COMBO_TypeAudit.Add("Interne")
    COMBO_TypeAudit.Add("Externe")
    COMBO_TypeAudit.Add("Audit client")

    COMBO_StatutAudit.DeleteAll()
    COMBO_StatutAudit.Add("Planifié")
    COMBO_StatutAudit.Add("En cours")
    COMBO_StatutAudit.Add("Complété")
    COMBO_StatutAudit.Add("Rapporté")
END

PROCEDURE ChargerListeAudits()
    TABLE_Audits.DeleteAll()
    iLigne is int = 0

    HReadFirst(T_Audit)
    WHILE HFound() = True
        TABLE_Audits.AddLine()
        TABLE_Audits[iLigne + 1].Code = T_Audit.CodeAudit
        TABLE_Audits[iLigne + 1].Date = T_Audit.DateAudit
        TABLE_Audits[iLigne + 1].Site = T_Audit.IDSite
        TABLE_Audits[iLigne + 1].Responsable = T_Audit.Responsable
        TABLE_Audits[iLigne + 1].Statut = T_Audit.Statut
        iLigne = iLigne + 1
        HReadNext(T_Audit)
    END
END

PROCEDURE BTN_AjouterAudit_Click()
    sCode is string

    IF EDT_DateAudit = "" THEN
        Error("La date de l'audit est obligatoire")
        RETURN
    END

    sCode = "AUD-" + DateToString(DateSys(), "YYYYMMDD") + "-" + Random(100, 999)

    HAdd(T_Audit)
    T_Audit.CodeAudit = sCode
    T_Audit.IDSite = COMBO_SiteAudit.SelectedIndex + 1
    T_Audit.DateAudit = EDT_DateAudit
    T_Audit.Responsable = EDT_ResponsableAudit
    T_Audit.TypeAudit = COMBO_TypeAudit.Value
    T_Audit.Statut = COMBO_StatutAudit.Value
    T_Audit.Commentaire = EDT_CommentaireAudit
    HSave(T_Audit)

    IF HError() <> 0 THEN
        Error("Erreur lors de l'enregistrement")
    ELSE
        Info("Audit enregistré : " + sCode)
        ChargerListeAudits()
        EDT_ResponsableAudit.Value = ""
        EDT_CommentaireAudit.Value = ""
    END
END

PROCEDURE BTN_AjouterPointAudit_Click()
    iIDAudit is int

    IF TABLE_Audits.Count = 0 THEN
        Error("Sélectionnez d'abord un audit")
        RETURN
    END

    iIDAudit = TABLE_Audits[TABLE_Audits.Position].IDAudit

    HAdd(T_PointAudit)
    T_PointAudit.IDAudit = iIDAudit
    T_PointAudit.Libelle = EDT_PointAudit
    T_PointAudit.Conforme = CHECK_Conforme.Value
    T_PointAudit.Observation = EDT_ObservationAudit
    T_PointAudit.NiveauRisque = COMBO_NiveauRisque.Value
    HSave(T_PointAudit)

    IF HError() <> 0 THEN
        Error("Erreur lors de l'ajout du point")
    ELSE
        Info("Point d'audit enregistré")
        EDT_PointAudit.Value = ""
        EDT_ObservationAudit.Value = ""
        CHECK_Conforme.Value = False
    END
END

PROCEDURE BTN_FermerAudits_Click()
    Close()
END

// ====================================================
// FEN_ACTIONS_PRODUCTION.wl
// Écran Gestion Actions - Production HSE2026
// ====================================================

PROCEDURE FEN_Actions_Production()
    Title = "HSE2026 - Gestion des actions"
    Width = 1200
    Height = 800
    BackgroundColor = RGB(244, 247, 251)
    PROCEDURE InitialiserActions()
END

PROCEDURE InitialiserActions()
    ChargerCombosAction()
    ChargerListeActions()
END

PROCEDURE ChargerCombosAction()
    COMBO_StatutAction.DeleteAll()
    COMBO_StatutAction.Add("En cours")
    COMBO_StatutAction.Add("En retard")
    COMBO_StatutAction.Add("Termine")
    COMBO_StatutAction.Add("Suspendu")

    COMBO_Priorite.DeleteAll()
    COMBO_Priorite.Add("Basse")
    COMBO_Priorite.Add("Moyenne")
    COMBO_Priorite.Add("Haute")
    COMBO_Priorite.Add("Critique")

    COMBO_TypeAction.DeleteAll()
    COMBO_TypeAction.Add("Corrective")
    COMBO_TypeAction.Add("Préventive")
    COMBO_TypeAction.Add("Amélioration")
END

PROCEDURE ChargerListeActions()
    TABLE_Actions.DeleteAll()
    iLigne is int = 0

    HReadFirst(T_Action)
    WHILE HFound() = True
        TABLE_Actions.AddLine()
        TABLE_Actions[iLigne + 1].Code = T_Action.CodeAction
        TABLE_Actions[iLigne + 1].Libelle = T_Action.Libelle
        TABLE_Actions[iLigne + 1].Responsable = T_Action.Responsable
        TABLE_Actions[iLigne + 1].DateEcheance = T_Action.DateEcheance
        TABLE_Actions[iLigne + 1].Statut = T_Action.Statut
        iLigne = iLigne + 1
        HReadNext(T_Action)
    END
END

PROCEDURE BTN_AjouterAction_Click()
    sCode is string

    IF EDT_LibelleAction = "" THEN
        Error("Le libellé est obligatoire")
        RETURN
    END

    IF EDT_DateEcheance = "" THEN
        Error("La date d'échéance est obligatoire")
        RETURN
    END

    sCode = "ACT-" + DateToString(DateSys(), "YYYYMMDD") + "-" + Random(100, 999)

    HAdd(T_Action)
    T_Action.CodeAction = sCode
    T_Action.Libelle = EDT_LibelleAction
    T_Action.Description = EDT_DescriptionAction
    T_Action.Responsable = EDT_ResponsableAction
    T_Action.DateDebut = EDT_DateDebut
    T_Action.DateEcheance = EDT_DateEcheance
    T_Action.Statut = COMBO_StatutAction.Value
    T_Action.Priorite = COMBO_Priorite.Value
    T_Action.TypeAction = COMBO_TypeAction.Value
    HSave(T_Action)

    IF HError() <> 0 THEN
        Error("Erreur lors de l'enregistrement")
    ELSE
        Info("Action enregistrée : " + sCode)
        ChargerListeActions()
        EDT_LibelleAction.Value = ""
        EDT_DescriptionAction.Value = ""
        EDT_ResponsableAction.Value = ""
    END
END

PROCEDURE BTN_CloturerAction_Click()
    iIDAction is int

    IF TABLE_Actions.Count = 0 THEN
        Error("Sélectionnez une action")
        RETURN
    END

    iIDAction = TABLE_Actions[TABLE_Actions.Position].IDAction
    HReadSeekFirst(T_Action, IDAction, iIDAction)

    IF HFound() THEN
        T_Action.Statut = "Termine"
        HSave(T_Action)
        Info("Action clôturée")
        ChargerListeActions()
    END
END

PROCEDURE BTN_FermerActions_Click()
    Close()
END

// ====================================================
// FEN_RISQUES_PRODUCTION.wl
// Écran Gestion Risques - Production HSE2026
// ====================================================

PROCEDURE FEN_Risques_Production()
    Title = "HSE2026 - Gestion des risques"
    Width = 1200
    Height = 800
    BackgroundColor = RGB(244, 247, 251)
    PROCEDURE InitialiserRisques()
END

PROCEDURE InitialiserRisques()
    ChargerCombosRisque()
    ChargerListeRisques()
END

PROCEDURE ChargerCombosRisque()
    COMBO_SiteRisque.DeleteAll()
    HReadFirst(T_Site)
    WHILE HFound() = True
        COMBO_SiteRisque.Add(T_Site.Libelle)
        HReadNext(T_Site)
    END

    COMBO_Probabilite.DeleteAll()
    COMBO_Probabilite.Add("Faible (1)")
    COMBO_Probabilite.Add("Modérée (2)")
    COMBO_Probabilite.Add("Moyenne (3)")
    COMBO_Probabilite.Add("Élevée (4)")
    COMBO_Probabilite.Add("Très élevée (5)")

    COMBO_GraviteRisque.DeleteAll()
    COMBO_GraviteRisque.Add("Faible (1)")
    COMBO_GraviteRisque.Add("Modérée (2)")
    COMBO_GraviteRisque.Add("Moyenne (3)")
    COMBO_GraviteRisque.Add("Élevée (4)")
    COMBO_GraviteRisque.Add("Critique (5)")
END

PROCEDURE ChargerListeRisques()
    TABLE_Risques.DeleteAll()
    iLigne is int = 0

    HReadFirst(T_Risque)
    WHILE HFound() = True
        TABLE_Risques.AddLine()
        TABLE_Risques[iLigne + 1].Libelle = T_Risque.Libelle
        TABLE_Risques[iLigne + 1].Site = T_Risque.IDSite
        TABLE_Risques[iLigne + 1].Probabilite = T_Risque.Probabilite
        TABLE_Risques[iLigne + 1].Gravite = T_Risque.Gravite
        TABLE_Risques[iLigne + 1].Criticite = T_Risque.Criticite
        TABLE_Risques[iLigne + 1].Statut = T_Risque.Statut
        iLigne = iLigne + 1
        HReadNext(T_Risque)
    END
END

PROCEDURE CalculerCriticite()
    iProb is int
    iGrav is int
    iCrit is int

    iProb = COMBO_Probabilite.SelectedIndex + 1
    iGrav = COMBO_GraviteRisque.SelectedIndex + 1
    iCrit = iProb * iGrav
    EDT_Criticite.Value = iCrit
END

PROCEDURE BTN_AjouterRisque_Click()
    IF EDT_LibelleRisque = "" THEN
        Error("Le libellé du risque est obligatoire")
        RETURN
    END

    HAdd(T_Risque)
    T_Risque.IDSite = COMBO_SiteRisque.SelectedIndex + 1
    T_Risque.Libelle = EDT_LibelleRisque
    T_Risque.Description = EDT_DescriptionRisque
    T_Risque.Probabilite = COMBO_Probabilite.SelectedIndex + 1
    T_Risque.Gravite = COMBO_GraviteRisque.SelectedIndex + 1
    T_Risque.Criticite = EDTCriticite.Value
    T_Risque.Responsable = EDT_ResponsableRisque
    T_Risque.Statut = "Ouvert"
    HSave(T_Risque)

    IF HError() <> 0 THEN
        Error("Erreur lors de l'enregistrement")
    ELSE
        Info("Risque enregistré")
        ChargerListeRisques()
        EDT_LibelleRisque.Value = ""
        EDT_DescriptionRisque.Value = ""
        EDT_ResponsableRisque.Value = ""
    END
END

PROCEDURE BTN_FermerRisques_Click()
    Close()
END

// ====================================================
// Fin du fichier - Version Production WinDev HSE2026
// ====================================================
