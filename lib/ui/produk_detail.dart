import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_page.dart';

class ProdukDetail extends StatefulWidget {
  Produk produk;
  ProdukDetail({this.produk});
  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}

enum BestTutorSite { kecil, sedang, besar }

class _ProdukDetailState extends State<ProdukDetail> {
  BestTutorSite _site = BestTutorSite.sedang;
  final _textJumlah = TextEditingController(text: '1');
  int harga_ukuran = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Detail Produk'),
      ),
      body: Center(
        child: Column(
          children: [
            new Image.asset(widget.produk.image),
            Text(
              widget.produk.namaProduk,
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              "Rp. ${widget.produk.hargaProduk.toString()}",
              style: TextStyle(fontSize: 18.0),
            ),
            Text(widget.produk.deskripsiProduk,
                style: TextStyle(fontSize: 18.0)),
            TextFormField(
                controller: _textJumlah,
                decoration: InputDecoration(labelText: "Jumlah Beli"),
                keyboardType: TextInputType.number),
            ListTile(
              title: const Text('Kecil'),
              leading: Radio(
                value: BestTutorSite.kecil,
                groupValue: _site,
                onChanged: (BestTutorSite value) {
                  setState(() {
                    _site = value;
                    harga_ukuran = -5000;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Sedang'),
              leading: Radio(
                value: BestTutorSite.sedang,
                groupValue: _site,
                onChanged: (BestTutorSite value) {
                  setState(() {
                    _site = value;
                    harga_ukuran = 0;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Besar'),
              leading: Radio(
                value: BestTutorSite.besar,
                groupValue: _site,
                onChanged: (BestTutorSite value) {
                  setState(() {
                    _site = value;
                    harga_ukuran = 5000;
                  });
                },
              ),
            ),
            _tombolBeli()
          ],
        ),
      ),
    );
  }

  Widget _tombolBeli() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Tombol Hapus
        ElevatedButton(
            child: Text("BELI"),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green)),
            onPressed: () => confirmBeli()),
      ],
    );
  }

  void confirmBeli() {
    final juml = int.parse(_textJumlah.text);
    int total_harga = (widget.produk.hargaProduk + harga_ukuran) * juml;

    AlertDialog alertDialog = new AlertDialog(
      content: Text(
          "Apa anda yakin ingin membeli kue ini?\n Nama: ${widget.produk.namaProduk}\n Total harga: ${total_harga}"),
      actions: [
        //tombol hapus
        ElevatedButton(
          child: Text("Ya"),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green)),
          onPressed: () => sukses(),
        ),
        //tombol batal
        ElevatedButton(
          child: Text("Batal"),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red)),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }

  void sukses() {
    AlertDialog alertDialog = new AlertDialog(
      content: Text("Terima Kasih!\n Kue pesanan anda akan segera dikirm"),
      actions: [
        ElevatedButton(
          child: Text("OKE"),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green)),
          onPressed: () async{
            Navigator.push(
          context, new MaterialPageRoute(builder: (context) => ProdukPage()));
          },
        )
      ],
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }
}
