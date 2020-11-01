import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ReviewScreen extends StatefulWidget {
  ReviewScreen({this.reviewData});

  final reviewData;
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen>
    with TickerProviderStateMixin {
  var temp;
  int length;

  @override
  void initState() {
    update();
    super.initState();
  }

  List<String> author = new List<String>();
  var auth;
  void update() {
    var tempo = widget.reviewData;
    temp = tempo['GoodreadsResponse']['book'];
    int len = temp['authors']['author'].length;
    length = len;
    print(length);
    if (len != 9) {
      List<String> authors = new List<String>();
      for (int i = 0; i < len; i++) {
        String t = temp['authors']['author'][i]['name'];
        authors.add(removeAllSlash(t));
      }
      author = authors;
    } else {
      auth = temp['authors']['author']['name'];
    }
  }

  dynamic removeAllHtmlTags(dynamic htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  dynamic removeAllSlash(dynamic htmlText) {
    RegExp exp = RegExp(r"\\", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffC8EAFC),
              Color(0xffa3e0f3),
            ],
          ),
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: 200.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ),
              ),
              backgroundColor: Color(0xff65c1d3),
              flexibleSpace: FlexibleSpaceBar(
                title: Container(
                  margin: EdgeInsets.only(top: 100.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('${temp['image_url']}'),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  padding: EdgeInsets.only(
                      left: 35.0, right: 35.0, top: 20.0, bottom: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Title',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Flexible(
                          child: Text(
                        temp['title'] != ''
                            ? '${removeAllSlash(temp['title'])}'
                            : '-',
                        style: TextStyle(
                          fontSize: 19.0,
                        ),
                      )),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 35.0, right: 35.0, bottom: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Author',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Flexible(
                          child: Text(
                        length != 9 ? '$author' : '$auth',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListTile(
                    leading: Text(
                      'Publication Year',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    trailing: Text(
                      temp['publication_year'] != null
                          ? '${temp['publication_year']}'
                          : '-',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 35.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Flexible(
                        child: Text(
                          temp['description'] != null
                              ? '${removeAllSlash(removeAllHtmlTags(temp['description']))}'
                              : '-',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListTile(
                    leading: Text(
                      'Average Ratings',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    trailing: Text(
                      temp['average_rating'] != ''
                          ? '${temp['average_rating']}'
                          : '-',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 35.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Edition',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Flexible(
                        child: Text(
                          temp['edition_information'] != ''
                              ? '${temp['edition_information']}'
                              : '-',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Reviews from Goodreads',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
