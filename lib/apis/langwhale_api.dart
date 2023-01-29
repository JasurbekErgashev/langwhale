import 'dart:convert';

import 'package:http/http.dart' as http;

import '../services/logger.dart';
import '../models/langwhale_model.dart';
import '../services/constants.dart';

class LangwhaleService {
  Future<List<Langwhale>> getData({required String query}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/search?lang=en&q=$query'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json; charset=utf-8',
        'Accept-Encoding': 'gzip, deflate, br'
      },
    );
    if (response.statusCode == 200) {
      logger.d({
        'type': response.request?.method,
        'url': response.request?.url,
        'status': response.statusCode,
        'body': response.body,
      });

      return langwhaleFromJson(utf8.decode(response.bodyBytes)).values.toList();
    } else {
      throw Exception('Failed to get the data');
    }
  }
}
