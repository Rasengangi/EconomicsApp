import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testpp/ViewModel/TransactionViewModel.dart';
import 'package:testpp/View/AddTransactionView.dart';

class TransactionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dine transaktioner"),
      ),
      body: Consumer<TransactionViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            itemCount: viewModel.Transactioner.length,
            itemBuilder: (context, index) {
              final t = viewModel.Transactioner[index];

              return Dismissible(
                key: Key(t.beskrivelse + t.dato.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  viewModel.sletTransaction(t);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${t.kategori} slettet"))
                  );
                },
                child: ListTile(
                  title: Text(t.kategori),
                  subtitle: Text(t.beskrivelse),
                  trailing: Text('${t.beloeb} kr'),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTransactionView()
            ) 
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}