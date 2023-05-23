class NavBarController {
  int selectedItem = 0;

  //list of navigation bar unselected icons
  List icons = [
    "assets/icons/home.svg",
    "assets/icons/search.svg",
    "assets/icons/orders.svg",
    "assets/icons/check.svg",
    "assets/icons/profile.svg",
  ];

  //list of navigation bar selected icons
  List selectedIcons = [
    "assets/icons/home_selected.svg",
    "assets/icons/search.svg",
    "assets/icons/orders_selected.svg",
    "assets/icons/check_selected.svg",
    "assets/icons/profile_selected.svg",
  ];

  //list of navigation bar labels
  List labels = [
    "الرئيسة",
    'بحث',
    'طلباتي',
    'السلة',
    'حسابي',
  ];
}
