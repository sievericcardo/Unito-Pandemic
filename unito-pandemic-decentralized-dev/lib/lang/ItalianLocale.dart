import 'package:unito_pandemic_decentralized/lang/Locale.dart';

class ItalianLocale extends Locale {
  ItalianLocale() {
    this.presentation1title = "Benvenuto in UniTO Pandemic";
    this.presentation1body =
        "UniTO Pandemic è una nuova applicazione creata da 2 studenti magistrali di Informatica dell'Università degli Studi Torino. Da qui in poi inizia il tour esplicativo";

    this.presentation2title = "La nostra mission";
    this.presentation2body =
        "Lo scopo dell'app è quello di raccogliere dati di movimento in modo da aiutare gli esperti a prevenire la diffusione di un contagio letale";
    this.presentation3title = "Una app privacy-oriented";
    this.presentation3body =
        "Questa app rende il tuo telefono in grado di comunicare con gli altri possessori mediante scambio di messaggi casuali. Hai capito bene, non ci serve nient'altro, la tua privacy è al sicuro";

    this.presentation4title = "Per cominciare ti chiediamo di compilare il form qui sotto";

    this.formName = "Nome";
    this.formAge = "Età";
    this.formGender = "Genere";

    this.signUp = "Registrati";

    this.toastMessage = "Messaggio da implementare";

    this.toastKeyMessage = "Chiave pubblica copiata negli appunti";
    this.toastPwdMessage = "Password copiata negli appunti";

    this.homeScreenSituationTitle = "Situazione attuale";

    this.homeScreenSituationSubTitle = "Devi osservare determinate precauzioni";

    this.homeScreenCaseUpdate = "Aggiornamento Casi\n(Fonte: Protezione Civile)\n";

    this.homeScreenLatestUpdate = "Ultimo aggiornamento: ";

    this.homeScreenPositive = "Positivi\nAttuali";

    this.homeScreenDeaths = "Morti\nTotali";

    this.homeScreenIntensive = "Terapia\nIntensiva";

    this.healthCareScreenStatus = "Stato Attuale";

    this.homeScreenVirusSpread = "Diffusione del virus\n";

    this.healthCareScreenCommonSynthoms = "Sintomi comuni";
    this.healthCareScreenFever = "Febbre";
    this.healthCareScreenCough = "Tosse";
    this.healthCareScreenHeadAche = "Mal di testa";
    this.healthCareScreenPrevention = "Misure di prevenzione";
    this.healthCareScreenFlipTitleFront = "Unito Pandemic è Attiva";
    this.healthCareScreenFlipSubtitle = "Attualmente sei protetto dalle minacce";
    this.healthCareScreenFlipTitleRear = "Tutti i sistemi sono attivi";
    this.healthCareScreenFlipSubtitleR = "Continua pure le tue attività, ci penso io a proteggerti";

    this.menuContacts = "Tracciamento Contagi";
    this.menuHealthCare = "Zona Salute";
    this.menuSettings = "Impostazioni";
    this.menuHome = "Cruscotto";

    this.contactScreenLatestBeacons = "Ultimi contatti ricevuti\n";
    this.contactScreenNerdStats = "Statistiche per nerd\n";

    this.biometricAuth = "Utilizza l'autenticazione biometrica per sbloccare l'applicazione";

    this.loadingRegScreenMessage = "Registrazione in corso...\nA breve sarai rediretto";

    this.registeredUser = "Utente registrato";

    this.account = "PROFILO";
    this.privateAccount = "Account privato";
    this.underHood = "MIGRAZIONE";
    this.personalData = "Mostra info account";
    this.unitoPubKey = "Chiave pubblica UniTO Pandemic";
    this.password = "La tua password";
    this.newPositives = "Nuovi contagi";
    this.contagionStatusNegative = "Attualmente non sei stato esposto al patogeno";
    this.contagionStatusPositive = "Attenzione! Rilevata una tua recente esposizione";
    this.contagionsubtitle1 =
        "Continua tranquillamente a fare le tue cose, ma sempre nel rispetto delle precauzioni";
    this.contagionsubtitle2 = "Ti consigliamo un auto isolamento di 14 giorni";

    this.washHands = "Lavati spesso le mani";
    this.washHandsSub =
        "Il modo migliore per proteggersi da COVID-19 è lavarsi frequentemente le mani con acqua e sapone o con soluzione a base di alcol";

    this.socialDistances = "Mantieni la distanza di almeno 1 metro";
    this.socialDistancesSub =
        "Il mantenimento di una distanza interpersonale riduce la probabilità di contagio";

    this.updateData = "Aggiorna dati app";

    this.contagionNumber = "Ultimi contagi nei 14 giorni: \n\n";
    this.diseaseNumber = "Malattie conosciute: \n\n";

    this.updateComplete = "Aggiornamento completato";

    this.genericError = "Errore generico";
    this.updateError = "Server offline";

    this.servicesStart = "Partito demone contact tracing";
    this.newContact = "Ricevuto nuovo contatto";
  }
}
