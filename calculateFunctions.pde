void changeColorMode() {
  if (colorMode == LIGHT_MODE) {
    colorMode = DARK_MODE;
    colors.clear();
    colors.put("white", color(40));
    colors.put("black", color(150));
    colors.put("red", color(160, 45, 45));
    colors.put("green", color(60, 140, 50));
    colors.put("orange", color(180, 130, 35));
    colors.put("darkBlue", color(65, 130, 220));
  } else { 
    colorMode = LIGHT_MODE;
    colors.clear();
    colors.put("white", color(255));
    colors.put("black", color(0));
    colors.put("red", color(220, 0, 0));
    colors.put("green", color(0, 200, 0));
    colors.put("orange", color(255, 170, 0));
    colors.put("darkBlue", color(50, 130, 220));
  }
  loadImages(colorMode);
  createImageFields();
}

int getProductSelectedNumber(int index) {
  String [] selection = loadSelection();
  int counter = 0;
  for (int i = 0; i<selection.length; i++ ) {
    if (int(selection[i]) - 1 == index)counter++ ;
  }
  return counter;
}

void openDialog() { 
  if (!boolean(universalLoad("grantedRead"))) {
    requestPermissions();
  } 
  files.selectInput("Bitte Produktbild wahlen!", "fileSelected"); //ä
}

void fileSelected(File selection) {
  if (selection == null) {
  } else {
    if (fileIsImage(selection.getAbsolutePath())) {
      universalSave("imageLocation", selection.getAbsolutePath());
      PImage selectedImage = loadImage(selection.getAbsolutePath());
      images.put("chosenImage", selectedImage);
      universalSave("imageSelected", "true");
    }
  }
}

void startAddingNewPurchase() {
  stockOverviewState = STOCK_OVERVIEW_NEW_PURCHASE;
  String []purchaseNumberOfProduct = new String[products.size()];
  for (int i = 0; i<purchaseNumberOfProduct.length; i++ )purchaseNumberOfProduct[i] = 0 + "";
  universalSaveArray("purchaseNumberOfProduct", purchaseNumberOfProduct);
}

boolean loginRegistrationDataRightness() {
  if (universalLoad(LOGIN_REGISTRATION_USERNAME).length()>0 && universalLoad(LOGIN_REGISTRATION_USERPASSWORD).length()>0)return true;
  else return false;
}

AKFilmMember processLoginRegistrationData() {
  AKFilmMember newest = new  AKFilmMember(universalLoad(LOGIN_REGISTRATION_USERNAME), universalLoad(LOGIN_REGISTRATION_USERPASSWORD), int(universalLoad(LOGIN_SELECTED_ACCESS_CATEGORY)));
  newest.setAccessCategory(newest.accessCategory);
  return newest;
}

void openAKFilmMemberAdministration() {
}

void showAKFilmMemberProtocol() {
}

void clearLoginRegistrationDocuments() {
  universalSave(LOGIN_REGISTRATION_USERNAME, "");
  universalSave(LOGIN_REGISTRATION_USERPASSWORD, "");
  universalSave(LOGIN_SELECTED_ACCESS_CATEGORY, "1");
}



int checkWhichProductGotClicked() {
  int boxCounter = 0;
  int productsPerLine = 3;
  int numberOfLines = 0;
  int clickedProduct = - 1;
  float pictureHeight = height/8;
  float productWidth = (width - width/8.2)/3 - width/120;
  float distance = width/20;
  if (products.size()%3 == 0)numberOfLines = products.size();
  else numberOfLines = products.size() + 1;
  for (int line = 0; line<numberOfLines; line++ ) {
    for (int t = 0; t<productsPerLine && boxCounter<products.size(); t++ ) {
      if (mouseAndPositionWereInside(width/10 + t * productWidth + width/60 + height/60, width/35 + line * pictureHeight + line * distance - height/65 + int(universalLoad(STOCK_OVERVIEW_PRODUCTS)), width/10 + t * productWidth + width/60 + height/60 + productWidth, width/35 + line * pictureHeight + line * distance - height/65 + pictureHeight + int(universalLoad(STOCK_OVERVIEW_PRODUCTS)), "CORNERS")) {
        clickedProduct = boxCounter;
      }
      boxCounter++ ;
    }
  }
  return clickedProduct;
}


ArrayList<AKFilmMember>sortAKFilmMemberList(ArrayList<AKFilmMember>AKFilmMembers) {
  AKFilmMember[] newAKFilmMemberList = new AKFilmMember[AKFilmMembers.size()];
  String[] AKFilmMemberNames = new String[AKFilmMembers.size()];
  for (int i = 0; i<AKFilmMembers.size(); i++ )AKFilmMemberNames[i] = AKFilmMembers.get(i).name;
  AKFilmMemberNames = sort(AKFilmMemberNames);
  for (int i = 0; i<AKFilmMemberNames.length; i++ )for (int t = 0; t<AKFilmMembers.size(); t++ )if (AKFilmMemberNames[i].equals(AKFilmMembers.get(t).name))newAKFilmMemberList[i] = AKFilmMembers.get(t);
  ArrayList<AKFilmMember>newAKFilmMemberArrayList = new ArrayList<AKFilmMember>();
  for (int i = 0; i < newAKFilmMemberList.length; i++ ) {
    newAKFilmMemberArrayList.add(newAKFilmMemberList[i]);
  }
  return newAKFilmMemberArrayList;
}


void checkIfAKFilmMemberListNamefieldGotClicked(String mode) {
  for (int i = 0; i<loadAKFilmMembers().size(); i++ )if (mouseAndPositionWereInside(width/8.2, i * height/10, width, (i + 1) * height/10, "CORNERS")) {
    if (mode == SELECT_USER_TO_LOG_IN) {
      loginState = LOGIN_STANDARD;
      universalSave(LOGIN_USERNAME, loadAKFilmMembers().get(i).name);
      universalSave(LOGIN_WRITE_STATE, "0");
    } else if (mode == LOGIN_CHANGE_USER_STRING) {
      loginState = LOGIN_CHANGE_USER;
      universalSave(USER_SELECTED_TO_CHANGE, i + "");
      AKFilmMember selectedToChange = AKFilmMemberList.get(i);
      universalSave(LOGIN_REGISTRATION_USERNAME, selectedToChange.name);
      universalSave(LOGIN_REGISTRATION_USERPASSWORD, selectedToChange.password);
      universalSave(LOGIN_SELECTED_ACCESS_CATEGORY, selectedToChange.accessCategory + "");
    }
  }
}


void saveLogoutData() {
  if (actualAKFilmMember.name.toLowerCase().equals("gast"))universalSave(LOGIN_USER_LOGED_IN_STATE, "false");
  else universalSave(LOGIN_USER_LOGED_IN_STATE, "true");
  universalSave(LOGIN_USERNAME_WHILE_LOGOUT, actualAKFilmMember.name);
}



void checkLoginData(String username, String userpassword) {
  boolean userWasFound = false;
  boolean passwordIsRight = false;
  boolean userAlreadyLogedIn = false;
  ArrayList <AKFilmMember> AKFilmMembers = loadAKFilmMembers();
  for (int i = 0; i<AKFilmMembers.size(); i++ )if (AKFilmMembers.get(i).name.toLowerCase().equals(username.toLowerCase())) {
    if (actualAKFilmMember.name.toLowerCase().equals(AKFilmMembers.get(i).name.toLowerCase()))userAlreadyLogedIn = true;
    if (AKFilmMembers.get(i).password.equals(userpassword)) {
      passwordIsRight = true;
      actualAKFilmMember = AKFilmMembers.get(i);
    }
    userWasFound = true;
  }
  if (!userWasFound)showUserNotFoundError();
  else if (userAlreadyLogedIn)showUserAlreadyLogedInMessage();
  else if (!passwordIsRight)showPasswordIsWrongError();
  else if (userWasFound && passwordIsRight)showUserLogedInConfirmation();
}



void myChangeKeyboardState() {
  openKeyboard();
  keyboardState = !keyboardState;
}

void myOpenKeyboard() {
  if (!keyboardState) {
    openKeyboard();
  }
  keyboardState = true;
}

void myCloseKeyboard() {
  if (keyboardState) {
    closeKeyboard();
  }
  keyboardState = false;
}



void writeText(String text, int writeState) {

  if (keyCode == 67 && text.length()>0) {
    text = text.substring(0, text.length() - 1);
  } else if (keyCode != 67)text += key;// - auf textlänge in pixeln zugreifen und abfragen ob der neue String länger ist als diese


  switch(writeState) {
  case EVENINGNAME_TEXTFIELD:
    if ((keyIsLetter() || keyIsNumber() || key == ' ' || key == '.' || keyCode == 67) && text.length() <= 12) {
      universalSave(BALANCES_FILM_TITLE, text);
      showEveningnameTextfield(text);
    } else if (text.length()>0) text = text.substring(0, text.length() - 1);
    break;
  case NUMBER_OF_VISITORS_TEXTFIELD:
    if ((keyIsNumber() || keyCode == 67) && valueIsSmallEnough(2, text)) {
      universalSave(BALANCES_NUMBER_OF_VISITORS, text);
      showNumberOfVisitorsTextField(text);
    } else if (text.length()>0) text = text.substring(0, text.length() - 1);
    break;
  case CASH_AFTER_COUNTED_TEXTFIELD:
    if ((keyIsNumber() || keyCode == 67 || key == '.') && valueIsSmallEnough(4, text)) {
      universalSave(BALANCES_CASH_AFTER_COUNTED, text);
      showCashAfterCountedTextField(text);
    } else if (text.length()>0) text = text.substring(0, text.length() - 1);
    break;
  case EXPENDITURE_TEXTFIELD:
    if ((keyIsNumber() || keyCode == 67 || key == '.') && valueIsSmallEnough(2, text)) {
      universalSave(BALANCES_EXPENDITURE, text);
      showExpenditureTextField(text);
    } else if (text.length()>0)text = text.substring(0, text.length() - 1); 
    break;
  case LOGIN_USERNAME_TEXTFIELD:
    if ((keyIsNumber() || keyCode == 67 || key == '.' || key == ' ' || keyIsLetter()) && text.length() <= 18) {
      universalSave(LOGIN_USERNAME, text);
    } else if (text.length()>0)text = text.substring(0, text.length() - 1); 
    break;
  case LOGIN_USERPASSWORD_TEXTFIELD:
    if ((keyIsNumber() || keyCode == 67 || key == '.' || key == ' ' || keyIsLetter()) && text.length() <= 12) {
      universalSave(LOGIN_USERPASSWORD, text);
    } else if (text.length()>0)text = text.substring(0, text.length() - 1); 
    break;
  case LOGIN_REGISTRATION_USERNAME_TEXTFIELD:
    if ((keyIsNumber() || keyCode == 67 || key == '.' || key == ' ' || keyIsLetter()) && text.length() <= 18) {
      universalSave(LOGIN_REGISTRATION_USERNAME, text);
    } else if (text.length()>0)text = text.substring(0, text.length() - 1); 
    break;
  case LOGIN_REGISTRATION_USERPASSWORD_TEXTFIELD:
    if ((keyIsNumber() || keyCode == 67 || key == '.' || key == ' ' || keyIsLetter()) && text.length() <= 12) {
      universalSave(LOGIN_REGISTRATION_USERPASSWORD, text);
    } else if (text.length()>0)text = text.substring(0, text.length() - 1); 
    break;
  case STOCK_OVERVIEW_ENTER_PURCHASE_PRICE_TEXTFIELD:
    if ((keyIsNumber() || keyCode == 67 || key == '.') && valueIsSmallEnough(4, text)) {
      universalSave(STOCK_OVERVIEW_PURCHASE_PRICE, text);
    } else if (text.length()>0)text = text.substring(0, text.length() - 1); 
    break;
  }
}



void resetDocuments() {
  universalSave(BALANCES_FILM_TITLE, "");
  universalSave(BALANCES_NUMBER_OF_VISITORS, "");
  universalSave(BALANCES_CASH_AFTER_COUNTED, "");
  universalSave(BALANCES_EXPENDITURE, "");
}

void endEvening() {
  drawSidebar();
  universalSave(CASH_REGISTER_CASH_POSITION, float(universalLoad(BALANCES_CASH_AFTER_COUNTED)) + "");
  evenings.add(today);
  makeEveningCsvDocument(today);
  saveEvenings(evenings);
  today = new Evening();
  resetDocuments();
  balancesState = 0;
  universalSave(BALANCES_STATE, balancesState + "");
  universalSave(BALANCES_EVENING_ACTIVITY, false + "");
  drawBalances();
}

void addNewEvening(String filmTitle) {
  resetDocuments();
  universalSave(BALANCES_EVENING_ACTIVITY, true + "");
  drawBalances();
  today = new Evening();
  today.film = filmTitle;
  today.date = day() + "." + month() + "." + year();
  today.responsible = actualAKFilmMember.name;
  today.storageBefore = loadStorage();
  today.cashBefore = Math.round(float(universalLoad(CASH_REGISTER_CASH_POSITION)) * 100.0)/100.0;
  saveActualEvening(today);
}

void closeEvening() {
  today = loadActualEvening();
  today.storageAfter = loadStorage();
  for (int i = 0; i<today.storageAfter.size(); i++ )today.storageDifference.add(today.storageAfter.get(i) - today.storageBefore.get(i));
  today.cashAfterExpected = Math.round(float(universalLoad(CASH_REGISTER_CASH_POSITION)) * 100.0)/100.0;
}

void simulateSale(String[]selection) {
  if (selection.length>0) {
    String []selectionString = loadSelection();
    for (int i = 0; i<selectionString.length; i++ )products.get(int(selectionString[i]) - 1).inStorage-- ;
    saveProducts(products);
    //for (int i = 0; i<selection.length; i++ )products.get(i).inStorage -= int(selection[i]);
    saveProducts(products);
    universalSave(CASH_REGISTER_WRITE_STATE, "1");
    float cashPosition = float(universalLoad(CASH_REGISTER_CASH_POSITION));
    cashPosition += calculatePrice(selection);
    universalSave(CASH_REGISTER_CASH_POSITION, cashPosition + "");
    drawCashRegister(imagesList, cashRegisterState);
    noStroke();
    fill(colors.get("white"));
    rect(0, height/1.28 + 5, width, height - (height/1.28 + 5));
    textAlign(CENTER);
    textSize(width/12);
    fill(colors.get("green"));
    text("Verkauf abgeschlossen!", width/2, height/1.08);
    clearSelection();
    setScroll(0, CASH_REGISTER_SELECTION);
    for (int i = 0; i<selection.length; i++ )selection[i] = 0 + "";
    //universalSaveArrayList(new ArrayList<String>(), "bilderauswahl");
  }
}

void quitSale(String[]selection) {
  if (selection.length>0) {
    universalSave(CASH_REGISTER_WRITE_STATE, 2 + "");
    drawCashRegister(imagesList, cashRegisterState);
    noStroke();
    fill(colors.get("white"));
    rect(0, height/1.28 + 5, width, height - (height/1.28 + 5));
    textAlign(CENTER);
    textSize(width/12);
    fill(colors.get("white"), 0, 0);
    text("Verkauf abgebrochen!", width/2, height/1.08);
    clearSelection();
    setScroll(0, CASH_REGISTER_SELECTION);
    for (int i = 0; i<selection.length; i++ )selection[i] = 0 + "";
    //universalSaveArrayList(new ArrayList<String>(), "bilderauswahl");
  }
}



int checkWhichImageIsClicked() {
  int pictureNumber = 0;
  if (mouseAndPositionWereInside(width/8.2, 0, width, height/1.28, "CORNERS")) {
    int numberOfPictures = products.size();
    if (numberOfPictures != 0) {
      int shift = loadScroll(CASH_REGISTER_PRODUCTS);
      int boxCounter = 0;
      int numberOfFields = 5;
      int boxWidth = round(width/(numberOfFields + 1.32));
      int boxHeight = round(width/(numberOfFields + 0.7));
      int distance = round((width - boxWidth * 5)/(numberOfFields + 9));
      int numberOfLines = int(products.size()/5);

      for (int t = 0; t <= numberOfLines; t++ ) {
        for (int i = 0; i<numberOfFields; i++ ) {
          boxCounter++ ;
          if (mouseAndPositionWereInside(width/8.5 + (i + 1) * distance + i * boxWidth, (t + 0.7) * distance + t * boxHeight + shift, width/8.5 + (i + 1) * distance + i * boxWidth + boxWidth, (t + 0.7) * distance + t * boxHeight + boxHeight + shift, "CORNERS")) {
            pictureNumber = boxCounter;
          }
          if (boxCounter + 1>numberOfPictures) {
            i = numberOfFields;
            t = numberOfLines + 1;
          }
        }
      }
    }
  }
  return pictureNumber;
}

void checkIfFieldIsClickedAndAddIt() {
  String [] selectionString = loadSelection();
  ArrayList <String> selectionStringList = new ArrayList <String>();
  for (int i = 0; i<selectionString.length; i++ )selectionStringList.add(selectionString[i]);
  ArrayList <PImage> selection = new ArrayList();
  if (selectionStringList.size()>0)for (int i = 0; i<selectionStringList.size(); i++ ) {
    if (checkWhichImageIsClicked()>0)selection.add(products.get(int(selectionStringList.get(i)) - 1).productImage);
  }
  if (checkWhichImageIsClicked() != 0 && products.get(checkWhichImageIsClicked() - 1).inStorage - getProductSelectedNumber(checkWhichImageIsClicked() - 1)>0) {
    println(products.get(checkWhichImageIsClicked() - 1).inStorage - getProductSelectedNumber(checkWhichImageIsClicked() - 1));
    setScroll(0, CASH_REGISTER_SELECTION);
    selectionStringList.add(checkWhichImageIsClicked() + ""); 
    if (calculatePrice(selectionStringList) <= 9.99) {
      drawSelection(selection);
      showPrice(selectionStringList);
      saveSelection(selectionStringList);
    } else selectionStringList.remove(checkWhichImageIsClicked() + "");
  }
}

void showAvailableProducts() {
  String [] selectionString = loadSelection();
  ArrayList <String> selectionStringList = new ArrayList();
  if (selectionString.length>0)for (int i = 0; i<selectionString.length; i++ )selectionStringList.add(selectionString[i]);
  ArrayList <PImage> selection = new ArrayList();
  if (selectionString.length>0)for (int i = 0; i<selectionString.length; i++ )selection.add(products.get(int(selectionString[i]) - 1).productImage);
  drawSelection(selection);
  showPrice(selectionStringList);
  saveSelection(selectionStringList);
}


float calculatePrice(String[]selectionNumbers) {
  float price = 0;
  for (int i = 0; i<selectionNumbers.length; i++ ) {
    for (int t = 0; t<products.size(); t++ )if (products.get(t).number == int(selectionNumbers[i]) - 1)price += products.get(t).sellPrice;
  }
  return price;
}

float calculatePrice(ArrayList <String> selectionNumbers) {
  float price = 0;
  for (int i = 0; i<selectionNumbers.size(); i++ ) {
    for (int t = 0; t<products.size(); t++ )if (products.get(t).number == int(selectionNumbers.get(i)) - 1)price += products.get(t).sellPrice;
  }
  return price;
}

void loadImages(int colorTheme) {
  //images.clear();
  println(colorTheme+ " theme");
  String colorMode;
  if (colorTheme == DARK_MODE)colorMode = "DARK";
  else colorMode = "";

  PImage shoppingVenture = loadImage("einkaufswagen" + colorMode + ".png");
  PImage cashRegister = loadImage ("kasse" + colorMode + ".png");
  PImage balances = loadImage("bilanzen" + colorMode + ".png");
  PImage home = loadImage ("home" + colorMode + ".png");
  PImage login = loadImage ("login" + colorMode + ".png");
  PImage yes = loadImage("yes" + colorMode + ".png");
  PImage no = loadImage("no" + colorMode + ".png");
  PImage checkButton = loadImage("gruenerHaken" + colorMode + ".png");
  PImage plus = loadImage("plus" + colorMode + ".png");
  PImage minus = loadImage("minus" + colorMode + ".png");
  PImage loginKey = loadImage("login" + colorMode + ".png");
  PImage profilePic = loadImage("profilbild" + colorMode + ".png");
  PImage logoutButton = loadImage("logoutButton" + colorMode + ".png");
  PImage leftArrow = loadImage("pfeillinks" + colorMode + ".png");
  PImage rightArrow = loadImage("pfeilrechts" + colorMode + ".png");
  PImage confirmButton = loadImage("gruenerHaken" + colorMode + ".png");
  PImage contactList = loadImage("contactList" + colorMode + ".png");
  PImage protocol = loadImage("protocol" + colorMode + ".png");
  PImage backbutton = loadImage("backbutton" + colorMode + ".png");
  PImage star = loadImage("star" + colorMode + ".png");
  PImage redBackbutton = loadImage("redBackbutton" + colorMode + ".png");
  PImage settings = loadImage("settings" + colorMode + ".png");
  PImage help = loadImage("help" + colorMode + ".png");
  PImage expenditure = loadImage("expenditure" + colorMode + ".png");
  PImage credits = loadImage("credits" + colorMode + ".png");
  PImage bill = loadImage("bill" + colorMode + ".png");
  PImage delete = loadImage("delete" + colorMode + ".png");

  images.put("shoppingVenture", shoppingVenture);
  images.put("cashRegister", cashRegister);
  images.put("balances", balances);
  images.put("home", home);
  images.put("login", login);
  images.put("yes", yes);
  images.put("no", no);
  images.put("checkButton", checkButton);
  images.put("plus", plus);
  images.put("minus", minus);
  images.put("loginKey", loginKey);
  images.put("profilePic", profilePic);
  images.put("logoutButton", logoutButton);
  images.put("leftArrow", leftArrow);
  images.put("rightArrow", rightArrow);
  images.put("confirmButton", confirmButton);
  images.put("contactList", contactList);
  images.put("protocol", protocol);
  images.put("backbutton", backbutton);
  images.put("star", star);
  images.put("redBackbutton", redBackbutton);
  images.put("settings", settings);
  images.put("help", help);
  images.put("expenditure", expenditure);
  images.put("credits", credits);
  images.put("bill", bill);
  images.put("delete", delete);
}


int findElementToRemove() {
  String [] selection = loadSelection();
  float rightBorder = width/80 + 2 * width/7 + width/7.48;
  float pictureWidth = width/7;
  int stop = selection.length;
  if (stop<3)stop = 3;
  for (int i = 0; i <= stop; i++ )if (mouseAndPositionWereInside(0, height/1.28, width/7 * 3, height, "CORNERS") && mouseAndPositionWereInside(rightBorder - i * pictureWidth + loadScroll(CASH_REGISTER_SELECTION), height/1.28, rightBorder - (i + 1) * pictureWidth + loadScroll(CASH_REGISTER_SELECTION), height, "CORNERS")) {
    if (selection.length >= 3) return selection.length - i - 1;
    else if (selection.length == 2 && i == 1)return 1;
    else if (selection.length == 2 && i == 2)return 0;
    else if (selection.length == 1 && i == 2)return 0;
  }
  return - 1122;
}

void removeSelectedElement(int elementToRemove) {
  String [] selection = loadSelection();
  String [] newSelection = new String[selection.length - 1];
  for (int i = elementToRemove; i<selection.length - 1; i++ )selection[i] = selection[i + 1];
  for (int i = 0; i<newSelection.length; i++ )newSelection[i] = selection[i];
  saveSelection(newSelection);
  setScroll(0, CASH_REGISTER_SELECTION);
}

void requestPermissions() {
  if (!hasPermission("android.permission.READ_EXTERNAL_STORAGE")) {
    requestPermission("android.permission.READ_EXTERNAL_STORAGE", "handleREAD_EXTERNAL_STORAGE");
  }
  if (!hasPermission("android.permission.WRITE_EXTERNAL_STORAGE")) {
    requestPermission("android.permission.WRITE_EXTERNAL_STORAGE", "handleWRITE_EXTERNAL_STORAGE");
  }
}



boolean fileIsImage(String dataPath) {
  try {
    PImage image = loadImage(dataPath);
    image(image, 0, 0, 10, 10);
  }
  catch(Exception e) {
    return false;
  }
  return true;
}

void addProduct(String name, float price, String imageLocation) {
  ArrayList<Product> oldProducts;
  if (loadProducts().size()>0)oldProducts = loadProducts();
  else oldProducts = new ArrayList<Product>();
  Product recent = new Product(oldProducts.size(), price, loadImage(imageLocation), name, imageLocation, 0);
  oldProducts.add(recent);
  saveProducts(oldProducts);
}

void saveProducts(ArrayList<Product>products) {
  String [] data = new String[products.size()];
  for (int i = 0; i<data.length; i++ ) {
    data[i] = products.get(i).name + "," + products.get(i).sellPrice + "," + products.get(i).number + "," + products.get(i).imageLocation + "," + products.get(i).inStorage;
  }
  saveStrings("products.csv", data);
}

ArrayList <Product> loadProducts() {
  String [] data = loadStrings("products.csv");
  ArrayList<Product>loadedProducts = new ArrayList<Product>(); 
  for (int i = 0; i<data.length; i++ ) {
    String [] split = split(data[i], ",");
    if (split.length == 5) {
      loadedProducts.add(new Product(int(split[2]), float(split[1]), loadImage(split[3]), split[0], split[3], int(split[4])));
    }
  }
  return loadedProducts;
}

//später aus Dokument laden und wieder speichern, dann wenn die Hinzufügung und Änderung von Produkten unterstützt wird
ArrayList createProducts() {
  ArrayList <Product> products = new ArrayList();
  products.add (new Product (0, 1.0, loadImage("spezi.jpg"), "Spezi", "spezi.jpg", 20));//70ct + 30ct Pfand(von Käufer)Einkaufspfand?
  products.add (new Product (1, 1.1, loadImage("cola.png"), "Cola", "cola.png", 20));//80ct + 20ct Pfand(von Käufer)Kastenpfand?
  products.add (new Product (2, 0.50, loadImage("oreo.jpg"), "Oreo", "oreo.jpg", 20));
  products.add (new Product (3, 0.50, loadImage("cracker.jpg"), "Cracker", "cracker.jpg", 20));
  products.add (new Product (4, 0.60, loadImage("salzstangen.jpg"), "Salzstangen", "salzstangen.jpg", 20));
  products.add (new Product (5, 0.60, loadImage("jaffacake.jpg"), "Jaffa Cake", "jaffacake.jpg", 20));
  products.add (new Product (6, 0.80, loadImage("giotto.jpg"), "Giotto", "giotto.jpg", 20));
  products.add (new Product (7, 0.9, loadImage("chips.jpg"), "Chips", "chips.jpg", 20));//zweiter Einkaufspreise: 0.75€
  products.add (new Product (8, 1.1, loadImage("gebaeckstangen.jpg"), "Gebäckstangen", "gebaeckstangen.jpg", 20));
  products.add (new Product(9, 1.30, loadImage("gummibaerchen.jpg"), "Gummibärchen", "gummibaerchen.jpg", 20));//Achtung: evtl. verschiedene Einkaufspreise
  products.add (new Product(10, 1.30, loadImage("gummibaeren.jpg"), "Gummibären", "gummibaeren.jpg", 20));
  products.add (new Product(11, 1.0, loadImage("cookies.jpg"), "Cookies", "cookies.jpg", 20));
  products.add (new Product (12, 0.25, loadImage("kinderschokolade.jpg"), "Kinderschokolade", "kinderschokolade.jpg", 20));
  products.add (new Product (13, 1.30, loadImage("kartoffelringe.jpg"), "Kartoffelringe", "kartoffelringe.jpg", 20));
  products.add(new Product (14, 0.30, loadImage("neapolitaner.jpg"), "Neapolitaner", "neapolitaner.jpg", 20));
  products.add(new Product (15, 1.0, loadImage("sprite.jpg"), "Zitronenlimo", "sprite.jpg", 20)); 
  products.add(new Product (16, 0.9, loadImage("Nic-Nacs.jpg"), "Nic-Nacs", "Nic-Nacs.jpg", 20)); 
  return products;
}

float roundToDecimals(float myFloat, int n) {
  return(Math.round( myFloat * pow(10, n)) / pow(10, n));
}

String changeToMoneyValue(String input) {
  String[]splitted = split(input, '.');
  if (splitted.length == 2) {
    if (splitted.length>1 && splitted[1].length() == 1)splitted[1] += 0;  
    splitted[0] += ",";
    if (splitted.length>1 && splitted[1].length()>2)splitted[1] = splitted[1].substring(0, 2);
    if (splitted.length>1)splitted[1] += "E"; //€
    else splitted[0] += "E"; //€
    if (splitted.length>1)return splitted[0] + splitted[1];
    else return splitted[0];
  } else if (splitted.length == 1) {
    return input + ",00E"; //€
  }
  return "naN";
}

boolean valueIsSmallEnough(int maximalWholeNumbers, String text) {
  String [] list = split(text, '.');
  if (list.length == 1 && int(list[0])<pow(10, maximalWholeNumbers))return true;
  else if (list.length == 2 && int(list[0])<pow(10, maximalWholeNumbers) && list[1].length() <= 2)return true;
  else return false;
}

boolean keyIsNumber() {
  if (key == '0' || key == '1' || key == '2' || key == '3' || key == '4' || key == '4' || key == '5' || key == '6' || key == '7' || key == '8' || key == '9')return true;
  else return false;
}

boolean keyIsLetter() {
  if ( key == 'q' || key == 'w' || key == 'e' || key == 'r' || key == 't' || key == 'z' || key == 'u' || key == 'i' || key == 'o' || key == 'p' || 
    key == 'a' || key == 's' || key == 'd' || key == 'f' || key == 'g' || key == 'h' || key == 'j' || key == 'k' || key == 'l'  || 
    key == 'y' || key == 'x' || key == 'c' || key == 'v' || key == 'b' || key == 'n' || key == 'm' || 
    key == 'Q' || key == 'W' || key == 'E' || key == 'R' || key == 'T' || key == 'Z' || key == 'U' || key == 'I' || key == 'O' || key == 'P' ||
    key == 'A' || key == 'S' || key == 'D' || key == 'F' || key == 'G' || key == 'H' || key == 'J' || key == 'K' || key == 'L'  || 
    key == 'Y' || key == 'X' || key == 'C' || key == 'V' || key == 'B' || key == 'N' || key == 'M')return true;
  else return false;
}

//boolean keyIsSpecialCharacter()

//nicht ganz korrekt, weil Processing floats in den Nachkommastellen nicht genau berechnet!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//boolean valueIsMoney(float value) {
//  float checkValue = (value - int(value)) * 100;
//  if ((checkValue - int(checkValue))>0)return false;
//  else return true;
//}

boolean isRealMoneyValue(String text) {
  String [] list = split(text, '.');
  if (list.length == 2 && list[1].length() == 2)return true;
  else return false;
}

boolean mouseIsInsideBalancesYes() {
  if (imageFields.get("balancesYes").mouseAndPosWereInside()) return true;
  else return false;
}

boolean mouseIsInsideBalancesNo() {
  if (imageFields.get("balancesNo").mouseAndPosWereInside()) return true;
  else return false;
}

boolean mouseIsInside(float x1, float y1, float x2, float y2, String rectMode) {
  float lowX = 0;
  float highX = 0;
  float lowY = 0;
  float highY = 0;
  if (rectMode == "CORNERS") {
    lowX = Math.min(x1, x2);
    lowY = Math.min(y1, y2);
    highX = Math.max(x1, x2);
    highY = Math.max(y1, y2);
  } else if (rectMode == "CORNER") {
    lowX = x1;
    highX = x1 + x2;
    lowY = y1;
    highY = y1 + y2;
  } else if (rectMode == "CENTER") {
    lowX = x1 - x2/2;
    highX = x1 + x2/2;
    lowY = y1 - y2/2;
    highY = y1 + y2/2;
  }
  if (touches.length == 1)return(touches[0].x> lowX && touches[0].x<highX && touches[0].y>lowY && touches[0].y< highY);
  else return false;
}

boolean mouseWasInside(float x1, float y1, float x2, float y2, String rectMode) {
  float lowX = 0;
  float highX = 0;
  float lowY = 0;
  float highY = 0;
  if (rectMode == "CORNERS") {
    lowX = Math.min(x1, x2);
    lowY = Math.min(y1, y2);
    highX = Math.max(x1, x2);
    highY = Math.max(y1, y2);
  } else if (rectMode == "CORNER") {
    lowX = x1;
    highX = x1 + x2;
    lowY = y1;
    highY = y1 + y2;
  } else if (rectMode == "CENTER") {
    lowX = x1 - x2/2;
    highX = x1 + x2/2;
    lowY = y1 - y2/2;
    highY = y1 + y2/2;
  }
  return(specialpmouseX> lowX && specialpmouseX<highX && specialpmouseY>lowY && specialpmouseY< highY);
}

boolean positionIsInside(float positionX, float positionY, float x1, float y1, float x2, float y2, String rectMode) {
  float lowX = 0;
  float highX = 0;
  float lowY = 0;
  float highY = 0;
  if (rectMode == "CORNERS") {
    lowX = Math.min(x1, x2);
    lowY = Math.min(y1, y2);
    highX = Math.max(x1, x2);
    highY = Math.max(y1, y2);
  } else if (rectMode == "CORNER") {
    lowX = x1;
    highX = x1 + x2;
    lowY = y1;
    highY = y1 + y2;
  } else if (rectMode == "CENTER") {
    lowX = x1 - x2/2;
    highX = x1 + x2/2;
    lowY = y1 - y2/2;
    highY = y1 + y2/2;
  }
  return positionX>lowX && positionX<highX && positionY>lowY && positionY<highY;
}

boolean mouseAndPositionWereInside(float x1, float y1, float x2, float y2, String rectMode) {
  float positionX = float(universalLoad("touchStartedX"));
  float positionY = float(universalLoad("touchStartedY"));
  float lowX = 0;
  float highX = 0;
  float lowY = 0;
  float highY = 0;
  if (rectMode == "CORNERS") {
    lowX = Math.min(x1, x2);
    lowY = Math.min(y1, y2);
    highX = Math.max(x1, x2);
    highY = Math.max(y1, y2);
  } else if (rectMode == "CORNER") {
    lowX = x1;
    highX = x1 + x2;
    lowY = y1;
    highY = y1 + y2;
  } else if (rectMode ==  "CENTER") {
    lowX = x1 - x2/2;
    highX = x1 + x2/2;
    lowY = y1 - y2/2;
    highY = y1 + y2/2;
  }
  return specialpmouseX> lowX && specialpmouseX<highX && specialpmouseY>lowY && specialpmouseY< highY && positionX>lowX && positionX<highX && positionY>lowY && positionY<highY;
}

int getPosDifference() {
  return int(dist(specialpmouseX, specialpmouseY, mouseX, mouseY));
}

boolean adminRegistrated() {
  ArrayList <AKFilmMember> AKFilmMembers = loadAKFilmMembers();
  for (int i=0; i<AKFilmMembers.size(); i++) {
    if (AKFilmMembers.get(i).accessCategory == 3)return true;
  }
  return false;
}
