import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ViewModel/TransactionViewModel.dart';
import '../Model/Transaction.dart';

class AddTransactionView extends StatefulWidget {
  @override
  State<AddTransactionView> createState() => _AddTransactionViewState();
}

class _AddTransactionViewState extends State<AddTransactionView> {
  final TextEditingController beloebController = TextEditingController();
  final TextEditingController beskrivelseController = TextEditingController();
  final List<String> kategorier =  ['Mad', 'Tøj', 'Bolig','Underholdning','Andet'];
  @override
  void dispose() {
    beloebController.dispose();
    beskrivelseController.dispose();
    super.dispose();
  }
  
  String? valgtKategori;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tilføj transaktion")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: beloebController,
              decoration: InputDecoration(labelText: "Beløb"),
              keyboardType: TextInputType.number,
            ),
            DropdownButtonFormField<String>(
              value: valgtKategori,
              decoration: InputDecoration(labelText: "Kategori"),
              items: kategorier.map((String kategori) {
                return DropdownMenuItem<String>(
                  value: kategori,
                  child: Text(kategori),
                );
              }).toList(),
              onChanged: (String? nyVaerdi) {
                setState(() {
                  valgtKategori = nyVaerdi;
                });
              },
            ),
            TextField(
              controller: beskrivelseController,
              decoration: InputDecoration(labelText: "Beskrivelse"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final beloebInt = int.tryParse(beloebController.text) ?? 0;

                // Her gemmer vi transaktionen i vores ViewModel
                final nyTransaktion = Transaction(
                    beloebInt,
                    valgtKategori!,
                    DateTime.now(),
                    beskrivelseController.text
                );

                Provider.of<TransactionViewModel>(context, listen: false)
                    .tilfoejTransaction(nyTransaktion);

                // Lukker siden og går tilbage
                Navigator.pop(context);
              },
              child: Text("Gem"),
            )
          ],
        ),
      ),
    );
  }
}