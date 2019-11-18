import java.io.File; //<>//
import select.files.*;
import android.os.Build;
import android.os.Environment;
import java.io.FileNotFoundException;

int state = 2;
boolean developerMode = false; //false for first run
boolean keyboardState = false;
int colorMode;
int homeState = 0;
int balancesState;
int loginState = 0;
int cashRegisterState = 0;
int stockOverviewState = 0;
int manualAmountInputState = 0;
int productAddingState = 0;
int specialpmouseY = 0;
int specialpmouseX = 0;
boolean isFirstDraw = true;
boolean permissionRequestionClosed = false;
boolean isFirstRun;
ArrayList <Product> products = new ArrayList(); 
ArrayList <Evening> evenings = new ArrayList();
ArrayList <PImage> imagesList = new ArrayList();

HashMap<String, PImage> images = new HashMap<String, PImage>();
HashMap<String, Textfield>textfields = new HashMap<String, Textfield>();
HashMap<String, ImageField>imageFields = new HashMap<String, ImageField>();
HashMap<String, Integer>colors = new HashMap<String, Integer>();

PFont theNextFont, arial, codeBold, antipasto;


AKFilmMember guest; 
AKFilmMember actualAKFilmMember;
ArrayList<AKFilmMember>AKFilmMemberList = new ArrayList<AKFilmMember>();
SelectLibrary files = new SelectLibrary(this);
Evening today = new Evening();



void setup() { 

  size(displayWidth, displayHeight, P2D);
  //size(int(displayWidth * 0.83333), displayHeight);//für Endprodukt zurücksetzen
  orientation(LANDSCAPE);
  theNextFont = createFont("TheNextFont.ttf", width/6);
  arial = createFont("Arial.ttf", width/6); //createFont("Arial.ttf", width/20);

  if (!txtExist("check.csv") && developerMode == false) {
    println("first run");
    createDocuments();
    actualAKFilmMember = new AKFilmMember ("Gast", "", 3);
    isFirstRun = true;
  } else {
    if (developerMode)guest = new AKFilmMember ("Gast", "", 3);
    else guest = new AKFilmMember ("Gast", "", 0);
    actualAKFilmMember = guest;
    println("not first run");
  }
  if (!adminRegistrated())actualAKFilmMember = new AKFilmMember ("Gast", "", 3);

  colorMode = DARK_MODE;
  loadImages(colorMode);
  createTextfields();
  createImageFields();
  createColors();
  startTotalTimeTimer();
  requestPermissions();
  //universalSave("eveningActivity", "false");
  universalSave("passedTimeThisRun", "0");
} 

void makeSetup() {
  products = loadProducts();
  //actualizeStorage(loadStorage());
  //ändern: AKFilmMemberList = sortAKFilmMemberList(loadAKFilmMembers()) //muss nach Hinzufügung oder Entfernung eines Mitglieds aktualisiert werden
  AKFilmMemberList = loadAKFilmMembers();
  //println(AKFilmMemberList.size() + " liste");
  universalSave(LOGIN_REGISTRATION_WRITE_STATE, "0");
  universalSave(LOGIN_WRITE_STATE, "0");
  universalSave(LOGIN_USERNAME, "");
  universalSave(LOGIN_USERPASSWORD, "");
  setScroll(0, CASH_REGISTER_PRODUCTS);
  setScroll(0, CASH_REGISTER_SELECTION);
  setScroll(0, STOCK_OVERVIEW_PRODUCTS);
  clearSelection();
  if (boolean(universalLoad(BALANCES_EVENING_ACTIVITY))) {
    today = loadActualEvening();
  }
  balancesState = int(universalLoad(BALANCES_STATE));
  if (loadEvenings().size()>0) {
    evenings = loadEvenings();
  }
  //startAddingNewPurchase();
  stockOverviewState = STOCK_OVERVIEW_STANDARD;
  //drawSidebar();
  imagesList = readImages(products.size());
  //textFont(arial);
  //textFont(theNextFont);
  //drawBalances();
  //drawHome();
  //drawLogin(LOGIN_STANDARD);
  //drawCashRegister(imagesList, 0);
  //drawStorageOverview(STOCK_OVERVIEW_STANDARD);
  //hhloadPixels();
  updatePixels();
}



void draw() {
  if (hasPermission("android.permission.READ_EXTERNAL_STORAGE") && hasPermission("android.permission.WRITE_EXTERNAL_STORAGE")) {
    if (isFirstDraw) {
      println("permission given");
      makeSetup();
      if (isFirstRun) {
        products = createProducts();
        saveProducts(products);
        imagesList = readImages(products.size());
        actualAKFilmMember = new AKFilmMember("Gast", "", 3);
      }
    }

    saveTotalTimeTimerTime();
    startTotalTimeTimer();
    savePassedTimeThisRun();
    switch(state) {
      /* 0 = > Home
       1 = > Bilanzen
       2 = > Login
       3 = > Kasse
       4 = > Bestandsübersicht
       */

    case HOME:
      if (homeState == HOME_STANDARD)drawHome();
      else if (homeState == HOME_AMOUNT_INPUT)showAmountInput(manualAmountInputState);
      else drawHome();
      break;
    case BALANCES:
      if (balancesState == 0)drawBalances();
      else if (balancesState == 1)showEveningnameTextfield(universalLoad(BALANCES_FILM_TITLE));
      else if (balancesState == 2)showNumberOfVisitorsTextField(universalLoad(BALANCES_NUMBER_OF_VISITORS));
      else if (balancesState == 3)showCashAfterCountedTextField(universalLoad(BALANCES_CASH_AFTER_COUNTED));
      //else if (balancesState == 4)showExpenditureTextField(universalLoad(BALANCES_EXPENDITURE));
      else if (balancesState == 5)showCashDifference();
      else if (balancesState == BALANCES_CASH_IN_HAND_DISPLAY)showCashInHandDisplay();
      else if (balancesState == BALANCES_FUNCTION_AVAILANLE_FROM_LEVEL_2)showNotificationAvailableFromLevel(2);
      break;
    case LOGIN:
      if (loginState == 0)drawLogin(LOGIN_STANDARD);
      else if (loginState == 1)drawLogin(LOGIN_USER_LOGED_OUT);
      else if (loginState == 2)showAKFilmMembersList(SELECT_USER_TO_LOG_IN);
      else if (loginState == 3)drawLogin(LOGIN_USER_NOT_FOUND_ERROR);
      else if (loginState == 4)drawLogin(LOGIN_USER_ALREADY_LOGED_IN_MESSAGE);
      else if (loginState == 5)drawLogin(LOGIN_PASSWORD_IS_WRONG_ERROR);
      else if (loginState == 6)drawLogin(LOGIN_USER_LOGED_IN_CONFIRMATION);
      else if (loginState == 7)showAddNewAKFilmMemberUserInterface(boolean(universalLoad("tenPeopleRegistrated")), LOGIN_CREATE_NEW_USER);
      else if (loginState == 8)drawLogin(LOGIN_REGISTRATION_AKFILM_MEMBER_ADDED_SUCCESSFULLY_MESSAGE);
      else if (loginState == 9)showNotificationAvailableFromLevel(3);
      else if (loginState == 10)showAKFilmMembersList(LOGIN_CHANGE_USER_STRING);
      else if (loginState == 11)showAddNewAKFilmMemberUserInterface(boolean(universalLoad("tenPeopleRegistrated")), LOGIN_CHANGE_USER_STRING);
      else if (loginState == 12)showNoUsersRegistratedMessage();
      break;
    case CASH_REGISTER:
      if (cashRegisterState == 0)drawCashRegister(imagesList, 0);
      else if (cashRegisterState == 1)drawCashRegister(imagesList, 1);
      break;
    case STOCK_OVERVIEW:
      if (stockOverviewState == STOCK_OVERVIEW_STANDARD)drawStorageOverview(STOCK_OVERVIEW_STANDARD);
      else if (stockOverviewState == STOCK_OVERVIEW_OPTIONS)showAddingOptions();
      else if (stockOverviewState == STOCK_OVERVIEW_NEW_PURCHASE)drawStorageOverview(STOCK_OVERVIEW_NEW_PURCHASE);
      else if (stockOverviewState == STOCK_OVERVIEW_STOCK_CORRECTION)drawStorageOverview(STOCK_OVERVIEW_STOCK_CORRECTION);
      else if (stockOverviewState == STOCK_OVERVIEW_STOCK_CORRECTION_RUNNING)drawStorageOverview(STOCK_OVERVIEW_STOCK_CORRECTION_RUNNING);
      else if (stockOverviewState == STOCK_OVERVIEW_NEW_PURCHASE_ADDING_RUNNING)drawStorageOverview(STOCK_OVERVIEW_NEW_PURCHASE_ADDING_RUNNING);
      else if (stockOverviewState == STOCK_OVERVIEW_QUIT_PURCHASE_WINDOW)drawStorageOverview(STOCK_OVERVIEW_QUIT_NEW_PURCHASE);
      else if (stockOverviewState == STOCK_OVERVIEW_ENTER_COMPLETE_PURCHASE_PRICE_WINDOW)showEnterCompletePurchasePriceWindow(universalLoad(STOCK_OVERVIEW_PURCHASE_PRICE));
      else if (stockOverviewState == STOCK_OVERVIEW_FUNCTION_AVAILABLE_FROM_LEVEL_2)showNotificationAvailableFromLevel(2);
      else if (stockOverviewState == STOCK_OVERVIEW_FUNCTION_AVAILABLE_FROM_LEVEL_3)showNotificationAvailableFromLevel(3);
      else if (stockOverviewState == STOCK_OVERVIEW_SHOW_PRODUCT_ADMINISTRATION_OPTIONS)openProductAdministrationOptions();
      else if (stockOverviewState == STOCK_OVERVIEW_PRODUCT_ADMINISTRATION_CREATE_PRODUCT)showCreateProductInterface();
      else if (stockOverviewState == STOCK_OVERVIEW_PRODUCT_ADMINISTRATION_SELECT_PRODUCT_TO_CHANGE)drawStorageOverview(STOCK_OVERVIEW_PRODUCT_ADMINISTRATION_SELECT_PRODUCT_TO_CHANGE);
      else if (stockOverviewState == STOCK_OVERVIEW_PRODUCT_ADMINISTRATION_CHANGE_PRODUCT)showChangeProductInterface();
      else if (stockOverviewState == STOCK_OVERVIEW_PRODUCT_ADMINISTRATION_CREATE_DEPOSIT)showCreateDepositInterface();
      else if (stockOverviewState == STOCK_OVERVIEW_PRODUCT_ADMINISTRATION_CHANGE_DEPOSIT)showChangeDepositInterface();
      //select deposit
      break;
    }
    if (isFirstDraw == true && (permissionRequestionClosed || boolean(universalLoad("grantedRead")) || Build.VERSION.SDK_INT <= 23))isFirstDraw = false;
  }
}


void touchStarted() {
  specialpmouseX = int(touches[0].x);
  specialpmouseY = int(touches[0].y);
  universalSave("touchStartedX", touches[0].x + "");
  universalSave("touchStartedY", touches[0].y + "");
  saveTouchStartTime(millis());
  if ((int(universalLoad(CASH_REGISTER_WRITE_STATE)) == 1 || int(universalLoad(CASH_REGISTER_WRITE_STATE)) == 2) && (touches.length == 1 && touches[0].y<height/1.28))universalSave(CASH_REGISTER_WRITE_STATE, 0 + "");
}


void touchEnded() {
  stopTouchTime();
}


void backPressed() {
  myOpenKeyboard();
}

void specialMouseClicked() {
  if (actualAKFilmMember.accessCategory != 0) {
    if (mouseAndPositionWereInside(0, 0, width/8.2, height/1.28/5 * 1, "CORNERS")) {
      state = HOME;
      myCloseKeyboard();
    } else if (mouseAndPositionWereInside(0, height/1.28/5 * 1, width/8.2, height/1.28/5 * 2, "CORNERS")) {
      state = BALANCES;
    } else if (mouseAndPositionWereInside(0, height/1.28/5 * 2, width/8.2, height/1.28/5 * 3, "CORNERS")) {
      state = LOGIN;
      loginState = LOGIN_STANDARD;
      myCloseKeyboard();
      universalSave(LOGIN_WRITE_STATE, "0");
    } else if (mouseAndPositionWereInside(0, height/1.28/5 * 3, width/8.2, height/1.28/5 * 4, "CORNERS")) {
      state = CASH_REGISTER;
    } else if (mouseAndPositionWereInside(0, height/1.28/5 * 4, width/8.2, height/1.28/5 * 5, "CORNERS")) {
      state = STOCK_OVERVIEW;
    }
  }

  switch(state) {
  case HOME:
    if (mouseAndPositionWereInside(width - width/8.2, 0, width, height/1.28/5 * 1, "CORNERS") && !boolean(universalLoad(BALANCES_EVENING_ACTIVITY))) {
      homeState = 1;
      manualAmountInputState = 0;
      myOpenKeyboard();
      textfields.get("manualAmountsValue").isActive = true;
    } else if (mouseAndPositionWereInside(width - width/8.2, height/1.28/5 * 1, width, height/1.28/5 * 2, "CORNERS")) {
      homeState = 2;
    } else if (mouseAndPositionWereInside(width - width/8.2, height/1.28/5 * 2, width, height/1.28/5 * 3, "CORNERS")) {
      homeState = 3;
    } else if (imageFields.get("activateDarkMode").mouseAndPosWereInside()) {
      changeColorMode();
    }
    //} else if (mouseAndPositionWereInside(width - width/8.2, height/1.28/5 * 3, width, height/1.28/5 * 4)) {
    //} else if (mouseAndPositionWereInside(width - width/8.2, height/1.28/5 * 4, width, height/1.28/5 * 5)) {
    //}

    switch(homeState) {
    case HOME_AMOUNT_INPUT:
      //Textfeld angeklickt, wird aktiviert
      if (textfields.get("manualAmountsValue").mouseAndPosWereInside()) {
        manualAmountInputState = 0;
        textfields.get("manualAmountsValue").isActive = !textfields.get("manualAmountsValue").isActive;
        textfields.get("manualAmountsUsage").isActive = false;
      } else if (textfields.get("manualAmountsUsage").mouseAndPosWereInside()) {
        manualAmountInputState = 0;
        textfields.get("manualAmountsUsage").isActive = !textfields.get("manualAmountsUsage").isActive;
        textfields.get("manualAmountsValue").isActive = false;
      }
      //Button angeklickt, wird ausgeführt  
      if (imageFields.get("yesHomeManualAmountInput").mouseAndPosWereInside()) {
        if (textfields.get("manualAmountsUsage").text.length()>2 && isRealMoneyValue(textfields.get("manualAmountsValue").text)) {
          myCloseKeyboard();
          homeState = 0;
          //universalSave(float(universalLoad("kassenstand")) + float(textfields.get("manualAmountsValue").text) + "", "kassenstand");
          float cashPosition = float(universalLoad(CASH_REGISTER_CASH_POSITION));
          cashPosition += float(textfields.get("manualAmountsValue").text);
          cashPosition = roundToDecimals(cashPosition, 2);
          universalSave(CASH_REGISTER_CASH_POSITION, cashPosition + "");
          textfields.get("manualAmountsValue").isActive = false;
          textfields.get("manualAmountsUsage").isActive = false;
          textfields.get("manualAmountsValue").text = "";
          textfields.get("manualAmountsUsage").text = "";
        } else if (textfields.get("manualAmountsUsage").text.length()>2)manualAmountInputState = PLEASE_ENTER_VALID_VALUE_ERROR;
        else if (isRealMoneyValue(textfields.get("manualAmountsValue").text))manualAmountInputState = PLEASE_ENTER_USAGE_ERROR;
        else manualAmountInputState = PLEASE_ENTER_VALID_VALUE_ERROR;
        //Usage und Betrag im Protokoll speichern
      } else if (imageFields.get("noHomeManualAmountInput").mouseAndPosWereInside()) {
        textfields.get("manualAmountsValue").isActive = false;
        textfields.get("manualAmountsUsage").isActive = false;
        textfields.get("manualAmountsValue").text = "";
        textfields.get("manualAmountsUsage").text = "";
        myCloseKeyboard();
        homeState = 0;
      }
      break;
    }
    break;




    //wenn man in der Ansicht der Bilanzen ist
  case BALANCES:
    switch(balancesState) {

    case BALANCES_ENTER_CASH_COUNTED:
      //Bestätigen - Button
      if (mouseIsInsideBalancesYes() && Math.round(float(universalLoad(BALANCES_CASH_AFTER_COUNTED)))>0) {
        myCloseKeyboard();
        balancesState = BALANCES_CONFIRM_POSSIBLE_DEVIATION;
      }
      //Abbrechen - Button
      else if (mouseIsInsideBalancesNo()) {
        showNumberOfVisitorsTextField(universalLoad(BALANCES_NUMBER_OF_VISITORS));
        universalSave(BALANCES_CASH_AFTER_COUNTED, "");
      }
      break;

      //wenn man bei der Bestätigung der Abweichung vom erwarteten Kassenstand ist
    case BALANCES_CONFIRM_POSSIBLE_DEVIATION:
      if (mouseAndPositionWereInside(width/1.28, height/1.48, width/1.28 + width/7, height/1.48 + width/7, "CORNERS"))endEvening();
      break;

      //Eingabe des Filmtitels
    case BALANCES_ENTER_FILM_TITLE:
      //Bestätigen
      if (mouseIsInsideBalancesYes()) {
        addNewEvening(universalLoad(BALANCES_FILM_TITLE));
        balancesState = 0;
        universalSave(BALANCES_STATE, balancesState + "");
      }
      //Abbrechen
      else if (mouseIsInsideBalancesNo()) {
        balancesState = 0;
        universalSave(BALANCES_FILM_TITLE, "");
        drawBalances();
      }
      break;

    case BALANCES_ENTER_NUMBER_OF_VISITORS:
      //Bestätigen - Button
      if (mouseIsInsideBalancesYes() && Math.round(float(universalLoad(BALANCES_NUMBER_OF_VISITORS)))>0) {
        closeEvening();
        balancesState = BALANCES_ENTER_CASH_COUNTED;
      }
      //Abbrechen - Button
      else if (mouseIsInsideBalancesNo()) {
        balancesState = 0;
        universalSave("balancesState", "0");
        universalSave("eveningActivity", "true");
        universalSave(BALANCES_NUMBER_OF_VISITORS, "");
        drawBalances();
      }
      break;

    case BALANCES_CASH_IN_HAND_DISPLAY:
      if (imageFields.get("backbutton").mouseAndPosWereInside())balancesState = 0;
      break;

    case BALANCES_STANDARD:
      //wenn das Kassenstand - Anzeigen - Symbol angeklickt wird
      if (imageFields.get("balancesCashInHandDisplayIcon").mouseAndPosWereInside() && balancesState == 0)balancesState = BALANCES_CASH_IN_HAND_DISPLAY;
      String eveningRunning = universalLoad(BALANCES_EVENING_ACTIVITY);

      if (boolean(eveningRunning)) {
        //wenn der rote Übergangs - Button angeklickt wird um den Abend abzubrechen
        if (mouseAndPositionWereInside(width/2 - width/16, height/2 - width/16, width/2 - width/16 + width/8, height/2 - width/16 + width/8, "CORNERS")) {
          showNumberOfVisitorsTextField("");
        }
      } else {
        //wenn der Plus - Button angetippt wird
        int numberOfEvenings = 0;
        if (numberOfEvenings>3)numberOfEvenings = 3;
        float boxSize = height/28;
        float displayingWidth = (boxSize * (28 - 4))/3;
        if (mouseAndPositionWereInside(width/8.2 + (width - width/8.2)/2, numberOfEvenings * displayingWidth + height/12, width/10, width/10, "CENTER")) {
          showEveningnameTextfield("");
        }
      }
      break;

    case BALANCES_FUNCTION_AVAILANLE_FROM_LEVEL_2:
      if (imageFields.get("backbutton").mouseAndPosWereInside())balancesState = 0;
      break;
    }
    break;


  case LOGIN:
    if (loginState != 2 && loginState != 7 && loginState != 11 && loginState != 10) {
      //prüfen ob in das Username - Feld geklickt wird
      if (mouseAndPositionWereInside(width/6.3 + textWidth("Name:") + width/110, height/2.7 - height/10, width/1.1, height/2.7 + height/22, "CORNERS")) {
        universalSave(LOGIN_WRITE_STATE, "1");
        loginState = LOGIN_STANDARD;
        myOpenKeyboard();
        //prüfen ob in das Passwort - Feld geklickt wird
      } else if (mouseAndPositionWereInside(width/6.3 + textWidth("Passwort:") + width/110, height/1.87 - height/10, width/1.1, height/1.87 + height/22, "CORNERS")) {
        universalSave(LOGIN_WRITE_STATE, "2");
        loginState = LOGIN_STANDARD;
        if (!keyboardState)myOpenKeyboard();
        //prüfen ob in einen leren Bereich geklickt wird
      } else if (mouseAndPositionWereInside(width/8.2, 0, width, height/4, "CORNERS")) {
        if (keyboardState)myChangeKeyboardState();
        universalSave(LOGIN_WRITE_STATE, "0");
        loginState = LOGIN_STANDARD;
      }
    }

    switch(loginState) {
    case LOGIN_STANDARD:
      //prüfen ob der Logout - Button angeklickt wird
      if (mouseAndPositionWereInside(width/8.2 + (width - width/8.2) * 0.25 - width/6.6/2, height/1.33 - width/6.6/2, width/8.2 + (width - width/8.2) * 0.25 + width/6.6/2, height/1.33 + width/6.6/2, "CORNERS")) {
        saveLogoutData();
        logoutActualAKFilmMember();
        //prüfen ob die Mitglieder - Liste angeklickt wird
      } else if (mouseAndPositionWereInside(width/8.2 + (width - width/8.2) * 0.5 - width/6.8/2, height/1.33 - width/6.8/2, width/8.2 + (width - width/8.2) * 0.5 + width/6.8/2, height/1.33 + width/6.8/2, "CORNERS")) {
        if (AKFilmMemberList.size()>0) {
          showAKFilmMembersList(SELECT_USER_TO_LOG_IN);
          startTimer();
        } else loginState = LOGIN_SHOW_NO_USERS_REGISTRATED_MESSAGE;
        //prüfen ob der Eingabe - Bestätigen - Button angeklickt wird
      } else if (mouseAndPositionWereInside(width/8.2 + (width - width/8.2) * 0.75 - width/6.6/2, height/1.33 - width/6.6/2, width/8.2 + (width - width/8.2) * 0.75 + width/6.6/2, height/1.33 + width/6.6/2, "CORNERS") && universalLoad(LOGIN_USERNAME).length()>0)checkLoginData(universalLoad(LOGIN_USERNAME), universalLoad(LOGIN_USERPASSWORD));
      //prüfen ob der Nutzer - Hinzufügen - Button angeklickt wird
      else if (mouseAndPositionWereInside(width/8.2/2 - width/24 + height/100, height/1.28 + (height - height/1.28)/2 - height/200 - width/24, width/8.2/2 + height/100 + width/24, height/1.28 + (height - height/1.28)/2 - height/200 + width/24, "CORNERS")) {
        if (actualAKFilmMember.accessCategory >= 3) {
          clearLoginRegistrationDocuments();
          startTimer();
          showAddNewAKFilmMemberUserInterface(boolean(universalLoad("tenPeopleRegistrated")), LOGIN_CREATE_NEW_USER);
        } else loginState = LOGIN_FUNCTION_AVAILABLE_FROM_LEVEL_3;
      }
      break;

    case 2:
      //wenn ein Eintrag aus der Mitglieder - Liste angeklickt wird
      if (loadTimerTime()>350)checkIfAKFilmMemberListNamefieldGotClicked(SELECT_USER_TO_LOG_IN);
      //wenn der Zurück - Button angeklickt wird
      if (mouseAndPositionWereInside(width/8.2/2 - width/12 + height/100, height/1.28 + (height - height/1.28)/2 - height/200 - width/12, width/8.2/2 + height/100 + width/12, height/1.28 + (height - height/1.28)/2 - height/200 + width/12, "CORNERS")) {
        loginState = 0;
      }
      break;

    case LOGIN_USER_REGISTRATION:
      //prüfen ob in das Username - Feld geklickt wird
      if (mouseAndPositionWereInside(width/6.3 + textWidth("Name:") + width/110, height/2.7 - height/10, width/1.1, height/2.7 + height/22, "CORNERS")) {
        universalSave(LOGIN_REGISTRATION_WRITE_STATE, "1");
        myOpenKeyboard();
        //prüfen ob in das Passwort - Feld geklickt wird
      } else if (mouseAndPositionWereInside(width/6.3 + textWidth("Passwort:") + width/110, height/1.87 - height/10, width/1.1, height/1.87 + height/22, "CORNERS")) {
        universalSave(LOGIN_REGISTRATION_WRITE_STATE, "2");
        if (!keyboardState)myOpenKeyboard();
        //prüfen ob in einen leeren Bereich geklickt wird
      } else if (mouseAndPositionWereInside(width/8.2, 0, width, height/4, "CORNERS")) {
        if (keyboardState)myChangeKeyboardState();
        universalSave(LOGIN_REGISTRATION_WRITE_STATE, "0");
      }

      //Links - Pfeil
      if (mouseAndPositionWereInside(width/2.37 - width/50, height/1.51 - width/24, width/2.37 + width/50, height/1.51 + width/24, "CORNERS") && int(universalLoad(LOGIN_SELECTED_ACCESS_CATEGORY))>1) {
        universalSave(LOGIN_SELECTED_ACCESS_CATEGORY, int(universalLoad(LOGIN_SELECTED_ACCESS_CATEGORY)) - 1 + "");

        //Rechts - Pfeil
      } else if (mouseAndPositionWereInside(width/1.89 - width/50, height/1.51 - width/24, width/1.89 + width/50, height/1.51 + width/24, "CORNERS") && int(universalLoad(LOGIN_SELECTED_ACCESS_CATEGORY))<3) {
        universalSave(LOGIN_SELECTED_ACCESS_CATEGORY, int(universalLoad(LOGIN_SELECTED_ACCESS_CATEGORY)) + 1 + "");

        //Bestätigen - Button
      } else if (imageFields.get("confirmAddingNewUser").mouseAndPosWereInside()) {
        if (loginRegistrationDataRightness()) {
          if (loadAKFilmMembers().size()<10) {
            addNewAKFilmMember(processLoginRegistrationData());
            //saveAKFilmMembers(AKFilmMemberList);
            AKFilmMemberList = sortAKFilmMemberList(loadAKFilmMembers());//muss nach Hinzufügung oder Entfernung eines Mitglieds aktualisiert werden
            saveAKFilmMembers(AKFilmMemberList);
            showAKFilmMemberAddedSuccessfullyMessage();
          } else {
            universalSave("tenPeopleRegistrated", "true");
            clearLoginRegistrationDocuments();
          }
        }
        //Mitglieder - Verwaltung
      } else if (imageFields.get("contactList").mouseAndPosWereInside()) {
        if (AKFilmMemberList.size()>0) {
          if (actualAKFilmMember.accessCategory>2)loginState = LOGIN_SELECT_USER_TO_CHANGE;
          else loginState = LOGIN_FUNCTION_AVAILABLE_FROM_LEVEL_3;
        } else loginState = LOGIN_SHOW_NO_USERS_REGISTRATED_MESSAGE;
        //Änderungsprotokoll
      } else if (mouseAndPositionWereInside(width/1.1 - height/7.3, height/1.51 - height/7.3, width/1.1 + height/7.3, height/1.51 + height/7.3, "CORNERS")) {
        showAKFilmMemberProtocol();
      } //Zurück - Button
      else if (mouseAndPositionWereInside(width/8.2/2 - width/12 + height/100, height/1.28 + (height - height/1.28)/2 - height/200 - width/12, width/8.2/2 + height/100 + width/12, height/1.28 + (height - height/1.28)/2 - height/200 + width/12, "CORNERS") && loadTimerTime()>350) {
        loginState = 0;
      } 
      break;

    case LOGIN_FUNCTION_AVAILABLE_FROM_LEVEL_3:
      if (imageFields.get("backbutton").mouseAndPosWereInside())loginState = LOGIN_STANDARD;
      break;

    case LOGIN_SELECT_USER_TO_CHANGE:
      checkIfAKFilmMemberListNamefieldGotClicked(LOGIN_CHANGE_USER_STRING);
      if (imageFields.get("backbutton").mouseAndPosWereInside())loginState = LOGIN_USER_REGISTRATION;
      break;

    case LOGIN_CHANGE_USER:
      //prüfen ob in das Username - Feld geklickt wird
      if (mouseAndPositionWereInside(width/6.3 + textWidth("Name:") + width/110, height/2.7 - height/10, width/1.1, height/2.7 + height/22, "CORNERS")) {
        universalSave(LOGIN_REGISTRATION_WRITE_STATE, "1");
        myOpenKeyboard();
        //prüfen ob in das Passwort - Feld geklickt wird
      } else if (mouseAndPositionWereInside(width/6.3 + textWidth("Passwort:") + width/110, height/1.87 - height/10, width/1.1, height/1.87 + height/22, "CORNERS")) {
        universalSave(LOGIN_REGISTRATION_WRITE_STATE, "2");
        if (!keyboardState)myOpenKeyboard();
        //prüfen ob in einen leeren Bereich geklickt wird
      } else if (mouseAndPositionWereInside(width/8.2, 0, width, height/4, "CORNERS")) {
        if (keyboardState)myChangeKeyboardState();
        universalSave(LOGIN_REGISTRATION_WRITE_STATE, "0");
      }

      //Links - Pfeil
      if (mouseAndPositionWereInside(width/2.37 - width/50, height/1.51 - width/24, width/2.37 + width/50, height/1.51 + width/24, "CORNERS") && int(universalLoad(LOGIN_SELECTED_ACCESS_CATEGORY))>1) {
        universalSave(LOGIN_SELECTED_ACCESS_CATEGORY, int(universalLoad(LOGIN_SELECTED_ACCESS_CATEGORY)) - 1 + "");

        //Rechts - Pfeil
      } else if (mouseAndPositionWereInside(width/1.89 - width/50, height/1.51 - width/24, width/1.89 + width/50, height/1.51 + width/24, "CORNERS") && int(universalLoad(LOGIN_SELECTED_ACCESS_CATEGORY))<3) {
        universalSave(LOGIN_SELECTED_ACCESS_CATEGORY, int(universalLoad(LOGIN_SELECTED_ACCESS_CATEGORY)) + 1 + "");

        //Bestätigen - Button
      } else if (imageFields.get("confirmAddingNewUser").mouseAndPosWereInside()) {
        //Speichern der Änderungen
        if (loginRegistrationDataRightness()) {
          AKFilmMember selectedToChange = AKFilmMemberList.get(int(universalLoad(USER_SELECTED_TO_CHANGE)));
          selectedToChange.name = universalLoad(LOGIN_REGISTRATION_USERNAME);
          selectedToChange.password = universalLoad(LOGIN_REGISTRATION_USERPASSWORD);
          selectedToChange.accessCategory = int(universalLoad(LOGIN_SELECTED_ACCESS_CATEGORY));
          loginState = LOGIN_SELECT_USER_TO_CHANGE;
          //saveAKFilmMembers(AKFilmMemberList);
          AKFilmMemberList = sortAKFilmMemberList(AKFilmMemberList);
          saveAKFilmMembers(AKFilmMemberList);
          clearLoginRegistrationDocuments();
        }
        //Delete - Button
      } else if (imageFields.get("deleteUser").mouseAndPosWereInside() && AKFilmMemberList.get(int(universalLoad(USER_SELECTED_TO_CHANGE))).accessCategory != 3) {
        AKFilmMemberList.remove(int(universalLoad(USER_SELECTED_TO_CHANGE)));
        saveAKFilmMembers(AKFilmMemberList);
        loginState = LOGIN_SELECT_USER_TO_CHANGE;
      }
      //Zurück - Button
      if (mouseAndPositionWereInside(width/8.2/2 - width/12 + height/100, height/1.28 + (height - height/1.28)/2 - height/200 - width/12, width/8.2/2 + height/100 + width/12, height/1.28 + (height - height/1.28)/2 - height/200 + width/12, "CORNERS") && loadTimerTime()>350) {
        loginState = LOGIN_SELECT_USER_TO_CHANGE;
        clearLoginRegistrationDocuments();
      }
      break;
    }
    break;





  case CASH_REGISTER:
    switch(cashRegisterState) {
    case CASH_REGISTER_STANDARD:
      //Kauf Bestätigen
      if (mouseAndPositionWereInside(width/1.16, height/1.24, width/1.16 + width/8, height/1.24 + width/8, "CORNERS"))simulateSale(loadSelection());
      //Kauf Abbrechen
      else if (mouseAndPositionWereInside(width/1.38, height/1.24, width/1.38 + width/8, height/1.24 + width/8, "CORNERS"))quitSale(loadSelection());
      //Produkte anklicken  
      if ((balancesState == BALANCES_STANDARD || balancesState == BALANCES_CASH_IN_HAND_DISPLAY) && boolean(universalLoad(BALANCES_EVENING_ACTIVITY))) {
        checkIfFieldIsClickedAndAddIt();
      }
      //Artikel entfernen
      if (findElementToRemove()  != - 1122 && loadSelection().length > 0 && findElementToRemove()  != - 1) {
        if (findElementToRemove() <  loadSelection().length) {
          cashRegisterState = 1;
          universalSave("elementToRemoveNumber", loadSelection()[findElementToRemove()]);
          universalSave("elementToRemove", findElementToRemove() + "");
        }
      }
      break;

    case CASH_REGISTER_DELETE_PRODUCT:
      //Produkt NICHT ENTFERNEN 
      if (mouseAndPositionWereInside(width/8.2 + (width - width/8.2)/2 - width/1.5/2, height/2.1, width/8.2 + (width - width/8.2)/2, (height - (height - height/1.28))/2 + height/3.3, "CORNERS"))cashRegisterState = 0;  
      //Produkt ENTFERNEN 
      if (mouseAndPositionWereInside(width/8.2 + (width - width/8.2)/2, height/2.1, width/8.2 + (width - width/8.2)/2 + width/1.5/2, (height - (height - height/1.28))/2 + height/3.3, "CORNERS")) {
        removeSelectedElement(int(universalLoad("elementToRemove")));
        //products.get(int(universalLoad("elementToRemoveNumber")) - 1).inStorage++ ;
        cashRegisterState = 0;
      }
      break;
    }
    break;




  case STOCK_OVERVIEW:
    if (checkWhichProductGotClicked() != - 1 && (stockOverviewState == STOCK_OVERVIEW_STOCK_CORRECTION || stockOverviewState == STOCK_OVERVIEW_NEW_PURCHASE
      || stockOverviewState == STOCK_OVERVIEW_PRODUCT_ADMINISTRATION_SELECT_PRODUCT_TO_CHANGE)) {
      startTimer();
      universalSave("selectedStockCorrection", "0");
      universalSave("clickedProduct", checkWhichProductGotClicked() + "");
      if (stockOverviewState == STOCK_OVERVIEW_STOCK_CORRECTION)stockOverviewState = STOCK_OVERVIEW_STOCK_CORRECTION_RUNNING;
      else if (stockOverviewState == STOCK_OVERVIEW_NEW_PURCHASE) {
        universalSave("purchaseNumberOfTheClickedProductBefore", universalLoadArray("purchaseNumberOfProduct")[int(universalLoad("clickedProduct"))] + "");
        stockOverviewState = STOCK_OVERVIEW_NEW_PURCHASE_ADDING_RUNNING;
      }
    }

    switch(stockOverviewState) {

    case STOCK_OVERVIEW_OPTIONS:
      //Backbutton
      if (mouseAndPositionWereInside(0, height/1.28, width/8.2, height, "CORNERS") && loadTimerTime()>350) {
        setScroll(0, STOCK_OVERVIEW_PRODUCTS);
        stockOverviewState = STOCK_OVERVIEW_STANDARD;
      }
      //Einkaufshinzufügung
      if (mouseAndPositionWereInside(width/8.2, height/1.28/3 * 0, width, height/1.28/3 * 1, "CORNERS")) {
        if (products.size() != 0) {
          if (actualAKFilmMember.accessCategory >= 2)startAddingNewPurchase();
          else stockOverviewState = STOCK_OVERVIEW_FUNCTION_AVAILABLE_FROM_LEVEL_2;
        } else stockOverviewState = STOCK_OVERVIEW_STANDARD;
        //Bestandskorrektur
      } else if (mouseAndPositionWereInside(width/8.2, height/1.28/3 * 1, width, height/1.28/3 * 2, "CORNERS")) {
        if (actualAKFilmMember.accessCategory >= 2) {
          setScroll(0, STOCK_OVERVIEW_PRODUCTS);
          stockOverviewState = STOCK_OVERVIEW_STOCK_CORRECTION;
        } else stockOverviewState = STOCK_OVERVIEW_FUNCTION_AVAILABLE_FROM_LEVEL_2;
        //Produktverwaltung
      } else if (mouseAndPositionWereInside(width/8.2, height/1.28/3 * 2, width, height/1.28/3 * 3, "CORNERS")) {
        if (actualAKFilmMember.accessCategory >= 3) {
          openProductAdministrationOptions();
          stockOverviewState = STOCK_OVERVIEW_SHOW_PRODUCT_ADMINISTRATION_OPTIONS;
        } else stockOverviewState = STOCK_OVERVIEW_FUNCTION_AVAILABLE_FROM_LEVEL_3;
      }
      break;

    case STOCK_OVERVIEW_STANDARD:
      if (mouseAndPositionWereInside(0, height/1.28, width/8.2, height, "CORNERS") && !boolean(universalLoad(BALANCES_EVENING_ACTIVITY))) {
        startTimer();
        stockOverviewState = STOCK_OVERVIEW_OPTIONS;
      }
      break;

    case STOCK_OVERVIEW_NEW_PURCHASE:
      //wenn der Abbrechen - /Zurück - Button bei der Einkaufshinzufügung angeklickt wird
      if (mouseAndPositionWereInside(0, height/1.28, width/8.2, height/1.28 + height/11, "CORNERS")) {
        //arial = createFont("Arial", height/10);
        showQuitNewPurchaseWindow();
        //wenn der Bestätigen - Button bei der Einkaufshinzufügung angeklickt wird
      } else if (mouseAndPositionWereInside(0, height/1.28 + height/11, width/8.2, height, "CORNERS")) {
        int numberOfAddedProducts = 0;
        String[]purchaseNumbers = universalLoadArray("purchaseNumberOfProduct");
        for (int i = 0; i<purchaseNumbers.length; i++ ) {
          numberOfAddedProducts += int(purchaseNumbers[i]);
          products.get(i).inStorage += int(purchaseNumbers[i]);
        }
        saveProducts(products);
        if (numberOfAddedProducts>0) {
          universalSave("numberOfAddedProducts", numberOfAddedProducts + "");
          universalSave(STOCK_OVERVIEW_PURCHASE_PRICE, "");
          stockOverviewState = STOCK_OVERVIEW_ENTER_COMPLETE_PURCHASE_PRICE_WINDOW;
          showEnterCompletePurchasePriceWindow(universalLoad(STOCK_OVERVIEW_PURCHASE_PRICE));
        }
      }
      break;

    case STOCK_OVERVIEW_STOCK_CORRECTION:
      if (mouseAndPositionWereInside(0, height/1.28, width/8.2, height, "CORNERS")) {
        startTimer();
        stockOverviewState = STOCK_OVERVIEW_OPTIONS;
      }
      break;

    case STOCK_OVERVIEW_STOCK_CORRECTION_RUNNING:

      //wenn der Abbrechen - Button im Bestandskorrektur - Fenster angeklickt wird
      if (loadTimerTime()>350 && mouseAndPositionWereInside( width/8.2 + (width - width/8.2)/2 - height/9.5 - height/12.4, height/1.45 - height/12.4, width/8.2 + (width - width/8.2)/2 - height/9.5 + height/12.4, height/1.45 + height/12.4, "CORNERS")) {
        stockOverviewState = STOCK_OVERVIEW_STOCK_CORRECTION;
        //wenn der Bestätigen - Button im Bestandskorrektur - Fenster angeklickt wird
      } else if (loadTimerTime()>350 && mouseAndPositionWereInside( width/8.2 + (width - width/8.2)/2 + height/9.5 - height/12.4, height/1.45 - height/12.4, width/8.2 + (width - width/8.2)/2 + height/9.5 + height/12.4, height/1.45 + height/12.4, "CORNERS")) {
        products.get(int(universalLoad("clickedProduct"))).inStorage += int(universalLoad("selectedStockCorrection"));
        stockOverviewState = STOCK_OVERVIEW_STOCK_CORRECTION;
        //saveStorage();
        saveProducts(products);
      }
      //wenn das Plus im Bestandskorrektur - Fenster angeklickt wird
      if (mouseAndPositionWereInside(width/8.2 + (width - width/8.2)/2 + width/4.2 - height/7.6/2, height/2 - height/7.6/2, width/8.2 + (width - width/8.2)/2 + width/4.2 + height/7.6/2, height/2 + height/7.6/2, "CORNERS")) {
        universalSave("selectedStockCorrection", int(universalLoad("selectedStockCorrection")) + 1 + "");
        //wenn das Minus im Bestandskorrektur - Fenster angeklickt wird
      } else if (mouseAndPositionWereInside(width/8.2 + (width - width/8.2)/2 - width/4.2 - height/5.7/2, height/2 - height/5.7/2, width/8.2 + (width - width/8.2)/2 - width/4.2 + height/5.7/2, height/2 + height/5.7/2, "CORNERS") && products.get(int(universalLoad("clickedProduct"))).inStorage + int(universalLoad("selectedStockCorrection"))>0) {
        universalSave("selectedStockCorrection", int(universalLoad("selectedStockCorrection")) - 1 + "");
      }
      break;

    case STOCK_OVERVIEW_NEW_PURCHASE_ADDING_RUNNING:
      //wenn der Abbrechen - Button im Produkteinkauf - Hinzufügen - Fenster angeklickt wird
      if (loadTimerTime()>350 && mouseAndPositionWereInside( width/8.2 + (width - width/8.2)/2 - height/9.5 - height/12.4, height/1.45 - height/12.4, width/8.2 + (width - width/8.2)/2 - height/9.5 + height/12.4, height/1.45 + height/12.4, "CORNERS")) {
        String []purchaseNumberOfProduct = universalLoadArray("purchaseNumberOfProduct");
        purchaseNumberOfProduct[int(universalLoad("clickedProduct"))] = universalLoad("purchaseNumberOfTheClickedProductBefore");
        universalSaveArray("purchaseNumberOfProduct", purchaseNumberOfProduct);
        stockOverviewState = STOCK_OVERVIEW_NEW_PURCHASE;
        //wenn der Bestätigen - Button im Produkteinkauf - Hinzufügen - Fenster angeklickt wird
      } else if (loadTimerTime()>350 && mouseAndPositionWereInside( width/8.2 + (width - width/8.2)/2 + height/9.5 - height/12.4, height/1.45 - height/12.4, width/8.2 + (width - width/8.2)/2 + height/9.5 + height/12.4, height/1.45 + height/12.4, "CORNERS")) {
        stockOverviewState = STOCK_OVERVIEW_NEW_PURCHASE;
      }
      //wenn das Plus im Einkauf - Hinzufügungs - Fenster angeklickt wird
      if (mouseAndPositionWereInside(width/8.2 + (width - width/8.2)/2 + width/4.2 - height/7.6/2, height/2 - height/7.6/2, width/8.2 + (width - width/8.2)/2 + width/4.2 + height/7.6/2, height/2 + height/7.6/2, "CORNERS")) {
        String []purchaseNumberOfProduct = universalLoadArray("purchaseNumberOfProduct");
        purchaseNumberOfProduct[int(universalLoad("clickedProduct"))] = (int(purchaseNumberOfProduct[int(universalLoad("clickedProduct"))]) + 1) + "";
        universalSaveArray("purchaseNumberOfProduct", purchaseNumberOfProduct);

        //wenn das Minus im Einkauf - Hinzufügungs - Fenster angeklickt wird
      } else if (mouseAndPositionWereInside(width/8.2 + (width - width/8.2)/2 - width/4.2 - height/5.7/2, height/2 - height/5.7/2, width/8.2 + (width - width/8.2)/2 - width/4.2 + height/5.7/2, height/2 + height/5.7/2, "CORNERS")) {
        String []purchaseNumberOfProduct = universalLoadArray("purchaseNumberOfProduct");
        if (int(purchaseNumberOfProduct[int(universalLoad("clickedProduct"))])>0) {
          purchaseNumberOfProduct[int(universalLoad("clickedProduct"))] = (int(purchaseNumberOfProduct[int(universalLoad("clickedProduct"))]) - 1) + "";
          universalSaveArray("purchaseNumberOfProduct", purchaseNumberOfProduct);
        }
      }
      break;

    case STOCK_OVERVIEW_QUIT_PURCHASE_WINDOW:
      //wenn der Abbrechen - Button im Einkaufshinzufügung - Abbrechen - Fenster angeklickt wird
      if (mouseAndPositionWereInside(width/8.2 + (width - width/8.2)/2 - width/3, height/1.7, width/1.5/2, height/5, "CORNER")) {
        stockOverviewState = STOCK_OVERVIEW_NEW_PURCHASE;
        //wenn der Bestätigen - Button im Einkaufshinzufügung - Abbrechen - Fenster  angeklickt wird
      } else if (mouseAndPositionWereInside(width/8.2 + (width - width/8.2)/2 - width/3 + width/1.5/2, height/1.7, width/1.5/2, height/5, "CORNER")) {
        stockOverviewState = STOCK_OVERVIEW_STANDARD;
      }
      break;
    case  STOCK_OVERVIEW_ENTER_COMPLETE_PURCHASE_PRICE_WINDOW:
      //Bestätigen - Button
      if (mouseIsInsideBalancesYes() && Math.round(float(universalLoad(STOCK_OVERVIEW_PURCHASE_PRICE)))>0) {    
        stockOverviewState = STOCK_OVERVIEW_OPTIONS;
        myCloseKeyboard();
        universalSave("kassenstand", float(universalLoad("kassenstand")) - float(universalLoad(STOCK_OVERVIEW_PURCHASE_PRICE)) + "");
      }
      //Abbrechen - Button
      else if (mouseIsInsideBalancesNo()) {
        myCloseKeyboard();
        stockOverviewState = STOCK_OVERVIEW_NEW_PURCHASE;
      }
      break;

    case STOCK_OVERVIEW_FUNCTION_AVAILABLE_FROM_LEVEL_2:
      if (imageFields.get("backbutton").mouseAndPosWereInside())stockOverviewState = STOCK_OVERVIEW_OPTIONS;
      break;

    case STOCK_OVERVIEW_FUNCTION_AVAILABLE_FROM_LEVEL_3:
      if (imageFields.get("backbutton").mouseAndPosWereInside())stockOverviewState = STOCK_OVERVIEW_OPTIONS;
      break;

    case STOCK_OVERVIEW_SHOW_PRODUCT_ADMINISTRATION_OPTIONS:
      //Backbutton
      if (imageFields.get("smallBackbutton").mouseAndPosWereInside() && loadTimerTime()>350) {       
        stockOverviewState = STOCK_OVERVIEW_OPTIONS;
      }
      //Produkt hinzufügen
      if (mouseAndPositionWereInside(width/8.2, height/4 * 0, width, height/4 * 1, "CORNERS")) {
        stockOverviewState = STOCK_OVERVIEW_PRODUCT_ADMINISTRATION_CREATE_PRODUCT;
        textfields.get("addProductPrice").text = "";
        textfields.get("addProductName").text = "";
        universalSave("imageSelected", "false");
        universalSave("imageLocation", "");
        //Produkt ändern
      } else if (mouseAndPositionWereInside(width/8.2, height/4 * 1, width, height/4 * 2, "CORNERS")) {
        if (products.size() != 0) stockOverviewState = STOCK_OVERVIEW_PRODUCT_ADMINISTRATION_SELECT_PRODUCT_TO_CHANGE;
        else stockOverviewState = STOCK_OVERVIEW_STANDARD;
        //Pfand hinzufügen
      } else if (mouseAndPositionWereInside(width/8.2, height/4 * 2, width, height/4 * 3, "CORNERS")) {       
        //stockOverviewState = STOCK_OVERVIEW_PRODUCT_ADMINISTRATION_CREATE_DEPOSIT;
        //myOpenKeyboard();
        //Pfand ändern
      } else if (mouseAndPositionWereInside(width/8.2, height/4 * 3, width, height/4 * 4, "CORNERS")) { 
        //stockOverviewState = STOCK_OVERVIEW_PRODUCT_ADMINISTRATION_CHANGE_DEPOSIT;
      }
      break;

    case STOCK_OVERVIEW_PRODUCT_ADMINISTRATION_CREATE_PRODUCT:
      //Textfeld angeklickt, wird aktiviert
      if (textfields.get("addProductName").mouseAndPosWereInside()) {
        if (!textfields.get("addProductPrice").isActive && !textfields.get("addProductName").isActive)myOpenKeyboard();
        else if (textfields.get("addProductName").isActive)myCloseKeyboard();
        textfields.get("addProductName").isActive = !textfields.get("addProductName").isActive;
        textfields.get("addProductPrice").isActive = false;
      } else if (textfields.get("addProductPrice").mouseAndPosWereInside()) {
        if (!textfields.get("addProductPrice").isActive && !textfields.get("addProductName").isActive)myOpenKeyboard();
        else if (textfields.get("addProductPrice").isActive)myCloseKeyboard();
        textfields.get("addProductPrice").isActive = !textfields.get("addProductPrice").isActive;
        textfields.get("addProductName").isActive = false;
      } else if (imageFields.get("smallBackbutton").mouseAndPosWereInside()) {
        stockOverviewState = STOCK_OVERVIEW_SHOW_PRODUCT_ADMINISTRATION_OPTIONS;
        myCloseKeyboard();
        textfields.get("addProductPrice").text = "";
        textfields.get("addProductName").text = "";
      } else {
        textfields.get("addProductName").isActive = false;
        textfields.get("addProductPrice").isActive = false;
        myCloseKeyboard();
      }
      if (imageFields.get("confirmProductAdding").mouseAndPosWereInside()) {
        if (textfields.get("addProductName").text.length()>3 && float(textfields.get("addProductPrice").text)>0 && boolean(universalLoad("imageSelected"))) {
          stockOverviewState = STOCK_OVERVIEW_SHOW_PRODUCT_ADMINISTRATION_OPTIONS;
          addProduct(textfields.get("addProductName").text, float(textfields.get("addProductPrice").text), universalLoad("imageLocation"));
          products = loadProducts();
          textfields.get("addProductPrice").text = "";
          textfields.get("addProductName").text = "";
          imagesList.add(products.get(products.size() - 1).productImage);
        }
      }
      if (mouseAndPositionWereInside(width/2, height/1.9, width/2.2, height/7, "CORNER"))openDialog();
      break;

    case STOCK_OVERVIEW_PRODUCT_ADMINISTRATION_SELECT_PRODUCT_TO_CHANGE:
      textfields.get("addProductName").text = products.get(int(universalLoad("clickedProduct"))).name;
      textfields.get("addProductPrice").text = products.get(int(universalLoad("clickedProduct"))).sellPrice + "";
      images.put("chosenImage", products.get(int(universalLoad("clickedProduct"))).productImage);
      stockOverviewState = STOCK_OVERVIEW_PRODUCT_ADMINISTRATION_CHANGE_PRODUCT;
      if (mouseAndPositionWereInside(0, height/1.28, width/8.2, height, "CORNERS")) {
        stockOverviewState = STOCK_OVERVIEW_SHOW_PRODUCT_ADMINISTRATION_OPTIONS;
      }
      break;

    case STOCK_OVERVIEW_PRODUCT_ADMINISTRATION_CHANGE_PRODUCT:
      if (textfields.get("addProductName").mouseAndPosWereInside()) {
        if (!textfields.get("addProductPrice").isActive && !textfields.get("addProductName").isActive)myOpenKeyboard();
        else if (textfields.get("addProductName").isActive)myCloseKeyboard();
        textfields.get("addProductName").isActive = !textfields.get("addProductName").isActive;
        textfields.get("addProductPrice").isActive = false;
      } else if (textfields.get("addProductPrice").mouseAndPosWereInside()) {
        if (!textfields.get("addProductPrice").isActive && !textfields.get("addProductName").isActive)myOpenKeyboard();
        else if (textfields.get("addProductPrice").isActive)myCloseKeyboard();
        textfields.get("addProductPrice").isActive = !textfields.get("addProductPrice").isActive;
        textfields.get("addProductName").isActive = false;
      } else if (imageFields.get("smallBackbutton").mouseAndPosWereInside()) {
        stockOverviewState = STOCK_OVERVIEW_PRODUCT_ADMINISTRATION_SELECT_PRODUCT_TO_CHANGE;
        images.remove("chosenImage");
        myCloseKeyboard();
        textfields.get("addProductPrice").text = "";
        textfields.get("addProductName").text = "";
      } else {
        textfields.get("addProductName").isActive = false;
        textfields.get("addProductPrice").isActive = false;
        myCloseKeyboard();
      }
      if (imageFields.get("deleteProduct").mouseAndPosWereInside()) {
        products.remove(products.get(int(universalLoad("clickedProduct"))));
        saveProducts(products);
        stockOverviewState = STOCK_OVERVIEW_SHOW_PRODUCT_ADMINISTRATION_OPTIONS;
      }
      if (imageFields.get("confirmProductAdding").mouseAndPosWereInside()) {
        if (textfields.get("addProductName").text.length()>3 && float(textfields.get("addProductPrice").text)>0 && boolean(universalLoad("imageSelected"))) {
          stockOverviewState = STOCK_OVERVIEW_SHOW_PRODUCT_ADMINISTRATION_OPTIONS;//change to showConfirmDeletingProgressWindow later
          products.get(int(universalLoad("clickedProduct"))).name = textfields.get("addProductName").text;
          products.get(int(universalLoad("clickedProduct"))).sellPrice = float(textfields.get("addProductPrice").text);
          products.get(int(universalLoad("clickedProduct"))).productImage = images.get("chosenImage");
          imagesList.add(products.get(products.size() - 1).productImage);
          images.remove("chosenImage");
        }
      }
      if (mouseAndPositionWereInside(width/2, height/1.9, width/2.2, height/7, "CORNER"))openDialog();
      break;
    }
    break;
  }
}


void touchMoved() {
  int specialmouseY = int(touches[0].y);
  int specialmouseX = int(touches[0].x);
  switch(state) {
  case CASH_REGISTER:
    switch(cashRegisterState) {
    case 0:
      if (boolean(universalLoad(BALANCES_EVENING_ACTIVITY)) && balancesState == 0 && specialmouseX>width/8.2 && specialmouseY<height/1.28) {
        saveScroll(CASH_REGISTER_PRODUCTS, specialmouseY - specialpmouseY);
      } else if (boolean(universalLoad(BALANCES_EVENING_ACTIVITY)) && balancesState == 0 && specialmouseX<width/80 + 2 * width/7 + width/7.48 && specialmouseY>height/1.28) {
        saveScroll(CASH_REGISTER_SELECTION, specialmouseX - specialpmouseX);
      }
      break;
    }
    break;
  case STOCK_OVERVIEW:
    if ((stockOverviewState == STOCK_OVERVIEW_STANDARD || stockOverviewState == STOCK_OVERVIEW_NEW_PURCHASE || stockOverviewState == STOCK_OVERVIEW_STOCK_CORRECTION) && specialmouseX>width/8.2) {
      saveScroll(STOCK_OVERVIEW_PRODUCTS, specialmouseY - specialpmouseY);
    }
    break;
  }
  specialpmouseY = int(touches[0].y);
  specialpmouseX = int(touches[0].x);
}


void keyPressed() {
  switch(key) {
  case 'q':
    println(changeTimeInHours(loadTotalTimeTimerTime()));
    break;
  }

  switch(state) {
  case HOME:
    switch(homeState) {
    case HOME_AMOUNT_INPUT:
      if (textfields.get("manualAmountsValue").isActive)textfields.get("manualAmountsValue").addText();
      else if (textfields.get("manualAmountsUsage").isActive)textfields.get("manualAmountsUsage").addText();
      break;
    }
    break;

  case BALANCES:
    switch(balancesState) {
    case 1:
      writeText(universalLoad(BALANCES_FILM_TITLE), balancesState);
      break;
    case 2:
      writeText(universalLoad(BALANCES_NUMBER_OF_VISITORS), balancesState);
      break;
    case 3:
      writeText(universalLoad(BALANCES_CASH_AFTER_COUNTED), balancesState);
      break;
    case 4:
      writeText(universalLoad(BALANCES_EXPENDITURE), balancesState);
      break;
    }
    break;

  case LOGIN:
    switch(loginState) {

    case LOGIN_STANDARD:
      if (keyCode == 66 && universalLoad(LOGIN_USERNAME).length()>0) {
        myCloseKeyboard();
        universalSave(LOGIN_WRITE_STATE, "0");
        checkLoginData(universalLoad(LOGIN_USERNAME), universalLoad(LOGIN_USERPASSWORD));
      }

      switch(int(universalLoad(LOGIN_WRITE_STATE))) {
      case 1:
        writeText(universalLoad(LOGIN_USERNAME), 5);
        break;
      case 2:
        writeText(universalLoad(LOGIN_USERPASSWORD), 6);
        break;
      }
      break;
    case LOGIN_USER_REGISTRATION:
      switch(int(universalLoad(LOGIN_REGISTRATION_WRITE_STATE))) {
      case 1:
        writeText(universalLoad(LOGIN_REGISTRATION_USERNAME), 7);
        break;
      case 2:
        writeText(universalLoad(LOGIN_REGISTRATION_USERPASSWORD), 8);
        break;
      }
      break;
    case LOGIN_CHANGE_USER:
      switch(int(universalLoad(LOGIN_REGISTRATION_WRITE_STATE))) {
      case 1:
        writeText(universalLoad(LOGIN_REGISTRATION_USERNAME), 7);
        break;
      case 2:
        writeText(universalLoad(LOGIN_REGISTRATION_USERPASSWORD), 8);
        break;
      }
      break;
    }
    break;
  case STOCK_OVERVIEW:
    switch(stockOverviewState) {
    case STOCK_OVERVIEW_ENTER_COMPLETE_PURCHASE_PRICE_WINDOW:
      writeText(universalLoad(STOCK_OVERVIEW_PURCHASE_PRICE), STOCK_OVERVIEW_ENTER_PURCHASE_PRICE_TEXTFIELD);
      break;
    case STOCK_OVERVIEW_PRODUCT_ADMINISTRATION_CREATE_PRODUCT:
      textfields.get("addProductName").addText();
      textfields.get("addProductPrice").addText();
      break;
    case STOCK_OVERVIEW_PRODUCT_ADMINISTRATION_CHANGE_PRODUCT:
      textfields.get("addProductName").addText();
      textfields.get("addProductPrice").addText();
      break;
    }
    break;
  }
}  
