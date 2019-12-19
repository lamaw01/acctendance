import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:photos_saver/photos_saver.dart';

class Draw extends StatefulWidget {
  @override
  _DrawState createState() => _DrawState();
}

class _WatermarkPaint extends CustomPainter {

  final String price;
  final String watermark;

  _WatermarkPaint(this.price, this.watermark);

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    //canvas.drawCircle(Offset(size.width / 2, size.height / 2), 10.8, Paint()..color = Colors.blue);
  }

  @override
  bool shouldRepaint(_WatermarkPaint oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _WatermarkPaint && runtimeType == other.runtimeType && price == other.price && watermark == other.watermark;

  @override
  int get hashCode => price.hashCode ^ watermark.hashCode;
}

class _DrawState extends State<Draw> {
  Uint8List image;
  ByteData _img = ByteData(0);
  final _sign = GlobalKey<SignatureState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Signature'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
        ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Signature(
                  color: Colors.white,
                  key: _sign,
                  onSign: () {
                    // ignore: unused_local_variable
                    final sign = _sign.currentState;
                    //print('${sign.points.length} points in the signature');
                  },
                  backgroundPainter: _WatermarkPaint("2.0", "2.0"),
                  strokeWidth: 2,
                ),
              ),
              //color: Colors.black12,
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                        color: Colors.green[300],
                        onPressed: () async {
                          final sign = _sign.currentState;
                          //retrieve image data, do whatever you want with it (send to server, save locally...)
                          final imageData = await sign.getData();
                          var data = await imageData.toByteData(format: ui.ImageByteFormat.png);
                          sign.clear();
                          //final encoded = base64.encode(data.buffer.asUint8List());
                          setState(() {
                            _img = data;
                          });
                          //print("onPressed " + encoded);

                          var image =
                          await imageData.toByteData(format: ui.ImageByteFormat.png).then((byteData) {
                            return byteData.buffer.asUint8List();
                          });
                            
                          setState(() {
                            image = image;
                          });

                          await PhotosSaver.saveFile(fileData: image);       
                          return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.brown[50],
                                title: Text(
                                  'Check your Gallery',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(        
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                content: Image.memory(_img.buffer.asUint8List()),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Back', 
                                      style: TextStyle(fontSize: 18.0)
                                    ),
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            }
                        );
                        },
                        child: Text("Save",
                          style: TextStyle(color: Colors.white, fontSize: 16.0)
                        )
                    ),
                    RaisedButton(
                        color: Colors.red[300],
                        onPressed: () {
                          final sign = _sign.currentState;
                          sign.clear();
                          setState(() {
                            _img = ByteData(0);
                          });
                          //print("cleared");
                        },
                        child: Text("Clear",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        )
                    ),             
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
    
  }

}

