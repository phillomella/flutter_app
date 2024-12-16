import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'guessing_game_model.dart';

class GuessingGamePage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Угадай число'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              context.watch<GuessingGameModel>().feedback,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Введите число',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final guess = int.tryParse(_controller.text);
                if (guess != null) {
                  Provider.of<GuessingGameModel>(context, listen: false).makeGuess(guess);
                }
              },
              child: Text('Угадать'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Provider.of<GuessingGameModel>(context, listen: false).resetGame();
                _controller.clear();
              },
              child: Text('Сбросить игру'),
            ),
          ],
        ),
      ),
    );
  }
}
