import 'package:flutter/material.dart';
import 'dart:math';

class GuessingGameModel extends ChangeNotifier {
  final Random _random = Random();
  int _targetNumber = 0;
  String _feedback = '';
  int _guesses = 0;

  GuessingGameModel() {
    _resetGame();
  }

  String get feedback => _feedback;
  int get guesses => _guesses;

  void _resetGame() {
    _targetNumber = _random.nextInt(100) + 1;
    _feedback = 'Угадай число от 1 до 100';
    _guesses = 0;
    notifyListeners();
  }

  void makeGuess(int guess) {
    _guesses++;
    if (guess < _targetNumber) {
      _feedback = 'Больше';
    } else if (guess > _targetNumber) {
      _feedback = 'Меньше';
    } else {
      _feedback = 'Правильно! Загадано число $_targetNumber. Попытки: $_guesses';
    }
    notifyListeners();
  }

  void resetGame() {
    _resetGame();
  }
}
