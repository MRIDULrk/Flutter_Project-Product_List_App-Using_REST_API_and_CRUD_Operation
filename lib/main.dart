import 'package:flutter/material.dart';
import 'package:product_list_app/product_list_screen.dart';

void main() {
  runApp(const ProductListApp());
}

class ProductListApp extends StatelessWidget {
  const ProductListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,

      theme: ThemeData(

        appBarTheme: AppBarTheme(
          backgroundColor: Colors.lightGreen,
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 42, fontStyle:FontStyle.italic, fontWeight: FontWeight.bold),
          foregroundColor: Colors.white,
        ),


          inputDecorationTheme: const InputDecorationTheme(
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightGreenAccent)),
          ),

          elevatedButtonTheme: ElevatedButtonThemeData(
            
            style: ElevatedButton.styleFrom(
              fixedSize: const Size.fromWidth(double.maxFinite),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Colors.lightGreen,
              foregroundColor: Colors.white,
              textStyle: TextStyle(fontSize: 24 ,fontWeight: FontWeight.bold)

            ),
          ),

      ),

      home: const ProductListScreen(),

    );
  }
}
