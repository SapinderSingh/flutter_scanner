import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  final List<CameraDescription>? cameras;

  Home({this.cameras});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _imageUrl = '';
  bool _isLoading = true;

  late CameraController _cameraController;

  @override
  void initState() {
    _getImageFromApi().then(
      (value) {
        _imageUrl = value;
      },
    ).then(
      (_) {
        _cameraController =
            CameraController(widget.cameras![0], ResolutionPreset.max);
        _cameraController.initialize().then(
          (_) {
            if (!mounted) {
              return;
            }
            setState(
              () {
                _isLoading = false;
              },
            );
          },
        );
      },
    );
    super.initState();
  }

  Future<String> _getImageFromApi() {
    final Uri _url = Uri.parse('https://fakeface.rest/face/json');
    return http.get(_url).then(
      (http.Response response) {
        final Map<String, dynamic> _fetchedData = jsonDecode(response.body);
        return _fetchedData['image_url'].toString();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    print('Height: $_height');
    return _isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Color(0xFF9C7CF5),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {},
              ),
              title: const Text('Savings'),
              centerTitle: true,
              elevation: 0,
            ),
            body: Stack(
              children: [
                Positioned(
                  top: _height / 9,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: _height / 2.8,
                    color: Colors.grey,
                    child: CameraPreview(_cameraController),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF9C7CF5),
                        ),
                      ),
                      hintText: 'Enter UPI Number',
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Pay through UPI',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DraggableScrollableSheet(
                  initialChildSize: 0.25,
                  builder: (_, scrollController) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: ListView(
                        controller: scrollController,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(left: 20, top: 20),
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
                            padding: EdgeInsets.only(
                              left: 25,
                              top: 20,
                              right: 20,
                              bottom: 20,
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF9C7CF5),
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.person,
                                    color: Color(0xFF9C7CF5),
                                  ),
                                  onPressed: () async {},
                                ),
                                hintText: 'Select Number',
                              ),
                            ),
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(_imageUrl),
                            ),
                            title: const Text(
                              'Sumanth Verma',
                            ),
                            subtitle: Text('7530009088'),
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
}
