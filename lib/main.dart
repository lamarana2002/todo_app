import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/screens/todo_screen.dart';

ThemeMode themeMode = ThemeMode.dark;

final kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(232, 175, 177, 234));

final kColorSchemeDark =
    ColorScheme.fromSeed(seedColor: Colors.black, brightness: Brightness.dark);

final appTheme = ThemeData(
  bottomSheetTheme: BottomSheetThemeData().copyWith(
    backgroundColor: kColorScheme.onSecondaryContainer
  ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData().copyWith(),
    appBarTheme:  AppBarTheme().copyWith(
      backgroundColor: kColorScheme.onPrimaryContainer,
      // foregroundColor:kColorScheme.onPrimary,
        iconTheme: const IconThemeData()
            .copyWith(size: 30,color:kColorScheme.onPrimary,)),
    textTheme: 
    GoogleFonts.ralewayTextTheme(
      const TextTheme().copyWith(
        titleMedium: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: kColorScheme.onPrimary
        ),
        titleSmall: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black
        ),
        bodyLarge: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black
        ),
        bodyMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kColorScheme.onSecondary,),
        bodySmall: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        labelMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kColorScheme.onSecondary,),
        labelSmall: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    ),
    drawerTheme: DrawerThemeData().copyWith(
      backgroundColor: kColorScheme.onSecondaryContainer
    ),
    cardTheme: const CardTheme().copyWith(
      margin: const EdgeInsets.only(left: 15, right: 15),
      color: kColorScheme.onSecondaryContainer,
      // surfaceTintColor: kColorScheme.onSecondary,
      shadowColor: kColorScheme.secondary,
      elevation: 10,
    ),
    listTileTheme: ListTileThemeData(
      iconColor: kColorScheme.onPrimary
    ),
    iconTheme:  IconThemeData(
      color: kColorScheme.onPrimary,
    ),
    iconButtonTheme: IconButtonThemeData(style: IconButton.styleFrom(
      foregroundColor: kColorScheme.onSecondary,
    )),
    elevatedButtonTheme:
        ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
          backgroundColor: kColorScheme.onPrimaryContainer
        )));
final appThemeDark = ThemeData.dark().copyWith(
  bottomSheetTheme: BottomSheetThemeData().copyWith(
    backgroundColor: kColorSchemeDark.primaryContainer
  ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData().copyWith(),
    appBarTheme: const AppBarTheme().copyWith(
        iconTheme: const IconThemeData()
            .copyWith(size: 30)),
    textTheme: 
    GoogleFonts.ralewayTextTheme(
      const TextTheme().copyWith(
        titleMedium: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold),
            titleSmall: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),
        bodyLarge: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),
        bodyMedium: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        bodySmall: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        labelMedium:const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
        labelSmall: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    ),
    cardTheme: const CardTheme().copyWith(
      margin: const EdgeInsets.only(left: 15, right: 15),
      color: kColorScheme.onSecondaryContainer.withOpacity(.3),
      surfaceTintColor: kColorSchemeDark.secondaryContainer,
      shadowColor: kColorSchemeDark.secondary,
      elevation: 5,
    ),
    elevatedButtonTheme:
        ElevatedButtonThemeData(style: ElevatedButton.styleFrom()));

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Get.key,
      title: 'Flutter Demo',
      theme: appTheme,
      darkTheme: appThemeDark,
      home: const TodoScreen(),
      // themeMode: ThemeMode.dark,
    );
  }
}
