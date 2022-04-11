import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class GifDetails extends StatelessWidget {
  const GifDetails({Key? key, required this.gifData, Key}) : super(key: key);

  final Map gifData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Gif ${gifData['title']}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share(gifData['embed_url']);
              // Share.share(gifData['images']['original']['url']);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Título: ${gifData['title']}',
                style: const TextStyle(color: Colors.blueGrey, fontSize: 16.0),
              ),
            ),
            Image.network(gifData['images']['fixed_height']['url']),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.00, 0.0),
              child: Text(
                'Adicionado em ${gifData['import_datetime']}',
                style: const TextStyle(color: Colors.blueGrey, fontSize: 14.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.00, 0.0),
              child: Text(
                'Classificação: ${gifData['rating']}',
                style: const TextStyle(color: Colors.blueGrey, fontSize: 14.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.00, 0.0),
              child: Text(
                'Fonte: ${gifData['source_tld']}',
                style: const TextStyle(color: Colors.blueGrey, fontSize: 14.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
