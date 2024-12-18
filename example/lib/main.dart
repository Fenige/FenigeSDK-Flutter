import 'package:fenige_sdk/data/address.dart';
import 'package:fenige_sdk/data/enviroment.dart';
import 'package:fenige_sdk/data/redirect_url.dart';
import 'package:fenige_sdk/data/sender.dart';
import 'package:fenige_sdk/fenige_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FenigeSDK Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  // Current environment
  FenigeEnvironment _currentEnvironment = FenigeEnvironment.development;

  final String _devApiKey = "a0185ee7-a197-4e3e-a830-a5d6992fba2f";
  final String _prodApiKey = "bfd5061e-9455-4f74-b688-d19ab3643808";

  String _transactionId = Uuid().v4();
  String _amount = "100";
  List<String> currencies = {"PLN", "EUR", "USD"}.toList();
  String _selectedCurrency = "PLN";
  String _paymentDescription = "Test Payment";
  bool _isAutoClear = true;
  bool _isRecurring = false;
  String _resultTransactionId = "";

  String get _apiKey =>
      _currentEnvironment == FenigeEnvironment.production ? _prodApiKey : _devApiKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FenigeSDK Demo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Environment Toggle
            Row(
              children: [
                const Text("Environment: "),
                const SizedBox(width: 8),
                Text(
                  _currentEnvironment == FenigeEnvironment.production ? "Production" : "Development",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _currentEnvironment == FenigeEnvironment.production
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Switch(
                  value: _currentEnvironment == FenigeEnvironment.production,
                  onChanged: (value) {
                    setState(() {
                      _currentEnvironment = value
                          ? FenigeEnvironment.production
                          : FenigeEnvironment.development;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            // API Key display (read-only)
            TextField(
              decoration: InputDecoration(
                labelText: "Api key (${_currentEnvironment == FenigeEnvironment.production ? 'Production' : 'Development'})",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
              ),
              controller: TextEditingController(text: _apiKey),
              readOnly: true,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Amount (cents)",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                    controller: TextEditingController(text: _amount),
                    onChanged: (value) {
                      _amount = value;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField(
                    value: currencies.first,
                    items: currencies.map<DropdownMenuItem<String>>((String currency) {
                      return DropdownMenuItem<String>(value: currency, child: Text(currency));
                    }).toList(),
                    onChanged: (value) {
                      _selectedCurrency = value ?? currencies.first;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: "Payment description",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
              ),
              controller: TextEditingController(text: _paymentDescription),
              onChanged: (value) {
                _paymentDescription = value;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text("AutoClear"),
                const SizedBox(width: 8),
                Switch(
                  value: _isAutoClear,
                  onChanged: (value) {
                    setState(() {
                      _isAutoClear = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text("Is Recurring"),
                const SizedBox(width: 8),
                Switch(
                  value: _isRecurring,
                  onChanged: (value) {
                    setState(() {
                      _isRecurring = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FenigeSDK.createPayment(
                      _currentEnvironment,
                      _apiKey,
                      _transactionId,
                      int.parse(_amount),
                      _selectedCurrency,
                      _paymentDescription,
                      "https://paytool-dev.fenige.pl/demo/",
                      "123",
                      "en",
                      RedirectUrl("https://testok.com", "https://testfaill.com"),
                      Sender("Test", "Test", Address("PL", "Krakow", "03-355", "vylitsya", "15")),
                      _isAutoClear,
                      _isRecurring,
                    ),
                  ),
                ).then((value) {
                  if (value is String) {
                    setState(() {
                      _resultTransactionId = value;
                    });
                  }
                });
              },
              child: const Text("Create payment"),
            ),
            _resultTransactionId.isNotEmpty
                ? GestureDetector(
                    child: Text("Transaction Id: $_resultTransactionId"),
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: _resultTransactionId));
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}