import 'dart:convert';

import 'package:apidemo/Models/HiPrac.dart';
import 'package:apidemo/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/WelcomeModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  List<Hi> data = [];
  bool isloading = false;

  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    setState(() {
      isloading = true;
    });
    const url = "https://jsonplaceholder.typicode.com/users";
    final response = await http.get(Uri.parse(url));

    var code = response.statusCode;
    print(code);

    if (code == 200) {
      var responseData = json.decode(response.body);
      // print("------------response data is:$responseData");
      for (var addata in responseData) {
        data.add(Hi.fromJson(addata));
      }

      /* for(int i=0;i<=data.length;i++) {
               print("title is:${data[i].title}");
             }*/
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Demo"),
      ),
      body: isloading == true
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
            leading: CircleAvatar(
            backgroundColor: Colors.cyan,
            child: Text(data[index].id.toString()),
          ),
          title: Text(data[index].username.toString(),
          maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: Text(data[index].email, maxLines: 2),
          trailing: Icon(Icons.arrow_drop_down_circle_sharp),
          onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(),));
          }


      ),
    );
  }

  ,

  )

  ,

  );
}}
