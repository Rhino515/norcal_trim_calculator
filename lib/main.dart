import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(NorCalTrimApp());

class NorCalTrimApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NorCal Trim Calculator',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.black,
        textTheme: GoogleFonts.montserratTextTheme().apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
      home: TrimCalculatorScreen(),
    );
  }
}

class TrimCalculatorScreen extends StatefulWidget {
  @override
  _TrimCalculatorScreenState createState() => _TrimCalculatorScreenState();
}

class _TrimCalculatorScreenState extends State<TrimCalculatorScreen> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';

  double calculatePayment(double grams) {
    double pay = 0.0;
    if (grams > 1587) {
      pay += (grams - 1587) * 0.11;
      pay += (1587 - 1134) * 0.05;
    } else if (grams > 1134) {
      pay += (grams - 1134) * 0.05;
    }
    return double.parse(pay.toStringAsFixed(2));
  }

  void _calculate() {
    final input = double.tryParse(_controller.text);
    if (input != null) {
      final payment = calculatePayment(input);
      setState(() {
        _result = 'Payment: \$${payment.toStringAsFixed(2)}';
      });
    } else {
      setState(() {
        _result = 'Please enter a valid number.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NorCal Trim Calculator'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset('assets/norcal_icon.png', height: 100),
            SizedBox(height: 16),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter grams'),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculate,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text('Calculate'),
            ),
            SizedBox(height: 16),
            Text(_result, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
