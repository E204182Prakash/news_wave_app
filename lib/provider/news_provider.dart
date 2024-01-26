import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/news_model.dart';

class NewsProvider with ChangeNotifier {
  NewsModel? _newsModel;
  String _selectedCategory = 'sports';
  String _selectedCountry = 'au';

  NewsModel? get news => _newsModel;

  String get selectedCategory => _selectedCategory;

  String get selectedCountry => _selectedCountry;

  Future<void> fetchHeadlines() async {
    try {
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=c0b58584422c486b866ab34605c1a745'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        _newsModel = NewsModel.fromJson(data);
        notifyListeners();
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<void> fetchNewsByCategory(String category) async {
    try {
      _selectedCategory = category;
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?q=$category&apiKey=c0b58584422c486b866ab34605c1a745'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        _newsModel = NewsModel.fromJson(data);
        notifyListeners();
      } else {
        throw Exception('Failed to load news data for category: $category');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<void> fetchNewsByCountry(String country) async {
    try {
      _selectedCountry = country;
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?q=$country&apiKey=c0b58584422c486b866ab34605c1a745'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        _newsModel = NewsModel.fromJson(data);
        notifyListeners();
      } else {
        throw Exception('Failed to load news data for category: $country');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<void> searchNews(String query) async {
    try {
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/everything?q=$query&apiKey=c0b58584422c486b866ab34605c1a745&sortBy=popularity'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        _newsModel = NewsModel.fromJson(data);
        notifyListeners();
      } else {
        throw Exception('Failed to load news data for search query: $query');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
