import 'package:flutter/material.dart';

class CommentScreen extends StatelessWidget {
  CommentScreen({super.key});

  final TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
          child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          backgroundImage: NetworkImage("Porfile Photo"),
                        ),
                        title: Row(children: [
                          Text(
                            'username',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Comment Description ',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ]),
                        subtitle: Row(
                          children: [
                            Text(
                              'Date',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '10 likes',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        trailing: InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.favorite,
                            size: 25,
                            color: Colors.red,
                          ),
                        ),
                      );
                    })),
            const Divider(),
            ListTile(
              title: TextFormField(
                controller: commentController,
                style: const TextStyle(fontSize: 16, color: Colors.white),
                decoration: const InputDecoration(
                    labelText: "Comment",
                    labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700)),
              ),
              trailing: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Send",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )),
            ),
          ],
        ),
      )),
    );
  }
}
