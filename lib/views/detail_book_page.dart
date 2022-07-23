import 'dart:convert';

import 'package:buku/models/book_detail_response.dart';
import 'package:buku/views/image_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailBookPage extends StatefulWidget {
  const DetailBookPage({Key? key, required this.isbn}) : super(key: key);
  final String isbn;
  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  BookDetailResponse? detailBook;
  fetchDetailBookApi() async {
    var url = Uri.parse('https://api.itbook.store/1.0/books/${widget.isbn}');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      detailBook = BookDetailResponse.fromJson(jsonDetail);
      setState(() {});
    }

    // print(await http.read(Uri.parse('https://example.com/foobar.txt')));
  }

  @override
  void initState() {
    super.initState();
    fetchDetailBookApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: detailBook == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ImageViewScreen(imageUrl: detailBook!.image!),
                            ),
                          );
                        },
                        child: Image.network(
                          detailBook!.image!,
                          height: 150,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Column(
                            children: [
                              Text(
                                detailBook!.title!,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                detailBook!.authors!,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: List.generate(
                                  5,
                                  (index) => Icon(
                                    Icons.star,
                                    color:
                                        index < int.parse(detailBook!.rating!)
                                            ? Colors.yellow
                                            : Colors.grey,
                                  ),
                                ),
                              ),
                              Text(
                                detailBook!.subtitle!,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                detailBook!.price!,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            // fixedSize: Size(double.infinity, 50)
                            ),
                        onPressed: () {},
                        child: Text('BUY')),
                  ),
                  // OutlinedButton(onPressed: () {}, child: Text('BUY')),
                  // TextButton(onPressed: () {}, child: Text('BUY')),
                  SizedBox(height: 20),
                  Text(detailBook!.desc!),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Year : " + detailBook!.year!),
                      Text("ISBN " + detailBook!.isbn13!),
                      Text(detailBook!.pages! + " Page"),
                      Text("Publisher " + detailBook!.publisher!),
                      Text("Language : " + detailBook!.publisher!),

                      // Text(detailBook!.rating!),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}