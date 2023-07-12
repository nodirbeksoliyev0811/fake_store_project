import 'package:flutter/material.dart';
import 'package:n8_default_project/data/network/providers/api_provider.dart';
import 'package:n8_default_project/data/network/repositories/category_repo.dart';
import 'package:n8_default_project/data/network/repositories/product_repo.dart';
import 'package:n8_default_project/data/network/repositories/user_repo.dart';
import 'package:n8_default_project/ui/tab_box/products/products_screen.dart';
import 'package:n8_default_project/ui/tab_box/users/users_screen.dart';

class TabBox extends StatefulWidget {
  const TabBox({Key? key, required this.apiProvider}) : super(key: key);

  final ApiProvider apiProvider;

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  List<Widget> screens = [];
  int activePage = 0;

  late ProductRepo productRepo;
  late UserRepo userRepo;
  late CategoryRepo categoryRepo;

  @override
  void initState() {
    productRepo = ProductRepo(apiProvider: widget.apiProvider);
    userRepo = UserRepo(apiProvider: widget.apiProvider);
    categoryRepo = CategoryRepo(apiProvider: widget.apiProvider);

    screens.add(ProductsScreen(
      productRepo: productRepo,
      categoryRepo: categoryRepo,
      apiProvider: ApiProvider(),
    ));
    screens.add(UsersScreen(
      userRepo: userRepo,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: activePage,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepPurple,
        currentIndex: activePage,
        unselectedIconTheme: const IconThemeData(color: Colors.white),
        selectedIconTheme: IconThemeData(color: Colors.white.withOpacity(0.7)),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            activePage = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shop,
            ),
            label: "Products",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people,
            ),
            label: "Users",
          ),
        ],
      ),
    );
  }
}
