import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/link.dart';

class QRCode extends StatefulWidget{
  const QRCode({super.key});

  @override
  State<QRCode> createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {

  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  String scannedCode = '';

  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        scannedCode = scanData.code!;
      });
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR CODE SCANNER'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body:Center(
        child: Container(
          height: 500,
          width: 350,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Place the QR inside the frame',
                style: TextStyle(fontSize: 18),),
              ),
              Expanded(
                flex: 8,
                  child: QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated
                  )
              ),
              Expanded(
                flex: 2,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(child: Text('Scanned Code :',
                          style: TextStyle(fontSize: 18),)
                          ),
                          Expanded(
                              child: Link(
                                target: LinkTarget.blank,
                                  uri: Uri.parse('$scannedCode'),
                                  builder: (context,followLink)=>
                                      TextButton(
                                          onPressed: followLink,
                                          child: Text('$scannedCode',
                                          style: TextStyle(
                                            fontSize: 18
                                          ),)
                                      )
                              )
                          )
                        ],
                      ),
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}