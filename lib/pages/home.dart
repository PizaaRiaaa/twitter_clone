import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/models/tweet.dart';
import 'package:twitter_clone/pages/create_tweet.dart';
import 'package:twitter_clone/pages/settings.dart';
import 'package:twitter_clone/provider/tweet_provider.dart';
import 'package:twitter_clone/provider/user_provider.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LocalUser currentUser = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.grey,
            height: 1,
          ),
        ),
        title: const Image(
          image: AssetImage("assets/twitter_blue.png"),
          width: 50,
        ),
        leading: Builder(builder: (context) {
          return GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(currentUser.user.profilePic),
              ),
            ),
          );
        }),
      ),
      body: ref.watch(feedProvider).when(
          data: (List<Tweet> tweets) {
            return ListView.separated(
                separatorBuilder: (context, count) => const Divider(
                      color: Colors.black,
                    ),
                itemCount: tweets.length,
                itemBuilder: (context, count) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(tweets[count].profilePic),
                    ),
                    title: Text(
                      tweets[count].name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      tweets[count].tweet,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  );
                });
          },
          error: (error, stackTrace) => const Center(
                child: Text("error"),
              ),
          loading: () {
            return const CircularProgressIndicator();
          }),
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Image.network(
              currentUser.user.profilePic,
            ),
            ListTile(
              title: Text(
                "Hello, ${currentUser.user.name}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Settings()));
              },
              title: const Text(
                "Settings",
              ),
            ),
            ListTile(
              key: const ValueKey("signOut"),
              onTap: () {
                FirebaseAuth.instance.signOut();
                ref.read(userProvider.notifier).logout();
              },
              title: const Text(
                "Sign Out",
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CreatTweet()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
