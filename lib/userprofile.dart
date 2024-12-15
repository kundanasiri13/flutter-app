import 'package:flutter/material.dart';

void main() {
  runApp(const BudgetLoftApp());
}

class BudgetLoftApp extends StatelessWidget {
  const BudgetLoftApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F1F1F),
          elevation: 5,
          titleTextStyle: TextStyle(
            color: Color(0xFF9EDAFF),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const ProfilePage(), // Start with the Profile Page
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _isEditingDetails = false;
  bool _isChangingPassword = false;

  @override
  void initState() {
    super.initState();
    // Initial values for the user details (normally retrieved from a database)
    nameController.text = "John Doe";
    emailController.text = "john.doe@example.com";
  }

  // Function to save changes in user details
  void _saveDetailsChanges() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User details updated successfully!')),
      );
      setState(() {
        _isEditingDetails = false;  // Hide details edit section after saving
      });
    }
  }

  // Function to save password changes
  void _changePassword() {
    if (passwordController.text == confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password changed successfully!')),
      );
      setState(() {
        _isChangingPassword = false;  // Hide password change form after changing password
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xFF1F1F1F),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(  // Center the entire content of the page
          child: Container(
            color: const Color(0xFF121212),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,  // Center the content vertically
              crossAxisAlignment: CrossAxisAlignment.center,  // Center the content horizontally
              children: [
                // Profile Avatar Section
                const CircleAvatar(
                  radius: 75,
                  backgroundColor: Color(0xFF9EDAFF),
                  child: Text(
                    ':D',  // Placeholder initials
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'user',
                  style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  'user@mail.com',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const SizedBox(height: 40),

                // Action Buttons
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isChangingPassword = false;
                      _isEditingDetails = !_isEditingDetails;  // Toggle edit details section
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xFF9EDAFF), backgroundColor: const Color(0xFF1C1C2E), padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                    elevation: 10,
                    shadowColor: const Color(0xFF9EDAFF).withOpacity(0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Edit Details'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isEditingDetails = false;
                      _isChangingPassword = !_isChangingPassword;  // Toggle password change section
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xFF9EDAFF), backgroundColor: const Color(0xFF1C1C2E), padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                    elevation: 10,
                    shadowColor: const Color(0xFF9EDAFF).withOpacity(0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Change Password'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Log Out clicked')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xFF9EDAFF), backgroundColor: const Color(0xFF1C1C2E), padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                    elevation: 10,
                    shadowColor: const Color(0xFF9EDAFF).withOpacity(0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Log Out'),
                ),
                const SizedBox(height: 30),

                // Edit User Details Form
                if (_isEditingDetails)
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Color(0xFF1C1C2E),
                            border: OutlineInputBorder(),
                          ),
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Color(0xFF1C1C2E),
                            border: OutlineInputBorder(),
                          ),
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _saveDetailsChanges,
                          child: const Text('Save Changes'),
                        ),
                      ],
                    ),
                  ),

                // Change Password Form
                if (_isChangingPassword)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Change Password',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'New Password',
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Color(0xFF1C1C2E),
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your new password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Color(0xFF1C1C2E),
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _changePassword,
                        child: const Text('Change Password'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
