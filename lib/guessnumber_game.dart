import 'package:flutter/material.dart';

import 'game.dart';

class Gameguessnumber extends StatefulWidget {
  static const buttonSize = 60.0;
  late Game _game;


  Gameguessnumber({Key? key}) : super(key: key){
    _game = Game(maxRandom: 100);
  }

  @override
  State<Gameguessnumber> createState() => _GameguessnumberState();
}

class _GameguessnumberState extends State<Gameguessnumber> {
  String _input = '';
  String _status = 'ทายเลข 1 ถึง 100';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GUESS THE NUMBER'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(5.0, 5.0),
                spreadRadius: 2.0,
                blurRadius: 5.0,
              )
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/guess_logo.png', width: 90.0),
                    SizedBox(width: 8.0),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('GUESS',
                            style: TextStyle(
                                fontSize: 36.0, color: Colors.lightBlueAccent)),
                        Text(
                          'THE NUMBER',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.teal,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_input, style: TextStyle(fontSize: 40.0)),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0,top: 15.0 ),
                child: Text('$_status', style: TextStyle(fontSize: 20.0)),
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildButton(1),
                        _buildButton(2),
                        _buildButton(3),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildButton(4),
                        _buildButton(5),
                        _buildButton(6),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildButton(7),
                        _buildButton(8),
                        _buildButton(9),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildButton(-2),
                        _buildButton(0),
                        _buildButton(-1),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          var input = _input;
                          var guess = int.tryParse(input);
                          if(guess == null){
                            showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  title: Text('ERROR'),
                                  content: Text('Please fill in number.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          var guessResult = widget._game.doGuess(guess!);
                          if(guessResult > 0){
                            setState(() {
                              _status = '$guess : มากเกินไป ';
                              _input = '';
                            });
                          }else if (guessResult < 0) {
                            setState(() {
                              _status = '$guess : น้อยเกินไป ';
                              _input = '';
                            });
                          }else {
                            setState(() {
                              _status = '$guess : ツถูกต้องツ ( ทาย : ${widget._game.guessCount} )';
                            });
                          }
                        },
                        child: Text('GUESS'),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildButton(int? num) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton(
        onPressed: ()
        {
          if (num == -1) {
            setState(() {
              // '12345'
              var length = _input.length;
              _input = _input.substring(0, length - 1);
            });
          }else if(num == -2){
            setState(() {
              _input = '';
            });
          }else {
            if(_input.length<3)
              setState(() {
                _input = _input+'$num';
              });
            print('You pressed $num');
          }
        },
        child: (num == -1) ? Icon(Icons.backspace,)  : (num == -2) ? Icon(Icons.close): Text('$num',style: TextStyle(
          fontSize: 25.0,
        ),),
      ),
    );
  }
}