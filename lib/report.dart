/*
// lib/report.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String? _selectedHazard;
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  // Function to open the camera
  Future<void> _pickImageFromCamera() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  // Function to open the gallery
  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  void _submitReport() {
    // Basic validation
    if (_selectedHazard == null || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a hazard type and add a description.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // On success
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Thank you! Your report has been submitted.'),
        backgroundColor: Colors.green,
      ),
    );

    // Reset form
    setState(() {
      _selectedHazard = null;
      _descriptionController.clear();
      _imageFile = null;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Hazard Type'),
            _buildHazardDropdown(),
            const SizedBox(height: 24),

            _buildSectionTitle('Location'),
            _buildLocationField(),
            const SizedBox(height: 24),

            _buildSectionTitle('Add Media (Optional)'),
            _buildMediaButtons(),
            if (_imageFile != null) _buildImagePreview(),
            const SizedBox(height: 24),

            _buildSectionTitle('Description'),
            _buildDescriptionField(),
            const SizedBox(height: 32),

            _buildSubmitButton(),
            const SizedBox(height: 16),
            _buildInfoBanner(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // --- WIDGET BUILDERS ---

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF0A4E6C).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.report_problem_outlined, color: Color(0xFF0A4E6C), size: 24),
          ),
          const SizedBox(width: 12),
          const Text('Report Hazard', style: TextStyle(color: Color(0xFF0A4E6C), fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
    );
  }

  Widget _buildHazardDropdown() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedHazard,
          isExpanded: true,
          hint: const Text('Select Hazard Type', style: TextStyle(color: Colors.grey)),
          items: ['Tsunami', 'Storm Surge', 'High Waves', 'Coastal Flooding', 'Other']
              .map((value) => DropdownMenuItem(value: value, child: Text(value)))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedHazard = value;
            });
          },
        ),
      ),
    );
  }

  Widget _buildLocationField() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade300, width: 1.5, style: BorderStyle.solid),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.location_on, color: Colors.blue.shade800),
          const SizedBox(width: 8),
          Text(
            'Marina Beach, Chennai (Default)',
            style: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildMediaButton(icon: Icons.camera_alt_outlined, label: 'Camera', onTap: _pickImageFromCamera),
          _buildMediaButton(icon: Icons.photo_library_outlined, label: 'Gallery', onTap: _pickImageFromGallery),
          _buildMediaButton(icon: Icons.videocam_outlined, label: 'Video', onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Video uploads coming soon!')));
          }),
        ],
      ),
    );
  }

  Widget _buildMediaButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              Icon(icon, color: Colors.grey.shade700, size: 28),
              const SizedBox(height: 8),
              Text(label, style: TextStyle(color: Colors.grey.shade800)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: FileImage(File(_imageFile!.path)),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: TextField(
        controller: _descriptionController,
        maxLines: 4,
        decoration: InputDecoration(
          hintText: 'Describe what you observed (wave height, damage, etc.)',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _submitReport,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0A4E6C),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text('Submit Report', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.blue.shade700),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Your report helps INCOIS validate hazards quickly',
              style: TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBar _buildBottomNavBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
        BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'MAP'),
        BottomNavigationBarItem(icon: Icon(Icons.report_problem_outlined), label: 'REPORT'),
        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'SOCIAL'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_active_outlined), label: 'ALERTS'),
      ],
      currentIndex: 2, // Current index is 2 for REPORT
      selectedItemColor: const Color(0xFF0A4E6C),
      unselectedItemColor: Colors.grey[600],
      onTap: (index) {
        if (index == 0) Navigator.popUntil(context, (route) => route.isFirst);
        if (index == 1) Navigator.pop(context); // Assumes map is previous screen
      },
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    );
  }
}*//*
*/
/*

// lib/report.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String? _selectedHazard;
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  // --- New Location State Variables ---
  String _currentAddress = 'No location selected';
  bool _isFetchingLocation = false;

  // --- Location Functions ---
  Future<void> _getCurrentLocation() async {
    setState(() => _isFetchingLocation = true);

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          setState(() {
            _currentAddress = "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
          });
        }
      } else {
        setState(() => _currentAddress = 'Location permission denied.');
      }
    } catch (e) {
      setState(() => _currentAddress = 'Error fetching location.');
    } finally {
      setState(() => _isFetchingLocation = false);
    }
  }

  Future<void> _setManualLocation() async {
    final TextEditingController manualLocationController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Set Location Manually'),
          content: TextField(
            controller: manualLocationController,
            decoration: const InputDecoration(hintText: "Enter address or landmark"),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            TextButton(
              onPressed: () {
                if (manualLocationController.text.isNotEmpty) {
                  setState(() {
                    _currentAddress = manualLocationController.text;
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Set'),
            ),
          ],
        );
      },
    );
  }

  // --- Image Picker Functions ---
  Future<void> _pickImageFromCamera() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() => _imageFile = pickedFile);
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() => _imageFile = pickedFile);
  }

  // --- Submit Function ---
  void _submitReport() {
    if (_selectedHazard == null || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a hazard type and add a description.'), backgroundColor: Colors.red));
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Thank you! Your report has been submitted.'), backgroundColor: Colors.green));
    setState(() {
      _selectedHazard = null;
      _descriptionController.clear();
      _imageFile = null;
      _currentAddress = 'No location selected';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Hazard Type'),
            _buildHazardDropdown(),
            const SizedBox(height: 24),
            _buildSectionTitle('Location'),
            _buildLocationSection(), // <-- UPDATED WIDGET
            const SizedBox(height: 24),
            _buildSectionTitle('Add Media (Optional)'),
            _buildMediaButtons(),
            if (_imageFile != null) _buildImagePreview(),
            const SizedBox(height: 24),
            _buildSectionTitle('Description'),
            _buildDescriptionField(),
            const SizedBox(height: 32),
            _buildSubmitButton(),
            const SizedBox(height: 16),
            _buildInfoBanner(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // --- WIDGET BUILDERS ---

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: const Color(0xFF0A4E6C).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.report_problem_outlined, color: Color(0xFF0A4E6C), size: 24),
          ),
          const SizedBox(width: 12),
          const Text('Report Hazard', style: TextStyle(color: Color(0xFF0A4E6C), fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87));
  }

  Widget _buildHazardDropdown() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade300)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedHazard,
          isExpanded: true,
          hint: const Text('Select Hazard Type', style: TextStyle(color: Colors.grey)),
          items: ['Tsunami', 'Storm Surge', 'High Waves', 'Coastal Flooding', 'Other'].map((value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
          onChanged: (value) => setState(() => _selectedHazard = value),
        ),
      ),
    );
  }

  // --- New Location Section Widget ---
  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(12)),
          child: _isFetchingLocation
              ? const Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(), SizedBox(width: 16), Text("Fetching location...")])
              : Row(
            children: [
              Icon(Icons.location_on, color: Colors.blue.shade800),
              const SizedBox(width: 8),
              Expanded(child: Text(_currentAddress, style: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.w600))),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: OutlinedButton.icon(onPressed: _getCurrentLocation, icon: const Icon(Icons.my_location), label: const Text("Current Location"))),
            const SizedBox(width: 8),
            Expanded(child: OutlinedButton.icon(onPressed: _setManualLocation, icon: const Icon(Icons.edit_location_alt_outlined), label: const Text("Set Manually"))),
          ],
        )
      ],
    );
  }

  Widget _buildMediaButtons() {
    // This widget remains the same
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildMediaButton(icon: Icons.camera_alt_outlined, label: 'Camera', onTap: _pickImageFromCamera),
          _buildMediaButton(icon: Icons.photo_library_outlined, label: 'Gallery', onTap: _pickImageFromGallery),
          _buildMediaButton(icon: Icons.videocam_outlined, label: 'Video', onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Video uploads coming soon!')));
          }),
        ],
      ),
    );
  }

  Widget _buildMediaButton({required IconData icon, required String label, required VoidCallback onTap}) {
    // This widget remains the same
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              Icon(icon, color: Colors.grey.shade700, size: 28),
              const SizedBox(height: 8),
              Text(label, style: TextStyle(color: Colors.grey.shade800)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    // This widget remains the same
    return Container(
      margin: const EdgeInsets.only(top: 16),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: FileImage(File(_imageFile!.path)),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    // This widget remains the same
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: TextField(
        controller: _descriptionController,
        maxLines: 4,
        decoration: InputDecoration(
          hintText: 'Describe what you observed (wave height, damage, etc.)',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    // This widget remains the same
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _submitReport,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0A4E6C),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text('Submit Report', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildInfoBanner() {
    // This widget remains the same
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.blue.shade700),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Your report helps INCOIS validate hazards quickly',
              style: TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBar _buildBottomNavBar() {
    // This widget remains the same
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
        BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'MAP'),
        BottomNavigationBarItem(icon: Icon(Icons.report_problem_outlined), label: 'REPORT'),
        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'SOCIAL'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_active_outlined), label: 'ALERTS'),
      ],
      currentIndex: 2,
      selectedItemColor: const Color(0xFF0A4E6C),
      unselectedItemColor: Colors.grey[600],
      onTap: (index) {
        if (index == 0) Navigator.popUntil(context, (route) => route.isFirst);
        if (index == 1) Navigator.pop(context);
      },
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    );
  }
}*//*

// lib/report.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'map.dart';
import 'social.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String? _selectedHazard;
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  String _currentAddress = 'No location selected';
  bool _isFetchingLocation = false;

  Future<void> _getCurrentLocation() async {
    setState(() => _isFetchingLocation = true);

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          setState(() {
            _currentAddress = "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
          });
        }
      } else {
        setState(() => _currentAddress = 'Location permission denied.');
      }
    } catch (e) {
      setState(() => _currentAddress = 'Error fetching location.');
    } finally {
      setState(() => _isFetchingLocation = false);
    }
  }

  Future<void> _setManualLocation() async {
    final TextEditingController manualLocationController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Set Location Manually'),
          content: TextField(
            controller: manualLocationController,
            decoration: const InputDecoration(hintText: "Enter address or landmark"),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            TextButton(
              onPressed: () {
                if (manualLocationController.text.isNotEmpty) {
                  setState(() {
                    _currentAddress = manualLocationController.text;
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Set'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImageFromCamera() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() => _imageFile = pickedFile);
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() => _imageFile = pickedFile);
  }

  void _submitReport() {
    if (_selectedHazard == null || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a hazard type and add a description.'), backgroundColor: Colors.red));
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Thank you! Your report has been submitted.'), backgroundColor: Colors.green));
    setState(() {
      _selectedHazard = null;
      _descriptionController.clear();
      _imageFile = null;
      _currentAddress = 'No location selected';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Hazard Type'),
            _buildHazardDropdown(),
            const SizedBox(height: 24),
            _buildSectionTitle('Location'),
            _buildLocationSection(),
            const SizedBox(height: 24),
            _buildSectionTitle('Add Media (Optional)'),
            _buildMediaButtons(),
            if (_imageFile != null) _buildImagePreview(),
            const SizedBox(height: 24),
            _buildSectionTitle('Description'),
            _buildDescriptionField(),
            const SizedBox(height: 32),
            _buildSubmitButton(),
            const SizedBox(height: 16),
            _buildInfoBanner(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: const Color(0xFF0A4E6C).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.report_problem_outlined, color: Color(0xFF0A4E6C), size: 24),
          ),
          const SizedBox(width: 12),
          const Text('Report Hazard', style: TextStyle(color: Color(0xFF0A4E6C), fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87));
  }

  Widget _buildHazardDropdown() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade300)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedHazard,
          isExpanded: true,
          hint: const Text('Select Hazard Type', style: TextStyle(color: Colors.grey)),
          items: ['Tsunami', 'Storm Surge', 'High Waves', 'Coastal Flooding', 'Other'].map((value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
          onChanged: (value) => setState(() => _selectedHazard = value),
        ),
      ),
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(12)),
          child: _isFetchingLocation
              ? const Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(), SizedBox(width: 16), Text("Fetching location...")])
              : Row(
            children: [
              Icon(Icons.location_on, color: Colors.blue.shade800),
              const SizedBox(width: 8),
              Expanded(child: Text(_currentAddress, style: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.w600))),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: OutlinedButton.icon(onPressed: _getCurrentLocation, icon: const Icon(Icons.my_location), label: const Text("Current Location"))),
            const SizedBox(width: 8),
            Expanded(child: OutlinedButton.icon(onPressed: _setManualLocation, icon: const Icon(Icons.edit_location_alt_outlined), label: const Text("Set Manually"))),
          ],
        )
      ],
    );
  }

  Widget _buildMediaButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildMediaButton(icon: Icons.camera_alt_outlined, label: 'Camera', onTap: _pickImageFromCamera),
          _buildMediaButton(icon: Icons.photo_library_outlined, label: 'Gallery', onTap: _pickImageFromGallery),
          _buildMediaButton(icon: Icons.videocam_outlined, label: 'Video', onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Video uploads coming soon!')));
          }),
        ],
      ),
    );
  }

  Widget _buildMediaButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              Icon(icon, color: Colors.grey.shade700, size: 28),
              const SizedBox(height: 8),
              Text(label, style: TextStyle(color: Colors.grey.shade800)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: FileImage(File(_imageFile!.path)),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: TextField(
        controller: _descriptionController,
        maxLines: 4,
        decoration: InputDecoration(
          hintText: 'Describe what you observed (wave height, damage, etc.)',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _submitReport,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0A4E6C),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text('Submit Report', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.blue.shade700),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Your report helps INCOIS validate hazards quickly',
              style: TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBar _buildBottomNavBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
        BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'MAP'),
        BottomNavigationBarItem(icon: Icon(Icons.report_problem_outlined), label: 'REPORT'),
        BottomNavigationBarItem(icon: Icon(Icons.group_outlined), label: 'SOCIAL'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_active_outlined), label: 'ALERTS'),
      ],
      currentIndex: 2,
      selectedItemColor: const Color(0xFF0A4E6C),
      unselectedItemColor: Colors.grey[600],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.popUntil(context, (route) => route.isFirst);
            break;
          case 1:
          // Avoid pushing a new map screen if we came from there
            if (ModalRoute.of(context)?.settings.name != '/map') {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MapScreen()));
            } else {
              Navigator.pop(context);
            }
            break;
          case 3:
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SocialScreen()));
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    );
  }
}*/
// lib/report.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'map.dart';
import 'social.dart';
import 'alert.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String? _selectedHazard;
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  String _currentAddress = 'No location selected';
  bool _isFetchingLocation = false;

  Future<void> _getCurrentLocation() async {
    setState(() => _isFetchingLocation = true);
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          setState(() => _currentAddress = "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}");
        }
      } else {
        setState(() => _currentAddress = 'Location permission denied.');
      }
    } catch (e) {
      setState(() => _currentAddress = 'Error fetching location.');
    } finally {
      setState(() => _isFetchingLocation = false);
    }
  }

  Future<void> _setManualLocation() async {
    final TextEditingController manualLocationController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Set Location Manually'),
        content: TextField(controller: manualLocationController, decoration: const InputDecoration(hintText: "Enter address or landmark")),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              if (manualLocationController.text.isNotEmpty) {
                setState(() => _currentAddress = manualLocationController.text);
              }
              Navigator.pop(context);
            },
            child: const Text('Set'),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImageFromCamera() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() => _imageFile = pickedFile);
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() => _imageFile = pickedFile);
  }

  void _submitReport() {
    if (_selectedHazard == null || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a hazard type and add a description.'), backgroundColor: Colors.red));
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Thank you! Your report has been submitted.'), backgroundColor: Colors.green));
    setState(() {
      _selectedHazard = null;
      _descriptionController.clear();
      _imageFile = null;
      _currentAddress = 'No location selected';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Hazard Type'),
            _buildHazardDropdown(),
            const SizedBox(height: 24),
            _buildSectionTitle('Location'),
            _buildLocationSection(),
            const SizedBox(height: 24),
            _buildSectionTitle('Add Media (Optional)'),
            _buildMediaButtons(),
            if (_imageFile != null) _buildImagePreview(),
            const SizedBox(height: 24),
            _buildSectionTitle('Description'),
            _buildDescriptionField(),
            const SizedBox(height: 32),
            _buildSubmitButton(),
            const SizedBox(height: 16),
            _buildInfoBanner(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: const Color(0xFF0A4E6C).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.report_problem_outlined, color: Color(0xFF0A4E6C), size: 24),
          ),
          const SizedBox(width: 12),
          const Text('Report Hazard', style: TextStyle(color: Color(0xFF0A4E6C), fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87));
  }

  Widget _buildHazardDropdown() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade300)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedHazard,
          isExpanded: true,
          hint: const Text('Select Hazard Type', style: TextStyle(color: Colors.grey)),
          items: ['Tsunami', 'Storm Surge', 'High Waves', 'Coastal Flooding', 'Other'].map((value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
          onChanged: (value) => setState(() => _selectedHazard = value),
        ),
      ),
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(12)),
          child: _isFetchingLocation
              ? const Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(), SizedBox(width: 16), Text("Fetching location...")])
              : Row(
            children: [
              Icon(Icons.location_on, color: Colors.blue.shade800),
              const SizedBox(width: 8),
              Expanded(child: Text(_currentAddress, style: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.w600))),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: OutlinedButton.icon(onPressed: _getCurrentLocation, icon: const Icon(Icons.my_location), label: const Text("Current Location"))),
            const SizedBox(width: 8),
            Expanded(child: OutlinedButton.icon(onPressed: _setManualLocation, icon: const Icon(Icons.edit_location_alt_outlined), label: const Text("Set Manually"))),
          ],
        )
      ],
    );
  }

  Widget _buildMediaButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildMediaButton(icon: Icons.camera_alt_outlined, label: 'Camera', onTap: _pickImageFromCamera),
          _buildMediaButton(icon: Icons.photo_library_outlined, label: 'Gallery', onTap: _pickImageFromGallery),
          _buildMediaButton(icon: Icons.videocam_outlined, label: 'Video', onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Video uploads coming soon!')))),
        ],
      ),
    );
  }

  Widget _buildMediaButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade300)),
          child: Column(
            children: [
              Icon(icon, color: Colors.grey.shade700, size: 28),
              const SizedBox(height: 8),
              Text(label, style: TextStyle(color: Colors.grey.shade800)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), image: DecorationImage(image: FileImage(File(_imageFile!.path)), fit: BoxFit.cover)),
    );
  }

  Widget _buildDescriptionField() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: TextField(
        controller: _descriptionController,
        maxLines: 4,
        decoration: InputDecoration(hintText: 'Describe what you observed (wave height, damage, etc.)', filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300))),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _submitReport,
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0A4E6C), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        child: const Text('Submit Report', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.blue.shade700),
          const SizedBox(width: 8),
          const Expanded(child: Text('Your report helps INCOIS validate hazards quickly', style: TextStyle(color: Colors.black54))),
        ],
      ),
    );
  }

  BottomNavigationBar _buildBottomNavBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
        BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'MAP'),
        BottomNavigationBarItem(icon: Icon(Icons.report_problem_outlined), label: 'REPORT'),
        BottomNavigationBarItem(icon: Icon(Icons.group_outlined), label: 'SOCIAL'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_active_outlined), label: 'ALERTS'),
      ],
      currentIndex: 2,
      selectedItemColor: const Color(0xFF0A4E6C),
      unselectedItemColor: Colors.grey[600],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.popUntil(context, (route) => route.isFirst);
            break;
          case 1:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MapScreen()));
            break;
          case 3:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SocialScreen()));
            break;
          case 4:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AlertsScreen()));
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    );
  }
}