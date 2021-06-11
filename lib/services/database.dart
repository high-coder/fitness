import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/modelss/ourUser.dart';

/// This will the class that will have access to the database
/// and all other classes will need to send their database related
/// requests to this class

class OurDatabase {
  //CurrentState _instance = Provider.of(context);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(OurUser user) async {
    String retVal = "error";

    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(user.toMap());

      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> updateUserData(String uid, Map user) async {
    String retVal = "error";
    if (user['type'] == 'trainer') {
      await _firestore.collection('users').doc(uid).delete();
      await _firestore.collection('trainer').doc(uid).set(user);
    } else {
      try {
        await _firestore.collection(user['type']).doc(uid).update(user);
        retVal = "success";
      } catch (e) {
        print(e);
      }
    }

    return retVal;
  }

  Future<OurUser> getUserInfo(String uid) async {
    OurUser retVal = OurUser();
    try {
      // this block is running fine
      DocumentSnapshot _docSnapshot;
      print("below the document snapshot data");
      //retVal(_docSnapshot.data()['name']);
      _firestore.collection('users').doc(uid).get().then((value) => {
            if (value.data() == null)
              {
                _firestore.collection('trainer').doc(uid).get().then((value) => {
                      //Data
                      _docSnapshot = value
                    })
              }
            else
              {_docSnapshot = value}
          });
      retVal = retVal.toInstance(_docSnapshot.data());
      // retVal.uid = uid;
      // retVal.fullName = _docSnapshot.data()['name'];
      // retVal.profileImg = _docSnapshot.data()['profileImage'];
      // retVal.phone = _docSnapshot.data()['phone'];
      // retVal.email = _docSnapshot.data()["email"];
      // retVal.type =  _docSnapshot.data()['type'];
      print(retVal.phone);
      print("Exiting the get user information function now");
    } catch (e) {
      print("in the catch of the get user info");
      print(e);
    }
    return retVal;
  }


  Future getTrainers() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _firestore.collection('trainer').get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allData;
  }

  Future getWorkoutList(String uid) async {
    print('${uid} +++++++++++++++++++++++++++++++++++++++++');
    var a;
    await _firestore
        .collection('trainer')
        .doc(uid)
        .get()
        .then((value) => a = value.get('workouts'));
    print(a);
    return a.length + 1;
  }

  AddWorkout({Map workout, String uid}) {
    print('${workout} +++++++++++++++++++++++++++++');
    _firestore.collection('trainer').doc(uid).update({
      'workouts': FieldValue.arrayUnion([workout])
    });
    print(uid);
  }
}
