import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  final List<String> categories;
  final ValueChanged<String> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.all(7),
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.deepPurple,
                      spreadRadius: 2,
                      offset: Offset(0,0),
                      blurRadius: 5,
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(width: 2, color: Colors.deepPurple)),
              child: TextButton(
                onPressed: () {
                  onCategorySelected.call("");
                },
                child: const Center(child: Text("All"))
              ),
            ),
          ),
          ...List.generate(categories.length, (index) {
            return Padding(
              padding: const EdgeInsets.all(7),
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.deepPurple,
                        spreadRadius: 2,
                        offset: Offset(0,0),
                        blurRadius: 5,
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 2, color: Colors.deepPurple)),
                child: TextButton(
                  style: TextButton.styleFrom(padding: const EdgeInsets.all(3)),
                  onPressed: () {
                    onCategorySelected.call(categories[index]);
                  },
                  child: Text(
                    categories[index],
                    style: const TextStyle(color: Colors.deepPurple),
                  ),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
