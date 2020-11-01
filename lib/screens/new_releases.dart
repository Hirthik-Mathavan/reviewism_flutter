import 'package:flutter/material.dart';

class NewReleases extends StatefulWidget {
  NewReleases({this.newRelease});

  static const String id = 'new_releases';
  final newRelease;

  @override
  _NewReleasesState createState() => _NewReleasesState();
}

class _NewReleasesState extends State<NewReleases> {
  List<dynamic> temp1;
  @override
  void initState() {
    super.initState();
    updateUI(widget.newRelease);
  }

  void updateUI(dynamic newReleaseData) {
    List<dynamic> temp = newReleaseData['results']['books'];
    temp1 = temp;
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
                      title: Text('New Releases'),
                    ),
                    floating: false,
                    pinned: true,
                    snap: false,
                    backgroundColor: Color(0xff78bed1),
                  ),
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300.0,
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
                                        children: <Widget>[
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      temp1[index]
                                                          ['book_image']),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Expanded(
                                            child: Text(
                                              temp1[index]['title'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Roboto',
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              temp1[index]['author'],
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '${temp1[index]['rank']}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13.0,
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
                      childCount: 10,
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
