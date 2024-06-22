import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/constants/colors.dart';
import 'package:news_app/model/model.dart';

import 'package:news_app/widgets/rich_text.dart';
import 'package:news_app/widgets/spacing.dart';
import 'package:provider/provider.dart';


import 'news_provider.dart';

class NewsDetailedScreen extends StatefulWidget {
  final Article album;

  const NewsDetailedScreen({super.key, required this.album});

  @override
  State<NewsDetailedScreen> createState() => _NewsDetailedScreenState();
}

class _NewsDetailedScreenState extends State<NewsDetailedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: appColor,
        title: const Text(
          "News Details",
          style: TextStyle(fontWeight: FontWeight.bold, color: buttonTextColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              mediumSpacing(context, 0.09),
              Stack(children: [
                Image.network(
                  widget.album.urlToImage ??
                      'https://cdn.vectorstock.com/i/500p/82/99/no-image-available-like-missing-picture-vector-43938299.jpg',
                  width: MediaQuery.of(context).size.width * 0.9,
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon:  Icon(
                        Icons.favorite_outline,
                        color: red,
                        size: 32,
                      ),
                      onPressed: () {
                        Provider.of<NewsProvider>(context, listen: false)
                            .addToWishlist(context,widget.album);
                      },
                    ))
              ]),
              mediumSpacing(context, 0.03),
              Text(
                widget.album.title.toUpperCase(),
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: appColor),
              ),
              mediumSpacing(context, 0.03),
              CustomRichText(
                  boldText: 'Source: ',
                  italicText: widget.album.source.name,
                  italicTextColor: red),
              mediumSpacing(context, 0.03),
              Text(
                widget.album.description,
                style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: blueGrey),
              ),
              mediumSpacing(context, 0.03),
              CustomRichText(
                  boldText: 'Author: ',
                  italicText: widget.album.author,
                  italicTextColor: orange),
              mediumSpacing(context, 0.03),
              Text(
                '${widget.album.content}',
                style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: green),
              ),
              mediumSpacing(context, 0.03),

              CustomRichText(
                  boldText: 'Link to Original Article :\n\n',
                  italicText: widget.album.url,
                  italicTextColor: linkColor),
              mediumSpacing(context, 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Published At: ${DateFormat('dd/MM/yyyy').format((widget.album.publishedAt))}",
                    style:  TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: grey),
                  ),
                ],
              ),
              mediumSpacing(context, 0.01),
              const Divider(
                color: blackColor,
                height: 20,
              ),
              mediumSpacing(context, 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
