class AKFilmMember {
  String name;
  String password;
  int accessCategory;

  //TODO durch Permission - HashMap (String - bool) ersetzen
  boolean controlActivityPermission = false;
  boolean correctStockPermission = false;
  boolean addNewPurchasePermission = false;
  boolean manageProductsPermission = false;
  boolean manageMembersPermission = false;

  AKFilmMember(String name, String password, int accessCategory) {
    this.name = name;
    this.password = password;
    this.accessCategory = accessCategory;
  }

  String toString() {
    return "Der Nutzer " + name + " mit dem Passwort " + password + " hat die Zugriffsberechtigung " + accessCategory + ".";
  }

  void setAccessCategory(int accessCategory) {

    switch(accessCategory) {
    case 1:
      this.controlActivityPermission = true;
      this.correctStockPermission = true;
      this.addNewPurchasePermission = true;
      break;

    case 2:
      this.controlActivityPermission = true;
      this.correctStockPermission = true;
      this.addNewPurchasePermission = true;
      this.manageProductsPermission = true;
      this.manageMembersPermission = true;
      break;
    }
  }
}
