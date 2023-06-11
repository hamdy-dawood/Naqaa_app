import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:naqaa/core/languages.dart';
import 'package:naqaa/pages/languages/cubit.dart';
import 'package:naqaa/pages/splash/view.dart';

import 'core/cache_helper.dart';
import 'core/navigate.dart';
import 'pages/add_product_to_basket/cubit.dart';
import 'pages/address_type/cubit.dart';
import 'pages/bottom_nav_bar/cubit.dart';
import 'pages/delete_account/cubit.dart';
import 'pages/edit_basket/cubit.dart';
import 'pages/get_user_id/cubit.dart';
import 'pages/home/cubit.dart';
import 'pages/map/home_map/cubit.dart';
import 'pages/orders/cubit.dart';
import 'pages/remove_all_basket/cubit.dart';
import 'pages/remove_product_from_basket/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await initApp();
}

Future<void> initApp() async {
  String savedLang = CacheHelper.getLang();
  Locale initialLocale =
      savedLang.isNotEmpty ? Locale(savedLang) : Locale("ar");

  runApp(MyApp(initialLocale: initialLocale));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initialLocale});

  final Locale initialLocale;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => NavBarCubit()),
            BlocProvider(create: (context) => GetUserIDCubit()),
            BlocProvider(create: (context) => AllProductsCubit()),
            BlocProvider(create: (context) => AddProductBasketCubit()),
            BlocProvider(create: (context) => RemoveProductBasketCubit()),
            BlocProvider(create: (context) => RemoveAllBasketCubit()),
            BlocProvider(create: (context) => EditBasketCubit()),
            BlocProvider(create: (context) => AddressTypeCubit()),
            BlocProvider(create: (context) => LanguageCubit()),
            BlocProvider(create: (context) => LanguageAppCubit()),
            BlocProvider(create: (context) => OrdersCubit()),
            BlocProvider(create: (context) => HomeMapCubit()),
            BlocProvider(create: (context) => DeleteAccountCubit()),
          ],
          child: BlocBuilder<LanguageAppCubit, Locale>(
            builder: (context, locale) {
              CacheHelper.saveLang(locale.languageCode);
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: "NAQAA",
                navigatorKey: navigatorKey,
                theme: ThemeData(
                  platform: TargetPlatform.iOS,
                ),
                translations: Languages(),
                locale: locale,
                fallbackLocale: Locale("ar"),
                home: const SplashView(),
              );
            },
          ),
        );
      },
    );
  }
}
