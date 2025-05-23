import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SubmissionPage extends StatefulWidget {
  const SubmissionPage({super.key});

  @override
  _SubmissionPageState createState() => _SubmissionPageState();
}

class _SubmissionPageState extends State<SubmissionPage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> tags = ['Pothole', 'Vendor', 'Rider', 'Trash', 'Other'];

  String selectedTag = 'Pothole';
  String description = '';
  String contactNumber = '';
  bool confirmed = false;
  File? imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && confirmed) {
      _formKey.currentState!.save();

      Navigator.pushNamed(
        context,
        '/submitted',
        arguments: {
          'tag': selectedTag,
          'description': description,
          'image': imageFile?.path ?? '',
          'contact': contactNumber,
        },
      );
    } else if (!confirmed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please confirm the report is based on real evidence')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define the light brown/orange color for input backgrounds
    final Color inputBgColor = const Color(0xFFFFF3E0); // light orange-ish

    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Issue'),
        centerTitle: true,  // force center title on Android
        backgroundColor: Colors.orange.shade700,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Google Map Static Image
              Image.asset(
                'assets/map.png',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 8),

              // Centered Location Text
              const Center(
                child: Text(
                  "Location",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 16),

              // Tag Row - inline label + dropdown
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Tag", style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  DropdownButton<String>(
                    value: selectedTag,
                    onChanged: (value) {
                      setState(() {
                        selectedTag = value!;
                      });
                    },
                    items: tags.map((tag) {
                      return DropdownMenuItem<String>(
                        value: tag,
                        child: Text(tag),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Description Section
              const Text("Description", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Type here",
                  border: InputBorder.none, // No border
                  filled: true,
                  fillColor: inputBgColor,
                  contentPadding: const EdgeInsets.all(12),
                ),
                onSaved: (value) => description = value ?? '',
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter a description' : null,
              ),
              const SizedBox(height: 16),

              // Evidence Section - file icon + filename container
              const Text("Evidence", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: inputBgColor,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.insert_drive_file, color: Colors.brown.shade700),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          imageFile != null
                              ? imageFile!.path.split('/').last
                              : "Tap to upload image",
                          style: TextStyle(
                            color: imageFile != null ? Colors.black : Colors.brown.shade400,
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      if (imageFile != null)
                        IconButton(
                          icon: const Icon(Icons.close, size: 20),
                          onPressed: () {
                            setState(() {
                              imageFile = null;
                            });
                          },
                          tooltip: 'Remove image',
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Contact No. inline label + input field without colon
              Row(
                children: [
                  const Text("Contact No.", style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'e.g. 0891231234',
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: inputBgColor,
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                      ),
                      keyboardType: TextInputType.phone,
                      onSaved: (value) => contactNumber = value ?? '',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter phone number';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Confirmation Checkbox with centered label text
              Row(
                children: [
                  Checkbox(
                    value: confirmed,
                    onChanged: (value) {
                      setState(() {
                        confirmed = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "This report is based on real evidence",
                        style: TextStyle(fontSize: 16, color: Colors.brown.shade900),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Submit Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade700,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  onPressed: _submitForm,
                  child: const Text("Submit Report"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
