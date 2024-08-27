import 'package:flutter/material.dart';

class Multiscroll extends StatefulWidget {
  const Multiscroll({super.key});

  @override
  State<Multiscroll> createState() => _MultiscrollState();
}

class _MultiscrollState extends State<Multiscroll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: NestedScrollView(
                headerSliverBuilder: (BuildContext context,bool istrue){
                  return [
                    const SliverAppBar(
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(50),
                        child: Text('444'),
                      ),
                      title: Text('NestedScrollView Example'),
                      floating: false,
                      pinned: false,
                    ),
                  ];
                },
                body: Container(
                  child: ListView.builder(
                      itemCount: 40,
                      itemBuilder: (context,index){
                        return Text("$index");
                      }),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
