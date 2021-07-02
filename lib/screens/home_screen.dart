import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location.dart';
import '../utilities/customExceptions.dart';
import '../screens/loading_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String message = "";
  void updateMessage(String info) {
    setState(() {
      message = info;
    });
  }

  void getLocation() async {
    try {
      Location locationService = Location();
      Position userLocation = await locationService.getCurrentLocation();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LoadingScreen(userLocation: userLocation);
      }));
    } on LocationServiceEnabledException catch (e) {
      updateMessage(e.cause);
    } on LocationServicePermissionException catch (e) {
      updateMessage(e.cause);
    } on LocationServicePermanentDenialException catch (e) {
      updateMessage(e.cause);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    getLocation();
                  },
                  child: Text("Find my location"),
                ),
                Text(
                  '$message',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   // const HomeScreen({Key key}) : super(key: key);
//
//   void getLocation() async {
//     Location locationService = Location();
//     try {
//       Position userLocation = await locationService.getCurrentLocation();
//     } on LocationServiceEnabledException catch (e) {
//       print(e.cause);
//     } on LocationServicePermissionException catch (e) {
//       print(e.cause);
//     } on LocationServicePermanentDenialException catch (e) {
//       print(e.cause);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         child: ElevatedButton(
//           onPressed: () {
//             getLocation();
//           },
//           child: Text("Get Location"),
//         ),
//       ),
//     );
//   }
// }
