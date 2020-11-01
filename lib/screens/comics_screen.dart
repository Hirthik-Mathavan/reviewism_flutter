import 'package:flutter/material.dart';

class Comics extends StatefulWidget {
  Comics({this.newComic});
  static const String id = 'comics_screen';
  final newComic;

  @override
  _ComicsState createState() => _ComicsState();
}

class _ComicsState extends State<Comics> {
  List<dynamic> temp1;

  void updateUI(dynamic newComicData) {
    List<dynamic> temp = newComicData['comics'];
    temp1 = temp;
  }

  @override
  void initState() {
    updateUI(widget.newComic);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xffC8EAFC),
                    Color(0xff328297),
                  ],
                ),
              ),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    expandedHeight: 140.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0),
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text('Comics New Releases'),
                    ),
                    floating: false,
                    pinned: true,
                    snap: false,
                    backgroundColor: Color(0xff78bed1),
                  ),
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200.0,
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 1.0,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Card(
                                    color: Color(0xffaddef1),
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            temp1[index]['title'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black,
                                              fontFamily: 'Roboto',
                                            ),
                                          ),
                                          Text(
                                            temp1[index]['creators'],
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                          Text(
                                            temp1[index]['price'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.0,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: 120,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
