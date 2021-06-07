
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/modelss/ourUser.dart';
import 'package:provider/provider.dart';

/// This will the class that will have access to the database
/// and all other classes will need to send their database related
/// requests to this class

class OurDatabase{

  //CurrentState _instance = Provider.of(context);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(OurUser user) async{
    String retVal = "error";

    try{
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set(user.toMap());

      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }



  Future<String> updateUserData(String uid,Map user) async{
    String retVal = "error";

    try{
      await _firestore.collection("users").doc(uid).update(user);
      retVal = "success";

    }catch(e) {
      print(e);
    }

    return retVal;
  }



  Future<OurUser> getUserInfo(String uid) async {
    OurUser retVal = OurUser();

    try{
      // this block is running fine
      DocumentSnapshot _docSnapshot = await _firestore.collection("users").doc(uid).get();
      print("Above the document snapshot data");
      print(_docSnapshot.data());
      print("below the document snapshot data");
      //retVal(_docSnapshot.data()['name']);

      retVal = retVal.toInstance(_docSnapshot.data());
      // retVal.uid = uid;
      // retVal.fullName = _docSnapshot.data()['name'];
      // retVal.profileImg = _docSnapshot.data()['profileImage'];
      // retVal.phone = _docSnapshot.data()['phone'];
      // retVal.email = _docSnapshot.data()["email"];
      // retVal.type =  _docSnapshot.data()['type'];
      print(retVal.phone);
      print("Exiting the get user information function now");
    } catch(e){
      print("in the catch of the get user info");
      print(e);
    }
    return retVal;
  }


  // Future<List<OurGarage>> fetchGarages(List ids) async{
  //   List<OurGarage> _data = [];
  //   print("Inside here");
  //   var result = await FirebaseFirestore.instance
  //       .collection('garages').get().then((value)  {
  //
  //         value.docs.forEach((element) {
  //           ids.forEach((id) {
  //             if(element.id == id) {
  //               var data = element.data();
  //               List<MechanicServices> _products = [];
  //               data["products"].forEach((el) {
  //                 _products.add(MechanicServices(
  //                   name: el["name"],
  //                   selected: el["selected"],
  //                   price: el["price"],
  //                   id: el["id"],
  //                 ));
  //               });
  //
  //               print(data["aboutUs"]);
  //               print("=================");
  //               print(element.data());
  //               _data.add(OurGarage(
  //                 name: data["name"],
  //                 aboutUs: data["aboutUs"],
  //                 type: data["type"],
  //                 establishedYear: data["establishedYear"],
  //                 uid: data["uid"],
  //                 status: data["status"],
  //                 openTime: TimingModel(
  //                   hours: data["openTime"]["hours"],
  //                   minutes: data["openTime"]["minutes"],
  //                 ),
  //                 closeTime: TimingModel(
  //                   hours: data["closeTime"]["hours"],
  //                   minutes: data["closeTime"]["minutes"],
  //                 ),
  //                 images: ImagesModel(
  //                   carosuelImgs: data["images"]["carosuelImages"],
  //                   profileImages: data["images"]["profileImages"],
  //                 ),
  //                 contacts:ContactsModel(
  //                   tel: data["contacts"]["tel"],
  //                   phone: data["contacts"]["phone"],
  //                   email: data["contacts"]["email"],
  //                 ),
  //                 address: AddressModel(
  //                   lat: data["address"]["lat"],
  //                   long: data["address"]["long"],
  //                   city: data["address"]["city"],
  //                   pincode: data["address"]["pincode"],
  //                   shopNo: data["address"]["shopNo"],
  //                   state: data["address"]["state"],
  //                   street: data["address"]["street"],
  //                 ),
  //                 ownerDetails: OwnerDetailsModel(
  //                   gender: data["ownerDetails"]["gender"],
  //                   age: data["ownerDetails"]["age"],
  //                   title: data["ownerDetails"]["title"],
  //                   firstName: data["ownerDetails"]["firstName"],
  //                   lastName: data["ownerDetails"]["lastName"],
  //                 ),
  //                 vehiclesServices: data["vehicleServices"],
  //                 satisfaction: data["satisfaction"],
  //                 distanceAway: data["distanceAway"],
  //                 products:_products,
  //               ));
  //             }
  //           });
  //
  //
  //
  //         });
  //         print(_data.length);
  //   });
  //   //print(result.docs);
  //   //print(result.docs)
  //   //print(result);
  //   print("-----------------------------[");
  //   return _data;
  // }
  //
  //
  // Future<List<OurGarage>> fetchIds(String vehicle, String brand) async{
  //
  //   List _data = [];
  //   List<OurGarage> garages = [];
  //   print("Inside here");
  //   var result = await FirebaseFirestore.instance
  //       .collection('vehicles').doc(vehicle).get().then((value) async {
  //     // value.docs.forEach((element) {
  //     //   var data = element.data();
  //     //   List<MechanicServices> _products = [];
  //     //
  //     // });
  //
  //     print(value.get(brand));
  //     _data = value.get(brand);
  //     //_data.forEach((element) {_firestore.collection(collectionPath).doc(element).})
  //     if(_data.isNotEmpty) {
  //       garages = await fetchGarages(_data);
  //     }
  //     print(value.id);
  //     print(value.data());
  //     print(_data.length);
  //     print(_data);
  //   });
  //   //print(result.docs);
  //   //print(result.docs)
  //   //print(result);
  //   print("-----------------------------[");
  //   return garages;
  // }
  //
  // Future createSampleData(OurGarage _services) async{
  //   List _products = [];
  //   _services.products.forEach((element) {
  //     _products.add({
  //       "name":element.name,
  //       "price":element.price,
  //       "id":element.id,
  //       "selected":false,
  //     });
  //   });
  //   // if(key==userClicked){
  //   //return abc[]
  //   await FirebaseFirestore.instance
  //       .collection('garages')
  //       .doc(_services.uid)
  //       .set(
  //     {
  //       'name': _services.name,
  //       'type': _services.type,
  //       "uid":_services.uid,
  //       "establishedYear":_services.establishedYear,
  //       "aboutUs":_services.aboutUs,
  //       "status":_services.status,
  //       "openTime": {
  //         "openTime":_services.openTime.hours,
  //         "minutes":_services.openTime.minutes,
  //       },
  //       "closeTime": {
  //         "hours":_services.closeTime.hours,
  //         "minutes":_services.closeTime.minutes,
  //       },
  //       "images": {
  //         "profileImages":_services.images.profileImages,
  //         "carosuelImages": _services.images.carosuelImgs,
  //       },
  //       "contacts": {
  //         "phone":_services.contacts.phone,
  //         "tel":_services.contacts.tel,
  //         "email":_services.contacts.email,
  //       },
  //       "address": {
  //         "lat":_services.address.lat,
  //         "long":_services.address.long,
  //         "shopNo":_services.address.shopNo,
  //         "street":_services.address.street,
  //         "city":_services.address.city,
  //         "state":_services.address.state,
  //         "pincode":_services.address.pincode,
  //       },
  //       "ownerDetails": {
  //         "title":_services.ownerDetails.title,
  //         "firstName":_services.ownerDetails.firstName,
  //         "lastName":_services.ownerDetails.lastName,
  //         "gender":_services.ownerDetails.gender,
  //         "age":_services.ownerDetails.age,
  //       },
  //       "vehicleServices":_services.vehiclesServices,
  //       "satisfaction":_services.satisfaction,
  //       "distanceAway":_services.distanceAway,
  //       "products":_products,
  //
  //     },
  //   );
  // }


  Future createOrder() {

  }
}