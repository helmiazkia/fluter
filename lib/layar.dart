import 'package:flutter/material.dart';

class styles extends StatefulWidget {
  @override
  _stylesState createState() => _stylesState();
}

class _stylesState extends State<styles> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _transactionType = 'Pemasukan';
  int _balance = 0;
  List<Map<String, dynamic>> _transactions = [];

  void _addTransaction() {
    String name = _nameController.text;
    int? amount = int.tryParse(_amountController.text);
    if (name.isEmpty || amount == null) return;

    setState(() {
      if (_transactionType == 'Pemasukan') {
        _balance += amount;
      } else {
        _balance -= amount;
      }
      _transactions.add({
        'name': name,
        'amount': amount,
        'type': _transactionType,
      });

      _nameController.clear();
      _amountController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Catatan Keuangan"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input untuk Nama Transaksi
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Transaksi",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),

            // Pilihan Jenis Transaksi
            Column(
              children: [
                RadioListTile<String>(
                  title: Text("Pemasukan"),
                  value: 'Pemasukan',
                  groupValue: _transactionType,
                  onChanged: (value) {
                    setState(() {
                      _transactionType = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text("Pengeluaran"),
                  value: 'Pengeluaran',
                  groupValue: _transactionType,
                  onChanged: (value) {
                    setState(() {
                      _transactionType = value!;
                    });
                  },
                ),
              ],
            ),

            // Input untuk Nominal Transaksi
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Nominal",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Tombol Simpan Transaksi
            ElevatedButton(
              onPressed: _addTransaction,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Simpan Transaksi"),
            ),
            SizedBox(height: 20),

            // Menampilkan Saldo
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  "Saldo: Rp $_balance",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Menampilkan Riwayat Transaksi
            Expanded(
              child: ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  final transaction = _transactions[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: Icon(
                        transaction['type'] == 'Pemasukan'
                            ? Icons.arrow_downward
                            : Icons.arrow_upward,
                        color: transaction['type'] == 'Pemasukan'
                            ? Colors.green
                            : Colors.red,
                      ),
                      title: Text("Rp ${transaction['amount']}"),
                      subtitle: Text(transaction['name']),
                      trailing: Text(
                        transaction['type'],
                        style: TextStyle(
                          color: transaction['type'] == 'Pemasukan'
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}