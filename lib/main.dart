import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/cache_helper.dart';
import 'core/navigate.dart';
import 'pages/add_product_to_basket/cubit.dart';
import 'pages/address_type/cubit.dart';
import 'pages/basket/cubit.dart';
import 'pages/bottom_nav_bar/cubit.dart';
import 'pages/home/cubit.dart';
import 'pages/orders/cubit.dart';
import 'pages/remove_all_basket/cubit.dart';
import 'pages/remove_product_from_basket/cubit.dart';
import 'pages/splash/view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  // CacheHelper.clear();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => NavBarCubit()),
            BlocProvider(create: (context) => AllProductsCubit()),
            BlocProvider(create: (context) => AddProductBasketCubit()),
            BlocProvider(create: (context) => RemoveProductBasketCubit()),
            BlocProvider(create: (context) => RemoveAllBasketCubit()),
            BlocProvider(create: (context) => BasketCubit()),
            BlocProvider(create: (context) => OrdersCubit()),
            BlocProvider(create: (context) => AddressTypeCubit()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'naqaa',
            navigatorKey: navigatorKey,
            theme: ThemeData(
              platform: TargetPlatform.iOS,
            ),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ar', 'AE'),
            ],
            locale: const Locale('ar', 'AE'),
            home: child,
          ),
        );
      },
      child: const SplashView(),
    );
  }
}
