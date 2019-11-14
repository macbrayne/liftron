void showNoUsersRegistratedMessage() {
  background(colors.get("white"));
  drawSidebar();
  textFont(arial);
  fill(colors.get("black"));
  textAlign(CENTER);
  textSize(height/9);
  text("Es sind noch\nkeine Nutzer\nregistriert!", width/8.2 + (width - width/8.2)/2, height/1.28/2 - height/13);
}

void showChangeDepositInterface() {
  background(colors.get("white"));
  drawSidebar();
  imageFields.get("backbutton").show();
  fill(colors.get("black"));
  textFont(theNextFont);
  textSize(height/10.85);
  textAlign(CENTER, CENTER);
  text("Pfand - Bearbeitung", width/8.2 + (width - width/8.2)/2, height/8);
  textfields.get("addDepositAmount").show();
  imageFields.get("deleteDeposit").show();
  imageFields.get("confirmDepositAdding").show();
}

void showCreateDepositInterface() {
  background(colors.get("white"));
  drawSidebar();
  imageFields.get("backbutton").show();
  fill(colors.get("black"));
  textFont(theNextFont);
  textSize(height/10.85);
  textAlign(CENTER, CENTER);
  text("Pfand - Hinzufugung", width/8.2 + (width - width/8.2)/2, height/8); //ü
  textfields.get("addDepositAmount").show();
  //imageFields.get("deleteDeposit").show();
  imageFields.get("confirmDepositAdding").show();
  //if (boolean(universalLoad("imageSelected")))image(images.get("backbutton"), width/5.9, height/1.9, height/2.55, height/2.55);
}

void showChangeProductInterface() {
  background(colors.get("white"));
  drawSidebar();
  imageFields.get("backbutton").show();
  fill(colors.get("black"));
  textFont(theNextFont);
  textSize(height/10.85);
  textAlign(CENTER, CENTER);
  text("Produkt - Bearbeitung", width/8.2 + (width - width/8.2)/2, height/8);
  textfields.get("addProductName").show();
  textfields.get("addProductPrice").show();
  imageFields.get("deleteProduct").show();
  imageFields.get("confirmProductAdding").show();

  imageMode(CORNER);
  rectMode(CORNER);
  strokeWeight(5);
  stroke(colors.get("black"));
  fill(colors.get("white"));
  //if (boolean(universalLoad("imageSelected")))strokeWeigh;
  rect(width/5.9, height/1.9, height/2.55, height/2.55);
  stroke(colors.get("black"));
  strokeWeight(5);
  rect(width/2, height/1.9, width/2.2, height/7);
  fill(colors.get("black"));
  textFont(arial);
  textAlign(CENTER, CENTER);
  textSize(height/10);
  text("Bild wahlen", width/2 + width/2.2/2, height/1.9 + height/16); //ä
  //if (productAddingState == 1)background(colors.get("white"), 10);
  image(images.get("chosenImage"), width/5.9, height/1.9, height/2.55, height/2.55);
}

void showCreateProductInterface() {
  background(colors.get("white"));
  drawSidebar();
  imageFields.get("backbutton").show();
  fill(colors.get("black"));
  textFont(theNextFont);
  textSize(height/10.85);
  textAlign(CENTER, CENTER);
  text("Produkt - Hinzufugung", width/8.2 + (width - width/8.2)/2, height/8); //ü
  textfields.get("addProductName").show();
  textfields.get("addProductPrice").show();
  //imageFields.get("deleteProduct").show();
  imageFields.get("confirmProductAdding").show();

  imageMode(CORNER);
  rectMode(CORNER);
  strokeWeight(5);
  stroke(colors.get("black"));
  fill(colors.get("white"));
  if (boolean(universalLoad("imageSelected")))noStroke();
  rect(width/5.9, height/1.9, height/2.55, height/2.55);
  stroke(colors.get("black"));
  strokeWeight(5);
  rect(width/2, height/1.9, width/2.2, height/7);
  fill(colors.get("black"));
  textFont(arial);
  textAlign(CENTER, CENTER);
  textSize(height/10);
  text("Bild wahlen", width/2 + width/2.2/2, height/1.9 + height/16); //ä
  //if (productAddingState == 1)background(colors.get("white"), 10);
  if (boolean(universalLoad("imageSelected"))) {
    image(images.get("chosenImage"), width/5.9, height/1.9, height/2.55, height/2.55);
  }
  //if (boolean(universalLoad("imageSelected")))image(images.get("backbutton"), width/5.9, height/1.9, height/2.55, height/2.55);
}

void showNotificationAvailableFromLevel(int availabilityLevel) {
  background(colors.get("white"));
  imageFields.get("backbutton").show();
  drawSidebar(); 
  textFont(arial);
  fill(colors.get("red"));
  textSize(height/10);
  textAlign(CENTER);
  text("Diese Funktion ist fur\nNutzer ab Level " + availabilityLevel + " \nfrei verfugbar!", width/8.2 + ((width - width/8.2)/2), height/2.85); //ü
}

void showCashInHandDisplay() {
  background(colors.get("white")); 
  imageFields.get("backbutton").show();
  drawSidebar();
  textFont(arial);
  textSize(height/10);
  textAlign(CENTER);
  fill(colors.get("black"));
  text("Virtueller Kassenstand:", width/8.2 + ((width - width/8.2)/2), height/5.7);
  textSize(height/6);
  if (float(universalLoad("kassenstand")) >= 0)fill(colors.get("green"));
  else fill(colors.get("red"));
  text(changeToMoneyValue(universalLoad("kassenstand")), width/8.2 + ((width - width/8.2)/2), height/2.5);
}

//In Bezug auf Betrag je nach Zugriffslevel limitieren
void showAmountInput(int state) {
  drawHome();
  myOpenKeyboard();
  rectMode(CORNER);
  fill(colors.get("white"));
  noStroke();
  rect(width/8, 0, width/1.5, height);
  textFont(theNextFont);
  stroke(colors.get("black"));
  strokeWeight(1);
  textAlign(CENTER);
  fill(colors.get("black"));
  textSize(height/8.5);
  text("Buchungen", width/8.2 + ((width - 2 * width/8.2)/2), height/6);
  textfields.get("manualAmountsValue").show();
  textfields.get("manualAmountsUsage").show();
  imageFields.get("yesHomeManualAmountInput").show();
  imageFields.get("noHomeManualAmountInput").show();
  switch(state) {
  case PLEASE_ENTER_VALID_VALUE_ERROR:
    textFont(arial);
    textSize(height/18.5);
    fill(colors.get("red"));
    textAlign(CORNER, CENTER);
    text("Gultigen Betrag eingeben!", width/6.5, height/2); //ü
    break;
  case PLEASE_ENTER_USAGE_ERROR:
    textFont(arial);
    textSize(height/18.5);
    fill(colors.get("green"));
    textAlign(CORNER, CENTER);
    text("Bitte Zweck eingeben!", width/6.5, height/2);
    break;
  }
}

void openProductAdministrationOptions() {
  stockOverviewState = STOCK_OVERVIEW_SHOW_PRODUCT_ADMINISTRATION_OPTIONS;
  background(colors.get("white"));
  imageFields.get("smallBackbutton").show();
  drawSidebar();
  stroke(colors.get("black"));
  strokeWeight(6);
  line(width/8.2, 0, width/8.2, height);
  textFont(arial);
  textAlign(CENTER, CENTER);
  textSize(height/9);
  fill(colors.get("green"));
  text("Produkt hinzufugen", width/8.2 + (width - width/8.2)/2, height/4 * 0.5); //ü
  fill(colors.get("orange"));
  text("Produkt ändern", width/8.2 + (width - width/8.2)/2, height/4 * 1.5);
  fill(colors.get("green"));
  text("Pfand hinzufugen", width/8.2 + (width - width/8.2)/2, height/4 * 2.5); //ü
  fill(colors.get("orange"));
  text("Pfand andern", width/8.2 + (width - width/8.2)/2, height/4 * 3.5); //ä
  strokeWeight(6);
  line(width/8.2, 3, width, 3);
  line(width/8.2, height/4 * 1, width, height/4 * 1);
  line(width/8.2, height/4 * 2, width, height/4 * 2);
  line(width/8.2, height/4 * 3, width, height/4 * 3);
}

void drawYesNo() {
  imageMode(CORNER);
  image(images.get("yes"), width/1.16, height/1.24, width/8, width/8);
  image(images.get("no"), width/1.38, height/1.24, width/8, width/8);
}

void showEnterCompletePurchasePriceWindow(String text) {
  stockOverviewState = STOCK_OVERVIEW_ENTER_COMPLETE_PURCHASE_PRICE_WINDOW;
  myOpenKeyboard();
  background(colors.get("white"));
  drawSidebar();
  fill(colors.get("black"));
  textSize(width/18);
  textAlign(CENTER);
  if (int(universalLoad("numberOfAddedProducts")) == 1) text("Bitte den Preis des \ngekauften Artikels angeben!", width/1.8, height/9);
  else text("Bitte den genauen Gesamtpreis \nder " + universalLoad("numberOfAddedProducts") + " gekauften Artikel angeben!", width/1.8, height/9);

  textSize(width/14);
  textAlign(CORNER);
  stroke(colors.get("black"));
  strokeWeight(4);
  line(width/5 + textWidth("Preis:"), height/2.95, width/1.13, height/2.95);
  text("Preis:", width/5, height/3);
  fill(colors.get("darkBlue"));
  text(text + "E", width/5 + textWidth("Preis:") + width/30, height/3); //€

  imageMode(CORNER);
  image(images.get("yes"), width/1.28, height/2.6, width/9.3, width/9.3);
  image(images.get("no"), width/1.5, height/2.6, width/9.3, width/9.3);
}

void drawReallyDeleteWindow() {
  fill(colors.get("white"), 200);
  rect(width/8.2, 0, width, height/1.28);
  rect(0, height/1.28, width, height/1.28);
  //x - Mitte = width/8.2 + (width - width/8.2)/2
  //y - Mitte = (height - (height - height/1.28))/2
  //bei Fenstergröße width/1.85, 
  fill(colors.get("white"));
  stroke(colors.get("black"));
  strokeWeight(5);
  rectMode(CORNER);
  rect(width/8.2 + (width - width/8.2)/2 - width/1.5/2, (height - (height - height/1.28))/2 - height/3.3, width/1.5, height/0.5/3.3);

  line(width/8.2 + (width - width/8.2)/2 - width/1.5/2, height/2.1, width/8.2 + (width - width/8.2)/2 + width/1.5/2, height/2.1);
  textFont(arial);
  fill(colors.get("black"));
  textAlign(CENTER);
  textSize(height/11);
  text("Soll der Artikel", width/8.2 + (width - width/8.2)/2, height/4.83 );
  text("entfernt werden?", width/8.2 + (width - width/8.2)/2, height/4.83 + height/9 * 2);
  fill(colors.get("red"));
  text("\"" + products.get(int(universalLoad("elementToRemoveNumber")) - 1).name + "\"", width/8.2 + (width - width/8.2)/2, height/4.83 + height/9);
  textSize(height/8);
  textAlign(CENTER);
  text("NEIN", (width/8.2 + (width - width/8.2)/2) + width/47 - height/5.5, height/4.8 + (height/9 * 3.8));
  fill(colors.get("green"));
  text("JA", (width/8.2 + (width - width/8.2)/2) + width/47 + height/5.5, height/4.8 + (height/9 * 3.8));
  //imageMode(CENTER);
  //image(yes,width/8.2 + (width - width/8.2)/2 + height/4.5,height/4.8 + (height/9) * 3.2,height/6.5,height/6.5);
  //image(no,width/8.2 + (width - width/8.2)/2 - height/4.5,height/4.8 + (height/9) * 3.2,height/6.5,height/6.5);
}

void showQuitNewPurchaseWindow() {
  stockOverviewState = STOCK_OVERVIEW_QUIT_PURCHASE_WINDOW;
  drawSidebar();
  fill(colors.get("white"), 200);
  rect(0, 0, width, height);
  fill(colors.get("white"));
  stroke(colors.get("black"));
  strokeWeight(5);
  rectMode(CORNER);
  rect(width/8.2 + (width - width/8.2)/2 - width/3, height/2 - height/3.3, width/1.5, height/0.5/3.3);
  line(width/8.2 + (width - width/8.2)/2 - width/1.5/2, height/1.7, width/8.2 + (width - width/8.2)/2 + width/1.5/2, height/1.7);

  textFont(arial);
  textSize(height/12);
  fill(colors.get("black"));
  textAlign(CENTER, TOP);
  text("Soll die Hinzufugung \ndes neuen Einkaufs \nabgebrochen werden?", width/8.2 + (width - width/8.2)/2, height/2 - height/3.3 + height/20); //ü 
  //image(no, width/8.2 + (width - width/8.2)/2 - height/9.5, height/1.45, height/6.2, height/6.2);
  //image(yes, width/8.2 + (width - width/8.2)/2 + height/9.5, height/1.45, height/6.2, height/6.2);

  fill(colors.get("red"));
  textSize(height/8);
  textAlign(CENTER, CENTER);
  text("NEIN", (width/8.2 + (width - width/8.2)/2) + width/47 - height/5.5, height/1.45);
  fill(colors.get("green"));
  text("JA", (width/8.2 + (width - width/8.2)/2) + width/47 + height/5.5, height/1.45);
}

void drawNewPurchaseAddingWindow(int clickedProduct) {
  fill(colors.get("white"), 200);
  noStroke();
  rectMode(CORNERS);
  rect(width/8.2, 0, width, height/1.28);
  rect(0, height/1.28, width, height);
  fill(colors.get("white"));
  stroke(colors.get("green"));
  strokeWeight(10);
  rectMode(CORNER);
  rect(width/8.2 + (width - width/8.2)/2 - width/3, height/2 - height/3.3, width/1.5, height/0.5/3.3);

  textAlign(CENTER, TOP);
  fill(colors.get("green"));
  textSize(height/9.85);
  String additionalShift = "";
  float additionalShift2 = 0;
  if ((int(universalLoadArray("purchaseNumberOfProduct")[clickedProduct]))<10) {
    additionalShift += "  ";
    additionalShift2 -= height/200;
  }
  text("\"" + products.get(clickedProduct).name + "\"", width/8.2 + (width - width/8.2)/2, height/2 - height/3.3 + height/15);
  textAlign(CENTER, CENTER);
  textSize(height/8);
  fill(colors.get("black"));
  //ändern 
  text(additionalShift + (int(universalLoadArray("purchaseNumberOfProduct")[clickedProduct])) + "", width/8.2 + (width - width/8.2)/2 - height/8.1, height/2 - height/70);
  textSize(height/8.5);
  text("x", width/8.2 + (width - width/8.2)/2 + additionalShift2, height/2 - height/60);
  imageMode(CENTER);
  image(products.get(clickedProduct).productImage, width/8.2 + (width - width/8.2)/2 + height/8.1, height/2, height/7.5, height/7.5);
  image(images.get("redBackbutton"), width/8.2/2, height/1.28 + height/20, width/9.3, height/11.3);
  image(images.get("confirmButton"), width/8.2/2, height - height/14.2, height/8.7, height/8.7);
  image(images.get("plus"), width/8.2 + (width - width/8.2)/2 + width/4.2, height/2, height/7.6, height/7.6);
  image(images.get("minus"), width/8.2 + (width - width/8.2)/2 - width/4.2, height/2, height/5.7, height/5.7);
  image(images.get("no"), width/8.2 + (width - width/8.2)/2 - height/9.5, height/1.45, height/6.2, height/6.2);
  image(images.get("yes"), width/8.2 + (width - width/8.2)/2 + height/9.5, height/1.45, height/6.2, height/6.2);
}

void showAddingOptions() {
  stockOverviewState = STOCK_OVERVIEW_OPTIONS;
  background(colors.get("white"));
  stroke(colors.get("black"));
  imageMode(CENTER);
  image(images.get("backbutton"), width/8.2/2 + height/100, height/1.28 + (height - height/1.28)/2 - height/200, width/6, width/6);
  drawSidebar();
  textFont(arial);
  textAlign(CENTER, CENTER);
  textSize(height/8);
  fill(colors.get("green"));
  text("Einkauf hinzufugen", width/8.2 + (width - width/8.2)/2, height/1.28/3 * 0.5); //ü
  fill(colors.get("red"));
  text("Bestand korrigieren", width/8.2 + (width - width/8.2)/2, height/1.28/3 * 1.5);
  fill(colors.get("black"));
  text("Produkte verwalten", width/8.2 + (width - width/8.2)/2, height/1.28/3 * 2.5);
  strokeWeight(5);
  line(width/8.2, 3, width, 3);
  line(width/8.2, height/1.28/3 * 1, width, height/1.28/3 * 1);
  line(width/8.2, height/1.28/3 * 2, width, height/1.28/3 * 2);
  line(width/8.2, height/1.28/3 * 3, width, height/1.28/3 * 3);
}

void drawStockCorrectionWindow(int clickedProduct) {
  fill(colors.get("white"), 200);
  noStroke();
  rectMode(CORNERS);
  rect(width/8.2, 0, width, height/1.28);
  rect(0, height/1.28, width, height);
  fill(colors.get("white"));
  stroke(colors.get("red"));
  strokeWeight(10);
  rectMode(CORNER);
  rect(width/8.2 + (width - width/8.2)/2 - width/3, height/2 - height/3.3, width/1.5, height/0.5/3.3);

  textAlign(CENTER, TOP);
  fill(colors.get("red"));
  textSize(height/9.85);
  String additionalShift = "";
  float additionalShift2 = 0;
  if (products.get(clickedProduct).inStorage<10) {
    additionalShift += "  ";
    additionalShift2 -= height/200;
  }
  text("\"" + products.get(clickedProduct).name + "\"", width/8.2 + (width - width/8.2)/2, height/2 - height/3.3 + height/15);
  textAlign(CENTER, CENTER);
  textSize(height/8);
  fill(colors.get("black"));
  text(additionalShift + (products.get(clickedProduct).inStorage + int(universalLoad("selectedStockCorrection"))) + "", width/8.2 + (width - width/8.2)/2 - height/8.1, height/2 - height/70);
  textSize(height/8.5);
  text("x", width/8.2 + (width - width/8.2)/2 + additionalShift2, height/2 - height/60);
  imageMode(CENTER);
  image(products.get(clickedProduct).productImage, width/8.2 + (width - width/8.2)/2 + height/8.1, height/2, height/7.5, height/7.5);
  image(images.get("plus"), width/8.2 + (width - width/8.2)/2 + width/4.2, height/2, height/7.6, height/7.6);
  image(images.get("minus"), width/8.2 + (width - width/8.2)/2 - width/4.2, height/2, height/5.7, height/5.7);
  image(images.get("no"), width/8.2 + (width - width/8.2)/2 - height/9.5, height/1.45, height/6.2, height/6.2);
  image(images.get("yes"), width/8.2 + (width - width/8.2)/2 + height/9.5, height/1.45, height/6.2, height/6.2);
}


//void drawTextDocument(String[]lines) {
//}


void showPrice(ArrayList <String> selectionNumbers) {
  if (calculatePrice(selectionNumbers)>0) {
    drawTransition(width/80 + 2 * width/7 + width/7.85, height/1.28 + 1, 100, height - height/1.28 - 1, 50, 6, "right");

    fill(colors.get("white"));
    rect(width/2.13, height/1.26, width/1.9, height);
    //drawTransition();
    textAlign(CORNER);
    fill(colors.get("black"));
    String price = Math.round(calculatePrice(selectionNumbers) * 100.0)/100.0 + "";
    if (price.length()<4)price += 0;
    price += "E"; //€
    fill(colors.get("green"));
    textFont(arial);
    textSize(height/7.5);
    text(price, width/2.18, height/1.073);
  }
}

//void drawTransition() {
//  noStroke();
//  rectMode(CORNERS);
//  for (int i = 0; i < 50; i++ ) {
//    fill(colors.get("white"), int(i * 5.1)); 
//    rect(width/80 + 2 * width/7 + width/7.85 + i * 2, height/1.26, 2 * width/7 + width/7.48 + (i + 1) * 2, height);
//  }
//  fill(colors.get("white"));
//  rect(width/2.13, height/1.26, width/1.9, height);
//}


void drawTransition(float startX, float startY, float transitionLength, float transitionLong, float steps, int strongness, String direction) {
  noStroke();
  rectMode(CORNERS);
  if (steps>transitionLength)steps = transitionLength;  
  if (direction == "right") {
    for (int i = 0; i < steps; i++ ) {
      fill(colors.get("white"), int(i * (255/steps))); 
      rect(startX + i * (transitionLength/steps), startY, startX + (i + 1) * (transitionLength/steps) + strongness, startY + transitionLong);
    }
  } else if (direction == "left") {
    for (int i = 0; i < steps; i++ ) {
      fill(colors.get("white"), int(i * (255/steps))); 
      rect(startX - i * (transitionLength/steps), startY, startX - (i + 1) * (transitionLength/steps) - strongness, startY + transitionLong);
    }
  } else if (direction == "up") {
    for (int i = 0; i < steps; i++ ) {
      fill(colors.get("white"), int(i * (255/steps))); 
      rect(startX, startY - i * (transitionLength/steps), startX + transitionLong, startY - (i + 1) * (transitionLength/steps) - strongness);
    }
  } else if (direction == "down") {
    for (int i = 0; i < steps; i++ ) {
      fill(colors.get("white"), int(i * (255/steps))); 
      rect(startX, startY + i * (transitionLength/steps), startX + transitionLong, startY + (i + 1) * (transitionLength/steps) + strongness);
    }
  }
}

void drawSelection (ArrayList <PImage> selection) {
  fill(colors.get("white"));
  noStroke();
  rectMode(CORNER);
  rect(0, height/1.28 + 1, width, height - (height/1.28 + 1));
  if (selection.size()>3) {
    float rightBorder = width/80 + 2 * width/7 + width/7.48;
    imageMode(CORNER);
    for (int i = 0; i<selection.size(); i++ )image(selection.get(selection.size() - i - 1), rightBorder - width/7.0 * (i + 1) + loadScroll(CASH_REGISTER_SELECTION), height/1.24, width/8.0, width/8.0);
  } else {
    for (int i = 0; i<selection.size(); i++ ) {
      imageMode(CORNER);
      image(selection.get(i), width/80 + width/7.0 * i + loadScroll(CASH_REGISTER_SELECTION), height/1.24, width/8.0, width/8.0);
    }
  }
  rect(width/2, height/1.28 + 5, width, height - (height/1.28 + 5));
  if (calculatePrice(loadSelection())>0)drawYesNo();
}

void logoutActualAKFilmMember() {
  loginState = 1;  
  universalSave(LOGIN_USERNAME, "");
  universalSave(LOGIN_USERPASSWORD, "");
  if (!boolean(universalLoad(LOGIN_USER_LOGED_IN_STATE)) || actualAKFilmMember.name.toLowerCase().equals("gast")) {
    universalSave("logoutWorked", "false");
  } else {
    universalSave("logoutWorked", "true");
  }
  actualAKFilmMember = guest;
}

void showLogoutMessage() {
  boolean logoutWorked = boolean(universalLoad("logoutWorked"));
  textFont(arial);
  textAlign(CENTER);
  textSize(height/12);
  fill(colors.get("red"));
  if (logoutWorked)text("Der Benutzer " + universalLoad(LOGIN_USERNAME_WHILE_LOGOUT) + "\nwurde erfolgreich ausgeloggt!", width/1.78, height/1.5);
  else text("Es ist aktuell kein gultiger\nBenutzer eingeloggt!", width/1.78, height/1.5); //ü
}

void showUserNotFoundError() {
  loginState = 3;
  universalSave(LOGIN_USERNAME, "");
  universalSave(LOGIN_USERPASSWORD, "");
  textFont(arial);
  fill(colors.get("red"));
  textSize(height/16);
  textAlign(CENTER);
  text("Dieser Benutzername ist nicht vergeben! \nBitte versuchen sie es erneut!", width/1.78, height/1.5);
}

void showUserAlreadyLogedInMessage() {
  loginState = 4;
  universalSave(LOGIN_USERNAME, "");
  universalSave(LOGIN_USERPASSWORD, "");
  textFont(arial);
  fill(colors.get("green"));
  textSize(height/12);
  textAlign(CENTER);
  text("Der Benutzer " + actualAKFilmMember.name + "\nist bereits eingeloggt!", width/1.78, height/1.5);
}

void showPasswordIsWrongError() {
  loginState = 5;
  universalSave(LOGIN_USERNAME, "");
  universalSave(LOGIN_USERPASSWORD, "");
  textFont(arial);
  fill(colors.get("red"));
  textSize(height/15.5 );
  textAlign(CENTER);
  text("Das eingegebene Passwort ist falsch! \nBitte versuchen sie es erneut!", width/1.78, height/1.5);
}

void showUserLogedInConfirmation() {
  loginState = 6;
  universalSave(LOGIN_USERNAME, "");
  universalSave(LOGIN_USERPASSWORD, "");
  textFont(arial);
  fill(colors.get("green"));
  textSize(height/13);
  textAlign(CENTER);
  text("Der Benutzer " + actualAKFilmMember.name + "\nwurde erfolgreich eingeloggt!", width/1.78, height/1.5);
}

void showAKFilmMemberAddedSuccessfullyMessage() {
  loginState = 8;
  textFont(arial);
  fill(colors.get("green"));
  textSize(height/13);
  textAlign(CENTER);
  text("Der Benutzer " + universalLoad(LOGIN_REGISTRATION_USERNAME) + "\nwurde erfolgreich hinzugefugt!", width/1.78, height/1.5); //ü
}

void showAKFilmMembersList(String mode) {
  background(colors.get("white"));
  image(images.get("backbutton"), width/8.2/2, height/1.28 + (height - height/1.28)/2 - height/200, width/6.8, width/6.8);
  strokeWeight(6);

  if (mode == SELECT_USER_TO_LOG_IN) {
    loginState = 2;
    stroke(colors.get("black"));
  } else if (mode == LOGIN_CHANGE_USER_STRING) {
    stroke(colors.get("orange"));
  } 

  for (int i = 0; i<AKFilmMemberList.size(); i++ ) {
    fill(colors.get("white"));
    rectMode(CORNER);
    rect(width/8.2, i * height/10, width - width/8.22, height/10);
    textFont(arial);
    textSize(height/13.3);
    textAlign(CORNER, CENTER);
    fill(colors.get("black"));
    text(AKFilmMemberList.get(i).name, width/8.2 + width/40, (i + 0.5) * height/10);
    fill(colors.get("black"));
    text(AKFilmMemberList.get(i).accessCategory, width - width/10, (i + 0.5) * height/10);
    imageMode(CENTER);    
    if (AKFilmMemberList.get(i).name.equals(actualAKFilmMember.name)) {
      image(images.get("star"), textWidth(AKFilmMemberList.get(i).name) + width/80 + width/8.2 + width/40 + height/30, (i + 0.5) * height/10 + height/280, height/19, height/19);
      fill(colors.get("green"));
      textSize(height/16);
      text("eingeloggt", textWidth(AKFilmMemberList.get(i).name) * 1.2 + width/70 + height/19 + width/60 + width/8.2 + width/40, (i + 0.5) * height/10);
    }
  }
  drawSidebar();
}


void showAddNewAKFilmMemberUserInterface(boolean tenPeopleRegistrated, String mode) {

  background(colors.get("white"));
  imageFields.get("backbutton").show();
  drawSidebar();
  fill(colors.get("black"));
  textFont(theNextFont);
  textSize(height/10.2);
  textAlign(CENTER, CENTER);

  if (mode == LOGIN_CREATE_NEW_USER) {
    loginState = 7;
    text("Nutzer - Hinzufugung", width/8.2 + (width - width/8.2)/2, height/7); //ü
    if (tenPeopleRegistrated) {
      textFont(arial);
      fill(colors.get("red"));
      textAlign(CENTER, CENTER);
      textSize(height/15);
      text("Es sind bereits 10 Nutzer registriert!", width/8.2 + (width - width/8.2)/2, height * 0.82);
    }
    image(images.get("protocol"), width/1.1, height/1.51, height/7.3, height/7.3);
    imageFields.get("contactList").show();
  } else if (mode == LOGIN_CHANGE_USER_STRING) {
    text("Nutzer - Bearbeitung", width/8.2 + (width - width/8.2)/2, height/7);
    imageFields.get("deleteUser").show();
  }
  fill(colors.get("black"));
  textFont(arial);
  textAlign(CORNER, CENTER);
  textSize(height/10.35);
  text("Name:", width/6.3, height/3.1);
  text(universalLoad(LOGIN_REGISTRATION_USERNAME), width/6.3 + textWidth("Name:") + width/60, height/3.1);
  text("Passwort:", width/6.3, height/2.05);
  String passwordCrypted = "";
  for (int i = 0; i<universalLoad(LOGIN_REGISTRATION_USERPASSWORD).length(); i++ )passwordCrypted += "*";
  text(passwordCrypted, width/6.3 + textWidth("Passwort:") + width/60, height/1.98);
  textSize(height/9);
  text("Level:", width/6.3, height/1.53);
  textSize(height/8.5);
  text(universalLoad(LOGIN_SELECTED_ACCESS_CATEGORY), width/2.218, height/1.51);
  stroke(colors.get("black"));
  textSize(height/10.35);
  if (int(universalLoad(LOGIN_REGISTRATION_WRITE_STATE)) == 1)stroke(colors.get("red"));
  line(width/6.3 + textWidth("Name:") + width/110, height/2.7, width/1.05, height/2.7);
  stroke(colors.get("black"));
  if (int(universalLoad(LOGIN_REGISTRATION_WRITE_STATE)) == 2)stroke(colors.get("red"));
  line(width/6.3 + textWidth("Passwort:") + width/110, height/1.87, width/1.05, height/1.87); 
  stroke(colors.get("black"));

  textSize(height/11);

  imageMode(CENTER);
  image(images.get("leftArrow"), width/2.37, height/1.51, width/25, width/12);
  image(images.get("rightArrow"), width/1.89, height/1.51, width/25, width/12);
  imageFields.get("confirmAddingNewUser").show();
}


void showEveningnameTextfield(String text) {
  balancesState = 1;
  myOpenKeyboard();
  universalSave(BALANCES_STATE, balancesState + "");
  //drawSidebar();
  //evenings.add(today);
  //saveEvenings(evenings);
  background(colors.get("white"));
  drawSidebar();
  textFont(arial);
  fill(colors.get("black"));
  textSize(width/18);
  textAlign(CENTER);
  text("Bitte den Titel des heute \n laufenden Films kurz angeben!", width/1.8, height/9);

  textSize(width/14);
  textAlign(CORNER);
  stroke(colors.get("black"));
  strokeWeight(4);
  line(width/5 + textWidth("Titel:"), height/2.95, width/1.13, height/2.95);
  text("Titel:", width/5, height/3);
  fill(colors.get("darkBlue"));
  text(text, width/2.8 + width/30, height/3);

  imageMode(CORNER);
  image(images.get("yes"), width/1.28, height/2.6, width/9.3, width/9.3);
  image(images.get("no"), width/1.5, height/2.6, width/9.3, width/9.3);
}

void showNumberOfVisitorsTextField(String text) {
  balancesState = 2;
  myOpenKeyboard();
  universalSave(BALANCES_STATE, balancesState + "");
  saveActualEvening(today);
  background(colors.get("white"));
  drawSidebar();
  textFont(arial);
  fill(colors.get("black"));
  textSize(width/18);
  textAlign(CENTER);
  text("Bitte die ungefahre Anzahl \n der Besucher heute angeben!", width/1.8, height/9); //ä

  textSize(width/14);
  textAlign(CORNER);
  stroke(colors.get("black"));
  strokeWeight(4);
  line(width/5 + textWidth("Anzahl:"), height/2.95, width/1.13, height/2.95);
  text("Anzahl:", width/5, height/3);
  fill(colors.get("darkBlue"));
  text(text + " Besucher", width/5 + textWidth("Anzahl:") + width/30, height/3);

  imageMode(CORNER);
  image(images.get("yes"), width/1.28, height/2.6, width/9.3, width/9.3);
  image(images.get("no"), width/1.5, height/2.6, width/9.3, width/9.3);
}

void showCashAfterCountedTextField(String text) {
  myOpenKeyboard();
  universalSave(BALANCES_STATE, balancesState + "");
  saveActualEvening(today);
  background(colors.get("white"));
  drawSidebar();
  textFont(arial);
  fill(colors.get("black"));
  textSize(width/18);
  textAlign(CENTER);
  text("Bitte den nach Filmende \n gezahlten Kassenstand angeben!", width/1.8, height/9); //ä

  textSize(width/14);
  textAlign(CORNER);
  stroke(colors.get("black"));
  strokeWeight(4);
  line(width/5 + textWidth("Kasse:"), height/2.95, width/1.13, height/2.95);
  text("Kasse: ", width/5, height/3);
  //das mit dem eurosymbol hinter dem Betrag
  fill(colors.get("darkBlue"));
  text("E", width/2.5 + textWidth(text) + width/30, height/3); //€
  text(text, width/2.5 + width/30, height/3);

  imageMode(CORNER);
  image(images.get("yes"), width/1.28, height/2.6, width/9.3, width/9.3);
  image(images.get("no"), width/1.5, height/2.6, width/9.3, width/9.3);
}

void showExpenditureTextField(String text) {
  balancesState = 4;
  myOpenKeyboard();
  universalSave(BALANCES_STATE, balancesState + "");
  saveActualEvening(today);
  background(colors.get("white"));
  drawSidebar();
  fill(colors.get("black"));
  textSize(width/18);
  textAlign(CENTER);
  text("Bitte die fur den den Abend \n angefallenen Ausgaben angeben!", width/1.8, height/9); //ü

  textSize(width/14);
  textAlign(CORNER);
  stroke(colors.get("black"));
  strokeWeight(4);
  line(width/5 + textWidth("Ausgaben:"), height/2.95, width/1.13, height/2.95);
  text("Ausgaben: ", width/5, height/3);
  //das mit dem Eurosymbol hinter dem Betrag
  fill(colors.get("darkBlue"));
  text("E", width/1.9 + textWidth(text) + width/30, height/3); //€
  text(text, width/1.9 + width/30, height/3);

  imageMode(CORNER);
  image(images.get("yes"), width/1.28, height/2.6, width/9.3, width/9.3);
  image(images.get("no"), width/1.5, height/2.6, width/9.3, width/9.3);
}


void showCashDifference() {
  balancesState = 5;
  universalSave(BALANCES_STATE, balancesState + "");
  today.cashAfterCounted = Math.round(float(universalLoad(BALANCES_CASH_AFTER_COUNTED)) * 100.0)/100.0;
  today.numberOfVisitors = int(universalLoad(BALANCES_NUMBER_OF_VISITORS));
  today.expenditure = Math.round(float(universalLoad(BALANCES_EXPENDITURE)) * 100.0)/100.0;
  today.cashDifference = Math.round((today.cashAfterCounted - today.cashAfterExpected) * 100.0)/100.0;
  today.salesVolume = Math.round((today.cashAfterCounted - today.cashBefore) * 100.0)/100.0;
  saveActualEvening(today);

  background(colors.get("white"));
  fill(colors.get("black"));
  textAlign(CORNER);
  textSize(width/16);


  //Methode, die einen Betrag in Euro optimiert (mit richtigen Nullstellen) zurückgibt
  String cAE = "";
  String cAC = "";
  String cD = "";
  String[]splitcAE = split(today.cashAfterExpected + "", '.');
  String[]splitcAC = split(today.cashAfterCounted + "", '.');
  String[]splitcD = split(today.cashDifference + "", '.');
  if (splitcAE.length == 2) {
    if (splitcAE[1].length() == 1)cAE = "0";
  }
  if (splitcAC.length == 2) {
    if (splitcAC[1].length() == 1)cAC = "0";
  }
  if (splitcD.length == 2) {
    if (splitcD[1].length() == 1)cD = "0";
  }

  text("Kassenstand erwartet: " + today.cashAfterExpected + cAE + "E", width/20, height/6); //€
  text("Kassenstand gezahlt: " + today.cashAfterCounted + cAC + "E", width/20, height/3); //ä,€
  text("Differenz: " + today.cashDifference + cD + "E", width/20, height/1.9); //€
  text("Bitte zum Beenden des \nAbends bestatigen!", width/20, height/1.4); //ä

  imageMode(CORNER);
  image(images.get("checkButton"), width/1.28, height/1.48, width/7, width/7);
}


void drawEveningOverview(int i, float displayingWidth) {
  fill(colors.get("white"));
  stroke(colors.get("black"));
  strokeWeight(1);
  rect(width/8.2, 0 + i * displayingWidth, width, displayingWidth);
}

void drawSidebar() {
  strokeWeight(6);
  stroke(colors.get("white"));
  fill(colors.get("white"));
  rect(0, 0, width/8.25, height/1.3 + 10);
  imageMode(CENTER);
  image(images.get("home"), width/8.2/2, height/1.28/5 * 0.5, width/10.5, width/10.5);
  image(images.get("balances"), width/8.2/2, height/1.28/5 * 1.5, width/10.3, width/10.3);
  image(images.get("login"), width/8.2/2, height/1.28/5 * 2.5, width/10.5, width/10.5);
  image(images.get("cashRegister"), width/8.2/2, height/1.28/5 * 3.5, width/12, width/12);
  image(images.get("shoppingVenture"), width/8.2/2, height/1.28/5 * 4.5, width/9.3, width/9.3);
  strokeWeight(6);
  stroke(colors.get("black"));
  line(width/8.2, 0, width/8.2, height/1.28);
  line(0, height/1.28, width/8.2, height/1.28);
  noFill();
  stroke(colors.get("red"));
  strokeWeight(7);
  rectMode(CORNERS);
  rect(9, state * (height/1.28/5) + 10, width/8.2 - 11, (state + 1) * (height/1.28/5) - 10);
  stroke(colors.get("black"));
}

void drawHomeSidebar() {
  strokeWeight(6);
  stroke(colors.get("white"));
  fill(colors.get("white"));
  rectMode(CORNERS);
  rect(width - width/8, 0, width, height/1.3 + 10);
  imageMode(CENTER);
  image(images.get("expenditure"), width - width/8.2/2, height/1.28/5 * 0.5, width/10.5, width/10.5);
  image(images.get("help"), width - width/8.2/2, height/1.28/5 * 1.5, width/11.4, width/11.4);
  image(images.get("credits"), width - width/8.2/2, height/1.28/5 * 2.5, width/11.4, width/11.4);
  //image(images.get("cashRegister"), width/8.2/2, height/1.28/5 * 3.5, width/12, width/12);
  //image(images.get("shoppingVenture"), width/8.2/2, height/1.28/5 * 4.5, width/9.3, width/9.3);
  stroke(colors.get("black"));
  line(width - width/8.2, 0, width - width/8.2, height/1.28/5 * 3);
  line(width - width/8.2, height/1.28/5 * 3, width, height/1.28/5 * 3);
  noFill();
  stroke(colors.get("green"));
  strokeWeight(7);
  rectMode(CORNERS);
  rect(width - width/8.2 + 9, (homeState - 1) * (height/1.28/5) + 10, width - 11, homeState * (height/1.28/5) - 10);
  stroke(colors.get("black"));
}
