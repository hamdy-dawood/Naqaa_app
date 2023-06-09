class UrlsStrings {
  static const String baseUrl = "https://morabrand.net/naqaa/";
  static const String baseImageUrl =
      "https://morabrand.net/naqaa/upload/productsimga/";

  static const String signUpUrl = "${baseUrl}Auth/signup.php";
  static const String loginUrl = "${baseUrl}Auth/login.php";
  static const String profileDateUrl = "${baseUrl}Auth/viewmyinfo.php";
  static const String getUserIdUrl = "${baseUrl}Auth/getmyinfo.php";
  static const String deleteAccUrl = "${baseUrl}Auth/deletmyaccount.php";
  static const String editNameUrl = "${baseUrl}Auth/editmyinfo.php";

  static const String allProductsUrl = "${baseUrl}products/viewproducts.php";
  static const String addProductBasketUrl = "${baseUrl}basket/addbasket.php";
  static const String removeProductBasketUrl =
      "${baseUrl}basket/removebasket.php";
  static const String removeAllBasketUrl =
      "${baseUrl}basket/removeAllBasket.php";
  static const String basketsUrl = "${baseUrl}basket/viewbasket.php";
  static const String ordersUrl = "${baseUrl}order/vieworders.php";
  static const String ticketsUrl = "${baseUrl}order/viewticket.php";
  static const String addOrdersUrl = "${baseUrl}order/addorder.php";
  static const String addAllBasketOrdersUrl = "${baseUrl}order/addorderAll.php";

  static const String networkErrorUrl =
      "https://telegra.ph/file/5fd32c81aeea0385e2418.png";
  static const String noImageUrl =
      "https://telegra.ph/file/71de56d0641458ae1c65d.png";
  static const String userImageUrl =
      "https://telegra.ph/file/c8e961ef22fcb1c4546f1.png";
}

class AssetsStrings {
  static const String baseIcons = "assets/icons/";
  static const String baseImages = "assets/images/";

  static const String noNetworkImage = "${baseImages}no_network.png";

  static const String mosqueImage = "${baseImages}mosque.svg";
  static const String homeImage = "${baseImages}home.svg";
  static const String logoArabicImage = "${baseImages}logo_arabic.png";
  static const String logoEnglishImage = "${baseImages}logo_english.png";
  static const String tickIcon = "${baseIcons}tick.svg";
  static const String tickUnFillIcon = "${baseIcons}tick_un_fill.svg";

  static const String logoIcon = "${baseIcons}logo.svg";
  static const String homeIcon = "${baseIcons}home.svg";
  static const String searchIcon = "${baseIcons}search.svg";
  static const String ordersIcon = "${baseIcons}orders.svg";
  static const String checkIcon = "${baseIcons}check.svg";
  static const String profileIcon = "${baseIcons}profile.svg";

  static const String homeSelectedIcon = "${baseIcons}home_selected.svg";
  static const String searchSelectedIcon = "${baseIcons}search_selected.svg";
  static const String ordersSelectedIcon = "${baseIcons}orders_selected.svg";
  static const String checkSelectedIcon = "${baseIcons}check_selected.svg";
  static const String profileSelectedIcon = "${baseIcons}profile_selected.svg";

  static const String locationIcon = "${baseIcons}location.svg";
  static const String notificationIcon = "${baseIcons}notification.svg";
  static const String deleteIcon = "${baseIcons}delete.svg";
  static const String filterIcon = "${baseIcons}filter.svg";
  static const String userEditIcon = "${baseIcons}user_edit.svg";
  static const String logoutIcon = "${baseIcons}logout.svg";
  static const String supportIcon = "${baseIcons}support.svg";
  static const String whatsappIcon = "${baseIcons}whatsapp.svg";
}
