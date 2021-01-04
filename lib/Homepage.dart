import 'package:flutter/material.dart';
import 'package:moviefy/Trending.dart';
import 'package:moviefy/TrendingAll.dart';
import 'package:moviefy/TopRatedAll.dart';
import 'package:moviefy/topRated.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xff1d1d27),
          body: ListView(
            children: [
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 34, horizontal: 20),
                          child: Text(
                            'Search',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 32),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: TextField(
                        onSubmitted: (ctx) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Search(
                                        value: controller.text,
                                      )));
                        },
                        controller: controller,
                        autofocus: false,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: 'Movie, Actors, Directors',
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey)),
                            disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey)),
                            hintStyle: TextStyle(color: Colors.blueGrey)),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 44, 20, 10),
                            child: Text(
                              'Trending',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TrendingAll()));
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 44, 20, 10),
                            child: Text(
                              'See All',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        height: 240,
                        child: Trending(),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 44, 20, 10),
                            child: Text(
                              'Top Rated',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TopRatedAll()));
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 44, 20, 10),
                            child: Text(
                              'See All',
                              style:
                              TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        height: 240,
                        child: Latest(),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class Search extends StatefulWidget {
  final String value;
  Search({Key key, this.value}) : super(key: key);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var title;
  var results;

  getSearch({index = 0}) async {
    http.Response response = await http.get(
        'https://api.themoviedb.org/3/search/movie?api_key=6d6f3a650f56fd6b3347428018a20a73&language=en-US&query=' +
            widget.value);
    results = json.decode(response.body);
    return results['results'][0]['title'];
  }

  getName(index) {
    return results['results'][index]['title'];
  }

  getId(index) {
    return results['results'][index]['id'];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xff1d1d27),
          body: Column(
            children: [
              Expanded(
                  child: FutureBuilder(
                future: getSearch(),
                builder: (context, snapshot) {
                  String name = snapshot.data;
                  print(name);
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: results['results']?.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: GestureDetector(
                              onTap: () {
                                print(getId(index));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailsPagee(
                                              id: getId(index),
                                            )));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          getName(index).toString(),
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    )),
                              ),
                            ),
                          );
                        });
                  } else {
                    return Center(
                        child: SpinKitThreeBounce(
                      color: Colors.white,
                    ));
                  }
                },
              ))
            ],
          )),
    );
  }
}

// ignore: must_be_immutable
class DetailsPagee extends StatefulWidget {
  int id;
  DetailsPagee({Key key, this.id}) : super(key: key);
  @override
  _DetailsPageeState createState() => _DetailsPageeState();
}

class _DetailsPageeState extends State<DetailsPagee> {
  var results;
  var name;
  var id;
  var date;

  getSearch({index = 0}) async {
    http.Response response = await http.get(
        'https://api.themoviedb.org/3/movie/' +
            widget.id.toString() +
            '?api_key=6d6f3a650f56fd6b3347428018a20a73&language=en-US');
    results = json.decode(response.body);
    setState(() {
      this.name = results['title'];
    });
    return results['title'];
  }

  getName() {
    return results['title'];
  }

  getPoster() {
    return results['poster_path'] != null
        ? results['poster_path']
        : '/bGN3Ik3CatDC9wvfV55LLBrBGh8.jpg';
  }

  getDate() {
    return results['release_date'];
  }

  getOverview() {
    return results['overview'];
  }

  formatDate() {
    var date = getDate();
    var formated = DateFormat('yyyy-MM-dd').parse(date);
    var formatedTwice = DateFormat.y().format(formated);
    return formatedTwice;
  }

  getVote() {
    return results['vote_average'];
  }

  getVoteCount() {
    return results['vote_count'];
  }

  var baseUrl = 'https://image.tmdb.org/t/p/w500/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1d1d27),
        body: ListView(
          children: [
            Column(
              children: [
                FutureBuilder(
                  future: getSearch(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Container(
                            height: 600,
                            child: Stack(
                              children: [
                                Image(
                                  image: NetworkImage(baseUrl + getPoster()),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            Color(0xff1d1d27),
                                            Color(0xff1d1d27).withOpacity(0),
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          stops: [0.0, 0.9])),
                                ),
                                Positioned(
                                    top: 530,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 5),
                                        child: Row(children: [
                                          Text(
                                            name,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            '(${formatDate()})',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ])))
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 10),
                            child: Container(
                              height: 1.0,
                              width: double.infinity,
                              color: Color(0xff3d3d49),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 44, vertical: 10),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.star_rate_rounded,
                                        color: Colors.white,
                                        size: 35,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        getVote().toString() + '/10',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 44, vertical: 10),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.face_rounded,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      getVoteCount().toString(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ],
                                ),
                              ))
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 10),
                            child: Container(
                              height: 1.0,
                              width: double.infinity,
                              color: Color(0xff3d3d49),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 10),
                                child: Text(
                                  'Overview',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 10),
                            child: Text(
                              getOverview(),
                              style: TextStyle(color: Color(0xffa0a7b8)),
                            ),
                          )
                        ],
                      );
                    } else {
                      return Center(
                          child: SpinKitThreeBounce(
                        color: Colors.white,
                      ));
                    }
                  },
                )
              ],
            ),
          ],
        ));
  }
}
