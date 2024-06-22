import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:news_app/widgets/spacing.dart';
import 'package:provider/provider.dart';


import '../constants/colors.dart';
import '../model/model.dart';
import 'news_detailed.dart';
import 'news_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isInCart = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: appColor,
        title: const Text(
          'Whishlist',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<Article>>(
        future:
            Provider.of<NewsProvider>(context, listen: false).getWishListItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No News in Whishlist',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 22),));
          } else {
            final cartItems = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailedScreen(
                            album: item,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Image.network(
                                item.urlToImage ??
                                    'https://cdn.vectorstock.com/i/500p/82/99/no-image-available-like-missing-picture-vector-43938299.jpg',
                                width: MediaQuery.of(context).size.width * 0.9,
                              ),
                              Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 32,
                                    ),
                                    onPressed: () {
                                      Provider.of<NewsProvider>(context, listen: false)
                                          .removeFromWishList(context, item);
                                      setState(() {
                                        isInCart = false;
                                      });
                                    },
                                  ))
                            ],
                          ),
                          mediumSpacing(context, 0.02),
                          Text(
                            item.title ?? "",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          mediumSpacing(context, 0.005),
                          Text(
                            "Source From : ${item.source.name ?? 'local workspace.'.toUpperCase()}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          mediumSpacing(context, 0.005),
                          Text(
                            "Author : ${item.author ?? 'local workspace.'.toUpperCase()}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          mediumSpacing(context, 0.005),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Published At: ${DateFormat('dd/MM/yyyy').format((item.publishedAt))}",
                              ),
                            ],
                          ),
                          mediumSpacing(context, 0.005),
                          const Divider(
                            color: blackColor,
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
