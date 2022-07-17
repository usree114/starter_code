import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const LoginScreen());
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late bool _success;
  late String _userEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Please sign in', style: TextStyle(fontSize: 35.0)),
              const SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration:
                    const InputDecoration(hintText: 'Type your email here'),
                onTap: () {},
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Type your password',
                ),
                onTap: () {},
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(child: const Text('Sign in'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _register();
                    }
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _register() async {
    final User? user = (await
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _usernameController.text,
      password: _passwordController.text,
    )
    ).user;
    if (user != null) {
      setState(() {
        _success = true;
        print("user email ${user. email}");
        _userEmail = user.email!;
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    } else {
      setState(() {
        print("user email $user");
        _success = true;
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    }
  }
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

