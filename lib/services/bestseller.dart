import 'package:reviewismflutter/services/networking.dart';

const apiKey = 'lJjycgZ2DgFzfezAbMi3zs6Ply7BitxG';
const nytimesURL =
    'https://api.nytimes.com/svc/books/v3/lists/2020-01-10/hardcover-fiction.json';
String newURL = '';

class BestSellerModel {
  Future<dynamic> getBooksBestSellers() async {
    NetworkHelper networkHelper = NetworkHelper('$nytimesURL?api-key=$apiKey');

    var bestSellerData = await networkHelper.getData();
    return bestSellerData;
  }

  Future<dynamic> getNewReleases() async {
    var currDt = DateTime.now();
    var year = currDt.year;
    var month = currDt.month;
    var day = currDt.day;
    if (month < 10) {
      newURL =
          'https://api.nytimes.com/svc/books/v3/lists/$year-0$month-0$day/hardcover-fiction.json?api-key=lJjycgZ2DgFzfezAbMi3zs6Ply7BitxG';
    }
    else if(day < 10){
      newURL =
      'https://api.nytimes.com/svc/books/v3/lists/$year-$month-0$day/hardcover-fiction.json?api-key=lJjycgZ2DgFzfezAbMi3zs6Ply7BitxG';

    }
    else {
      newURL =
          'https://api.nytimes.com/svc/books/v3/lists/$year-$month-$day/hardcover-fiction.json?api-key=lJjycgZ2DgFzfezAbMi3zs6Ply7BitxG';
    }
    NetworkHelper networkHelper = NetworkHelper(newURL);

    var newReleaseData = await networkHelper.getData();
    return newReleaseData;
  }

  Future<dynamic> getNewComics() async {
    newURL = 'https://api.shortboxed.com/comics/v1/new';

    NetworkHelper networkHelper = NetworkHelper(newURL);

    var newReleaseData = await networkHelper.getData();
    return newReleaseData;
  }

  Future<dynamic> getBookList() async {
    const url =
        "http://www.json-generator.com/api/json/get/bVQxXaoGcy?indent=2";
    NetworkHelper networkHelper = NetworkHelper(url);

    var newData = await networkHelper.getJsonString();
    return newData;
  }

  Future<dynamic> getReviews(String name) async {
    var url =
        "https://www.goodreads.com/book/title.xml?key=ztLGus9FiSMGJudtEXt6w&title=$name";
    NetworkHelper networkHelper = NetworkHelper(url);

    var newData = await networkHelper.getJsonString();
    return newData;
  }
}
