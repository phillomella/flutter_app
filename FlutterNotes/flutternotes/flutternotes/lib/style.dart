import 'package:flutter/material.dart';

class AppStyles {
  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.blueAccent,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    color: Colors.black,
  );

  static final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white, backgroundColor: Colors.blue,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    textStyle: TextStyle(fontSize: 16),
  );

  static ThemeData getAppointmentsTheme() {
    return ThemeData(
      primarySwatch: Colors.green,
      textTheme: TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.green),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.green,
        ),
      ),
    );
  }

  static ThemeData getContactsTheme() {
    return ThemeData(
      primarySwatch: Colors.red,
      textTheme: TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.red),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.red),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.red,
        ),
      ),
    );
  }

  static ThemeData getNotesTheme() {
    return ThemeData(
      primarySwatch: Colors.purple,
      textTheme: TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.purple),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.purple),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.purple,
        ),
      ),
    );
  }

  static ThemeData getTasksTheme() {
    return ThemeData(
      primarySwatch: Colors.orange,
      textTheme: TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.orange),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.orange),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.orange,
        ),
      ),
    );
  }

  static ThemeData getClickerTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      textTheme: TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.blue),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.blue,
        ),
      ),
    );
  }

  static ThemeData getGuessingGameTheme() {
    return ThemeData(
      primarySwatch: Colors.teal,
      textTheme: TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.teal),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.teal),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.teal,
        ),
      ),
    );
  }
}
