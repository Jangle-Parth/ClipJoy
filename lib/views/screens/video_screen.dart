import 'package:clipjoy/views/widgets/circleanimation.dart';
import 'package:clipjoy/views/widgets/shorts_player.dart';
import 'package:flutter/material.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  buildProfile(String profilePhoto) {
    return SizedBox(
      width: 50,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profilePhoto),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Container(
        padding: const EdgeInsets.all(11),
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.grey, Colors.white],
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image(
            image: NetworkImage(profilePhoto),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 10,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  const ShortsPlayer(
                    videoUrl: '',
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 20),
                                child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "username",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Caption",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.music_note),
                                        Text(
                                          "Song name",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              margin: EdgeInsets.only(top: size.height / 5),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildProfile('String Url'),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.favorite,
                                          size: 40,
                                          color: Colors.red,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      const Text(
                                        "2200",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.comment,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      const Text(
                                        "2",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.reply,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      const Text(
                                        "2",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      )
                                    ],
                                  ),
                                  CircleAnimation(
                                    child: buildMusicAlbum("Profile Photo"),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              );
            }));
  }
}
