import 'package:cached_network_image/cached_network_image.dart';
import 'package:clipjoy/constants.dart';
import 'package:clipjoy/controller/profile_controller.dart';
import 'package:clipjoy/views/screens/home_screen.dart';
import 'package:clipjoy/views/widgets/shorts_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  @override
  void initState() {
    super.initState();
    profileController.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.user.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final List<String> thumbnails = controller.user['thumbnails'];
          final List<String> videos = controller.user['videos'];
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black12,
              leading: const Icon(Icons.person_add),
              actions: const [Icon(Icons.more_horiz)],
              title: Text(
                controller.user['name'] ?? 'Unknown',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            body: SafeArea(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: controller.user['profilePhoto'] ?? '',
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
                          Column(
                            children: [
                              Text(
                                  controller.user['following']?.toString() ??
                                      '0',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text('Following',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          Container(
                            color: Colors.black,
                            width: 1,
                            height: 15,
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                          ),
                          Column(
                            children: [
                              Text(
                                  controller.user['followers']?.toString() ??
                                      '0',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text('Followers',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          Container(
                            color: Colors.black,
                            width: 1,
                            height: 15,
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                          ),
                          Column(
                            children: [
                              Text(controller.user['likes'],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text('likes',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
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
                            onTap: () {
                              if (widget.uid == authController.user?.uid) {
                                authController.signOut();
                              } else {
                                controller.followUser();
                              }
                            },
                            child: Text(
                              widget.uid == authController.user?.uid
                                  ? "Sign Out"
                                  : controller.user['isFollowing'] == true
                                      ? 'Unfollow'
                                      : 'Follow',
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: thumbnails.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            String thumbnail = thumbnails[index];
                            String videoUrl = videos[index];
                            return GestureDetector(
                              onTap: () {
                                try {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ShortsPlayer(
                                            videoUrl: videoUrl,
                                          )));
                                } catch (e) {
                                  Get.snackbar(
                                      "Failed Fetching video", e.toString());
                                }
                              },
                              child: CachedNetworkImage(
                                imageUrl: thumbnail,
                                fit: BoxFit.cover,
                              ),
                            );
                          })
                    ],
                  )
                ],
              ),
            )),
          );
        });
  }
}
