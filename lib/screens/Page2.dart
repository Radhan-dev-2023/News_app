import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/widgets/spacing.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import 'news_detailed.dart';
import 'news_provider.dart';


class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  late NewsProvider _newsProvider;
  @override
  void initState() {
    super.initState();
    _newsProvider=NewsProvider();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _newsProvider.fetchTechCrunch();
    });
  }

  @override
  Widget build(BuildContext context) {
  /*  final newsProvider = Provider.of<NewsProvider>(context);*/

    return ChangeNotifierProvider.value(value: _newsProvider,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              mediumSpacing(context, 0.05),
               Text(
                "Explore News,",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600,color: blueGrey),
              ),

              mediumSpacing(context, 0.009),
              Consumer(builder:  (BuildContext context, NewsProvider newsProvider, _){
                return Expanded(
                  child: newsProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : newsProvider.errorMessage != null
                      ? Center(child: Text(newsProvider.errorMessage!,style:  const TextStyle(fontWeight: FontWeight.bold,color: appColor,fontSize: 22),))
                      : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: newsProvider.albumTechCrunch?.articles.length ?? 0,
                    itemBuilder: (context, index) {
                      final article = newsProvider.albumTechCrunch?.articles[index];
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsDetailedScreen(
                                album: article,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                article?.urlToImage ??
                                    'https://cdn.vectorstock.com/i/500p/82/99/no-image-available-like-missing-picture-vector-43938299.jpg',
                                width:
                                MediaQuery.of(context).size.width * 0.9,
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
                                "Source From : ${article?.source.id ?? 'local workspace.'.toUpperCase()}",
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Published At: ${DateFormat('dd/MM/yyyy').format((article!.publishedAt))}",
                                  ),
                                ],
                              ),
                              /*  Text(article.publishedAt.toIso8601String()??"",),*/
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
              },

              ),
            ],
          ),
        ),
      ),
    );
  }
}
