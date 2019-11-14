class Evening {
  String film = "";
  String date = "";
  String responsible = "";
  ArrayList <Integer> storageBefore = new ArrayList();
  ArrayList <Integer> storageAfter = new ArrayList();
  ArrayList <Integer> storageDifference = new ArrayList();
  float cashBefore = 0.0;
  float cashAfterExpected = 0.0;
  float cashAfterCounted = 0.0;
  float cashDifference = 0.0;
  float salesVolume = 0.0;
  float expenditure = 0.0;
  int numberOfVisitors = 0;

  String toString() {
    return "Datum: " + date + " Verantwortlich: " + responsible + " \n Lagerbestand vorher: " + storageBefore + " \n Lagerbestand nachher: " + storageAfter;
  }
}
