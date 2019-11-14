/* Übersicht über alle Funktionen, die in diesem Programm erstellt werden sowie andere Inhalte, gegliedert in Tabs
 
 AKFILM_V5:-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
 - Deklaration globaler Variablen
 - void setup()
 - void draw()
 - void touchStarted()
 - void touchEnded()
 - void specialTouchEnded() 
 - void touchMoved()
 - void specialMouseClicked()
 - void keyPressed()
 
 AKFilmMember:-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --  - 
 - Variablendeklaration
 - Konstruktor
 - String toString()
 - void setAccessCategory(int accessCategory)
 
 Constants:-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
 - Konstanten für die allgemeine Anwendung
 - Konstanten für die Bilanzen
 - Konstanten für den Loginbereich
 - Konstanten für den Kassenbereich
 - Konstanten für die Bestandsübersicht
 - Konstanten für die Schreibfelder
 - Konstanten für die Speicherung der Verschiebungen
 
 Evening:-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
 - Variablendeklaration
 - String toString()
 
 Product:-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
 - Variablendeklaration
 - Konstruktor
 - String toString()
 
 calculateFunctions:-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --  - 
 - void startAddingNewPurchase()
 - boolean loginRegistrationDataRightness()
 - AKFilmMember processLoginRegistrationData()
 - void openAKFilmMemberAdministration()
 - void showAKFilmMemberProtocol()
 - void clearLoginRegistrationDocuments()
 - int checkWhichProductGotClicked()
 - AKFilmMember[]sortAKFilmMemberList(AKFilmMember[]AKFilmMembers)
 - void checkIfAKFilmMemberListNamefieldGotClicked()
 - void saveLogoutData()
 - void checkLoginData(String username, String userpassword)
 - void myChangeKeyboardState() 
 - void myOpenKeyboard()
 - myCloseKeyboard()
 - void writeText(String text, int writeState)
 - void resetDocuments()
 - void endEvening()
 - void addNewEvening(String filmTitle)
 - void closeEvening()
 - void simulateSale(String[]selection)
 - void quitSale(String[]selection)
 - int checkWhichImageIsClicked()
 - void checkIfFieldIsClickedAndAddIt()
 - void checkIfFieldIsClickedAndAddIt2()
 - float calculatePrice(String[]selectionNumbers)
 - float calculatePrice(ArrayList <String> selectionNumbers)
 - void loadImages()
 - int findElementToRemove()
 - void removeSelectedElement(int elementToRemove)
 - ArrayList loadProducts()
 - boolean valueIsSmallEnough(int maximalWholeNumbers, String text)
 - boolean keyIsNumber() 
 - boolean keyIsLetter()
 - boolean valueIsMoney(float value)
 - boolean mouseIsInsideBalancesYes()
 - boolean mouseIsInsideBalancesNo()
 - boolean mouseIsInside(float x1, float y1, float x2, float y2)
 - boolean mouseWasInside(float x1, float y1, float x2, float y2)
 - boolean positionIsInside(float positionX, float positionY, float x1, float y1, float x2, float y2)
 - boolean mouseAndPositionWereInside(float x1, float y1, float x2, float y2)
 
 dataFunctions:-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
 - void universalSave(String value, String valueName)
 - String universalLoad(String valueName)
 - void universalSaveArray(String[]data, String valueName)
 - String [] universalLoadArray(String valueName)
 - void universalCreateDocument(String filename)
 - void deleteOldFile(String oldFile)
 - void saveTextDocumentText()
 - void saveScroll(int shift, String scrollField)
 - void setScroll(int shift, String scrollField)
 - int loadScroll(String scrollField)
 - void createAKFilmMembersDocument()
 - void addNewAKFilmMember(AKFilmMember recent)
 - void saveAKFilmMembers(AKFilmMember[]AKFilmMembers)
 - AKFilmMember [] loadAKFilmMembers()
 - void saveSelection(ArrayList <String> selectionStringList)
 - void saveSelection(String[] selection)
 - String[] loadSelection()
 - void clearSelection()
 - void saveStorage()
 - ArrayList <Integer> loadStorage()
 - void createStorageDocument(int value)
 - void actualizeStorage(ArrayList <Integer> inStorage)
 - int loadTouchTime()
 - void saveTouchStartTime(int time)
 - int stopTouchTime()
 - ArrayList readImages(int bilderAnzahl)
 - void startTimer()
 - int loadTimerTime()
 - void saveActualEvening(Evening today)
 - Evening loadActualEvening()
 - void saveEvenings(ArrayList<Evening>evenings)
 - ArrayList <Evening> loadEvenings()
 - void makeEveningCsvDocument(Evening today)
 - void createDocuments()
 
 drawFunctions:-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
 - void openProductAdministrationOptions()
 - void showEnterCompletePurchasePriceWindow(String text)
 - void showQuitNewPurchaseWindow()
 - void drawNewPurchaseAddingWindow(int clickedProduct)
 - void showAddingOptions() 
 - void drawStockCorrectionWindow(int clickedProduct)
 - void drawTextDocument(String[]lines)
 - void drawReallyDeleteWindow()
 - void showPrice(ArrayList <String> selectionNumbers)
 - void drawTransition(float startX, float startY, float transitionLength, float transitionLong, float steps, int strongness, String direction)
 - void drawSelection (ArrayList <PImage> selection)
 - void logoutActualAKFilmMember()
 - void showUserNotFoundError()
 - void showUserAlreadyLogedInMessage()
 - void showPasswordIsWrongError()
 - void showUserLogedInConfirmation()
 - void showAKFilmMemberAddedSuccessfullyMessage()
 - void showAKFilmMembersList()
 - void showAddNewAKFilmMemberUserInterface()
 - void showEveningnameTextfield(String text)
 - void showNumberOfVisitorsTextField(String text)
 - void showCashAfterCountedTextField(String text)
 - void showExpenditureTextField(String text)
 - void showCashDifference() 
 - void drawEveningOverview(int i, float displayingWidth)
 - void drawSidebar(float shift)
 
 mainFunctions:-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
 - void drawHome()
 - void drawBalances()
 - void drawLogin(int mode)
 - void drawCashRegister(ArrayList <PImage> images, int state)
 - void drawStorageOverview(int mode)
 
 others:-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --  - 
 - void startTotalTimeTimer()
 - void saveTotalTimeTimerTime()
 - void savePassedTimeThisRun()
 - int loadPassedTimeThisRun()
 - int loadTotalTimeTimerTime()
 - String changeTimeInHours(int millis)
 
 overview:-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --  - 
 - Übersicht über alle Inhalte des Codes, gegliedert nach Tabs
 
 simplificationFunctions:-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
 - void drawYesNo()
 
 */
