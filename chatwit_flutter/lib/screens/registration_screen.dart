import 'package:flutter/material.dart';
import 'package:chatwit_flutter/core/client.dart';
import 'package:chatwit_flutter/core/app_constants.dart';
import 'package:chatwit_flutter/screens/photo_setup_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _customGenderController = TextEditingController();
  final _occupationController = TextEditingController();
  final _locationController = TextEditingController();
  final _websiteController = TextEditingController();

  DateTime? _selectedDateOfBirth;
  String? _selectedGender;
  bool _isLoading = false;

  @override
  void dispose() {
    _pageController.dispose();
    _firstNameController.dispose();
    _surnameController.dispose();
    _usernameController.dispose();
    _customGenderController.dispose();
    _occupationController.dispose();
    _locationController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  void _nextPage() {
    FocusScope.of(context).unfocus();
    if (_currentStep == 0) {
      if (_firstNameController.text.isEmpty ||
          _surnameController.text.isEmpty ||
          _usernameController.text.isEmpty) {
        _showError("Please fill in all required fields.");
        return;
      }
    } else if (_currentStep == 1) {
      if (_selectedDateOfBirth == null || _selectedGender == null) {
        _showError("Please complete this step.");
        return;
      }
    }

    if (_currentStep < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _submitRegistration();
    }
  }

  void _previousPage() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  String? get _resolvedGender {
    if (_selectedGender == 'Custom') {
      return _customGenderController.text.trim().isNotEmpty
          ? _customGenderController.text.trim()
          : "Custom";
    }
    return _selectedGender;
  }

  Future<void> _submitRegistration() async {
    if (_firstNameController.text.isEmpty ||
        _surnameController.text.isEmpty ||
        _usernameController.text.isEmpty) {
      _showError("Please fill in all required fields on Step 1.");
      _pageController.animateToPage(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }

    if (_selectedDateOfBirth == null || _resolvedGender == null) {
      _showError("Please complete your date of birth and gender on Step 2.");
      _pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }

    if (_formKey.currentState != null && !_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);
    try {
      final success = await client.userRegistration.submitRegistration(
        firstName: _firstNameController.text.trim(),
        surname: _surnameController.text.trim(),
        username: _usernameController.text.trim(),
        dateOfBirth: _selectedDateOfBirth!,
        sex: _resolvedGender!,
        occupation: _occupationController.text.trim().isNotEmpty
            ? _occupationController.text.trim()
            : null,
        location: _locationController.text.trim().isNotEmpty
            ? _locationController.text.trim()
            : null,
        website: _websiteController.text.trim().isNotEmpty
            ? _websiteController.text.trim()
            : null,
      );

      if (success && mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const PhotoSetupScreen()),
        );
      }
    } catch (e) {
      _showError("Registration failed: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: _previousPage,
        ),
        title: const Text(
          "Chatwit",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) =>
                          setState(() => _currentStep = index),
                      children: [
                        _buildStep1(),
                        _buildStep2(),
                        _buildStep3(),
                      ],
                    ),
                  ),
                  _buildFooter(),
                ],
              ),
            ),
    );
  }

  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Create your account",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 40),
          _buildXTextField(
            controller: _firstNameController,
            label: "First Name",
          ),
          const SizedBox(height: 30),
          _buildXTextField(
            controller: _surnameController,
            label: "Surname",
          ),
          const SizedBox(height: 30),
          _buildXTextField(
            controller: _usernameController,
            label: "Username",
            prefix: "@",
          ),
        ],
      ),
    );
  }

  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            "What's your date of birth?",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "This will not be shown publicly. Confirm your own age, even if this account is for a business, a pet, or something else.",
            style: TextStyle(color: Colors.grey, fontSize: 14, height: 1.3),
          ),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime(2000),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: Colors.black,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (picked != null) setState(() => _selectedDateOfBirth = picked);
            },
            child: _buildXSelector(
              label: "Date of birth",
              value: _selectedDateOfBirth == null
                  ? ""
                  : "${_selectedDateOfBirth!.day}/${_selectedDateOfBirth!.month}/${_selectedDateOfBirth!.year}",
            ),
          ),
          const SizedBox(height: 40),
          const Text(
            "Gender",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _selectedGender,
            icon: const Icon(Icons.keyboard_arrow_down),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[200]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[200]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            items: ['Male', 'Female', 'Custom'].map((String val) {
              return DropdownMenuItem<String>(value: val, child: Text(val));
            }).toList(),
            onChanged: (value) => setState(() => _selectedGender = value),
          ),
          if (_selectedGender == 'Custom') ...[
            const SizedBox(height: 20),
            _buildXTextField(
              controller: _customGenderController,
              label: "Specify gender",
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStep3() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Customize your experience",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) => Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return AppConstants.occupationOptions;
                }
                return AppConstants.occupationOptions.where((String option) {
                  return option.toLowerCase().contains(
                    textEditingValue.text.toLowerCase(),
                  );
                });
              },
              onSelected: (String selection) {
                _occupationController.text = selection;
              },
              fieldViewBuilder:
                  (
                    context,
                    textEditingController,
                    focusNode,
                    onFieldSubmitted,
                  ) {
                    return _buildXTextField(
                      controller: textEditingController,
                      label: "Occupation",
                      focusNode: focusNode,
                      onChanged: (val) => _occupationController.text = val,
                      validator: (v) => null,
                    );
                  },
              optionsViewBuilder: (context, onSelected, options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: constraints.maxWidth,
                      height: 200,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final String option = options.elementAt(index);
                          return ListTile(
                            title: Text(option),
                            onTap: () => onSelected(option),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 30),
          _buildXTextField(
            controller: _locationController,
            label: "Location",
            validator: (v) => null,
          ),
          const SizedBox(height: 30),
          _buildXTextField(
            controller: _websiteController,
            label: "Website",
            validator: (v) => null,
          ),
        ],
      ),
    );
  }

  Widget _buildXTextField({
    required TextEditingController controller,
    required String label,
    String? prefix,
    FocusNode? focusNode,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      validator:
          validator ?? (v) => (v == null || v.isEmpty) ? "Required" : null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        prefixText: prefix,
        floatingLabelStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildXSelector({required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value.isEmpty ? "Select" : value,
                style: TextStyle(
                  color: value.isEmpty ? Colors.grey : Colors.black,
                  fontSize: 16,
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[100]!)),
      ),
      child: ElevatedButton(
        onPressed: _nextPage,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        child: Text(
          _currentStep == 2 ? "Get started" : "Next",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
