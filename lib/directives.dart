import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';





class Directives extends StatefulWidget {
  @override
  _DirectivesState createState() => _DirectivesState();
}

class _DirectivesState extends State<Directives> {
  String? _documentPath;

  @override
  void initState() {
    super.initState();
    loadPDF().then((path) {
      setState(() {
        _documentPath = path;
      });
    });
  }

  Future<String> loadPDF() async {
    final ByteData data = await rootBundle.load('assets/pdf/dir.pdf');
    final Directory tempDir = await getTemporaryDirectory();
    final File file = File('${tempDir.path}/dir.pdf');
    await file.writeAsBytes(data.buffer.asUint8List(), flush: true);
    return file.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF009FE3),
        title:

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 200,  // Largeur souhaitée de l'image
              height: 90, // Hauteur souhaitée de l'image
            ),
            SizedBox(width: 8),
          ],

        ),

      ),
      body: _documentPath != null
          ? LayoutBuilder(
        builder: (context, constraints) {
          return PDFView(
            filePath: _documentPath!,
            fitPolicy: FitPolicy.WIDTH, // Ajustement à la largeur de l'écran
            pageFling: false, // Désactiver le "flick" de page
            pageSnap: false, // Désactiver le "snap" de page
            fitEachPage: false, // Adapter chaque page individuellement
          );
        },
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
