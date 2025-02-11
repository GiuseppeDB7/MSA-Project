import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/services/firestore.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirestoreService().getListsStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List shoppingList = snapshot.data!.docs;

              if (shoppingList.isEmpty) {
                return const Center(
                  child: Text(
                    "Non ci sono liste...",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemCount: shoppingList.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = shoppingList[index];
                  String docID = document.id;
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;

                  String listName = data['list'];
                  String description = data['description'];
                  double budget = data['budget'];

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 2,
                    child: ListTile(
                      title: Text(
                        listName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(description),
                          Text(
                            'Budget: €${budget.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      trailing: SizedBox(
                        width: 96, // Larghezza per contenere due icone
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                // Controller per il nuovo testo
                                final TextEditingController editController =
                                    TextEditingController(text: description);

                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Modifica Descrizione'),
                                    content: TextField(
                                      controller: editController,
                                      decoration: const InputDecoration(
                                        labelText: 'Nuova Descrizione',
                                        border: OutlineInputBorder(),
                                      ),
                                      maxLines: 3,
                                    ),
                                    actions: [
                                      // Pulsante Annulla
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Annulla'),
                                      ),
                                      // Pulsante Conferma
                                      TextButton(
                                        onPressed: () async {
                                          // Verifica che il testo non sia vuoto
                                          if (editController.text
                                              .trim()
                                              .isNotEmpty) {
                                            try {
                                              await FirestoreService()
                                                  .updateList(
                                                docID,
                                                editController.text.trim(),
                                              );
                                              if (context.mounted) {
                                                Navigator.pop(context);
                                                // Mostra conferma
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'Descrizione aggiornata con successo!'),
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                );
                                              }
                                            } catch (e) {
                                              if (context.mounted) {
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'Errore durante l\'aggiornamento'),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              }
                                            }
                                          }
                                        },
                                        child: const Text('Conferma'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title:
                                          const Text('Conferma Eliminazione'),
                                      content: Text(
                                          'Sei sicuro di voler eliminare la lista "$listName"?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(
                                                context); // Chiude il dialog
                                          },
                                          child: const Text('Annulla'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            try {
                                              await FirestoreService()
                                                  .deleteList(docID);
                                              if (context.mounted) {
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'Lista eliminata con successo!'),
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                );
                                              }
                                            } catch (e) {
                                              if (context.mounted) {
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'Errore durante l\'eliminazione'),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                          child: const Text(
                                            'Elimina',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        // TODO: Implementare l'apertura della lista
                      },
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
