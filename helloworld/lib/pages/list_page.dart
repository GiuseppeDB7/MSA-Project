import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  // Aggiungi questo metodo per verificare l'utente
  Future<bool> _checkUser() async {
    final user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My Lists', // Modificato
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        automaticallyImplyLeading: false, // Rimuove il tasto indietro
      ),
      body: FutureBuilder<bool>(
        future: _checkUser(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!userSnapshot.hasData || !userSnapshot.data!) {
            return const Center(
              child: Text(
                'Unauthorized access', // Modificato
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                ),
              ),
            );
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirestoreService().getListsStream(),
                builder: (context, snapshot) {
                  // Gestione degli errori
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'An error occurred: ${snapshot.error}', // Modificato
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  // Gestione del caricamento
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Verifica se ci sono dati
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        "No lists found...", // Modificato
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    );
                  }

                  // Costruzione della lista
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final document = snapshot.data!.docs[index];
                      final data = document.data() as Map<String, dynamic>;
                      final docID = document.id;

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        elevation: 2,
                        child: ListTile(
                          title: Text(
                            data['name'] ?? 'Untitled', // Modificato
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data['description'] ??
                                  'No description'), // Modificato
                              Text(
                                'Budget: €${(data['budget'] as num).toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          trailing: SizedBox(
                            width: 96,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => _showEditDialog(
                                    context,
                                    docID,
                                    data['description'] ?? '',
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => _showDeleteDialog(
                                    context,
                                    docID,
                                    data['name'] ?? 'questa lista',
                                  ),
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
                },
              ),
            ),
          );
        },
      ),
    );
  }

  // Dialog per la modifica
  void _showEditDialog(
      BuildContext context, String docID, String currentDescription) {
    final editController = TextEditingController(text: currentDescription);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Description'), // Modificato
        content: TextField(
          controller: editController,
          decoration: const InputDecoration(
            labelText: 'New Description', // Modificato
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'), // Modificato
          ),
          TextButton(
            onPressed: () async {
              if (editController.text.trim().isNotEmpty) {
                try {
                  await FirestoreService()
                      .updateList(docID, editController.text.trim());
                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Description updated successfully!'), // Modificato
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: ${e.toString()}'), // Modificato
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              }
            },
            child: const Text('Confirm'), // Modificato
          ),
        ],
      ),
    );
  }

  // Dialog per l'eliminazione
  void _showDeleteDialog(BuildContext context, String docID, String listName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Deletion'), // Modificato
        content: Text(
            'Are you sure you want to delete the list "$listName"?'), // Modificato
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'), // Modificato
          ),
          TextButton(
            onPressed: () async {
              try {
                await FirestoreService().deleteList(docID);
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('List deleted successfully!'), // Modificato
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: ${e.toString()}'), // Modificato
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            child: const Text(
              'Delete', // Modificato
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
