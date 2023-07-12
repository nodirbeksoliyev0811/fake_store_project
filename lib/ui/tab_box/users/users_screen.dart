// import 'package:flutter/material.dart';
// import 'package:n8_default_project/data/network/repositories/user_repo.dart';
//
// class UsersScreen extends StatefulWidget {
//   const UsersScreen({Key? key, required this.userRepo}) : super(key: key);
//
//   final UserRepo userRepo;
//
//   @override
//   State<UsersScreen> createState() => _UsersScreenState();
// }
//
// class _UsersScreenState extends State<UsersScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Users screen"),
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/models/user/user_model.dart';
import '../../../data/network/providers/api_provider.dart';
import '../../../data/network/repositories/login_repo.dart';
import '../../../data/network/repositories/user_repo.dart';
import '../login/login_screen.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key, required this.userRepo}) : super(key: key);

  final UserRepo userRepo;

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List<UserModel> user = [];

  _updateProducts() async {
    setState(() {
      isLoading = true;
    });
    user = await widget.userRepo.getAllUsers();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _updateProducts();
    super.initState();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        actions: [
          IconButton(
              onPressed: () {
                widget.userRepo.logOutUser();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen(apiProvider: ApiProvider());
                    },
                  ),
                );
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    children: List.generate(
                      user.length,
                      (index) => ListTile(
                        title: Text(
                          "${user[index].name.firstname} ${user[index].name.lastname}",
                        ),
                        subtitle: Text(user[index].email),
                        trailing: Text(
                          "${user[index].id}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
