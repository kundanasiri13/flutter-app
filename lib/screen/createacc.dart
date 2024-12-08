import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF333333)),
          bodyMedium: TextStyle(color: Color(0xFF555555)),
        ),
        buttonTheme: ButtonThemeData(buttonColor: const Color(0xFF81D4FA)),
      ),
      home: const CreateAccountPage(),
    );
  }
}

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        backgroundColor: const Color(0xFF0288D1),
        centerTitle: true,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Text(
              'Create an Account',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
              ),
            ),
            const SizedBox(height: 40),

            // Username field
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
            ),
            const SizedBox(height: 20),

            // Phone number field
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
            ),
            const SizedBox(height: 20),

            // Email field
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email ID',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
            ),
            const SizedBox(height: 20),

            // Password field
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
            ),
            const SizedBox(height: 40),

            // Create Account Button
            ElevatedButton(
              onPressed: () {
                // Add logic to create an account here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Account created successfully!')),
                );
                Navigator.pop(context); // Go back to the previous page or home
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 85),
                backgroundColor: const Color(0xFF81D4FA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 10,
                shadowColor: Colors.blue.withOpacity(0.4),
              ),
              child: const Text(
                'Create Account',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 20),

            // Option to go back to login page
            Center(
              child: TextButton(
                onPressed: () {
                  // Navigate back to login page (can be implemented later)
                  Navigator.pop(context);
                },
                child: const Text(
                  'Already have an account? Login',
                  style: TextStyle(color: Color(0xFF0288D1)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
