import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  //get collection of lists
  final CollectionReference lists =
      FirebaseFirestore.instance.collection('lists');

  //CREATE: add a new list in database
  Future<void> addList(String name, String description, double budget) {
    return lists.add({
      'list': name,
      'description': description,
      'budget': budget,
      'timestamp': Timestamp.now(),
    });
  }

  //READ: get lists from database
  Stream<QuerySnapshot> getListsStream() {
    final listsStream =
        lists.orderBy('timestamp', descending: true).snapshots();
    return listsStream;
  }

  //UPDATE: update lists from a doc id
  Future<void> updateList(String docId, String description) {
    return lists
        .doc(docId)
        .update({'description': description, 'timestamp': Timestamp.now()});
  }

  //DELETE: delete lists from a doc id
  Future<void> deleteList(String docId) {
    return lists.doc(docId).delete();
  }
}
