class Textfield {
  boolean isActive;
  float xPos;
  float yPos;
  float fieldWidth;
  float fieldTextSize;
  String text;
  String type;//moneyValue,text
  String name;
  int border;

  Textfield(String name, float xPos, float yPos, float fieldWidth, float fieldTextSize, String type, int border) {
    this.name = name;
    this.xPos = xPos;
    this.yPos = yPos;
    this.fieldWidth = fieldWidth;
    this.fieldTextSize = fieldTextSize;
    this.type = type;
    this.border = border;
    isActive = false;
    universalSave(name, "");
    text = "";
  }

  Textfield() {
  }

  void show() {
    textFont(arial);
    textAlign(CORNER, BOTTOM);
    textSize(fieldTextSize);
    fill(colors.get("black"));
    text(name, xPos, yPos);
    if (type == "moneyValue") {
      if (text.length() == 0)fill(colors.get("black"));
      else if (float(text) >= 0)fill(colors.get("green"));
      else fill(colors.get("red"));
    } else fill(colors.get("black"));
    if (type == "moneyValue")text(text + "E", xPos + textWidth(name) + height/50, yPos); //€
    else text(text, xPos + textWidth(name) + height/50, yPos);
    strokeWeight(5);
    if (isActive)stroke(colors.get("red"));
    else stroke(colors.get("black"));
    line(xPos + textWidth(name) + height/120, yPos, xPos + fieldWidth - height/60, yPos);
  }

  void addText() {  
    if (isActive) {
      if (keyCode == 67 && text.length()>0) {
        text = text.substring(0, text.length() - 1);
      } else if (keyCode != 67)text += key;
      
      if (type == "moneyValue") {
        if (!((keyIsNumber() || keyCode == 67 || key == '.' || key == '-') && valueIsSmallEnough(border, text)) && text.length()>0)text = text.substring(0, text.length() - 1);
      } else if (type == "text") {
        if (!((keyIsLetter() || keyIsNumber() || key == ' ' || key == '.' || keyCode == 67) && xPos + textWidth(text) + textWidth(name) + height/15<xPos + fieldWidth) && text.length()>0)text = text.substring(0, text.length() - 1);
      }
    }
  }

  boolean mouseIsInsideTextField() {
    return mouseIsInside(xPos + textWidth(name), yPos - fieldTextSize, fieldWidth - textWidth(name), fieldTextSize, "CORNER");
  }

  boolean mouseWasInsideTextField() {
    return mouseWasInside(xPos + textWidth(name), yPos - fieldTextSize, fieldWidth - textWidth(name), fieldTextSize, "CORNER");
  }

  boolean mouseAndPosWereInside() {
    return mouseAndPositionWereInside(xPos + textWidth(name), yPos - fieldTextSize, fieldWidth - textWidth(name), fieldTextSize, "CORNER");
  }
}


class ImageField {
  PImage image = new PImage();
  float xPos;
  float yPos;
  float pictureWidth;
  float pictureHeight;
  int imageMode;
  String imageModeString;

  ImageField() {
  }
  ImageField(PImage image, float xPos, float yPos, float pictureWidth, float pictureHeight, int imageMode, String imageModeString) {
    this.image = image;
    this.xPos = xPos;
    this.yPos = yPos;
    this.pictureWidth = pictureWidth;
    this.pictureHeight = pictureHeight;
    this.imageMode = imageMode;
    this.imageModeString = imageModeString;
  }

  void show() {
    imageMode(imageMode);
    image(image, xPos, yPos, pictureWidth, pictureHeight);
  }

  boolean mouseIsInsideImageField() {
    return mouseIsInside(xPos, yPos, pictureWidth, pictureHeight, imageModeString);
  }

  boolean mouseWasInsideImageField() {
    return mouseWasInside(xPos, yPos, pictureWidth, pictureHeight, imageModeString);
  }

  boolean mouseAndPosWereInside() {
    return mouseAndPositionWereInside(xPos, yPos, pictureWidth, pictureHeight, imageModeString);
  }
}


void createTextfields() {
  textfields.put("manualAmountsValue", new Textfield("Betrag:", width/6.5, height/3.25, width - 2 * width/6, height/13, "moneyValue", 4));
  textfields.put("manualAmountsUsage", new Textfield("Zweck:", width/6.5, height/2.4, width - 2 * width/6, height/13, "text", 0));
  textfields.put("addProductName", new Textfield("Name:", width/6.5, height/3.28, width - width/6, height/11, "text", 0));
  textfields.put("addProductPrice", new Textfield("Preis:", width/6.5, height/2.25, width - width/6, height/11, "moneyValue", 2));
  textfields.put("addDepositAmount", new Textfield("Betrag:", width/6.5, height/3.28, width - width/6, height/11, "moneyValue", 1));
}

void createImageFields() {
  imageFields.put("yesHomeManualAmountInput", new ImageField(images.get("yes"), width - width/4.4, height/2, height/(height/161), height/(height/161), CENTER, "CENTER"));
  imageFields.put("noHomeManualAmountInput", new ImageField(images.get("no"), width - width/3.2, height/2, height/(height/161), height/(height/161), CENTER, "CENTER"));
  imageFields.put("balancesCashInHandDisplayIcon", new ImageField(images.get("bill"), width/8.2/2, height/1.28 + (height - height/1.28)/2 - height/200, width/11.5, width/11.5, CENTER, "CENTER"));
  imageFields.put("backbutton", new ImageField(images.get("backbutton"), width/8.2/2 + height/100, height/1.28 + (height - height/1.28)/2 - height/200, width/6, width/6, CENTER, "CENTER"));
  imageFields.put("smallBackbutton", new ImageField(images.get("backbutton"), width/8.2/2, height/1.28 + (height - height/1.28)/2 - height/200, width/6.8, width/6.8, CENTER, "CENTER"));
  imageFields.put("deleteProduct", new ImageField(images.get("delete"), width/2 + width/4 + width/64, height/1.25, height/6.5, height/6.5, CENTER, "CENTER"));
  imageFields.put("confirmProductAdding", new ImageField(images.get("yes"), width/2 + width/4 + width/8 + width/32, height/1.25, height/6.25, height/6.25, CENTER, "CENTER"));
  imageFields.put("contactList", new ImageField(images.get("contactList"), width/1.28, height/1.51, height/8, height/8, CENTER, "CENTER"));
  imageFields.put("confirmButton", new ImageField(images.get("confirmButton"), width/1.56, height/1.51, height/6.4, height/6.4, CENTER, "CENTER"));
  imageFields.put("deleteUser", new ImageField(images.get("delete"), width/1.28, height/1.51, height/8, height/8, CENTER, "CENTER"));
  imageFields.put("deleteDeposit", new ImageField(images.get("delete"), width/2 + width/4 + width/64, height * 0.45, height/6.5, height/6.5, CENTER, "CENTER"));
  imageFields.put("confirmDepositAdding", new ImageField(images.get("yes"), width/2 + width/4 + width/8 + width/32, height * 0.45, height/6.25, height/6.25, CENTER, "CENTER"));
  imageFields.put("balancesYes", new ImageField(images.get("yes"), width/1.28, height/2.6, width/9.3, width/9.3, CORNER, "CORNER"));
  imageFields.put("balancesNo", new ImageField(images.get("no"), width/1.5, height/2.6, width/9.3, width/9.3, CORNER, "CORNER"));
  imageFields.put("confirmAddingNewUser", new ImageField(images.get("confirmButton"), width/1.56, height/1.51, height/6.4, height/6.4, CENTER, "CENTER"));
  imageFields.put("activateDarkMode", new ImageField(images.get("credits"), width - width/7, height/1.28/5 * 4.5, height/10, height/10, CORNER, "CORNER"));
}

void createColors() {
  if (colorMode == DARK_MODE) {
    colors.put("white", color(40));
    colors.put("black", color(150));
    colors.put("red", color(160, 45, 45));
    colors.put("green", color(60, 140, 50));
    colors.put("orange", color(180, 130, 35));
    colors.put("darkBlue", color(65, 130, 220));
  } else {   
    colors.put("white", color(255));
    colors.put("black", color(0));
    colors.put("red", color(220, 0, 0));
    colors.put("green", color(0, 200, 0));
    colors.put("orange", color(255, 170, 0));
    colors.put("darkBlue", color(50, 130, 220));
  }
}
