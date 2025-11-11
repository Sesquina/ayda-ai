import 'package:flutter/material.dart';
import '../../core/theme.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload')),
      body: Center(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: 360,
            height: 260,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DottedBorderPlaceholder(),
                const SizedBox(height: 16),
                ElevatedButton(
                    onPressed: () {}, child: const Text('Upload Now')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DottedBorderPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(
            color: AydaColors.secondary, width: 2, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(
          child: Text('Drop files here or click to upload (PDF / image).')),
    );
  }
}
