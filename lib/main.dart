import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff5a9076),
        toolbarHeight: 75,
        title: const Center(
            child: Text(
          'Pocket Skills',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xffffffff),
          ),
        )),
      ),
      resizeToAvoidBottomInset: false,
      body: Align(
        alignment: Alignment.center,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: Color(0xff5a9076),
          ),
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          width: 300,
          height: 400,
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  'Log in',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xffffffff),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                buildUsername(),
                const SizedBox(
                  height: 18,
                ),
                buildEmail(),
                const SizedBox(
                  height: 18,
                ),
                buildPassword(),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  "Don't have an account yet?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xffffffff),
                    decoration: TextDecoration.underline,
                  ),
                ),
                buildSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUsername() => TextFormField(
        decoration: const InputDecoration(
          labelText: 'Username',
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          border: UnderlineInputBorder(),
        ),
        validator: (value) {
          if (value!.length < 4) {
            return 'Enter at least 4 characters';
          } else {
            return null;
          }
        },
        maxLength: 30,
        onSaved: (value) => setState(() => username = value!),
      );

  Widget buildEmail() => TextFormField(
        decoration: const InputDecoration(
          labelText: 'Email',
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          border: UnderlineInputBorder(),
        ),
        validator: (value) {
          const pattern =
              r'^[a-zA-Z0-9]+(?:\.[a-zA-Z0-9]+)*@[a-zA-Z0-9]+(?:\.[a-zA-Z0-9]+)*$';
          final regExp = RegExp(pattern);

          if (!regExp.hasMatch(value!)) {
            return 'Email is not valid';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => email = value!),
      );

  Widget buildPassword() => TextFormField(
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          border: UnderlineInputBorder(),
        ),
        validator: (value) {
          if (value!.length < 7) {
            return 'Password must be at least 7 characters long';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => password = value!),
      );

  Widget buildSubmit() => ElevatedButton(
        child: const Text('Submit'),
        onPressed: () {
          final isValid = formKey.currentState?.validate();

          if (isValid!) {
            formKey.currentState?.save();

            final message =
                'Username: $username \nEmail: $email \nPassword: $password';

            final snackBar = SnackBar(
              content: Text(
                message,
                style: const TextStyle(fontSize: 20),
              ),
              backgroundColor: Colors.green,
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
      );
}
