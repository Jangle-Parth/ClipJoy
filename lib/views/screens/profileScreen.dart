import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String? uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        leading: const Icon(Icons.person_add),
        actions: const [Icon(Icons.more_horiz)],
        title: const Text(
          "Username",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: 'http://via.placeholder.com/350x150',
                    height: 100,
                    width: 100,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Column(
                  children: [
                    Text('10',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 5,
                    ),
                    Text('following',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))
                  ],
                ),
                Container(
                  color: Colors.black,
                  width: 1,
                  height: 15,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                ),
                const Column(
                  children: [
                    Text('10',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 5,
                    ),
                    Text('followers',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))
                  ],
                ),
                Container(
                  color: Colors.black,
                  width: 1,
                  height: 15,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                ),
                const Column(
                  children: [
                    Text('10',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 5,
                    ),
                    Text('likes',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: 140,
              height: 47,
              decoration: const BoxDecoration(color: Colors.black12),
              child: Center(
                child: InkWell(
                    onTap: () {},
                    child: const Text(
                      "Sign Out",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
              ),
            )
          ])
        ],
      )),
    );
  }
}
