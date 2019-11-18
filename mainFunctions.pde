void drawHome() {
  background(colors.get("white"));
  fill(colors.get("black"));
  textFont(theNextFont);
  textSize(height/6.5);
  textAlign(CENTER, CENTER);
  text("HOME", width/2, height/7);
  drawSidebar();
  imageMode(CENTER);
  image(images.get("home"), width/2, height/1.8, height/2, height/2);
  drawHomeSidebar();
  imageFields.get("activateDarkMode").show();
}

void drawBalances() {
  //hierin muss später die aktuelle Bilanz des laufenden Abends angezeigt werden
  background(colors.get("white"));
  drawSidebar();
  myCloseKeyboard();

  if (!boolean(universalLoad(BALANCES_EVENING_ACTIVITY))) {
    balancesState = 0;
    universalSave(BALANCES_STATE, balancesState + "");
    int numberOfEvenings = 0;
    if (numberOfEvenings>3)numberOfEvenings = 3;
    float boxSize = height/28;
    float displayingWidth = (boxSize * (28 - 4))/3;
    fill(colors.get("black"));
    stroke(colors.get("white"));
    strokeWeight(1);
    //for(int i = 0;i<numberOfEvenings;i++ )rect(0,0 + i * displayingWidth,width,displayingWidth);
    for (int i = 0; i<numberOfEvenings; i++ )drawEveningOverview(i, displayingWidth);
    imageMode(CENTER);
    image(images.get("plus"), width/8.2 + (width - width/8.2)/2, numberOfEvenings * displayingWidth + height/12, width/10, width/10);
    //if(loadSidebarState())drawSidebar();
  } else {
    fill(colors.get("black"));
    textFont(arial);
    textSize(width/12);
    textAlign(CENTER);
    text("Klicken, um den\n Abend zu beenden!", width/1.85, height/5);
    rectMode(CORNER);
    fill(colors.get("red"));
    strokeWeight(1);
    rect(width/2 - width/16, height/2 - width/16, width/8, width/8);
  }
  imageFields.get("balancesCashInHandDisplayIcon").show();
}

void drawLogin(int mode) {

  pushStyle();
  background(colors.get("white"));
  drawSidebar();
  fill(colors.get("black"));
  textFont(theNextFont);
  textSize(height/6.5);
  textAlign(CENTER, CENTER);
  text("LOGIN", width/8.2 + (width - width/8.2)/2, height/7);
  popStyle();
  fill(colors.get("black"));
  textFont(arial);

  textAlign(CORNER, CENTER);
  textSize(height/10.35);
  text("Name:", width/6.3, height/3.1);
  text("Passwort:", width/6.3, height/2.05);
  stroke(colors.get("black"));
  if (int(universalLoad(LOGIN_WRITE_STATE)) == 1)stroke(colors.get("red"));
  line(width/6.3 + textWidth("Name:") + width/110, height/2.7, width/1.05, height/2.7);
  stroke(colors.get("black"));
  if (int(universalLoad(LOGIN_WRITE_STATE)) == 2)stroke(colors.get("red"));
  line(width/6.3 + textWidth("Passwort:") + width/110, height/1.87, width/1.05, height/1.87); 
  textSize(height/11);
  text(universalLoad(LOGIN_USERNAME), width/6.3 + textWidth("Name: ") + width/60, height/3.1);
  String userPasswordCrypted = "";
  for (int i = 0; i<universalLoad(LOGIN_USERPASSWORD).length(); i++ )userPasswordCrypted += "*";
  textSize(height/10.35);
  text(userPasswordCrypted, width/6.3 + textWidth("Passwort:") + width/60, height/1.98);
  strokeWeight(5);

  switch(mode) {
  case LOGIN_STANDARD:
    imageMode(CENTER);
    image(images.get("settings"), width/8.2/2, height/1.28 + (height - height/1.28)/2 - height/200, width/11.5 * 1.9, width/11.5);    
    image(images.get("logoutButton"), width/8.2 + (width - width/8.2) * 0.25, height/1.33, width/6.6, width/6.6);
    image(images.get("profilePic"), width/8.2 + (width - width/8.2) * 0.5, height/1.33, width/6.8, width/6.8);
    image(images.get("yes"), width/8.2 + (width - width/8.2) * 0.75, height/1.33, width/6.6, width/6.6);
    break;
  case LOGIN_USER_NOT_FOUND_ERROR:
    showUserNotFoundError();
    break;
  case LOGIN_USER_ALREADY_LOGED_IN_MESSAGE:
    showUserAlreadyLogedInMessage();
    break;
  case LOGIN_PASSWORD_IS_WRONG_ERROR:
    showPasswordIsWrongError();
    break;
  case LOGIN_USER_LOGED_IN_CONFIRMATION:
    showUserLogedInConfirmation();
    break;
  case LOGIN_USER_LOGED_OUT:
    showLogoutMessage();
    break;
  case LOGIN_REGISTRATION_AKFILM_MEMBER_ADDED_SUCCESSFULLY_MESSAGE:
    showAKFilmMemberAddedSuccessfullyMessage();
    break;
  }
}

void drawCashRegister(ArrayList <PImage> images, int state) {
  myCloseKeyboard();
  if ((balancesState == 0 || balancesState == BALANCES_CASH_IN_HAND_DISPLAY) && boolean(universalLoad(BALANCES_EVENING_ACTIVITY))) {

    int numberOfPictures = products.size();
    if (numberOfPictures != 0) {
      int shift = loadScroll(CASH_REGISTER_PRODUCTS);
      int boxCounter = 0;
      int numberOfFields = 5;
      int boxWidth = round(width/(numberOfFields + 1.32));
      int boxHeight = round(width/(numberOfFields + 0.7));
      int realBoxWidth = boxWidth - width/45;
      int realBoxHeight = boxHeight - width/45;
      int distance = round((width - boxWidth * 5)/(numberOfFields + 9));
      int numberOfLines = int(products.size()/5) + 1;
      background(colors.get("white"));
      fill(colors.get("white"));
      for (int t = 0; t <= numberOfLines; t++ ) {
        for (int i = 0; i<numberOfFields; i++ ) {
          boxCounter++ ;
          imageMode(CENTER);
          image(images.get(t * numberOfFields + i), boxWidth/2 + width/8.5 + (i + 1) * distance + i * boxWidth, boxHeight/2 + (t + 0.7) * distance + t * boxHeight + shift, realBoxWidth, realBoxHeight);
          rectMode(CENTER);
          fill(colors.get("white"), 150);
          noStroke();
          if (products.get(t * numberOfFields + i).inStorage - getProductSelectedNumber(t * numberOfFields + i) == 0)rect(boxWidth/2 + width/8.5 + (i + 1) * distance + i * boxWidth, boxHeight/2 + (t + 0.7) * distance + t * boxHeight + shift, realBoxWidth, realBoxHeight);
          if (boxCounter + 1>numberOfPictures) {
            i = numberOfFields;
            t = numberOfLines + 1;
          }
        }
      }
      showAvailableProducts();
      strokeWeight(4);
      stroke(colors.get("black"));
      line(0, height/1.28, width, height/1.28);
    } else background(colors.get("white"));
  } else {
    background(colors.get("white"));
    textFont(theNextFont);
    fill(colors.get("black"));
    textSize(height/6.5);
    textAlign(CENTER, CENTER);
    text("KASSE", width/8.2 + (width - width/8.2)/2, height/7);
    textFont(arial);
    fill(colors.get("red"));
    textSize(width/14);
    textAlign(CENTER);
    text("Diese Funktion ist nur\n verfugbar, wahrend\n ein Abend lauft!", width/1.825, height/2.5); //ä,ü
  }

  if (state == 3)drawSidebar();

  if (int(universalLoad(CASH_REGISTER_WRITE_STATE)) == 1) {
    noStroke();
    fill(colors.get("white"));
    rect(0, height/1.28 + 5, width, height - (height/1.28 + 5));
    textAlign(CENTER);
    textSize(width/12);
    fill(colors.get("green"));
    text("Verkauf abgeschlossen!", width/2, height/1.08);
  } else if (int(universalLoad(CASH_REGISTER_WRITE_STATE)) == 2) {
    noStroke();
    fill(colors.get("white"));
    rect(0, height/1.28 + 5, width, height - (height/1.28 + 5));
    textAlign(CENTER);
    textSize(width/12);
    fill(colors.get("red"));
    text("Verkauf abgebrochen!", width/2, height/1.08);
  }

  switch(state) {
  case 1:
    drawReallyDeleteWindow();
    break;
  }
  drawTransition(width/8.2, height/1.28 - height/11, height/11, width - width/8.2, 90, 4, "down");
  drawSidebar();
  strokeWeight(6);
  line(width/8.2, height/1.28, width, height/1.28);
}


void drawStorageOverview(int mode) {
  if (!(products.size() == 0)) {
    myCloseKeyboard();
    background(colors.get("white"));
    imageMode(CENTER);
    if (mode != STOCK_OVERVIEW_NEW_PURCHASE && mode != STOCK_OVERVIEW_STANDARD)image(images.get("backbutton"), width/8.2/2, height/1.28 + (height - height/1.28)/2 - height/200, width/6.8, width/6.8);
    else if (mode == STOCK_OVERVIEW_NEW_PURCHASE) {      
      image(images.get("redBackbutton"), width/8.2/2, height/1.28 + height/20, width/9.3, height/11.3);
      image(images.get("confirmButton"), width/8.2/2, height - height/14.2, height/8.7, height/8.7);
    } else if (mode == STOCK_OVERVIEW_STANDARD)image(images.get("settings"), width/8.2/2, height/1.28 + (height - height/1.28)/2 - height/200, width/11.5 * 1.9, width/11.5);
    int boxCounter = 0;
    int productsPerLine = 3;
    int numberOfLines = 0;
    float pictureWidth = height/8;
    float pictureHeight = height/8;
    float productWidth = (width - width/8.2)/3 - height/250;
    float distance = width/20;
    if (products.size()%3 == 0)numberOfLines = products.size();
    else numberOfLines = products.size() + 1;
    strokeWeight(6);
    if (mode == STOCK_OVERVIEW_STANDARD)stroke(colors.get("black"));
    else if (mode == STOCK_OVERVIEW_NEW_PURCHASE)stroke(colors.get("green"));
    else if (mode == STOCK_OVERVIEW_STOCK_CORRECTION)stroke(colors.get("red"));
    else if (mode == STOCK_OVERVIEW_PRODUCT_ADMINISTRATION_SELECT_PRODUCT_TO_CHANGE)stroke(colors.get("orange"));
    int numberOfHorizontalLines = int(products.size()/3) + 1;
    if (products.size()%3 == 0)numberOfHorizontalLines-- ;
    int remaining = products.size();
    int stockOverviewProductsScrolling = loadScroll(STOCK_OVERVIEW_PRODUCTS);
    for (int i = 0; i<numberOfHorizontalLines; i++ ) {
      if (remaining >= 3) {
        remaining -= 3;
        line(width/8.2, (i + 1.18) * pictureHeight + i * distance + width/35 + stockOverviewProductsScrolling, width, (i + 1.18) * pictureHeight + i * distance + width/35 + stockOverviewProductsScrolling);
      } else line(width/8.2, (i + 1.18) * pictureHeight + i * distance + width/35 + stockOverviewProductsScrolling, width/8.2 + ((width - width/8.2)/3 * remaining), (i + 1.18) * pictureHeight + i * distance + width/35 + stockOverviewProductsScrolling);
    }
    if (products.size()>1) {
      int stacksForLineOne = int(products.size()/3);
      int stacksForLineTwo = stacksForLineOne;
      if (products.size()%3 == 2) {
        stacksForLineOne++ ;
        stacksForLineTwo++ ;
      } else if (products.size()%3 == 1)stacksForLineOne++ ;
      line(width/8.2 + ((width - width/8.2)/3), stockOverviewProductsScrolling, width/8.2 + ((width - width/8.2)/3), (stacksForLineOne + 1.18 - 1) * pictureHeight + (stacksForLineOne - 1) * distance + width/35 + stockOverviewProductsScrolling);
      line(width/8.2 + ((width - width/8.2)/3 * 2), stockOverviewProductsScrolling, width/8.2 + ((width - width/8.2)/3 * 2), (stacksForLineTwo + 1.18 - 1) * pictureHeight + (stacksForLineTwo - 1) * distance + width/35 + stockOverviewProductsScrolling);
    } else {
      line(width/8.2 + ((width - width/8.2)/3), stockOverviewProductsScrolling, width/8.2 + ((width - width/8.2)/3), 1.18 * pictureHeight + width/35 + stockOverviewProductsScrolling);
    }   
    for (int line = 0; line<numberOfLines; line++ ) {
      for (int t = 0; t<productsPerLine && boxCounter<products.size(); t++ ) {
        if (mode == STOCK_OVERVIEW_STANDARD || mode == STOCK_OVERVIEW_NEW_PURCHASE || mode == STOCK_OVERVIEW_STOCK_CORRECTION) {
          //strokeWeight(6);
          //line(width/8.2, (line + 1.18) * pictureHeight + line * distance + width/35 + loadScroll(STOCK_OVERVIEW_PRODUCTS), width, (line + 1.18) * pictureHeight + line * distance + width/35 + loadScroll(STOCK_OVERVIEW_PRODUCTS));
          //line(width/8.2 + (t + 0.94) * productWidth + width/60 + height/60, 0, width/8.2 + (t + 0.94) * productWidth + width/60 + height/60, height);
          //line(width/8.2, 0, width/8.2, height);
        }
        textFont(arial);
        textAlign(CORNER, TOP);
        textSize(height/9.3);
        fill(colors.get("black"));
        String additionalShift = "";
        float additionalShift2 = 0;
        if (products.get(boxCounter).inStorage<10 && mode != STOCK_OVERVIEW_NEW_PURCHASE && mode != STOCK_OVERVIEW_NEW_PURCHASE_ADDING_RUNNING) {
          additionalShift += "  ";
          additionalShift2 -= height/82;
        } else if (int(universalLoadArray("purchaseNumberOfProduct")[boxCounter])<10 && (mode == STOCK_OVERVIEW_NEW_PURCHASE || mode == STOCK_OVERVIEW_NEW_PURCHASE_ADDING_RUNNING)) {
          additionalShift += "  ";
          additionalShift2 -= height/82;
        }
        if (mode != STOCK_OVERVIEW_NEW_PURCHASE && mode != STOCK_OVERVIEW_NEW_PURCHASE_ADDING_RUNNING)text(additionalShift + products.get(boxCounter).inStorage, width/8.2 + t * productWidth + width/60 + height/60, line * pictureHeight + line * distance + width/35 + stockOverviewProductsScrolling);
        else text(additionalShift + int(universalLoadArray("purchaseNumberOfProduct")[boxCounter]), width/8.2 + t * productWidth + width/60 + height/60, line * pictureHeight + line * distance + width/35 + stockOverviewProductsScrolling);
        //ändern
        imageMode(CORNER);
        image(products.get(boxCounter).productImage, width/8.2 + t * productWidth + width/60 + textWidth(25 + "") + height/150 + textWidth("X") + height/100, line * pictureHeight + line * distance - height/65 + width/35 + stockOverviewProductsScrolling, pictureWidth, pictureHeight);
        textSize(height/11);
        text("x", width/8.2 + t * productWidth + width/60 + height/120 + textWidth(25 + "") + height/33 + height/72 + additionalShift2, line * pictureHeight + line * distance + width/35 + stockOverviewProductsScrolling);
        boxCounter++ ;
      }
    }
    drawSidebar();
    drawTransition(width/8.2, height - 90, 90, width - width/8.2, 90, 4, "down");
    switch(mode) {
    case STOCK_OVERVIEW_STOCK_CORRECTION_RUNNING:
      drawStockCorrectionWindow(int(universalLoad("clickedProduct")));
      break;
    case STOCK_OVERVIEW_NEW_PURCHASE_ADDING_RUNNING:
      drawNewPurchaseAddingWindow(int(universalLoad("clickedProduct")));
      break;
    case STOCK_OVERVIEW_QUIT_NEW_PURCHASE:
      showQuitNewPurchaseWindow();
      break;
    }
  } else {
    background(colors.get("white"));   
    textFont(arial);
    textSize(height/9);
    textAlign(CENTER, CENTER);
    fill(colors.get("black"));
    text("Es sind noch\nkeine Produkte\nvorhanden!", width/8.2 + (width - width/8.2)/2, height/1.28/2);
    drawSidebar();
    imageMode(CENTER);
    image(images.get("settings"), width/8.2/2, height/1.28 + (height - height/1.28)/2 - height/200, width/11.5 * 1.9, width/11.5);
  }
}
