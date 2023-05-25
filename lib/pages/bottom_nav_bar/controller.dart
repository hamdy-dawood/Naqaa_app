import 'package:naqaa/constants/strings.dart';

class NavBarController {
  int selectedItem = 0;

  //list of navigation bar unselected icons
  List icons = [
    AssetsStrings.homeIcon,
    AssetsStrings.searchIcon,
    AssetsStrings.ordersIcon,
    AssetsStrings.checkIcon,
    AssetsStrings.profileIcon,
  ];

  //list of navigation bar selected icons
  List selectedIcons = [
    AssetsStrings.homeSelectedIcon,
    AssetsStrings.searchSelectedIcon,
    AssetsStrings.ordersSelectedIcon,
    AssetsStrings.checkSelectedIcon,
    AssetsStrings.profileSelectedIcon,
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
