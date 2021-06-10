import 'package:fitness_app/Screens/HomeScreen/homePage.dart';
import 'package:fitness_app/Screens/Login/OurLogin.dart';
import 'package:fitness_app/providers/currentState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


enum AuthStatus {
  notLoggedIn,
  loogedIn,
}



class Root extends StatefulWidget {
  const Root({Key key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {

  AuthStatus _authStatus = AuthStatus.notLoggedIn;
  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    //get the state , check the state, check current user set authstatus based on state
    CurrentState _instance = Provider.of<CurrentState>(context,listen:false);
    String _returnString = await _instance.onStartApi();

    if(_returnString=="success") {
      setState(() {
        print("the user is logged in");
        _authStatus = AuthStatus.loogedIn;
      });
    }
  }
  @override
  void initState() {
    CurrentState _instance = Provider.of<CurrentState>(context,listen:false);
    _instance.onStartApi();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Widget retVal;
    switch (_authStatus) {
      case AuthStatus.notLoggedIn:
        retVal = OurLogin();
        break;
      case AuthStatus.loogedIn:
        retVal = OurHome();
        break;
    }
    return retVal;
  }
}
