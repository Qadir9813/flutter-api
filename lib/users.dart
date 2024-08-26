import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;
import 'model/ProductModel.dart';
import 'model/Userdata.dart';

class UserModel extends StatefulWidget {
  const UserModel({super.key});

  @override
  State<UserModel> createState() => _UserModelState();
}

class _UserModelState extends State<UserModel> {

  Future<ProductModel> GetApiData() async{
    final response= await http.get(Uri.parse('https://dummyjson.com/products'));
    var data= jsonDecode(response.body.toString());
    if(response.statusCode==200){
      return ProductModel.fromJson(data);
    }else{
      return ProductModel.fromJson(data);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children: [
          Expanded(child:
          FutureBuilder<ProductModel>(
              future: GetApiData(),
              builder: (context,snapshot)
              {
                if(!snapshot.hasData){
                  return Text('loading');

                }else{
                  return ListView.builder(
                      itemCount: snapshot.data!.products!.length,
                      itemBuilder: (context,index){
                        return Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Height:${snapshot.data!.products![index].dimensions!.height.toString()}'),
                                Text('Width: ${snapshot.data!.products![index].dimensions!.width.toString()}'),
                                ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data!.products![index].reviews!.length,
                                    itemBuilder: (context,inde){
                                      return Row(
                                          children: [
                                            Text(snapshot.data!.products![index].reviews![inde].rating.toString()),
                                          ]);


                                    }
                                ),
                                SizedBox(height: 10),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.products![index].tags!.length,
                                  itemBuilder: (context, position) {
                                    return Row(
                                      children: [
                                        Text(
                                          snapshot.data!.products![index].tags![position].toString(),
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(width: 8), // Adds spacing between tags
                                      ],
                                    );
                                  },
                                ),
                              ]
                          ),
                        );

                      });

                }

              }

          ),

          ),
        ],
      ),
    );
  }
}
