// ============================================================
// HSE2026_THEME_VISUEL.wl
// Thème visuel final WinDev 2025 pour le système HSE2026
// ============================================================
// IMPORTER CE FICHIER DANS LE PROJET WINDEV
// ET APPELER InitialiserThemeHSE() AU CHARGEMENT DE CHAQUE FENETRE
// ============================================================

GLOBAL
    // Palette officielle HSE2026
    cHSE_Primary is int = RGB(15, 45, 77)        // Bleu foncé / branding
    cHSE_Secondary is int = RGB(60, 198, 240)     // Bleu ciel / action
    cHSE_Tertiary is int = RGB(20, 96, 148)       // Bleu profond / en-tête
    cHSE_Success is int = RGB(69, 179, 157)       // Vert / OK / terminé
    cHSE_Warning is int = RGB(243, 156, 18)       // Orange / en cours / attention
    cHSE_Danger is int = RGB(231, 76, 60)          // Rouge / critique / urgent
    cHSE_Background is int = RGB(239, 245, 250)    // Fond global
    cHSE_White is int = RGB(255, 255, 255)         // Blanc
    cHSE_GrayLight is int = RGB(224, 230, 235)    // Gris clair
    cHSE_GrayMid is int = RGB(153, 166, 177)       // Gris intermédiaire
    cHSE_GrayDark is int = RGB(67, 78, 86)         // Texte secondaire
    cHSE_Text is int = RGB(31, 41, 55)             // Texte principal
    cHSE_Chart1 is int = RGB(40, 118, 204)         // Bleu chart
    cHSE_Chart2 is int = RGB(20, 181, 157)         // Vert chart
    cHSE_Chart3 is int = RGB(245, 166, 35)         // Orange chart
    cHSE_Chart4 is int = RGB(230, 73, 73)          // Rouge chart
END

// ============================================================
// 1. THEME GLOBAL
// ============================================================
PROCEDURE InitialiserThemeHSE()
    // Style général de la fenêtre
    BackgroundColor = cHSE_Background
    ForegroundColor = cHSE_Text
    FontName = "Segoe UI"
    FontSize = 11
    FontBold = False

    // Couleur de titre et bordure
    TitleColor = cHSE_Primary
    TitleFontSize = 18
    TitleFontBold = True
END

PROCEDURE AppliquerThemeFenetre(sTitre is string)
    Title = sTitre
    BackgroundColor = cHSE_Background
    ForegroundColor = cHSE_Text
    FontName = "Segoe UI"
    FontSize = 11
    BorderColor = cHSE_GrayLight
END

// ============================================================
// 2. STYLE DES BOUTONS
// ============================================================
PROCEDURE ConfigurerBoutonPrincipal(sNomChamp is string, sLibelle is string, cCouleur is int)
    // Exemple d’usage WinDev
    // sNomChamp = BTN_Connexion ou BTN_AjouterAction
    // cCouleur = cHSE_Primary, cHSE_Success, cHSE_Danger, cHSE_Warning

    sNomChamp.BackgroundColor = cCouleur
    sNomChamp.ForegroundColor = cHSE_White
    sNomChamp.FontName = "Segoe UI"
    sNomChamp.FontSize = 11
    sNomChamp.FontBold = True
    sNomChamp.BorderColor = cCouleur
    sNomChamp.BorderRadius = 8
    sNomChamp.Padding = 10
END

PROCEDURE ConfigurerBoutonSecondaire(sNomChamp is string)
    sNomChamp.BackgroundColor = cHSE_White
    sNomChamp.ForegroundColor = cHSE_Primary
    sNomChamp.BorderColor = cHSE_GrayMid
    sNomChamp.FontName = "Segoe UI"
    sNomChamp.FontBold = True
    sNomChamp.BorderRadius = 8
END

// ============================================================
// 3. STYLE DES CARTES KPI
// ============================================================
PROCEDURE ConfigurerCarteKPI(sNomCarte is string, sTitre is string, sValeur is string, cCouleur is int)
    // Cette procédure est orientée WinDev et permet de dessiner
    // une carte KPI avec un en-tête, une valeur, un fond blanc,
    // une bordure colorée, et une ombre légère.

    sNomCarte.BackgroundColor = cHSE_White
    sNomCarte.BorderColor = cCouleur
    sNomCarte.BorderWidth = 2
    sNomCarte.BorderRadius = 10
    sNomCarte.Padding = 12

    // Le titre et la valeur sont généralement dans des champs texte associés
    // Exemple : TXT_KPI_Incidents_Titre, TXT_KPI_Incidents_Valeur
    // à personnaliser selon le nom réel des champs du formulaire
END

PROCEDURE ConfigurerTitreCarte(sNomLibelle is string, sTitre is string)
    sNomLibelle.Text = sTitre
    sNomLibelle.ForegroundColor = cHSE_GrayDark
    sNomLibelle.FontName = "Segoe UI"
    sNomLibelle.FontSize = 11
    sNomLibelle.FontBold = False
END

PROCEDURE ConfigurerValeurCarte(sNomValeur is string, sValeur is string, cCouleur is int)
    sNomValeur.Text = sValeur
    sNomValeur.ForegroundColor = cCouleur
    sNomValeur.FontName = "Segoe UI"
    sNomValeur.FontSize = 24
    sNomValeur.FontBold = True
END

// ============================================================
// 4. STYLE DES TABLES / GRILLES
// ============================================================
PROCEDURE ConfigurerTableHSE(sNomTable is string)
    sNomTable.BackgroundColor = cHSE_White
    sNomTable.BorderColor = cHSE_GrayLight
    sNomTable.HeaderBackgroundColor = cHSE_Primary
    sNomTable.HeaderForegroundColor = cHSE_White
    sNomTable.HeaderFontBold = True
    sNomTable.RowAlternateColor = cHSE_Background
    sNomTable.FontName = "Segoe UI"
    sNomTable.FontSize = 10
END

// ============================================================
// 5. STYLE DES CHAMPS DE SAISIE
// ============================================================
PROCEDURE ConfigurerChampSaisie(sNomChamp is string)
    sNomChamp.BackgroundColor = cHSE_White
    sNomChamp.ForegroundColor = cHSE_Text
    sNomChamp.BorderColor = cHSE_GrayMid
    sNomChamp.BorderRadius = 6
    sNomChamp.FontName = "Segoe UI"
    sNomChamp.FontSize = 11
END

PROCEDURE ConfigurerChampMemo(sNomChamp is string)
    sNomChamp.BackgroundColor = cHSE_White
    sNomChamp.ForegroundColor = cHSE_Text
    sNomChamp.BorderColor = cHSE_GrayMid
    sNomChamp.BorderRadius = 6
    sNomChamp.FontName = "Segoe UI"
    sNomChamp.FontSize = 11
END

PROCEDURE ConfigurerCombo(sNomCombo is string)
    sNomCombo.BackgroundColor = cHSE_White
    sNomCombo.ForegroundColor = cHSE_Text
    sNomCombo.BorderColor = cHSE_GrayMid
    sNomCombo.BorderRadius = 6
    sNomCombo.FontName = "Segoe UI"
    sNomCombo.FontSize = 11
END

// ============================================================
// 6. STYLE DES STATUTS
// ============================================================
PROCEDURE AppliquerStatutHSE(sStatut is string, sNomChamp is string)
    IF sStatut = "OK" OR sStatut = "Termine" OR sStatut = "Complété" OR sStatut = "Clôturé" THEN
        sNomChamp.BackgroundColor = cHSE_Success
        sNomChamp.ForegroundColor = cHSE_White
    ELSEIF sStatut = "En cours" OR sStatut = "Planifié" OR sStatut = "Moyenne" THEN
        sNomChamp.BackgroundColor = cHSE_Warning
        sNomChamp.ForegroundColor = cHSE_White
    ELSEIF sStatut = "Alerte" OR sStatut = "Critique" OR sStatut = "Urgent" OR sStatut = "En retard" THEN
        sNomChamp.BackgroundColor = cHSE_Danger
        sNomChamp.ForegroundColor = cHSE_White
    ELSEIF sStatut = "Suspendu" OR sStatut = "Probable" THEN
        sNomChamp.BackgroundColor = cHSE_GrayMid
        sNomChamp.ForegroundColor = cHSE_White
    ELSE
        sNomChamp.BackgroundColor = cHSE_Secondary
        sNomChamp.ForegroundColor = cHSE_White
    END

    sNomChamp.FontBold = True
    sNomChamp.BorderRadius = 6
END

// ============================================================
// 7. HEADER / NAVIGATION / DASHBOARD
// ============================================================
PROCEDURE ConfigurerHeaderDashboard(sNomHeader is string, sNomUser is string, sNomSysteme is string)
    sNomHeader.BackgroundColor = cHSE_Primary
    sNomHeader.ForegroundColor = cHSE_White
    sNomHeader.FontName = "Segoe UI"
    sNomHeader.FontSize = 18
    sNomHeader.FontBold = True

    sNomUser.ForegroundColor = cHSE_White
    sNomUser.FontName = "Segoe UI"
    sNomUser.FontSize = 10
END

// ============================================================
// 8. UTILITAIRE GRAPHIQUE POUR LE DASHBOARD
// ============================================================
PROCEDURE ConfigurerBlocAlertes(sNomBloc is string)
    sNomBloc.BackgroundColor = cHSE_White
    sNomBloc.BorderColor = cHSE_Danger
    sNomBloc.BorderWidth = 2
    sNomBloc.BorderRadius = 10
    sNomBloc.Padding = 10
END

PROCEDURE ConfigurerBlocSynthese(sNomBloc is string)
    sNomBloc.BackgroundColor = cHSE_White
    sNomBloc.BorderColor = cHSE_Secondary
    sNomBloc.BorderWidth = 2
    sNomBloc.BorderRadius = 10
    sNomBloc.Padding = 10
END

// ============================================================
// 9. EXEMPLE D’APPLICATION DANS LE DASHBOARD
// ============================================================
PROCEDURE AppliquerStyleDashboardHSE()
    // Appel unique pour appliquer le thème sur les éléments
    InitialiserThemeHSE()

    // Exemples de composants à personnaliser selon les contrôles réels du projet
    // ConfigurerBoutonPrincipal(BTN_OuvrirIncidents, "Incidents", cHSE_Primary)
    // ConfigurerBoutonPrincipal(BTN_OuvrirAudits, "Audits", cHSE_Secondary)
    // ConfigurerBoutonPrincipal(BTN_OuvrirActions, "Actions", cHSE_Warning)
    // ConfigurerBoutonPrincipal(BTN_OuvrirRisques, "Risques", cHSE_Danger)

    // ConfigurerTableHSE(TABLE_Alertes)
    // ConfigurerTableHSE(TABLE_SyntheseSites)
    // ConfigurerTableHSE(TABLE_Evolution)

    // ConfigurerChampSaisie(EDT_Login)
    // ConfigurerChampSaisie(EDT_MotDePasse)
    // ConfigurerChampSaisie(EDT_LibelleAction)
    // ConfigurerChampMemo(EDT_DescriptionAction)
    // ConfigurerCombo(COMBO_StatutAction)
END

// ============================================================
// 10. CODE D’INTÉGRATION RAPIDE
// ============================================================
// Ajouter dans les procédures d'initialisation des fenêtres :
//
// PROCEDURE FEN_Dashboard_Production()
//     Title = "HSE2026 - Tableau de bord"
//     Width = 1400
//     Height = 900
//     InitialiserThemeHSE()
//     AppliquerStyleDashboardHSE()
// END
//
// PROCEDURE FEN_Incidents_Production()
//     Title = "HSE2026 - Gestion des incidents"
//     Width = 1200
//     Height = 800
//     InitialiserThemeHSE()
//     ConfigurerBoutonPrincipal(BTN_AjouterIncident, "Ajouter incident", cHSE_Primary)
//     ConfigurerBoutonSecondaire(BTN_FermerIncidents)
//     ConfigurerTableHSE(TABLE_Incidents)
// END
//
// ============================================================
// FIN DU FICHIER
// ============================================================
