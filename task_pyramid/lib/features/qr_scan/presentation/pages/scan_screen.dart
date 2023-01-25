import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:task_pyramid/features/qr_scan/presentation/pages/scan_results_screen.dart';

import '../../../../core/constant/constant.dart';

// import 'package:lottie/lottie.dart';
import '../../../auth/presentation/widgets/submit_button_widget.dart';
import '../cubit/qr_code_cubit.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({Key? key}) : super(key: key);

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<QrCodeCubit>().fGetScanResults());
  }

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          margin: const EdgeInsets.only(
            top: 100,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: ()=>Constant.pushReplacment(
                    context, const ScanResultsScreen()),
                child: Container(
                    margin: Constant.kPaddingA8,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Constant.primaryColor, width: 3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(05))),
                    child: Icon(Icons.list,
                        color: Constant.primaryColor)),
              ),
              Container(
                  margin: Constant.kMargin16,
                  padding: Constant.kPaddingH30,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Scan QR code",
                        textAlign: TextAlign.center,
                        style: Constant.bodyText16,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "place qr code inside the frame to scan please avoid shake to get results quickly",
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 200,
                        width: 200,
                        child: QRView(
                          key: qrKey,
                          onQRViewCreated: _onQRViewCreated,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      (result != null)
                          ? Text(
                              'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                          : const Text('Scanning code...'),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.bolt_sharp,color: Constant.fontGraylight,size: 30),
                            Icon(Icons.keyboard_alt_outlined,color: Constant.fontGraylight,size: 30),
                            Icon(Icons.image,color: Constant.fontGraylight,size: 30),
                          ]),
                    ],
                  )),
              SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: SubmitButton(
                    function: () {
                      context.read<QrCodeCubit>().fScanQRCode(result!.code!);
                    },
                    title: "Place Camera Code",
                  )),
            ],
          ),
        ));
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
