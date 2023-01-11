import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_mobile/models/bien.dart';
import 'package:real_estate_mobile/util/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:http/http.dart" as http;
import 'login.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name = "";
  int id = 0;
  late Future<List<Bien>> futureBiens;

  @override
  void initState() {
    _loadUserData();
    getProjectDetails();
    super.initState();
  }

  Future<List<Bien>> fetchBiens() async {
    final response = await http
        .get(Uri.parse('http://192.168.43.222:8000/api/ajax/biens/1'));

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((i) => Bien.fromJson(i))
          .toList();

      // return body.map<Bien>((json) => Bien.fromJson(json)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

// A function that converts a response body into a List<Photo>.
  /*List<Bien> parseBiens(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Bien>((json) => Bien.fromJson(json)).toList();
  }*/

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));

    if (user != null) {
      setState(() {
        name = user['name'] + user['lastname'];
        id = user['id'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: projectWidget());
  }

  void logout() async {
    var res = await NetWork().getData('/user/logout');
    var body = json.decode(res.body);

    if (body['success'] != null) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  /*Future<List<Bien>> getBiens(id) async {
    var res = await NetWork().getData("/ajax/biens/$id");
    return parseBiens(res.body);
  }*/

  Future<void> getBiensData() async {
    return await NetWork().getBiens("biens-data");
  }

  Future getProjectDetails() async {
    List<Bien> projetcList = await NetWork().getBiens("/biens-data");
    return projetcList;
  }

  Container _buildBody() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical, child: Column()),
    );
  }

  Widget projectWidget() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container();
        }
        return ListView.builder(
          itemCount: projectSnap.data!.length,
          itemBuilder: (context, index) {
            Bien bien = projectSnap.data[index];
            return Column(
              children: <Widget>[
                Card(
                    elevation: 4.0,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(bien.numero),
                          subtitle: const Text("Votre bien"),
                          trailing: const Icon(Icons.favorite_outline),
                          onTap: () {
                            print('id === ${bien.id}');
                          },
                        ),
                      ],
                    ))
              ],
            );
          },
        );
      },
      future: getProjectDetails(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        backgroundColor: const Color(0xFF073b4c),
        title: const Text("DASHBOARD"),
        actions: [
          IconButton(
            icon: const Icon(Icons.lock_open),
            tooltip: 'Show Snackbar',
            onPressed: logout,
          ),
        ]);
  }
}

class BiensList extends StatelessWidget {
  const BiensList({super.key, required this.biens});

  final List<Bien> biens;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: biens.length,
      itemBuilder: (context, index) {
        return Text(biens[index].numero);
      },
    );
  }
}
