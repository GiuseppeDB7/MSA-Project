import 'package:flutter/material.dart';
import 'package:helloworld/pages/list_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //firestore
  final FirestoreService firestoreService = FirestoreService();

  //text controller
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();

  // Aggiungi questa variabile di stato
  String? firstName;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  // Aggiungi questo metodo per caricare il nome dell'utente
  Future<void> _loadUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userData.exists) {
        setState(() {
          firstName = userData.data()?['firstName'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          25.0,
          10.0, // Ridotto da 25.0 a 10.0
          25.0,
          MediaQuery.of(context).viewInsets.bottom + 25.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sostituisci il Container del messaggio di benvenuto con questo
            Container(
              width: double.infinity, // Per consentire il centramento
              margin: const EdgeInsets.only(bottom: 20.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    letterSpacing: 0.5,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Welcome back, ',
                    ),
                    TextSpan(
                      text: firstName ?? "User",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Container esistente per il form
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'List name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: budgetController,
                    decoration: InputDecoration(
                      hintText: 'Budget',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FloatingActionButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();

                        try {
                          if (nameController.text.isEmpty ||
                              descriptionController.text.isEmpty ||
                              budgetController.text.isEmpty) {
                            throw 'Per favore, compila tutti i campi';
                          }

                          String listName = nameController.text;
                          double budget =
                              double.tryParse(budgetController.text) ?? -1;
                          if (budget < 0) {
                            throw 'Inserisci un budget valido';
                          }

                          await firestoreService.addList(
                            nameController.text,
                            descriptionController.text,
                            budget,
                          );

                          nameController.clear();
                          descriptionController.clear();
                          budgetController.clear();

                          if (context.mounted) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Lista Creata'),
                                  content: Text(
                                      'La lista "$listName" è stata creata con successo!'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(
                                            context); // Chiude il dialog
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ListPage()),
                                        );
                                      },
                                      child: const Text('Visualizza Liste'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Crea un\'altra'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Errore'),
                                  content: Text(e.toString()),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        // Se l'errore è di autenticazione, reindirizza alla pagina di login
                                        if (e
                                            .toString()
                                            .contains('non autenticato')) {
                                          // Implementa qui la navigazione alla pagina di login
                                        }
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      },
                      backgroundColor: Colors.black,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FirestoreService {
  // Add your existing methods here

  Future<void> addList(String name, String description, double budget) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('lists').add({
        'name': name,
        'description': description,
        'budget': budget,
        'userId': user.uid,
        'createdAt': Timestamp.now(),
      });
    }
  }
}
