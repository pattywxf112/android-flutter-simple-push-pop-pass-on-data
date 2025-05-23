import 'package:flutter/material.dart';
import 'dart:io';

class SubmittedPage extends StatelessWidget {
  const SubmittedPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve arguments passed from submission.dart
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ?? {};

    final tag = args['tag'] ?? 'Unknown';
    final description = args['description'] ?? '';
    final imagePath = args['image'] ?? '';
    final contact = args['contact'] ?? '';

    final Color containerBgColor = const Color(0xFFFFF3E0);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Submission Confirmation"),
        centerTitle: true,
        backgroundColor: Colors.orange.shade700,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 100),
            const SizedBox(height: 12),
            const Text(
              "Report submitted",
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: containerBgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Map image
                  Image.asset(
                    'assets/map.png',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 8),

                  // Centered Location text
                  const Center(
                    child: Text(
                      "Location",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Tag row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Tag", style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 8),
                      Text(
                        tag,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Description section
                  const Text("Description", style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(description.isEmpty ? "No description" : description),
                  ),
                  const SizedBox(height: 16),

                  // Evidence section - file icon + filename
                  const Text("Evidence", style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  imagePath.isNotEmpty
                      ? Row(
                    children: [
                      Icon(Icons.insert_drive_file, color: Colors.brown.shade700),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          imagePath.split('/').last,
                          style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  )
                      : const Text("No image uploaded"),
                  const SizedBox(height: 16),

                  // Contact No. inline display
                  Row(
                    children: [
                      const Text("Contact No.", style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 8),
                      Text(contact, style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Done button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade700,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                child: const Text("Done"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
