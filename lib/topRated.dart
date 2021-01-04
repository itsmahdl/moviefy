import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moviefy/detailspage.dart';

// ignore: must_be_immutable
class Latest extends StatefulWidget {
  var id;
  Latest({this.id});
  @override
  _Latest createState() => _Latest();
}

class _Latest extends State<Latest> {
  var titleLatest;
  var id;
  var poster;
  var date;
  var genre;
  var posterLatest;
  var apiKey = '6d6f3a650f56fd6b3347428018a20a73';

  listPosterlatest(index) {
    return titleLatest[index]['poster_path'] != null
        ? titleLatest[index]['poster_path']
        : 'loading';
  }

  listNameLatest(index) {
    return titleLatest[index]['title'] != null
        ? titleLatest[index]['title']
        : 'loading';
  }

  getid(index) {
    this.id = titleLatest[index]['id'];
    return titleLatest[index]['id'];
  }

  getRate(index) {
    return titleLatest[index]['vote_average'];
  }

  getVoteCount(index) {
    return titleLatest[index]['vote_count'];
  }

  getposterr(index) {
    this.poster = titleLatest[index]['poster_path'];
    return titleLatest[index]['poster_path'];
  }

  getDate(index) {
    this.date = titleLatest[index]['release_date'];
    var formated = DateFormat('yyyy-MM-dd').parse(date);
    var formatedTwice = DateFormat.y().format(formated);
    return formatedTwice;
  }
  getOverview(index) {
    return titleLatest[index]['overview'];
  }

  var page;
  var results;

  @override
  void initState() {
    this.getListRecent();
    super.initState();
  }

  Future getListRecent({index}) async {
    http.Response response = await http.get(
        'https://api.themoviedb.org/3/movie/top_rated?api_key=6d6f3a650f56fd6b3347428018a20a73&language=en-US&page=1');
     results = jsonDecode(response.body);
    setState(() {
      this.titleLatest = results['results'];
    });
    return results['results'];
  }



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: getListRecent(),builder: (context, snapshot){
      if (snapshot.hasData) {
        return ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            getid(index);
                            print(index);
                            print(id);
                            print(poster);
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Details(
                                      getid(index),
                                      getposterr(index),
                                      listNameLatest(index),
                                      getDate(index),
                                      getRate(index), getVoteCount(index), getOverview(index))));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black38.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5)
                                ],
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500/' +
                                          listPosterlatest(index),
                                    ))),
                            height: 150,
                            width: 100,
                            child: null),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          width: 100,
                          child: Text(
                            listNameLatest(index),
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          )),
                    ],
                  ));
            });
      } else {
        return Center(child: SpinKitThreeBounce(color: Colors.white,));
      }
    });
  }
}
