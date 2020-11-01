import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reviewismflutter/screens/best_sellers.dart';
import 'package:reviewismflutter/screens/comics_screen.dart';
import 'package:reviewismflutter/screens/new_releases.dart';
import 'package:reviewismflutter/screens/review_screen.dart';
import 'package:reviewismflutter/services/bestseller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:reviewismflutter/services/book.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:xml2json/xml2json.dart';
import 'dart:io' show Platform;

class SearchScreen extends StatefulWidget {
  static const String id = 'search_screen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isLoading = false;
  String bookName;
  String name;
  bool loading = true;

  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<Book>> key = new GlobalKey();
  static List<Book> books = new List();

  Xml2Json xml2json = new Xml2Json();

  void getBestSellersData() async {
    setState(() {
      isLoading = true;
    });
    var bestSellerData = await BestSellerModel().getBooksBestSellers();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return BestSellers(
        bestSeller: bestSellerData,
      );
    }));

    setState(() {
      isLoading = false;
    });
  }

  void getNewReleaseData() async {
    setState(() {
      isLoading = true;
    });
    var newReleaseData = await BestSellerModel().getNewReleases();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NewReleases(
        newRelease: newReleaseData,
      );
    }));
    setState(() {
      isLoading = false;
    });
  }

  void getNewComicReleaseData() async {
    setState(() {
      isLoading = true;
    });
    var newComicData = await BestSellerModel().getNewComics();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Comics(
        newComic: newComicData,
      );
    }));
    setState(() {
      isLoading = false;
    });
  }

  void getBooks() async {
    try {
      var newData = await BestSellerModel().getBookList();
      books = loadBooks(newData);
      setState(() {
        loading = false;
      });
    } catch (e) {
      print("Error getting books.");
    }
  }

  void getReview(String name) async {
    setState(() {
      isLoading = true;
    });
    try {
      var newReviewData = await BestSellerModel().getReviews(name);
      xml2json.parse(newReviewData);
      var jsondata = xml2json.toParker();
      var data = json.decode(jsondata);
      if (data['error'] != 'Page not found') {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ReviewScreen(
            reviewData: data,
          );
        }));
      } else {
        _showDialog();
      }
      setState(() {
        isLoading = false;
      });
      bookName = null;
    } catch (e) {
      print(e);
    }
  }

  _showDialog() {
    return showDialog(
      context: context,
      child: CupertinoAlertDialog(
        title: Text(
          'Not available',
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  static List<Book> loadBooks(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Book>((json) => Book.fromJson(json)).toList();
  }

  @override
  void initState() {
    super.initState();
    getBooks();
  }

  Widget row(Book book) {
    return Container(
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(20.0),
          right: Radius.circular(20.0),
        ),
      ),
      child: Text(
        book.name,
        textScaleFactor: 1.0,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
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
          child: isLoading
              ? Center(
                  child: SpinKitDoubleBounce(
                    color: Colors.white,
                    size: 100.0,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SafeArea(
                      child: Opacity(
                        opacity: 0.9,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 80.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'images/book-glasses_icon-icons.com_49248.png'),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          child: Text(''),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Review book',
                          textScaleFactor: 1.0,
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 50.0, right: 50.0, top: 50.0, bottom: 20.0),
                      child: loading
                          ? CircularProgressIndicator()
                          : searchTextField = AutoCompleteTextField<Book>(
                              key: key,
                              clearOnSubmit: false,
                              suggestions: books,
                              submitOnSuggestionTap: true,
                              textChanged: (text) {
                                bookName = text;
                              },
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                              ),
                              decoration: InputDecoration(
                                hintText: 'type book name here',
                                fillColor: Colors.white,
                                hintStyle: TextStyle(color: Colors.grey),
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 20.0),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 2.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0)),
                                ),
                              ),
                              itemFilter: (item, query) {
                                return item.name
                                    .toLowerCase()
                                    .startsWith(query.toLowerCase());
                              },
                              itemSorter: (a, b) {
                                return a.name.compareTo(b.name);
                              },
                              itemSubmitted: (item) {
                                setState(() {
                                  searchTextField.textField.controller.text =
                                      item.name;
                                  bookName = item.name;
                                });
                              },
                              itemBuilder: (context, item) {
                                // ui for the autocompelete row
                                return row(item);
                              },
                            ),
                    ),
                    Padding(
                      padding: Platform.isIOS
                          ? const EdgeInsets.only(
                              left: 150.0, right: 150.0, bottom: 60.0)
                          : const EdgeInsets.only(
                              left: 120.0, right: 120.0, bottom: 20.0),
                      child: FlatButton(
                        padding: EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          'search',
                          textScaleFactor: 1.0,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Platform.isIOS ? 20.0 : 15.0,
                          ),
                        ),
                        color: Color(0xffC8EAFC),
                        onPressed: () {
                          if ((bookName != null) && (bookName != '')) {
                            isLoading
                                ? Center(
                                    child: SpinKitDoubleBounce(
                                      color: Colors.white,
                                      size: 100.0,
                                    ),
                                  )
                                : getReview(bookName);
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: Platform.isIOS
                          ? EdgeInsets.only(top: 50.0)
                          : EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    getBestSellersData();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(20.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xffC8EAFC),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                    ),
                                    child: Icon(
                                      Icons.library_books,
                                      size: 40.0,
                                      color: Color(0xff094B9E),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    getNewReleaseData();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(20.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xffC8EAFC),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                    ),
                                    child: Icon(
                                      Icons.fiber_new,
                                      size: 40.0,
                                      color: Color(0xff094B9E),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    getNewComicReleaseData();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(20.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xffC8EAFC),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                    ),
                                    child: Icon(
                                      Icons.child_care,
                                      size: 40.0,
                                      color: Color(0xff094B9E),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Top 10 Best Sellers',
                                textScaleFactor: 1.0,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'New Releases',
                                textScaleFactor: 1.0,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Comics',
                                textScaleFactor: 1.0,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
