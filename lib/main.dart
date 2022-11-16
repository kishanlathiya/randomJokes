import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'APIhelperclass.dart';
import 'Jsonmodelclass.dart';
import 'allJokes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? savedJokes = prefs.getString('savedJokes') ?? "";
  await prefs.setString('savedJokes', savedJokes);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => jokesPage(),
        'allJokes': (context) => AllJokes(),
      },
    ),
  );
}

class jokesPage extends StatefulWidget {
  const jokesPage({Key? key}) : super(key: key);

  @override
  State<jokesPage> createState() => _jokesPageState();
}

class _jokesPageState extends State<jokesPage> {
  late Future<RandomJokes?> fetchedJokes;
  TextStyle myTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  final TextEditingController timeController = TextEditingController();
  final TextEditingController jokesController = TextEditingController();

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
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Jokes',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();

                await prefs.setString('savedJokes', "");

                Navigator.of(context).pushNamed('allJokes');
              },
              icon: const Icon(Icons.list_alt)),
        ],
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: fetchedJokes,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error : ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            RandomJokes data = snapshot.data as RandomJokes;
            return Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Image.asset("assets/images/emoji.png", height: 80),
                    const SizedBox(height: 20),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 15),
                          const Text(
                            "Created At  :  ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            data.createdAt,
                            style: myTextStyle,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 15),
                          const Text(
                            "ID  :  ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            data.id,
                            style: myTextStyle,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 15),
                          const Text(
                            "Updated At  :  ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            data.updatedAt,
                            style: myTextStyle,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
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
                          style: myTextStyle,
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              fetchedJokes = APIHelper.apiHelper.fetchJokes();
                            });
                          },
                          child: const Text("Fetch My Laugh  🔃")),
                    )
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
