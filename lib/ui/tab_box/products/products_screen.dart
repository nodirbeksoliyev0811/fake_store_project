import 'package:flutter/material.dart';
import 'package:n8_default_project/data/models/product/product_model.dart';
import 'package:n8_default_project/data/network/providers/api_provider.dart';
import 'package:n8_default_project/data/network/repositories/category_repo.dart';
import 'package:n8_default_project/data/network/repositories/product_repo.dart';
import 'package:n8_default_project/ui/tab_box/products/product_screen.dart';
import 'package:n8_default_project/ui/tab_box/products/widgets/category_selector.dart';
import 'package:n8_default_project/ui/tab_box/products/widgets/shimmer_widget.dart';
import 'package:n8_default_project/ui/tab_box/tab_box.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({
    Key? key,
    required this.productRepo,
    required this.categoryRepo,
    required this.apiProvider,
  }) : super(key: key);

  final ProductRepo productRepo;
  final CategoryRepo categoryRepo;
  final ApiProvider apiProvider;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String activeCategoryName = "";

  List<ProductModel> products = [];
  List<String> categories = [];
  bool isLoading = false;
  int limit = 0;
  String selectedPopupMenuValue = 'All';
  Color color = Colors.white;

  _updateProducts() async {
    setState(() {
      isLoading = true;
    });
    products =
        await widget.productRepo.getProductsByCategory(activeCategoryName);
    setState(() {
      isLoading = false;
    });
  }

  _init() async {
    categories = await widget.categoryRepo.getAllCategories();
  }

  @override
  void initState() {
    _init();
    _updateProducts();
    super.initState();
  }

  void _showLimitDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Set Limit',
            style: TextStyle(color: Colors.deepPurple),
          ),
          content: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                limit = int.tryParse(value) ?? 0;
              });
            },
            decoration: const InputDecoration(
              hintText: 'Enter a limit',
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.deepPurple),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TabBox(apiProvider: ApiProvider()),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final List<ProductModel> fetchedData =
          await widget.productRepo.getAllProducts();
      setState(() {
        products = fetchedData;
      });

      if (selectedPopupMenuValue == 'Sort') {
        final List<ProductModel> sortedData =
            await widget.productRepo.getSortedProducts("desc");
        setState(() {
          products = sortedData;
        });
      } else if (selectedPopupMenuValue == "unSort") {
        final List<ProductModel> unSortedData =
            await widget.productRepo.getSortedProducts("asc");
        setState(() {
          products = unSortedData;
        });
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to load products.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Market"),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert,
              size: 30,
            ),
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'Limit',
                  child: Text(
                    'Limit to Products',
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Sort',
                  child: Text(
                    'A-Z',
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'unSort',
                  child: Text(
                    'Z-A',
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                ),
              ];
            },
            onSelected: (value) {
              setState(() {
                selectedPopupMenuValue = value;
                if (value == 'Limit') {
                  _showLimitDialog();
                } else if (value == 'Sort') {
                  fetchData();
                } else if (value == "unSort") {
                  fetchData();
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          categories.isNotEmpty
              ? CategorySelector(
                  categories: categories,
                  onCategorySelected: (selectedCategory) {
                    activeCategoryName = selectedCategory;
                    _updateProducts();
                  },
                )
              : const Center(child: LinearProgressIndicator()),
          Expanded(
            child: categories.isNotEmpty
                ? GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.0,
                      crossAxisSpacing: 16.0,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final item = products[index];
                      return categories.isNotEmpty
                          ? ZoomTapAnimation(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      title: item.title,
                                      price: item.price,
                                      description: item.description,
                                      image: item.image,
                                      rating: item.rating,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(
                                        color: Colors.deepPurple, width: 2),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.deepPurple,
                                        spreadRadius: 2,
                                        offset: Offset(0, 0),
                                        blurRadius: 5,
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                            top: Radius.circular(12.0),
                                          ),
                                          child: Center(
                                            child: Image.network(item.image),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                child: Text(
                                                  item.title,
                                                  style: const TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(height: 4.0),
                                              Center(
                                                child: Text(
                                                  item.category,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.grey,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(height: 8.0),
                                              Center(
                                                child: Text(
                                                  '\$${item.price.toStringAsFixed(2)}',
                                                  style: const TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : const Center(child: LinearProgressIndicator());
                    },
                  )
                : const ProductLoadingShimmer(),
          ),
        ],
      ),
    );
  }
}
