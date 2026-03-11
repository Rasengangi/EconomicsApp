import 'package:flutter/cupertino.dart';
import 'package:testpp/Model/Transaction.dart';
import 'package:testpp/Data/DatabaseHelper.dart';

class TransactionViewModel extends ChangeNotifier {
  List<Transaction> Transactioner = [];

  Future<void> hentFraDatabase() async {
    Transactioner = await DatabaseHelper.instance.fetchAll();
    notifyListeners();
  }

  void tilfoejTransaction(Transaction t) async {
    await DatabaseHelper.instance.insert(t); // Gemmer i databasen
    await hentFraDatabase(); // Opdaterer listen i appen
  }
  
  void fjernTransaction(Transaction t) {
    Transactioner.remove(t);
    notifyListeners();
  }
  
  int beregnBalance() {
    int sum = 0;
    for (var t in Transactioner) {
      sum += t.beloeb;
    }
    return sum;
  }
  
  void sletTransaction(Transaction t) async {
    await DatabaseHelper.instance.delete(t.beskrivelse, t.beloeb); 
    await hentFraDatabase();
  }

  Map<String, int> beregnKategoriData() {
    Map<String, int> kategoriSum = {};

    for (var t in Transactioner) {
      if (kategoriSum.containsKey(t.kategori)) {
        kategoriSum[t.kategori] = kategoriSum[t.kategori]! + t.beloeb;
      } else {
        kategoriSum[t.kategori] = t.beloeb;
      }
    }
    return kategoriSum;
  }
}