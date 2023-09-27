import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/provider/tweet_provider.dart';

class CreatTweet extends ConsumerWidget {
  const CreatTweet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController tweetController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Tweet"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 4,
                maxLength: 240,
                controller: tweetController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                ref.read(tweetProvider).postTweet(tweetController.text);
                Navigator.pop(context);
              },
              child: const Text("Post Tweet"),
            ),
          ],
        ),
      ),
    );
  }
}
