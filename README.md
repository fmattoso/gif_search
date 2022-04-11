# gif_search

Buscador de Gifs

- API do Giphy Developers
- Navigator
- GridView
- Imagine Works
- Gesture detector
- Share, fading image
- Progress indicator

## Sobre o acesso ao Giphy
É preceiso ter um cadastro no Giphy e criar a classe abaixo na pasta "models" para o App funcionar.
import 'dart:convert';

import 'package:http/http.dart' as http;

class UrlGiphy {
  static const String _urlTrending = 'https://api.giphy.com/v1/gifs/trending?api_key=SUA_SENHA&limit=25&rating=r';
  static const String _urlRandom = 'https://api.giphy.com/v1/gifs/random?api_key=SUA_SENHA&tag=&rating=r';
  static const String _urlSearch = 'https://api.giphy.com/v1/gifs/search?api_key=SUA_SENHA&q=c%C3%A3o&limit=25&offset=0&rating=r&lang=pt';

  static String get urlTrending {
    return _urlTrending;
  }

  static String get urlRandom {
    return _urlRandom;
  }

  static String urlSearch(String q, int offset) {
    String urlResult = _urlSearch.replaceAll('&q=c%C3%A3o', '&q=${const HtmlEscape().convert(q)}');
    urlResult = urlResult.replaceAll('&offset=0', '&offset=$offset');
    return urlResult;
  }

}
## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
