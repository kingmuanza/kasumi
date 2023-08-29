import 'package:flutter/material.dart';
import 'package:kasumi/models/reunion.model.dart';
import 'package:kasumi/pages/reunion/reunion.view.dart';
import 'package:kasumi/services/reunion.service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Reunion> reunions = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reunions = ReunionService().getAll();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: reunions.length,
        itemBuilder: (context, index) {
          Reunion reunion = reunions[index];
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade200,
                ),
              ),
            ),
            child: ListTile(
              title: Text(reunion.nom),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ReunionView(
                      reunion: reunion,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
