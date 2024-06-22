import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/model.dart';


class NewsProvider with ChangeNotifier {
  static const String apiKey = '41170309382f41c8963e29168b45dd2a';
  static const String appleBaseUrl =
      'https://newsapi.org/v2/everything?q=apple&from=2024-05-26&to=2024-05-26&sortBy=popularity&apiKey=';
  static const String techCrunchBaseurl =
      'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=';
  static const String teslaBaseurl =
      'https://newsapi.org/v2/everything?q=tesla&from=2024-05-26&to=2024-05-26&sortBy=publishedAt&apiKey=';
  static const String businessBaseurl =
      'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=';
  static const String wallStreetJournal =
      'https://newsapi.org/v2/everything?domains=wsj.com&apiKey=';
  Album? _albumApple;
  Album? _albumTesla;
  Album? _albumTechCrunch;
  Album? _albumBusiness;
  Album? _albumWallStJrnl;
  bool _isLoading = false;
  String? _errorMessage;

  Album? get albumApple => _albumApple;

  Album? get albumTesla => _albumTesla;

  Album? get albumTechCrunch => _albumTechCrunch;

  Album? get albumBusiness => _albumBusiness;

  Album? get albumWallStJrnl => _albumWallStJrnl;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  void disposeHomeData() {
    _albumApple = null;
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> fetchApple() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(appleBaseUrl + apiKey));

      if (response.statusCode == 200) {
        _albumApple = Album.fromJson(jsonDecode(response.body));
        _errorMessage = null;
      } else {
        _errorMessage = 'Failed to load News';
      }
      // _isLoading = false;
      // notifyListeners();
    } on FormatException catch (_) {
      _errorMessage = 'Data conversion error';
      // _isLoading = false;
      // notifyListeners();
    } on SocketException catch (_) {
      _errorMessage = 'Please check your internet connection';
      // _isLoading = false;
      // notifyListeners();
    } on PlatformException catch (e) {
      _errorMessage = '${e.message}';
      //  _isLoading = false;
      // notifyListeners();
    } catch (e) {
      _errorMessage = '$e';
      //  _isLoading = false;
      // notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchNews(String keyword) async {
    _isLoading = true;
    _albumApple = null;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('https://newsapi.org/v2/everything?q=$keyword&from=2024-05-26&to=2024-05-26&sortBy=popularity&apiKey=$apiKey'));

      if (response.statusCode == 200) {
        _albumApple = Album.fromJson(jsonDecode(response.body));
        _errorMessage = null;
      } else {
        _errorMessage = 'Failed to load News';
      }
      // _isLoading = false;
      // notifyListeners();
    } on FormatException catch (_) {
      _errorMessage = 'Data conversion error';
      // _isLoading = false;
      // notifyListeners();
    } on SocketException catch (_) {
      _errorMessage = 'Please check your internet connection';
      // _isLoading = false;
      // notifyListeners();
    } on PlatformException catch (e) {
      _errorMessage = '${e.message}';
      //  _isLoading = false;
      // notifyListeners();
    } catch (e) {
      _errorMessage = '$e';
      //  _isLoading = false;
      // notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> filterCategory(String category) async {
    _isLoading = true;
    _albumApple = null;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=$apiKey'));

      if (response.statusCode == 200) {
        _albumApple = Album.fromJson(jsonDecode(response.body));
        _errorMessage = null;
      } else {
        _errorMessage = 'Failed to load News';
      }
      // _isLoading = false;
      // notifyListeners();
    } on FormatException catch (_) {
      _errorMessage = 'Data conversion error';
      // _isLoading = false;
      // notifyListeners();
    } on SocketException catch (_) {
      _errorMessage = 'Please check your internet connection';
      // _isLoading = false;
      // notifyListeners();
    } on PlatformException catch (e) {
      _errorMessage = '${e.message}';
      //  _isLoading = false;
      // notifyListeners();
    } catch (e) {
      _errorMessage = '$e';
      //  _isLoading = false;
      // notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchTechCrunch() async {
    _isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse(techCrunchBaseurl + apiKey));

    if (response.statusCode == 200) {
      _albumTechCrunch = Album.fromJson(jsonDecode(response.body));
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to load News';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchTesla() async {
    _isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse(teslaBaseurl + apiKey));

    if (response.statusCode == 200) {
      _albumTesla = Album.fromJson(jsonDecode(response.body));
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to load News';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchBusiness() async {
    _isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse(businessBaseurl + apiKey));

    if (response.statusCode == 200) {
      _albumBusiness = Album.fromJson(jsonDecode(response.body));
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to load Business News';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchJournal() async {
    _isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse(wallStreetJournal + apiKey));

    if (response.statusCode == 200) {
      _albumWallStJrnl = Album.fromJson(jsonDecode(response.body));
      _errorMessage = null;
    } else if (response.statusCode == 503) {
      _errorMessage = 'No Internet';
      notifyListeners();
    } else {
      _errorMessage = 'Failed to load Journal News';
    }

    _isLoading = false;
    notifyListeners();
  }

   String _key = 'cart_items';

  Future<void> addToWishlist(BuildContext context,Article article) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItems = prefs.getStringList(_key) ?? [];
    bool alreadyInCart = cartItems.any((item) {
      Article cartItem = Article.fromJson(jsonDecode(item));
      return cartItem.title == article.title;
    });

    if (!alreadyInCart) {
      cartItems.add(jsonEncode(article.toJson()));
      await prefs.setStringList(_key, cartItems);
      showSnackBar(context, "News is added to the Whislist");
      notifyListeners();
    } else {
      showSnackBar(context, "News is already in the Whislist");
    }
  }

  Future<void> removeFromWishList(BuildContext context,Article article) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItems = prefs.getStringList(_key) ?? [];
    cartItems.removeWhere((item) {
      Article cartItem = Article.fromJson(jsonDecode(item));
      return cartItem.title == article.title;
    });
    await prefs.setStringList(_key, cartItems);
    showSnackBar(context, "News is removed from the Whislist");
    notifyListeners();
  }

  Future<List<Article>> getWishListItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItems = prefs.getStringList(_key) ?? [];
    return cartItems.map((item) => Article.fromJson(jsonDecode(item))).toList();
  }

}
