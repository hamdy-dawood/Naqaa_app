class UrlsStrings {
  static String baseUrl = "https://morabrand.net/naqaa/";
  static String baseImageUrl =
      "https://morabrand.net/naqaa/upload/productsimga/";

  static String signUpUrl = "${baseUrl}Auth/signup.php";
  static String loginUrl = "${baseUrl}ll";

  static String allProductsUrl = "${baseUrl}products/viewproducts.php";
  static String addProductBasketUrl = "${baseUrl}basket/addbasket.php";
  static String removeProductBasketUrl = "${baseUrl}basket/removebasket.php";
  static String removeAllBasketUrl = "${baseUrl}basket/removeAllBasket.php";

  static String basketsUrl = "${baseUrl}basket/viewbasket.php";

  static String ordersUrl = "${baseUrl}order/vieworders.php";
  static String addOrdersUrl = "${baseUrl}order/addorder.php";

  static String networkErrorUrl =
      "https://telegra.ph/file/5fd32c81aeea0385e2418.png";
  static String noImageUrl =
      "https://telegra.ph/file/71de56d0641458ae1c65d.png";
  static String userImageUrl =
      "https://telegra.ph/file/c8e961ef22fcb1c4546f1.png";
}

class AssetsStrings {
  static String baseIcons = "assets/icons/";
  static String baseImages = "assets/images/";

  static String noNetworkImage = "${baseImages}no_network.png";

  static String mosqueImage = "${baseImages}mosque.svg";
  static String homeImage = "${baseImages}home.svg";
  static String tickIcon = "${baseIcons}tick.svg";
  static String tickUnFillIcon = "${baseIcons}tick_un_fill.svg";

  static String logoIcon = "${baseIcons}logo.svg";
  static String homeIcon = "${baseIcons}home.svg";
  static String searchIcon = "${baseIcons}search.svg";
  static String ordersIcon = "${baseIcons}orders.svg";
  static String checkIcon = "${baseIcons}check.svg";
  static String profileIcon = "${baseIcons}profile.svg";

  static String homeSelectedIcon = "${baseIcons}home_selected.svg";
  static String searchSelectedIcon = "${baseIcons}search_selected.svg";
  static String ordersSelectedIcon = "${baseIcons}orders_selected.svg";
  static String checkSelectedIcon = "${baseIcons}check_selected.svg";
  static String profileSelectedIcon = "${baseIcons}profile_selected.svg";

  static String locationIcon = "${baseIcons}location.svg";
  static String notificationIcon = "${baseIcons}notification.svg";
  static String deleteIcon = "${baseIcons}delete.svg";
  static String filterIcon = "${baseIcons}filter.svg";
  static String userEditIcon = "${baseIcons}user_edit.svg";
  static String logoutIcon = "${baseIcons}logout.svg";
  static String supportIcon = "${baseIcons}support.svg";
  static String whatsappIcon = "${baseIcons}whatsapp.svg";
}
