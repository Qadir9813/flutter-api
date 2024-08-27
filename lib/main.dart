import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_demo/multiscroll.dart';
import 'package:flutter_demo/users.dart';
import 'package:http/http.dart' as http;


import 'model/Post2.dart';

// UserModel and Data classes

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Multiscroll(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<photomodel> photos=[];
  Future<List<photomodel>> getphoto ()async{
    final respone=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data= jsonDecode(respone.body.toString());
    if(respone.statusCode==200){
      for(Map i in data){
        photomodel photo= photomodel(title: i['title'], url: i['url']);
        photos.add(photo);
      }
      return photos;
    }else{
      return photos;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getphoto(),
                builder: (context,AsyncSnapshot<List<photomodel>> snapshot){
                  if(!snapshot.hasData){
                    return Text("Loading");
                  }else{
                    return ListView.builder(
                        itemCount: photos.length,
                        itemBuilder: (context,index){
                          return ListTile(
                            title: Text(photos[index].title.toString()),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                            ),
                          );
                        });
                  }
                }
            ),
          )
        ],
      ),
    );

  }

}
class photomodel{
  String title, url;
  photomodel({required this.title,required this.url});

}
