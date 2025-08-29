import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EndOfGameView extends StatelessWidget {
  const EndOfGameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(253, 251, 234, 1),
      appBar: AppBar(backgroundColor: Color.fromRGBO(253, 251, 234, 1)),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text("Congratulations!", style: Theme.of(context).textTheme.displaySmall),
              Text("You've completed all the words.", style: Theme.of(context).textTheme.titleLarge),
              // SvgPicture.asset(assetName)
              // Text("Thank you so much for playing <3"),
            ],
          ),
        ),
      ),
    );
  }
}
