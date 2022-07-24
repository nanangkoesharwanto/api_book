import 'package:buku/models/book_detail_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:buku/models/book_list_response.dart';
import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:js';

// import 'package:buku/models/book_detail_response.dart';
// import 'package:buku/views/image_view_screen.dart';
// import 'package:url_launcher/url_launcher.dart';

class BookController extends ChangeNotifier {
  BookListResponse? bookList;
  fetchBookApi() async {
    var url = Uri.parse('https://api.itbook.store/1.0/new');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonBookList = jsonDecode(response.body);
      bookList = BookListResponse.fromJson(jsonBookList);
      notifyListeners();
    }
    // print(await http.read(Uri.parse('https://example.com/foobar.txt')));
  }

  BookDetailResponse? detailBook;
  fetchDetailBookApi(isbn) async {
    var url = Uri.parse('https://api.itbook.store/1.0/books/${isbn}');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      detailBook = BookDetailResponse.fromJson(jsonDetail);
      notifyListeners();

      fetchSimiliarBookApi(detailBook!.title!);
    }

    // print(await http.read(Uri.parse('https://example.com/foobar.txt')));
  }

  BookListResponse? similiarBooks;
  fetchSimiliarBookApi(String title) async {
    var url = Uri.parse('https://api.itbook.store/1.0/search/${title}');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      similiarBooks = BookListResponse.fromJson(jsonDetail);
      notifyListeners();
    }

    // print(await http.read(Uri.parse('https://example.com/foobar.txt')));
  }
}
