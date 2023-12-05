import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calculator App'),
          backgroundColor: Colors.blue, // Set app bar color to blue
        ),
        body: Container(
          color: Colors.white,
          child: CalculatorView(),
        ),
      ),
    );
  }
}

class CalculatorView extends StatefulWidget {
  @override
  _CalculatorViewState createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  String _display = '0';
  String _currentOperand = '';
  String _previousOperand = '';
  String _operation = '';

  void _onButtonPressed(String value) {
    setState(() {
      if (_display == '0' || _display == 'Error') {
        _display = value;
      } else {
        _display += value;
      }
    });
  }

  void _onOperatorPressed(String operator) {
    setState(() {
      _operation = operator;
      _previousOperand = _display;
      _display = '0';
    });
  }

  void _onEqualsPressed() {
    setState(() {
      try {
        double result = _calculateResult();
        _display = result.toString();
        _currentOperand = _display;
        _operation = '';
      } catch (e) {
        _display = 'Error';
      }
    });
  }

  void _onClearPressed() {
    setState(() {
      _display = '0';
      _currentOperand = '';
      _previousOperand = '';
      _operation = '';
    });
  }

  double _calculateResult() {
    double num1 = double.parse(_previousOperand);
    double num2 = double.parse(_display);

    switch (_operation) {
      case '+':
        return num1 + num2;
      case '-':
        return num1 - num2;
      case 'x':
        return num1 * num2;
      case '/':
        return num1 / num2;
      default:
        throw Exception('Invalid operator');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.bottomRight,
            child: Text(
              _display,
              style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              for (int row = 3; row >= 1; row--)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int col = 1; col <= 3; col++)
                        _buildNumberButton(((row - 1) * 3 + col).toString()),
                    ],
                  ),
                ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildNumberButton('0'),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildOperatorButton('+'),
              _buildOperatorButton('-'),
              _buildOperatorButton('x'),
              _buildOperatorButton('/'),
              _buildEqualsButton(),
              _buildClearButton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNumberButton(String buttonText) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _onButtonPressed(buttonText),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Color(0xFFE1F5FE)), // Very light blue
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 36.0, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildOperatorButton(String operator) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _onOperatorPressed(operator),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Color(0xFFE1F5FE)), // Very light blue
        ),
        child: Text(
          operator,
          style: TextStyle(fontSize: 36.0, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildEqualsButton() {
    return Expanded(
      child: ElevatedButton(
        onPressed: _onEqualsPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Color(0xFFE1F5FE)), // Very light blue
        ),
        child: Text(
          '=',
          style: TextStyle(fontSize: 36.0, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildClearButton() {
    return Expanded(
      child: ElevatedButton(
        onPressed: _onClearPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Color(0xFFE1F5FE)), // Very light blue
        ),
        child: Text(
          'C',
          style: TextStyle(fontSize: 36.0, color: Colors.black),
        ),
      ),
    );
  }
}
