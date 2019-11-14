void universalSave(String valueName, String value) {
  String data[] = new String[1];
  data[0] = value;
  deleteOldFile(valueName + ".csv");
  saveStrings(valueName + ".csv", data);
}

String universalLoad(String valueName) {
  String data[] = loadStrings(valueName + ".csv");
  return data[0];
}

void universalSaveArray(String dataName, String[]data) {
  deleteOldFile(dataName + ".csv");
  saveStrings(dataName + ".csv", data);
}

String [] universalLoadArray(String valueName) {
  return loadStrings(valueName + ".csv");
}

void universalSaveArrayList(ArrayList<String>data, String valueName) {
  String[]array = new String[data.size()];
  for (int i = 0; i<data.size(); i++ )array[i] = data.get(i);
  saveStrings(valueName + ".csv", array);
}

ArrayList <String> universalLoadArrayList(String valueName) {
  String data[] = loadStrings(valueName + ".csv");
  ArrayList <String> list = new ArrayList<String>();
  for (int i = 0; i<data.length; i++ )list.add(data[i]);
  return list;
}


void universalCreateDocument(String filename) {
  String[]data = new String[0];
  saveStrings(filename + ".csv", data);
}

void deleteOldFile(String oldFile) {
  File existing = new File(oldFile + "");
  if (existing.exists()) {
    existing.delete();
  }
}


//universell verwendbare Funktionen zum Laden und Speichern bzw. Setzen von Verschiebungen (scroll) ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  || 
void saveScroll(String scrollField, int shift) {

  String scroll[] = new String[1];
  scroll = loadStrings(scrollField + ".csv");
  int numberOfLines;

  if (scrollField == CASH_REGISTER_PRODUCTS) { 
    if (products.size()%5 != 0)numberOfLines = int(products.size()/5) + 1;
    else numberOfLines = int(products.size()/5);
    if (int(scroll[0]) + shift <= 0 && int(scroll[0]) + shift >= - (numberOfLines - 3) * height/4)scroll[0] = (int(scroll[0]) + shift) + "";
  } else if (scrollField == CASH_REGISTER_SELECTION) {
    if (int(scroll[0]) + shift >= 0 && int(scroll[0]) + shift<(width/7 * (loadSelection().length - 3)))scroll[0] = (int(scroll[0]) + shift) + "";
  } else if (scrollField == STOCK_OVERVIEW_PRODUCTS) {
    if (products.size()%3 != 0)numberOfLines = products.size()/3 + 1;
    else numberOfLines = int(products.size()/3);
    if (int(scroll[0]) + shift <= 0 && int(scroll[0]) + shift >= - (numberOfLines - 5.2382) * height/5.2382)scroll[0] = (int(scroll[0]) + shift) + "";
  } else {
    System.exit(0);
  }
  deleteOldFile(scrollField + ".csv");
  saveStrings(scrollField + ".csv", scroll);
}

void setScroll(int shift, String scrollField) {
  String scroll[] = new String[1];  
  scroll[0] = shift + "";
  deleteOldFile(scrollField + ".csv");
  saveStrings(scrollField + ".csv", scroll);
}

int loadScroll(String scrollField) {
  String scroll[] = loadStrings(scrollField + ".csv");
  return int(scroll[0]);
}// ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  || |





//Funktionen zum Laden, Speichern und Hinzufügen von AKFilm - Mitgliedern ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  || |
void createAKFilmMembersDocument() {
  String data[] = new String[0];
  //data[0] = "Admin" + "," + "" + "," + "0";
  saveStrings("AKFilmMembers.csv", data);
}

void addNewAKFilmMember(AKFilmMember recent) {
  ArrayList <AKFilmMember> AKFilmMembers = new ArrayList();
  for (int i = 0; i<loadAKFilmMembers().size(); i++ )AKFilmMembers.add(loadAKFilmMembers().get(i));
  AKFilmMembers.add(recent);
  String [] data = new String[AKFilmMembers.size()];
  for (int i = 0; i<AKFilmMembers.size(); i++ ) {
    data[i] = AKFilmMembers.get(i).name + "," + AKFilmMembers.get(i).password + "," + AKFilmMembers.get(i).accessCategory;
  }
  saveStrings("AKFilmMembers.csv", data);
}

void saveAKFilmMembers(ArrayList<AKFilmMember>AKFilmMembers) { 
  String [] data = new String[AKFilmMembers.size()];
  if (AKFilmMembers.size()>0) {
    for (int i = 0; i<AKFilmMembers.size(); i++ ) {
      data[i] = AKFilmMembers.get(i).name + "," + AKFilmMembers.get(i).password + "," + AKFilmMembers.get(i).accessCategory;
    }
  }
  saveStrings("AKFilmMembers.csv", data);
}

ArrayList <AKFilmMember> loadAKFilmMembers() {
  String [] data = loadStrings("AKFilmMembers.csv");
  ArrayList <AKFilmMember> AKFilmMembers = new ArrayList <AKFilmMember>();
  for (int i = 0; i<data.length; i++ ) {
    String [] split = split(data[i], ",");
    if (split.length>0) {
      AKFilmMembers.add(new AKFilmMember(split[0], split[1], int(split[2])));
    }
  }
  return AKFilmMembers;
}// ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  || 




//Funktionen zum Laden, Speichern und Leeren der aktuellen Produktauswahl in der Kasse
void saveSelection(ArrayList <String> selectionStringList) {
  String selectionStringNeu [] = new String [selectionStringList.size()];
  for (int i = 0; i<selectionStringList.size(); i++ )selectionStringNeu[i] = selectionStringList.get(i);
  deleteOldFile("auswahl.csv");
  saveStrings("auswahl.csv", selectionStringNeu);
}

void saveSelection(String[] selection) {
  deleteOldFile("auswahl.csv");
  saveStrings("auswahl.csv", selection);
}

String[] loadSelection() {
  String [] selectionString = loadStrings("auswahl.csv");
  return selectionString;
}

void clearSelection() {
  ArrayList <String> empty = new ArrayList();
  saveSelection(empty);
}// ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  || 




//Funktionen zum Speichern, Laden und Aktualisieren des aktuellen Lagerbestandes ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  || |
ArrayList <Integer> loadStorage() {
  ArrayList <Integer> inStorageInt = new ArrayList <Integer>();
  for (int i = 0; i<products.size(); i++ )inStorageInt.add(products.get(i).inStorage);
  return inStorageInt;
}

void actualizeStorage(ArrayList <Integer> inStorage) {
  for (int i = 0; i<products.size(); i++ )products.get(i).inStorage = inStorage.get(i);
}// ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  || 



//Funktion zum Messen der Zeitspanne vom Beginn eines "Touches" bis zu dessen Ende ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  || |
int loadTouchTime() {
  String [] time = loadStrings("startTime.csv");
  return int(time[0]);
}

void saveTouchStartTime(int time) {
  String [] startTime = new String[1];
  startTime[0] = time + "";
  deleteOldFile("startTime.csv");
  saveStrings("startTime.csv", startTime);
}

int stopTouchTime() {
  String [] time = loadStrings("startTime.csv");
  int startTime = int(time[0]);
  int stopTime = millis();
  if (stopTime - startTime<300 && getPosDifference()<5) {
    specialMouseClicked();
  }
  return int(time[0]);
}

//Funktion zur Zusammenfassung aller Produktbilder in einer ArrayList vom Typ PImage ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  || 
ArrayList readImages(int numberOfPictures) {
  ArrayList <PImage> images = new ArrayList();
  for (int i = 0; i < numberOfPictures; i++ ) {
    images.add(products.get(i).productImage);
  }
  return images;
}


//Funktionen zum Starten und Abrufen eines Timers
void startTimer() {
  universalSave("timerTime", millis() + "");
}

int loadTimerTime() {
  int startTime = int(universalLoad("timerTime"));
  int passedTime = millis() - startTime;
  return passedTime;
}



//Funktionen zum Speichern und Laden aller bzw. des gerade laufenden Abends ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  || 
void saveActualEvening(Evening today) {

  String eveningData [] = new String[10];
  eveningData[0] = "" + today.cashAfterCounted;
  eveningData[1] = "" + today.cashAfterExpected;
  eveningData[2] = "" + today.cashBefore;
  eveningData[3] = "" + today.cashDifference;
  eveningData[4] = "" + today.date;
  eveningData[5] = "" + today.expenditure;
  eveningData[6] = "" + today.film;
  eveningData[7] = "" + today.numberOfVisitors;
  eveningData[8] = "" + today.salesVolume;
  eveningData[9] = "" + today.responsible;

  deleteOldFile("actualEvening.csv");
  saveStrings("actualEvening.csv", eveningData);


  String [] storageBefore = new String [today.storageBefore.size()];
  for (int t = 0; t<today.storageBefore.size(); t++ ) {
    storageBefore[t] = "" + today.storageBefore.get(t);
  }

  deleteOldFile("actualEveningStorageBefore.csv");
  saveStrings("actualEveningStorageBefore.csv", storageBefore);


  String [] storageAfter = new String [today.storageAfter.size()];
  for (int t = 0; t<today.storageAfter.size(); t++ ) {
    storageAfter[t] = "" + today.storageAfter.get(t);
  }
  deleteOldFile("actualEveningStorageAfter.csv");
  saveStrings("actualEveningStorageAfter.csv", storageAfter);

  String [] storageDifference = new String [today.storageDifference.size()];
  for (int t = 0; t<today.storageDifference.size(); t++ ) {
    storageDifference[t] = "" + today.storageDifference.get(t);
  }

  deleteOldFile("actualEveningStorageDifference.csv");
  saveStrings("actualEveningStorageDifference.csv", storageDifference);
}

Evening loadActualEvening() {

  Evening actualEvening = new Evening();
  String eveningData[] = loadStrings("actualEvening.csv");

  actualEvening.cashAfterCounted = float(eveningData[0]);
  actualEvening.cashAfterExpected = float(eveningData[1]);
  actualEvening.cashBefore = float(eveningData[2]);
  actualEvening.cashDifference = float(eveningData[3]);
  actualEvening.date = eveningData[4];
  actualEvening.expenditure = float(eveningData[5]);
  actualEvening.film = eveningData[6];
  actualEvening.numberOfVisitors = int(eveningData[7]);
  actualEvening.salesVolume = float(eveningData[8]);
  actualEvening.responsible = eveningData[9];

  String storageBefore [] = loadStrings("actualEveningStorageBefore.csv");
  for (int t = 0; t<storageBefore.length; t++ ) {
    actualEvening.storageBefore.add(int(storageBefore[t]));
  }

  String storageAfter [] = loadStrings ("actualEveningStorageAfter.csv");
  for (int t = 0; t<storageAfter.length; t++ ) {
    actualEvening.storageAfter.add(int(storageAfter[t]));
  }

  String storageDifference [] = loadStrings ("actualEveningStorageDifference.csv");
  for (int t = 0; t<storageDifference.length; t++ ) {
    actualEvening.storageDifference.add(int(storageDifference[t]));
  }
  return actualEvening;
}

void saveEvenings(ArrayList<Evening>evenings) {
  String [] allEvenings = new String[evenings.size()];
  for (int i = 0; i<evenings.size(); i++ ) {
    allEvenings[i] = evenings.get(i).cashAfterCounted + "," + evenings.get(i).cashAfterExpected + "," + evenings.get(i).cashBefore + "," + evenings.get(i).cashDifference + ","
      + evenings.get(i).date + "," + evenings.get(i).expenditure + "," + evenings.get(i).film + "," + evenings.get(i).numberOfVisitors + "," + evenings.get(i).salesVolume + ","
      + evenings.get(i).responsible;

    String [] storageBefore = new String [evenings.get(i).storageBefore.size()];
    for (int t = 0; t<evenings.get(i).storageBefore.size(); t++ ) {
      storageBefore[t] = "" + evenings.get(i).storageBefore.get(t);
    }
    deleteOldFile(i + "storageBefore.csv");
    saveStrings(i + "storageBefore.csv", storageBefore);

    String [] storageAfter = new String [evenings.get(i).storageAfter.size()];
    for (int t = 0; t<evenings.get(i).storageAfter.size(); t++ ) {
      storageAfter[t] = "" + evenings.get(i).storageAfter.get(t);
    }
    deleteOldFile(i + "storageAfter.csv");
    saveStrings(i + "storageAfter.csv", storageAfter);

    String [] storageDifference = new String [evenings.get(i).storageDifference.size()];
    for (int t = 0; t<evenings.get(i).storageDifference.size(); t++ ) {
      storageDifference[t] = "" + evenings.get(i).storageDifference.get(t);
    }
    deleteOldFile(i + "storageDifference.csv");
    saveStrings(i + "storageDifference.csv", storageDifference);
  }
  deleteOldFile("evenings.csv");
  saveStrings("evenings.csv", allEvenings);
}

ArrayList <Evening> loadEvenings() {

  String [] allEvenings = loadStrings("evenings.csv");
  ArrayList <Evening> evening = new ArrayList();

  for (int i = 0; i<allEvenings.length; i++ ) {
    String []data = allEvenings[i].split(",");
    Evening example = new Evening();
    example.cashAfterCounted = float(data[0]);
    example.cashAfterExpected = float(data[1]);
    example.cashBefore = float(data[2]);
    example.cashDifference = float(data[3]);
    example.date = data[4];
    example.expenditure = float(data[5]);
    example.film = data[6];
    example.numberOfVisitors = int(data[7]);
    example.salesVolume = float(data[8]);
    example.responsible = data[9];

    String storageBefore [] = loadStrings(i + "storageBefore.csv");
    for (int t = 0; t<storageBefore.length; t++ ) {
      example.storageBefore.add(int(storageBefore[t]));
    }

    String storageAfter [] = loadStrings(i + "storageAfter.csv");
    for (int t = 0; t<storageAfter.length; t++ ) {
      example.storageAfter.add(int(storageAfter[t]));
    }

    String storageDifference [] = loadStrings(i + "storageDifference.csv");
    for (int t = 0; t<storageDifference.length; t++ ) {
      example.storageDifference.add(int(storageDifference[t]));
    }
    evening.add(example);
  }
  return evening;
}

void makeEveningCsvDocument(Evening today) {
  if (!boolean(universalLoad("grantedWrite")))requestPermissions();
  String lines [] = new String[15 + today.storageBefore.size()];

  lines[0] = "Datum: " + today.date;
  lines[1] = "Verantwortlicher: " + today.responsible;
  lines[2] = "Film: " + today.film;
  lines[3] = "Besucher: " + today.numberOfVisitors;
  lines[4] = "";
  lines[5] = "Umsatz: " + today.salesVolume + "€"; 
  lines[6] = "";
  lines[7] = "Kassenstand vorher: " + today.cashBefore + "€"; 
  lines[8] = "Kassenstand nachher gezahlt: " + today.cashAfterCounted + "€"; //ä
  lines[9] = "";
  lines[10] = "Kassenstand nachher erwartet: " + today.cashAfterExpected + "€"; 
  lines[11] = "Abweichung von der Erwartung: " + today.cashDifference + "€"; 
  lines[12] = "";
  lines[13] = "Lagerbestand  zum Beginn - zum Ende - und Verkaufszahl:";
  lines[14] = "";

  for (int i = 0; i<today.storageBefore.size(); i++ ) {
    lines[i + 15] = products.get(i).name + ":";
    for (int t = 0; t<18 - products.get(i).name.length(); t++ ) {
      lines[i + 15] += " ";
    }
    lines[i + 15] += today.storageBefore.get(i);
    if ((today.storageBefore.get(i) + "").length() == 1)lines[i + 15] += " ";
    lines[i + 15] += " - ";
    lines[i + 15] += today.storageAfter.get(i);
    if ((today.storageAfter.get(i) + "").length() == 1)lines[i + 15] += " ";
    lines[i + 15] += " - ";
    lines[i + 15] += - today.storageDifference.get(i);
  }
  saveStrings("/storage/emulated/0/AKFilm/" + today.date + ".txt", lines);
}// ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  ||  || 

boolean txtExist(String name) {
  boolean result = true;
  try {
    String []lines = loadStrings(name);
    println(lines[0]);
  }
  catch(Exception e) {
    result = false;
  }
  return result;
}

void createDocuments() {
  createAKFilmMembersDocument();
  universalSave("check", " ");
  universalSave("loginUserName", "");
  universalSave("loginUserPassword", "");
  universalSave("loginRegistrationUsername", "");
  universalSave("loginRegistrationUserpassword", "");
  universalSave("loginWriteState", "0");
  universalSave("loginRegistrationWriteState", "0");
  universalSave("userLogedInWileLogoutState", "");
  universalSave("usernameWhileLogout", "");
  universalSave("expenditure", "");
  universalSave("cashAfterCounted", "");
  universalSave("numberOfVisitors", "");
  universalSave("filmTitle", "");
  universalSave("eveningActivity", "false");
  universalSave("balancesState", "0");
  universalSave("selectionWriteState", "0");
  universalSave("kassenstand", "0");
  universalSave("selectedaccessCategory", "0");
  universalSave("totalTimeTimerTime", "0");
  universalSave("totalTimeTimerStartTime", "0");
  universalSave("touchStartedX", "0");
  universalSave("touchStartedY", "0");
  universalSave("tenPeopleRegistrated", "false");
  universalSave("grantedRead", "false");
  universalSave("grantedWrite", "false");
  universalSave("products", "");
  setScroll(0, CASH_REGISTER_PRODUCTS);
  setScroll(0, CASH_REGISTER_SELECTION);
  universalCreateDocument("auswahl");
  universalCreateDocument("startTime");
  universalCreateDocument("actualEvening");
  universalCreateDocument("actualEveningStorageBefore");
  universalCreateDocument("actualEveningStorageAfter");
  universalCreateDocument("actualEveningStorageDifference");
  universalCreateDocument("evenings");
  String[]arr = new String[100];
  universalSaveArray("purchaseNumberOfProduct", arr);
}
