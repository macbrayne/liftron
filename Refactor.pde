/**
This section is to be embedded into the program by Paul Schappert after review.
*/

int cashRegisterProducts;
int cashRegisterSelection;
int stockOverviewProducts;


/**
For reusing the old api
*/
// Can be inlined
void shiftScroll(String scrollField, int shift) {
  switch(scrollField) {
    case CASH_REGISTER_PRODUCTS:
      
      break;
    case CASH_REGISTER_SELECTION:
      break;
    case STOCK_OVERVIEW_PRODUCTS:
      break;
    default:
      throw new RuntimeException(String.format("Invalid argument: %s", scrollField));
  }
}

void setScroll(String scrollField, int value) {
  switch(scrollField) {
    case CASH_REGISTER_PRODUCTS:
      cashRegisterProducts = value;
      break;
    case CASH_REGISTER_SELECTION:
      cashRegisterSelection = value;
      break;
    case STOCK_OVERVIEW_PRODUCTS:
      stockOverviewProducts = value;
      break;
    default:
      throw new RuntimeException(String.format("Invalid argument: %s", scrollField));
  }
}

int getScroll(String scrollField) {
  switch(scrollField) {
    case CASH_REGISTER_PRODUCTS:
      return stockOverviewProducts;
    case CASH_REGISTER_SELECTION:
      return stockOverviewProducts;
    case STOCK_OVERVIEW_PRODUCTS:
      return stockOverviewProducts;
    default:
      throw new RuntimeException(String.format("Invalid argument: %s", scrollField));
  }
}
