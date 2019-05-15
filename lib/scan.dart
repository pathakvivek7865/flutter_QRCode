import 'dart:async';
import 'package:flutter/material.dart';
import "package:qrcode_reader/qrcode_reader.dart";

class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  String barcode = "";
  Future<String> futureString;

  void _scanner() {
    setState(() {
      futureString = new QRCodeReader()
          // .setAutoFocusIntervalInMs(200) // default 5000
          // .setForceAutoFocus(true) // default false
          // .setTorchEnabled(true) // default false
          // .setHandlePermissions(true) // default true
          // .setExecuteAfterPermissionGranted(true) // default true
          .scan();
    });
  }

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('QR Code Scanner'),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: _scanner,
                    child: const Text('START CAMERA SCAN')),
              ),
              FutureBuilder<String>(
                future: futureString,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return Text(
                      snapshot.data != null ? snapshot.data : "try again");
                },
              ),
            ],
          ),
        ));
  }

  // Future scan() async {
  //   try {
  //     String barcode = await BarcodeScanner.scan();
  //     setState(() => this.barcode = barcode);
  //   } on PlatformException catch (e) {
  //     if (e.code == BarcodeScanner.CameraAccessDenied) {
  //       setState(() {
  //         this.barcode = 'The user did not grant the camera permission!';
  //       });
  //     } else {
  //       setState(() => this.barcode = 'Unknown error: $e');
  //     }
  //   } on FormatException{
  //     setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
  //   } catch (e) {
  //     setState(() => this.barcode = 'Unknown error: $e');
  //   }
  // }
}
