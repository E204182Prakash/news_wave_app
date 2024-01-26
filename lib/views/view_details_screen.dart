import 'package:flutter/material.dart';
import '../model/news_model.dart';

class ViewDetailsScreen extends StatelessWidget {
  final Article? news;

  const ViewDetailsScreen({Key? key, this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Full View'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(news?.urlToImage ?? ""),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              news?.title ?? "",
              style:
              const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Author: ${news?.author ?? ""}',
              style: const TextStyle(
                  fontSize: 16.0, color: Colors.deepPurpleAccent),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Published At: ${news?.publishedAt ?? ""}',
              style: const TextStyle(fontSize: 16.0, color: Colors.indigo),
            ),
            const SizedBox(height: 20.0),
            Text(
              news?.description ?? "",
              style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Read More: ${news?.url ?? ""}',
              style: const TextStyle(fontSize: 10.0, color: Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }
}
