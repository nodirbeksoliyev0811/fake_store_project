import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductLoadingShimmer extends StatelessWidget {
  const ProductLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.8),
      highlightColor: Colors.grey.withOpacity(0.2),
      direction: ShimmerDirection.btt,
      period: const Duration(milliseconds: 1000),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GridView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 0.7,
              ),
              children: List.generate(
                20,
                (index) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 10,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        )
                      ],
                      border: Border.all(
                        color: Colors.teal,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    child: const Column(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.yellow,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
