// ============================================================
// HSE2026_DASHBOARD.wl
// Exemple complet de tableau de bord WinDev HSE2026
// À copier dans le projet WinDev et à appeler depuis l'écran principal
// ============================================================

GLOBAL
    // Palette HSE2026
    cHSE_Primary is int = RGB(15, 45, 77)
    cHSE_Secondary is int = RGB(60, 198, 240)
    cHSE_Tertiary is int = RGB(20, 96, 148)
    cHSE_Success is int = RGB(69, 179, 157)
    cHSE_Warning is int = RGB(243, 156, 18)
    cHSE_Danger is int = RGB(231, 76, 60)
    cHSE_Background is int = RGB(239, 245, 250)
    cHSE_White is int = RGB(255, 255, 255)
    cHSE_GrayLight is int = RGB(224, 230, 235)
    cHSE_GrayMid is int = RGB(153, 166, 177)
    cHSE_GrayDark is int = RGB(67, 78, 86)
    cHSE_Text is int = RGB(31, 41, 55)
    cHSE_Panel is int = RGB(248, 250, 252)
END

// ============================================================
// 1. THÈME COMMUN
// ============================================================
PROCEDURE InitialiserThemeHSE2026()
    BackgroundColor = cHSE_Background
    ForegroundColor = cHSE_Text
    FontName = "Segoe UI"
    FontSize = 11
END

PROCEDURE AppliquerThemeBouton(sNomBouton is string, sLibelle is string, cCouleur is int)
    sNomBouton.Text = sLibelle
    sNomBouton.BackgroundColor = cCouleur
    sNomBouton.ForegroundColor = cHSE_White
    sNomBouton.FontName = "Segoe UI"
    sNomBouton.FontSize = 11
    sNomBouton.FontBold = True
    sNomBouton.BorderColor = cCouleur
    sNomBouton.BorderRadius = 8
    sNomBouton.Padding = 10
END

PROCEDURE AppliquerThemeChamp(sNomChamp is string)
    sNomChamp.BackgroundColor = cHSE_White
    sNomChamp.ForegroundColor = cHSE_Text
    sNomChamp.BorderColor = cHSE_GrayMid
    sNomChamp.BorderRadius = 6
    sNomChamp.FontName = "Segoe UI"
    sNomChamp.FontSize = 11
END

// ============================================================
// 2. CARTES KPI
// ============================================================
PROCEDURE ConfigurerCarteKpi(sCarte is string, sTitre is string, sValeur is string, cCouleur is int)
    sCarte.BackgroundColor = cHSE_White
    sCarte.BorderColor = cCouleur
    sCarte.BorderWidth = 2
    sCarte.BorderRadius = 12
    sCarte.Padding = 12

    // Champs texte associés (à adapter selon le projet réel)
    // TXT_KPI_Titre, TXT_KPI_Valeur, etc.
END

PROCEDURE ConfigurerTitreKpi(sTitreChamp is string, sTexte is string)
    sTitreChamp.Text = sTexte
    sTitreChamp.ForegroundColor = cHSE_GrayDark
    sTitreChamp.FontName = "Segoe UI"
    sTitreChamp.FontSize = 11
    sTitreChamp.FontBold = False
END

PROCEDURE ConfigurerValeurKpi(sValeurChamp is string, sTexte is string, cCouleur is int)
    sValeurChamp.Text = sTexte
    sValeurChamp.ForegroundColor = cCouleur
    sValeurChamp.FontName = "Segoe UI"
    sValeurChamp.FontSize = 26
    sValeurChamp.FontBold = True
END

// ============================================================
// 3. STYLES DES PANNEAUX
// ============================================================
PROCEDURE ConfigurerPanneau(sPanneau is string, cBordure is int)
    sPanneau.BackgroundColor = cHSE_White
    sPanneau.BorderColor = cBordure
    sPanneau.BorderWidth = 1
    sPanneau.BorderRadius = 10
    sPanneau.Padding = 10
END

PROCEDURE ConfigurerHeader(sHeader is string)
    sHeader.BackgroundColor = cHSE_Primary
    sHeader.ForegroundColor = cHSE_White
    sHeader.BorderRadius = 0
    sHeader.FontName = "Segoe UI"
    sHeader.FontSize = 18
    sHeader.FontBold = True
END

// ============================================================
// 4. STYLES DES STATUTS
// ============================================================
PROCEDURE AppliquerStatutDashboard(sNomStatut is string, sValeur is string)
    IF sValeur = "OK" OR sValeur = "Terminé" OR sValeur = "Clôturé" OR sValeur = "Complété" THEN
        sNomStatut.BackgroundColor = cHSE_Success
        sNomStatut.ForegroundColor = cHSE_White
    ELSEIF sValeur = "En cours" OR sValeur = "Planifié" OR sValeur = "Moyenne" THEN
        sNomStatut.BackgroundColor = cHSE_Warning
        sNomStatut.ForegroundColor = cHSE_White
    ELSEIF sValeur = "Alerte" OR sValeur = "Critique" OR sValeur = "Urgent" OR sValeur = "En retard" THEN
        sNomStatut.BackgroundColor = cHSE_Danger
        sNomStatut.ForegroundColor = cHSE_White
    ELSE
        sNomStatut.BackgroundColor = cHSE_Secondary
        sNomStatut.ForegroundColor = cHSE_White
    END

    sNomStatut.FontBold = True
    sNomStatut.BorderRadius = 6
END

// ============================================================
// 5. TABLEAU DE BORD COMPLET
// ============================================================
PROCEDURE AfficherDashboardHSE2026()
    // --------------------------------------------------------
    // 1. Paramétrage de la fenêtre
    // --------------------------------------------------------
    Title = "HSE2026 - Dashboard sécurité / environnement"
    Width = 1500
    Height = 930
    BackgroundColor = cHSE_Background
    ForegroundColor = cHSE_Text
    FontName = "Segoe UI"
    FontSize = 11

    // --------------------------------------------------------
    // 2. Header principal
    // --------------------------------------------------------
    // Panneau du header à créer dans le formulaire : PANEL_Header
    // LABEL_Titre_Principal : HSE2026
    // LABEL_SousTitre : Dashboard Général
    // BTN_Incidents, BTN_Audits, BTN_Actions, BTN_Risques

    ConfigurerHeader(PANEL_Header)
    LABEL_Titre_Principal.ForegroundColor = cHSE_White
    LABEL_Titre_Principal.FontName = "Segoe UI"
    LABEL_Titre_Principal.FontSize = 24
    LABEL_Titre_Principal.FontBold = True

    LABEL_SousTitre.ForegroundColor = cHSE_GrayLight
    LABEL_SousTitre.FontName = "Segoe UI"
    LABEL_SousTitre.FontSize = 11

    AppliquerThemeBouton(BTN_Incidents, "Incidents", cHSE_Primary)
    AppliquerThemeBouton(BTN_Audits, "Audits", cHSE_Secondary)
    AppliquerThemeBouton(BTN_Actions, "Actions", cHSE_Warning)
    AppliquerThemeBouton(BTN_Risques, "Risques", cHSE_Danger)

    // --------------------------------------------------------
    // 3. KPI cards
    // --------------------------------------------------------
    // 4 cartes KPI à personnaliser selon les champs réels
    // Exemple de contrôles : KPI_1, KPI_2, KPI_3, KPI_4

    ConfigurerCarteKpi(KPI_1, "Incidents", "24", cHSE_Primary)
    ConfigurerCarteKpi(KPI_2, "Actions correctives", "18", cHSE_Warning)
    ConfigurerCarteKpi(KPI_3, "Audits réalisés", "09", cHSE_Success)
    ConfigurerCarteKpi(KPI_4, "Risques critiques", "03", cHSE_Danger)

    ConfigurerTitreKpi(TXT_KPI_1_Titre, "Incidents")
    ConfigurerTitreKpi(TXT_KPI_2_Titre, "Actions correctives")
    ConfigurerTitreKpi(TXT_KPI_3_Titre, "Audits réalisés")
    ConfigurerTitreKpi(TXT_KPI_4_Titre, "Risques critiques")

    ConfigurerValeurKpi(TXT_KPI_1_Valeur, "24", cHSE_Primary)
    ConfigurerValeurKpi(TXT_KPI_2_Valeur, "18", cHSE_Warning)
    ConfigurerValeurKpi(TXT_KPI_3_Valeur, "09", cHSE_Success)
    ConfigurerValeurKpi(TXT_KPI_4_Valeur, "03", cHSE_Danger)

    // --------------------------------------------------------
    // 4. Panneaux d'information
    // --------------------------------------------------------
    ConfigurerPanneau(PANEL_Alertes, cHSE_Danger)
    ConfigurerPanneau(PANEL_Synthese, cHSE_Secondary)
    ConfigurerPanneau(PANEL_Trace, cHSE_Primary)
    ConfigurerPanneau(PANEL_Actions, cHSE_Secondary)

    // Titres
    LABEL_Alertes_Titre.ForegroundColor = cHSE_Danger
    LABEL_Alertes_Titre.FontName = "Segoe UI"
    LABEL_Alertes_Titre.FontSize = 16
    LABEL_Alertes_Titre.FontBold = True

    LABEL_Synthese_Titre.ForegroundColor = cHSE_Primary
    LABEL_Synthese_Titre.FontName = "Segoe UI"
    LABEL_Synthese_Titre.FontSize = 16
    LABEL_Synthese_Titre.FontBold = True

    LABEL_Trace_Titre.ForegroundColor = cHSE_Primary
    LABEL_Trace_Titre.FontName = "Segoe UI"
    LABEL_Trace_Titre.FontSize = 16
    LABEL_Trace_Titre.FontBold = True

    LABEL_Actions_Titre.ForegroundColor = cHSE_Primary
    LABEL_Actions_Titre.FontName = "Segoe UI"
    LABEL_Actions_Titre.FontSize = 16
    LABEL_Actions_Titre.FontBold = True

    // --------------------------------------------------------
    // 5. Table / liste des alertes
    // --------------------------------------------------------
    // TABLE_Alertes : exemple de table listant les alertes
    TABLE_Alertes.BackgroundColor = cHSE_White
    TABLE_Alertes.BorderColor = cHSE_GrayLight
    TABLE_Alertes.HeaderBackgroundColor = cHSE_Primary
    TABLE_Alertes.HeaderForegroundColor = cHSE_White
    TABLE_Alertes.HeaderFontBold = True
    TABLE_Alertes.RowAlternateColor = cHSE_Background
    TABLE_Alertes.FontName = "Segoe UI"
    TABLE_Alertes.FontSize = 10

    // Exemple de données (à remplacer par vos données métier)
    // N°  | Zone        | Type            | Statut     | Danger
    // 101 | Atelier 2   | Incendie        | Critique   | Elevé
    // 104 | Bâtiment A  | Ergonomie       | En cours   | Moyen
    // 118 | Stockage    | Risque chimique | Alerte     | Elevé

    // --------------------------------------------------------
    // 6. Tableau synthèse par site
    // --------------------------------------------------------
    TABLE_Synthese.BackgroundColor = cHSE_White
    TABLE_Synthese.BorderColor = cHSE_GrayLight
    TABLE_Synthese.HeaderBackgroundColor = cHSE_Tertiary
    TABLE_Synthese.HeaderForegroundColor = cHSE_White
    TABLE_Synthese.RowAlternateColor = cHSE_Background

    // --------------------------------------------------------
    // 7. Intégration de chart / indicateur visuel
    // --------------------------------------------------------
    // Exemple : CHART_Evolution ou PANEL_Graphique
    // CHART_Evolution.BackgroundColor = cHSE_White
    // CHART_Evolution.BorderColor = cHSE_GrayLight
    // CHART_Evolution.Series1Color = cHSE_Chart1
    // CHART_Evolution.Series2Color = cHSE_Chart2

    // --------------------------------------------------------
    // 8. Champs de recherche / filtres
    // --------------------------------------------------------
    EDT_Recherche.BackgroundColor = cHSE_White
    EDT_Recherche.BorderColor = cHSE_GrayMid
    EDT_Recherche.BorderRadius = 6
    EDT_Recherche.FontName = "Segoe UI"
    EDT_Recherche.FontSize = 11

    COMBO_Filtre.BackgroundColor = cHSE_White
    COMBO_Filtre.BorderColor = cHSE_GrayMid
    COMBO_Filtre.BorderRadius = 6

    // --------------------------------------------------------
    // 9. Boutons d'actions rapides
    // --------------------------------------------------------
    AppliquerThemeBouton(BTN_AjouterIncident, "Ajouter incident", cHSE_Primary)
    AppliquerThemeBouton(BTN_Exporter, "Exporter", cHSE_Secondary)
    AppliquerThemeBouton(BTN_Valider, "Valider", cHSE_Success)

    // --------------------------------------------------------
    // 10. Labels des statuts affichés
    // --------------------------------------------------------
    AppliquerStatutDashboard(LBL_Statut_Critique, "Critique")
    AppliquerStatutDashboard(LBL_Statut_EnCours, "En cours")
    AppliquerStatutDashboard(LBL_Statut_OK, "OK")
    AppliquerStatutDashboard(LBL_Statut_Alerte, "Alerte")
END

// ============================================================
// 6. EXEMPLE DE STRUCTURE FICHE D'ACTION
// ============================================================
PROCEDURE AfficherFicheActionHSE2026()
    Title = "HSE2026 - Fiche d'action"
    Width = 1100
    Height = 750
    BackgroundColor = cHSE_Background

    PANEL_Fiche.BackgroundColor = cHSE_White
    PANEL_Fiche.BorderColor = cHSE_Secondary
    PANEL_Fiche.BorderWidth = 2
    PANEL_Fiche.BorderRadius = 10

    EDT_Description.BackgroundColor = cHSE_White
    EDT_Description.BorderColor = cHSE_GrayMid
    EDT_Description.BorderRadius = 6

    COMBO_Responsable.BackgroundColor = cHSE_White
    COMBO_Responsable.BorderColor = cHSE_GrayMid
    COMBO_Responsable.BorderRadius = 6

    BTN_Sauvegarder.Text = "Sauvegarder"
    BTN_Sauvegarder.BackgroundColor = cHSE_Success
    BTN_Sauvegarder.ForegroundColor = cHSE_White
    BTN_Sauvegarder.FontBold = True

    BTN_Annuler.Text = "Annuler"
    BTN_Annuler.BackgroundColor = cHSE_GrayMid
    BTN_Annuler.ForegroundColor = cHSE_White
    BTN_Annuler.FontBold = True
END

// ============================================================
// 7. EXEMPLE DE PAGE D'ACCUEIL RAPIDE
// ============================================================
PROCEDURE OuvrirAccueilHSE2026()
    // appel de la fenêtre dashboard
    AfficherDashboardHSE2026()
END

// ============================================================
// 8. COMMENTAIRES D’INTÉGRATION
// ============================================================
// À créer dans le formulaire WinDev :
// - PANEL_Header
// - LABEL_Titre_Principal
// - LABEL_SousTitre
// - BTN_Incidents
// - BTN_Audits
// - BTN_Actions
// - BTN_Risques
// - KPI_1...KPI_4
// - TXT_KPI_1_Titre... etc.
// - TABLE_Alertes
// - TABLE_Synthese
// - EDT_Recherche
// - COMBO_Filtre
// - BTN_AjouterIncident
// - BTN_Exporter
// - BTN_Valider
// - PANEL_Alertes, PANEL_Synthese, PANEL_Trace, PANEL_Actions
// - LBL_Statut_Critique, LBL_Statut_EnCours, LBL_Statut_OK, LBL_Statut_Alerte
//
// Puis dans la procédure d'ouverture du formulaire :
//
// PROCEDURE OUVRE_FEN_Dashboard()
//     InitialiserThemeHSE2026()
//     AfficherDashboardHSE2026()
// END
//
// ============================================================
// FIN DU FICHIER
// ============================================================
