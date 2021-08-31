/// Object used for the various simulations done (not ready in version 1.0)
/// 
/// When starting a new simulation we will require its identifier, the id for
/// the disease that will be studied, as well as when to start and when to stop
/// We need al that data, since we can compute more than one simulation on one
/// or more disease; moreover, the simulation is needed to study the disease
/// as well as its spread probability, which requires it being on a definite
/// span of time to have precise data to study.
class Simulation {
  int id;
  int startDate;
  int endDate;
  int diseaseId;

  Simulation(int id, int startDate, int endDate, int diseaseId) {
    this.id = id;
    this.startDate = startDate;
    this.endDate = endDate;
    this.diseaseId = diseaseId;
  }

  Simulation.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        startDate = json["startDate"],
        endDate = json["endDate"],
        diseaseId = json["diseaseId"];

  int get getId => this.id;
  int get getStartDate => this.startDate;
  int get getEndDate => this.endDate;
  int get getDiseaseId => this.diseaseId;
}
