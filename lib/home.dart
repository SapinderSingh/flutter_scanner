import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String imageUrl = '';
  bool _isLoading = true;
  @override
  void initState() {
    getImageFromApi().then((value) {
      imageUrl = value;
    }).then((_) => setState(() {
          _isLoading = false;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CircularProgressIndicator()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {},
              ),
              title: Text('Savings'),
              centerTitle: true,
              elevation: 0,
            ),
            body: Stack(
              children: [
                Positioned(
                  top: 200,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 300,
                    color: Colors.grey,
                    child: Text('Here I am'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter UPI Number',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Pay through UPI',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DraggableScrollableSheet(
                  initialChildSize: 0.25,
                  builder: (BuildContext context, myscrollController) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      child: ListView(
                        controller: myscrollController,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 20),
                            child: Text(
                              'Search Contact',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25, top: 20, right: 20, bottom: 20),
                            child: TextField(
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.person),
                                hintText: 'Select Number',
                              ),
                            ),
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(''),
                            ),
                            title: Text(
                              'Sapinder Singh',
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
  }

  Future<String> getImageFromApi() async {
    var url = Uri.parse('https://fakeface.rest/face/json');
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    return data['image_url'].toString();
  }
}
