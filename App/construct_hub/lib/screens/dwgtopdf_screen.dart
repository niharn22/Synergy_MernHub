import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class DwgtoPdfScreen extends StatefulWidget {
  const DwgtoPdfScreen({Key? key}) : super(key: key);

  @override
  _DwgtoPdfScreenState createState() => _DwgtoPdfScreenState();
}

class _DwgtoPdfScreenState extends State<DwgtoPdfScreen> {
  File? _pickedFile;
  Uint8List? _pdfBytes;
  bool _converting = false;

  void _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        setState(() {
          _pickedFile = File(result.files.single.path!);
        });
      }
    } catch (e) {
      print('File picking error: $e');
    }
  }

  Future<void> _convertToPdf() async {
    if (_pickedFile == null) {
      return;
    }

    setState(() {
      _converting = true;
    });

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.66.133:5000/convert'),
    );

    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        _pickedFile!.path,
      ),
    );

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var pdfBytes = await response.stream.toBytes(); // Get PDF bytes
        setState(() {
          _pdfBytes = pdfBytes;
        });

        // Schedule the toast message after a delay
        Timer(Duration(seconds: 3), () {
          Fluttertoast.showToast(
            msg: "File converted to PDF successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Request failed: $e');
    } finally {
      setState(() {
        _converting = false;
      });
    }
  }

  void _savePdfToDevice() async {
    if (_pdfBytes != null) {
      // Save PDF to device
      // For example, you can use path_provider package to get a directory and save the PDF there
      // Then open the saved PDF using a PDF viewer package or launch it in another app

      // Example:
      // final directory = await getApplicationDocumentsDirectory();
      // final path = '${directory.path}/output.pdf';
      // final File file = File(path);
      // await file.writeAsBytes(_pdfBytes!);
    }
  }

  void _downloadPdf() async {
    if (_pdfBytes != null) {
      final blobUrl = Uri.dataFromBytes(
        _pdfBytes!,
        mimeType: 'application/pdf',
        //Encoding.getByName('utf-8'),
      ).toString();
      await launch(blobUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DWG to PDF Converter'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _pickFile,
                  child: Text('Select DWG File'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _pickedFile != null && !_converting ? _convertToPdf : null,
                  child: Text('Convert to PDF'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _downloadPdf,
                  child: Text('View PDF'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _savePdfToDevice,
                  child: Text('Save PDF to Device'),
                ),
              ],
            ),
            if (_converting)
              CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
