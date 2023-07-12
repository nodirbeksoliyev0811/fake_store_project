import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../data/network/providers/api_provider.dart';
import '../../../data/network/repositories/login_repo.dart';
import '../tab_box.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.apiProvider});

  final ApiProvider apiProvider;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  late LoginRepo loginRepository;
  bool isTap = true;
  Icon isShow = const Icon(Icons.visibility);

  @override
  void initState() {
    loginRepository = LoginRepo(apiProvider: widget.apiProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text(
          "Store Login",
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 24, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              const Icon(
                Icons.shopping_bag_sharp,
                color: Colors.deepPurple,
                size: 120,
              ),
              const SizedBox(height: 40),
              TextField(
                textInputAction: TextInputAction.next,
                controller: _controller1,
                decoration: InputDecoration(
                  hintText: "Enter username",
                  labelText: "Enter username",
                  hintStyle:
                      const TextStyle(fontSize: 18, color: Colors.deepPurple),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      width: 1.5,
                      color: Colors.deepPurple,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      width: 1.5,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                textInputAction: TextInputAction.done,
                controller: _controller2,
                obscureText: isTap,
                decoration: InputDecoration(
                  hintText: "Enter password",
                  labelText: "Enter password",
                  suffixIcon: ZoomTapAnimation(
                    onTap: () {
                      setState(() {
                        isTap = !isTap;
                        isTap ? isShow = const Icon(Icons.visibility) : isShow;
                        !isTap
                            ? isShow = const Icon(Icons.visibility_off)
                            : isShow;
                      });
                    },
                    child: isShow,
                  ),
                  hintStyle:
                      const TextStyle(fontSize: 18, color: Colors.deepPurple),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1.5,
                      color: Colors.deepPurple,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1.5,
                      color: Colors.deepPurple,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 100),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                    onPressed: () async {
                      if (await loginRepository.loginUser(
                          username: _controller1.text,
                          password: _controller2.text)) {
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return TabBox(apiProvider: widget.apiProvider);
                            },
                          ),
                        );
                      } else {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("Password or username error"),
                          ),
                        );
                      }
                    },
                    child: const SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
