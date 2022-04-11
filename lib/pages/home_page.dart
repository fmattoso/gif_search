import 'dart:convert';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/gif_details.dart';
import '../models/url_giphy.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _search;
  int _offset = 0;

  @override
  void initState() {
    super.initState();

    _getGifs().then((map) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Pesquise aqui!',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (text) {
                setState(() {
                  _search = text;
                  _offset = 0;
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _getGifs(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Container(
                      width: 200.0,
                      height: 200.0,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                        strokeWidth: 5.0,
                      ),
                    );
                  default:
                    if (snapshot.hasError) {
                      return Container();
                    } else {
                      return _createGifGrid(context, snapshot);
                    }
                }
              },
            ),
          ),
//          const Text(
//            'You have pushed the button this many times:',
//          ),
//          Text(
//            '---',
//            style: Theme.of(context).textTheme.headline4,
//          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  int _getCount(List data) {
    if (_search == null) {
      return data.length;
    } else {
      return data.length + 1;
    }
  }

  Widget _createGifGrid(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: _getCount(snapshot.data['data']),
        itemBuilder: (context, index) {
          if (_search == null || index < snapshot.data['data'].length) {
            return GestureDetector(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: snapshot.data['data'][index]['images']['fixed_height']
                    ['url'],
                fit: BoxFit.cover,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GifDetails(
                              Key: null,
                              gifData: snapshot.data['data'][index],
                            )));
              },
              onLongPress: () {
                Share.share(snapshot.data['data'][index]['images']
                    ['fixed_height']['url']);
              },
            );
          } else {
            return Container(
              child: GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 70.0,
                    ),
                    Text(
                      'Carregar mais!',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  setState(() {
                    _offset += 20;
                  });
                },
              ),
            );
          }
        });
  }

  Future<Map> _getGifs() async {
    http.Response response;
    if (_search == null) {
      response = await http.get(Uri.parse(UrlGiphy.urlTrending));
    } else {
      response =
          await http.get(Uri.parse(UrlGiphy.urlSearch(_search!, _offset)));
    }
    return jsonDecode(response.body);
  }
}
