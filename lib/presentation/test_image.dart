import 'package:flutter/material.dart';

class TestImageNet extends StatefulWidget {
  const TestImageNet({Key? key}) : super(key: key);

  @override
  State<TestImageNet> createState() => _TestImageNetState();
}

class _TestImageNetState extends State<TestImageNet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: 300,
        width: 300,
        color: Colors.black,
        child: const Image(
          image: NetworkImage(
              'https://styles.redditmedia.com/t5_b5dpm/styles/profileIcon_snoo16441972-337e-4afd-bd2c-e69f9e6ab5df-headshot-f.png?width=256&amp;height=256&amp;crop=256:256,smart&amp;s=df4661b2d35140c4ed53353204771eb93973d038.jpg'),
        ),
      ),
    );
  }
}
