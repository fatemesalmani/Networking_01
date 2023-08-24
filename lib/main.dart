import 'package:flutter/material.dart';
import 'package:flutter_application_13/data.dart';
import 'package:google_fonts/google_fonts.dart';

final _formkey = GlobalKey<FormState>();
void main() {
  getUsers();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
          filled: true,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.latoTextTheme(const TextTheme(
            bodyText1: TextStyle(fontSize: 10),
            bodyText2: TextStyle(fontSize: 15),
            subtitle1: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            subtitle2: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  get list => null;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Form(
        key: _formkey,
        child: Scaffold(
            body: Container(
          width: 300,
          height: 600,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 12,
                  //spreadRadius: 1,
                )
              ]),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 80, 0, 0),
                    child: Row(
                      children: [
                        Text(
                          'Welcome!',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 0, 35),
                    child: Row(
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.subtitle1,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: SizedBox(
                      height: 35,
                      child: TextFormField(
                        controller: controllerUsername,
                        validator: (value) {
                          if (value == "") {
                            return "plz complete";
                          } else if (value!.length < 3) {
                            return "false";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(labelText: 'Username '),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: SizedBox(
                      height: 35,
                      child: Password(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 30, 60, 0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () { 
                            if (_formkey.currentState!.validate()) {

                              for(var i = 0; i < 10; i++){

                              if(list[i].username == controllerUsername.text && list[i].password == controllerPassword.text){
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => _HomeScreen()));
                           }
                           
                            }
                          }},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                          ),
                          child: Text(
                            'LOGIN',
                            style: Theme.of(context).textTheme.bodyText2,
                          )),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(70, 20, 70, 40),
                      child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'Forget Password?',
                            style: Theme.of(context).textTheme.bodyText1,
                          )),
                    ),
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 25,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 6, 25, 0),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'Dont have an account?Creat Account',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}

class Password extends StatefulWidget {
  const Password({
    super.key,
  });

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  bool obscureText = true;
  TextEditingController controllerPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllerPassword,
      validator: (value) {
        if (value == "") {
          return "plz complete";
        } else if (value!.length < 3) {
          return "false";
        }
        return null;
      },
      obscureText: obscureText,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
          label: const Text('Password'),
          suffixIcon: TextButton(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              child: Text(obscureText ? 'Show' : 'Hide'))),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<User>>(
        future: getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return _User(user: snapshot.data![index]);
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class _User extends StatelessWidget {
  final User user;
  const _User({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: [
          Container(
            width: 300,
            height: 40,
            color: Colors.amber,
            margin: const EdgeInsets.all(5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(user.username.toString()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


