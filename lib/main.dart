import 'package:flutter/material.dart';
import 'package:testpp/View/DashboardView.dart';
import 'package:testpp/ViewModel/TransactionViewModel.dart';
import 'package:provider/provider.dart';
import 'package:testpp/View/TransactionView.dart';
import 'package:testpp/Data/DatabaseHelper.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TransactionViewModel()..hentFraDatabase(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardView(),
    );
  }
}

class TransactionListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TransactionViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            itemCount: viewModel.Transactioner.length,
            itemBuilder: (context, index) {
              final t = viewModel.Transactioner[index];
              return ListTile(
                title: Text(t.kategori),
                subtitle: Text(t.beskrivelse),
                trailing: Text('${t.beloeb} kr'),
              );
            },
          );
        },
      ),
    );
  }
}