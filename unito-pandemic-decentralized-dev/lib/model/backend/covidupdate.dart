/// Update the data of Covid
/// 
/// we get new data as json and we map them as data that we can use on the
/// application, as well as getting our data and parse it to a json standard
/// so that they can be sent to the REST server.
class CovidUpdate {
  String data;
  String stato;
  int ricoveratiConSintomi;
  int terapiaIntensiva;
  int totaleOspedalizzati;
  int isolamentoDomiciliare;
  int totalePositivi;
  int variazioneTotalePositivi;
  int nuoviPositivi;
  int dimessiGuariti;
  int deceduti;
  int totaleCasi;
  int tamponi;
  int casiTestati;
  String noteIt;
  String noteEn;

  CovidUpdate(
      {this.data,
      this.stato,
      this.ricoveratiConSintomi,
      this.terapiaIntensiva,
      this.totaleOspedalizzati,
      this.isolamentoDomiciliare,
      this.totalePositivi,
      this.variazioneTotalePositivi,
      this.nuoviPositivi,
      this.dimessiGuariti,
      this.deceduti,
      this.totaleCasi,
      this.tamponi,
      this.casiTestati,
      this.noteIt,
      this.noteEn});

  CovidUpdate.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    stato = json['stato'];
    ricoveratiConSintomi = json['ricoverati_con_sintomi'];
    terapiaIntensiva = json['terapia_intensiva'];
    totaleOspedalizzati = json['totale_ospedalizzati'];
    isolamentoDomiciliare = json['isolamento_domiciliare'];
    totalePositivi = json['totale_positivi'];
    variazioneTotalePositivi = json['variazione_totale_positivi'];
    nuoviPositivi = json['nuovi_positivi'];
    dimessiGuariti = json['dimessi_guariti'];
    deceduti = json['deceduti'];
    totaleCasi = json['totale_casi'];
    tamponi = json['tamponi'];
    casiTestati = json['casi_testati'];
    noteIt = json['note_it'];
    noteEn = json['note_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['stato'] = this.stato;
    data['ricoverati_con_sintomi'] = this.ricoveratiConSintomi;
    data['terapia_intensiva'] = this.terapiaIntensiva;
    data['totale_ospedalizzati'] = this.totaleOspedalizzati;
    data['isolamento_domiciliare'] = this.isolamentoDomiciliare;
    data['totale_positivi'] = this.totalePositivi;
    data['variazione_totale_positivi'] = this.variazioneTotalePositivi;
    data['nuovi_positivi'] = this.nuoviPositivi;
    data['dimessi_guariti'] = this.dimessiGuariti;
    data['deceduti'] = this.deceduti;
    data['totale_casi'] = this.totaleCasi;
    data['tamponi'] = this.tamponi;
    data['casi_testati'] = this.casiTestati;
    data['note_it'] = this.noteIt;
    data['note_en'] = this.noteEn;
    return data;
  }
}
