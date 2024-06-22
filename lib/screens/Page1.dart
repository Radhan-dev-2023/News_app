import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:news_app/widgets/spacing.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import 'cart_screen.dart';
import 'news_detailed.dart';
import 'news_provider.dart';


class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  late NewsProvider _newsProvider;
  String? _selectedValue;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _newsProvider = NewsProvider();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _newsProvider.fetchApple();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _newsProvider.disposeHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _newsProvider,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              mediumSpacing(context, 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    "Explore News,",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: blueGrey),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CartScreen()),
                        );
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: buttonColor,
                        size: 32,
                      ))
                ],
              ),
              mediumSpacing(context, 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "You need to know !",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: appColor),
                  ),
                  IconButton(
                      onPressed: () {
                        _showFilterOptions(context);
                      },
                      icon: const Icon(
                        Icons.sort_outlined,
                        color: buttonColor,
                        size: 32,
                      ))
                  /*  Icon(
                    Icons.filter,
                    color: buttonColor,
                    size: 50,
                  )*/
                ],
              ),
              mediumSpacing(context, 0.04),
              TextFormField(
                minLines: 1,
                maxLines: 2,
                controller: _searchController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (_searchController.text.isNotEmpty) {
                        _newsProvider.searchNews(_searchController.text);
                      }
                    },
                    icon: const Icon(
                      Icons.search_sharp,
                      size: 32,
                      color: buttonColor,
                    ),
                  ),
                  hintText: "Search your News here....",
                  hintStyle: const TextStyle(
                      color: appColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              mediumSpacing(context, 0.009),
              Consumer(builder:
                  (BuildContext context, NewsProvider newsProvider, _) {
                return Expanded(
                  child: newsProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : newsProvider.errorMessage != null
                          ? Center(
                              child: Text(
                              newsProvider.errorMessage!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: appColor,
                                  fontSize: 20),
                            ))
                          : ListView.builder(
                              padding: const EdgeInsets.all(20),
                              itemCount:
                                  newsProvider.albumApple?.articles.length ?? 0,
                              itemBuilder: (context, index) {
                                final article =
                                    newsProvider.albumApple?.articles[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            NewsDetailedScreen(
                                          album: article,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          article?.urlToImage ??
                                              'https://cdn.vectorstock.com/i/500p/82/99/no-image-available-like-missing-picture-vector-43938299.jpg',
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                        ),
                                        mediumSpacing(context, 0.02),
                                        Text(
                                          article?.title ?? "",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        mediumSpacing(context, 0.005),
                                        Text(
                                          "Source From : ${article?.source.name ?? 'local workspace.'.toUpperCase()}",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: textColor,
                                          ),
                                        ),
                                        mediumSpacing(context, 0.005),
                                        Text(
                                          "Author : ${article?.author ?? 'local workspace.'.toUpperCase()}",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: textColor,
                                          ),
                                        ),
                                        mediumSpacing(context, 0.005),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Published At: ${DateFormat('dd/MM/yyyy').format((article!.publishedAt))}",
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
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            String? selectedOption;
            return Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Filter By",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: blackColor),
                  ),
                  RadioListTile(
                    title: const Text('Entertainment'),
                    value: 'Entertainment',
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Technology'),
                    value: 'Technology',
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('General'),
                    value: 'General',
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Science'),
                    value: 'Science',
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Sports'),
                    value: 'Sports',
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Health'),
                    value: 'Health',
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value!;
                      });
                    },
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context, selectedOption);
                        _newsProvider
                            .filterCategory(_selectedValue ?? 'Business');
                      },
                      child: const Text(
                        'Apply Filter',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: buttonTextColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((selectedOption) {
      if (selectedOption != null) {
        print('Selected option: $selectedOption');
      }
    });
  }
}
