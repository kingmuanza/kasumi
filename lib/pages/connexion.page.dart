import 'package:flutter/material.dart';
import 'package:kasumi/pages/home.page.dart';

import '../services/connexion.service.dart';

class ConnexionPage extends StatefulWidget {
  const ConnexionPage({super.key});

  @override
  State<ConnexionPage> createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  TextEditingController loginCtrl = TextEditingController(text: "melo");
  TextEditingController passeCtrl = TextEditingController(text: "melo");
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Connexion"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextFormField(
                  controller: loginCtrl,
                  decoration: InputDecoration(
                    label: Text("Login"),
                    errorText: loginCtrl.text == "" && loading ? 'Champ requis' : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextFormField(
                  controller: passeCtrl,
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text("Passe"),
                    errorText: loginCtrl.text == "" && loading ? 'Champ requis' : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  color: Colors.green,
                  child: TextButton(
                    onPressed: loading
                        ? null
                        : () {
                            loading = true;
                            setState(() {});
                            if (loginCtrl.text != "" && passeCtrl.text != "") {
                              ConnexionService().connexion(loginCtrl.text, passeCtrl.text).then((value) {
                                print(value.toJSON());
                                loading = false;
                                setState(() {});
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) => MyHomePage(),
                                  ),
                                );
                              }).catchError((error, trace) {
                                loading = false;
                                setState(() {});
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("$error"),
                                ));
                              });
                            }
                          },
                    child: Text(
                      "Connexion",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
