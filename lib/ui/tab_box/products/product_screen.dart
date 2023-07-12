// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:n8_default_project/data/models/product/product_model.dart';
//
// class ProductScreen extends StatefulWidget {
//   const ProductScreen({Key? key, required this.model}) : super(key: key);
//
//   final ProductModel model;
//
//   @override
//   _ProductScreenState createState() => _ProductScreenState();
// }
//
// class _ProductScreenState extends State<ProductScreen> {
//   List<ProductModel> storeData = [];
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Product",style: TextStyle(color: Colors.white),),
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           const SizedBox(
//             height: 40,
//           ),
//           Container(
//             height: 300,
//             clipBehavior: Clip.antiAlias,
//             child: Image.network(
//               widget.model.image,
//             ),
//           ),
//           const SizedBox(height: 8.0),
//           Expanded(
//             flex: 2,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 10,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.model.title,
//                     style: const TextStyle(
//                       fontSize: 25.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     maxLines: 20,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 20),
//                   Expanded(
//                     child: ListView(children: [
//                       Column(
//                         children: [
//                           Text(
//                             widget.model.description,
//                             style: const TextStyle(
//                               color: Colors.black54,
//                               fontSize: 18.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             maxLines: 100,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           const SizedBox(height: 8.0),
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               '\$${widget.model.price}',
//                               style: const TextStyle(
//                                 fontSize: 30.0,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ]),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       backgroundColor: Colors.white,
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/product/rating_model.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen(
      {super.key,
      required this.title,
      required this.price,
      required this.description,
      required this.image,
      required this.rating});

  final String title;
  final num price;
  final String description;
  final String image;
  final RatingModel rating;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // centerTitle: 1 > 0,
        backgroundColor: Colors.deepPurple,
        title: const Text('About'),
      ),
      body: Stack(
        children: [
          const SizedBox(
            height: double.infinity,
            width: double.infinity,
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Image.network(
                  widget.image,
                  height: 200,
                  width: 200,
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Price ${widget.price} \$',
                            style: const TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.star,
                            size: 20,
                            color: Colors.yellow,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.rating.rate.toString(),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Center(
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Text(
                        widget.description,
                        style: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 100,
                        width: double.infinity,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 640,
            left: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * (57 / 812),
                  width: MediaQuery.of(context).size.width * (326 / 375),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                        elevation: const MaterialStatePropertyAll<double>(10),
                        backgroundColor:
                            const MaterialStatePropertyAll<Color>(Colors.blue)),
                    child: const Text(
                      'Buy',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
