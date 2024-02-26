// ignore_for_file: avoid_print, prefer_const_constructors, deprecated_member_use

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';

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
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Request failed: $e');
    } finally {
      setState(() {
        _converting = false;
      });

      // Show snackbar after conversion is completed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('File downloaded and converted to PDF successfully'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green, // Change background color to green
          behavior: SnackBarBehavior.floating, // Make snackbar floating
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DWG to PDF Converter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _pickFile,
              style: ElevatedButton.styleFrom(
                primary: Colors.orangeAccent, // Change button color to orange
                onPrimary: Colors.white, // Change text color to white
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25), // Add rounded corners
                ),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Increase padding
              ),
              child: Text(
                'Select DWG File',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickedFile != null && !_converting ? _convertToPdf : null,
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent, // Change button color to blue
                onPrimary: Colors.white, // Change text color to white
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25), // Add rounded corners
                ),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Increase padding
              ),
              child: Text(
                'Convert to PDF',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            // Animated container to make the spacing lively
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: _converting ? 20 : 0,
            ),
            if (_converting)
              CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
