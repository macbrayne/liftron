//Allgemeine Konstanten 
final int HOME = 0;
final int BALANCES = 1;
final int LOGIN = 2;
final int CASH_REGISTER = 3;
final int STOCK_OVERVIEW = 4;


//Konstanten Home - Bereich
final int HOME_STANDARD = 0;
final int HOME_AMOUNT_INPUT = 1;


//Konstanten Bilanzen - Bereich
final int BALANCES_STANDARD = 0;
final int BALANCES_ENTER_FILM_TITLE = 1;
final int BALANCES_ENTER_NUMBER_OF_VISITORS = 2;
final int BALANCES_ENTER_CASH_COUNTED = 3;
final int BALANCES_CONFIRM_POSSIBLE_DEVIATION = 5;
final int BALANCES_CASH_IN_HAND_DISPLAY = 6;
final int BALANCES_FUNCTION_AVAILANLE_FROM_LEVEL_2 = 7;

final String BALANCES_STATE = "balancesState";
final String BALANCES_EXPENDITURE = "expenditure";
final String BALANCES_CASH_AFTER_COUNTED = "cashAfterCounted";
final String BALANCES_NUMBER_OF_VISITORS = "numberOfVisitors";
final String BALANCES_FILM_TITLE = "filmTitle";
final String BALANCES_EVENING_ACTIVITY = "eveningActivity";


//Konstanten Login - Bereich
final int LOGIN_STANDARD = 0;
final int LOGIN_USER_NOT_FOUND_ERROR = 1;
final int LOGIN_USER_ALREADY_LOGED_IN_MESSAGE = 2;
final int LOGIN_PASSWORD_IS_WRONG_ERROR = 3;
final int LOGIN_USER_LOGED_IN_CONFIRMATION = 4;
final int LOGIN_USER_LOGED_OUT = 5;
final int LOGIN_REGISTRATION_AKFILM_MEMBER_ADDED_SUCCESSFULLY_MESSAGE = 6;
final int LOGIN_USER_REGISTRATION = 7;
final int LOGIN_FUNCTION_AVAILABLE_FROM_LEVEL_3 = 9;
final int LOGIN_SELECT_USER_TO_CHANGE = 10;
final int LOGIN_CHANGE_USER = 11;
final int LOGIN_SHOW_NO_USERS_REGISTRATED_MESSAGE = 12;

final String LOGIN_USERNAME = "loginUserName";
final String LOGIN_USERPASSWORD = "loginUserPassword";
final String LOGIN_REGISTRATION_USERNAME = "loginRegistrationUsername";
final String LOGIN_REGISTRATION_USERPASSWORD = "loginRegistrationUserpassword";
final String LOGIN_WRITE_STATE = "loginWriteState";
final String LOGIN_REGISTRATION_WRITE_STATE = "loginRegistrationWriteState";
final String LOGIN_USER_LOGED_IN_STATE = "userLogedInWileLogoutState";
final String LOGIN_USERNAME_WHILE_LOGOUT = "usernameWhileLogout";
//TODO Verschiebung um - 1 zwischen Eingabe und Verarbeitung entfernen?
final String LOGIN_SELECTED_ACCESS_CATEGORY = "selectedaccessCategory";
final String LOGIN_CHANGE_USER_STRING = "changeUser";
final String SELECT_USER_TO_LOG_IN = "selectUserToLogIn";
final String USER_SELECTED_TO_CHANGE = "userSelectedToChange";
final String LOGIN_CREATE_NEW_USER = "createNewUser";


//Konstanten Kassenbereich
final int CASH_REGISTER_STANDARD = 0;
final int CASH_REGISTER_DELETE_PRODUCT = 1;

final String CASH_REGISTER_WRITE_STATE = "selectionWriteState";
final String CASH_REGISTER_CASH_POSITION = "kassenstand";
final String CASH_REGISTER_NUMBER_OF_PICTURES = "bilderanzahl";


//Konstanten Bestandsübersicht
final int STOCK_OVERVIEW_STANDARD = 0;
final int STOCK_OVERVIEW_OPTIONS = 1;
final int STOCK_OVERVIEW_NEW_PURCHASE = 2;
final int STOCK_OVERVIEW_STOCK_CORRECTION = 3;
final int STOCK_OVERVIEW_PRODUCT_ADMINISTRATION = 4;
final int STOCK_OVERVIEW_STOCK_CORRECTION_RUNNING = 5;
final int STOCK_OVERVIEW_NEW_PURCHASE_ADDING_RUNNING = 6;
final int STOCK_OVERVIEW_QUIT_PURCHASE_WINDOW = 7;
final int STOCK_OVERVIEW_ENTER_COMPLETE_PURCHASE_PRICE_WINDOW = 8;
final int STOCK_OVERVIEW_FUNCTION_AVAILABLE_FROM_LEVEL_2 = 9;
final int STOCK_OVERVIEW_FUNCTION_AVAILABLE_FROM_LEVEL_3 = 10;
final int STOCK_OVERVIEW_SHOW_PRODUCT_ADMINISTRATION_OPTIONS = 11;
final int STOCK_OVERVIEW_PRODUCT_ADMINISTRATION_CREATE_PRODUCT = 12;
final int STOCK_OVERVIEW_PRODUCT_ADMINISTRATION_SELECT_PRODUCT_TO_CHANGE = 13;
final int STOCK_OVERVIEW_PRODUCT_ADMINISTRATION_CHANGE_PRODUCT = 14;
final int STOCK_OVERVIEW_PRODUCT_ADMINISTRATION_CREATE_DEPOSIT = 15;
final int STOCK_OVERVIEW_PRODUCT_ADMINISTRATION_CHANGE_DEPOSIT = 16;
final int STOCK_OVERVIEW_QUIT_NEW_PURCHASE = 17;

final String STOCK_OVERVIEW_PURCHASE_PRICE = "stockOverviewPurchasePrice";



//Konstanten manuelle Betragseingabe
final int PLEASE_ENTER_VALID_VALUE_ERROR = 1;
final int PLEASE_ENTER_USAGE_ERROR = 2;


//Konstanten Schreibfelder
final int EVENINGNAME_TEXTFIELD = 1;
final int NUMBER_OF_VISITORS_TEXTFIELD = 2;
final int CASH_AFTER_COUNTED_TEXTFIELD = 3;
final int EXPENDITURE_TEXTFIELD = 4;
final int LOGIN_USERNAME_TEXTFIELD = 5;
final int LOGIN_USERPASSWORD_TEXTFIELD = 6;
final int LOGIN_REGISTRATION_USERNAME_TEXTFIELD = 7;
final int LOGIN_REGISTRATION_USERPASSWORD_TEXTFIELD = 8;
final int STOCK_OVERVIEW_ENTER_PURCHASE_PRICE_TEXTFIELD = 9;


//Konstanten Verschiebungs - Speicherung (scroll)
final String CASH_REGISTER_PRODUCTS = "cashRegisterProducts";
final String CASH_REGISTER_SELECTION = "cashRegisterSelection";
final String STOCK_OVERVIEW_PRODUCTS = "stockOverviewProducts";

//Konstanten Farbschema
final int DARK_MODE = 0;
final int LIGHT_MODE = 1;
