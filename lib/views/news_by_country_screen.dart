import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/news_provider.dart';

class NewsCatByCountry extends StatefulWidget {
  const NewsCatByCountry({Key? key}) : super(key: key);

  @override
  State<NewsCatByCountry> createState() => _NewsCatByCountryState();
}

class _NewsCatByCountryState extends State<NewsCatByCountry> {

  final List<String> countries = ['au', 'in', 'gb', 'cn'];

  @override
  void initState() {
    Provider.of<NewsProvider>(context, listen: false)
        .fetchNewsByCountry(countries.first);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category By Country'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade200,
      ),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          if (newsProvider.news == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: [
                Container(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: countries.length,
                    itemBuilder: (context, index) {
                      final country = countries[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Fetch news for the selected country
                            Provider.of<NewsProvider>(context, listen: false)
                                .fetchNewsByCountry(country);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            newsProvider.selectedCountry == country
                                ? Colors.lightBlueAccent
                                : Colors.white,
                          ),
                          child: Text(country),
                        ),
                      );
                    },
                  ),
                ),
                // News article list
                Expanded(
                  child: ListView.builder(
                    itemCount: newsProvider.news?.articles.length,
                    itemBuilder: (context, int index) {
                      return Card(
                        elevation: 5,
                        margin: const EdgeInsets.all(20.0),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Image.network(
                                  newsProvider.news?.articles
                                      .elementAt(index)
                                      .urlToImage ??
                                      "",
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        newsProvider.news?.articles
                                            .elementAt(index)
                                            .title ??
                                            "",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        newsProvider.news?.articles
                                            .elementAt(index)
                                            .description ??
                                            "",
                                        style: const TextStyle(
                                          color: Colors.blue,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
