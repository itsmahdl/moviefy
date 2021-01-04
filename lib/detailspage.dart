import 'dart:ui';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Details extends StatelessWidget {
  Details(this.id, this.poster, this.name, this.date, this.rate, this.vote,this.overview);
  var id;
  var poster;
  var name;
  var rate;
  var vote;
  var date;
  var overview;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1d1d27),
        body: ListView(children: [Column(
          children: [
            Container(
              height: 600,
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    width: double.infinity,
                    child: Container(
                        child: Image(
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500/' + poster))),
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
                        child: Row(
                          children: [
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
                              '($date)',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
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
                    padding: EdgeInsets.symmetric(horizontal: 44, vertical: 10),
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
                          rate.toString() + '/10',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 44, vertical: 10),
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
                            vote.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
              child: Container(
                height: 1.0,
                width: double.infinity,
                color: Color(0xff3d3d49),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Text(overview, style: TextStyle(color: Color(0xffa0a7b8)),),
            )
          ],
        )],));
  }
}
