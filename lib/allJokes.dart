import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'APIhelperclass.dart';
import 'Jsonmodelclass.dart';

class AllJokes extends StatefulWidget {
  const AllJokes({Key? key}) : super(key: key);

  @override
  State<AllJokes> createState() => _AllJokesState();
}

class _AllJokesState extends State<AllJokes> {

  late Future<RandomJokes?> fetchedJokes;

  @override
  initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {});
    });
    fetchedJokes = APIHelper.apiHelper.fetchJokes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: fetchedJokes,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
         if (snapshot.hasData) {
            RandomJokes data = snapshot.data as RandomJokes;
            return Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Container(
                      alignment: Alignment.center,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          data.jokes,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: const [
                    SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                    ),
                    CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ],
                ));
          }
        },
      ),
    );
  }
}
