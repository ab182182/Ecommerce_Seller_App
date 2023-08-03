import '../const/const.dart';

class StoreServices {
  static double totalSale = 0;
  static double averageRating = 0;

  static getProfile(uid) {
    return firestore
        .collection(vendorsCollection)
        .where('id', isEqualTo: uid)
        .get();
  }

  static getMessages() {
    return firestore
        .collection(chatsCollection)
        .where('toId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getChatMessages(docId) {
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getOrders(uid) {
    return firestore
        .collection(ordersCollection)
        .where('vendors', arrayContains: uid)
        .snapshots();
  }

  static getProducts(uid) {
    return firestore
        .collection(productsCollection)
        .where('vendor_id', isEqualTo: uid)
        .snapshots();
  }

  static getTotalSale(uid) {
    firestore
        .collection(ordersCollection)
        .where('vendors', arrayContains: uid)
        .get()
        .then(
      (value) {
        double sale = 0;
        for (var i = 0; i < value.docs.length; i++) {
          sale += value.docs[i]['total_amount'];
        }

        StoreServices.totalSale = sale;
      },
    );
  }

  static getRating(uid) {
    firestore
        .collection(productsCollection)
        .where('vendor_id', isEqualTo: uid)
        .get()
        .then(
      (value) {
        double totalRating = 0;
        for (var i = 0; i < value.docs.length; i++) {
          totalRating += double.parse(value.docs[i]['p_rating']);
        }
        StoreServices.averageRating = totalRating / value.docs.length;
      },
    );
  }
}
