import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../ViewModel/TransactionViewModel.dart';
import 'TransactionView.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mit Overblik")),
      body: Consumer<TransactionViewModel>(
        builder: (context, viewModel, child) {
          final data = viewModel.beregnKategoriData();

          return Column(
            children: [
              SizedBox(height: 20),
              Text("Forbrug fordelt på kategorier", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 300,
                child: PieChart(
                  PieChartData(
                    sections: data.entries.map((entry) {
                      return PieChartSectionData(
                        color: _getFarveForKategori(entry.key),
                        value: entry.value.toDouble(),
                        title: '${entry.key}',
                        radius: 50,
                        titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
                      );
                    }).toList(),
                  ),
                ),
              ),
              ListTile(
                title: Text("Total forbrug"),
                trailing: Text("${viewModel.beregnBalance()} kr", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TransactionView()
              )
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
  Color _getFarveForKategori(String kategori) {
    switch (kategori.toLowerCase()) {
      case 'mad': return Colors.blue;
      case 'bolig': return Colors.green;
      case 'transport': return Colors.orange;
      case 'underholdning': return Colors.purple;
      case 'tøj': return Colors.yellow;
      case 'andet': return Colors.grey;
      default: return Colors.grey;
    }
  }
}