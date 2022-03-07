import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<dynamic> foods = [];

  Future<void> _handClickButton() async {
    const API_URL = 'https://cpsu-test-api.herokuapp.com/foods';

    final response = await http.get(Uri.parse(API_URL));
    Map<String, dynamic> map = json.decode(response.body);
    foods = map["data"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FLUTTER FOOD'),
        ),
        body: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: _handClickButton,
                  child: const Text('LOAD FOODS DATA'),
                )),
            Expanded(
              child: ListView.builder(
                  itemCount: foods.length,
                  itemBuilder: (_, int index) => Card(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Image.network(
                              foods[index]["image"],
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Container(
                                    width: 300.0,
                                    child: Text(
                                      foods[index]["name"],
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Container(
                                    width: 300.0,
                                    child: Text(
                                      foods[index]["price"].toString() + " บาท",
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
            ),
          ],
        ));
  }
}
