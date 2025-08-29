import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:four_words_game/features/history/presentation/ui/heart_particles.dart';

class EndOfGameScreen extends StatelessWidget {
  const EndOfGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(253, 251, 234, 1),
      // appBar: AppBar(backgroundColor: Color.fromRGBO(253, 251, 234, 1)),
      body: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/svg/super_thank_you.svg', height: MediaQuery.of(context).size.height * 0.3),
                const SizedBox(height: 32),
                Text("Congratulations!", style: Theme.of(context).textTheme.displaySmall),
                Text("You've completed all the words.", style: Theme.of(context).textTheme.titleLarge),
                Text("Thank you so much for playing <3", style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
          HeartParticles(),
        ],
      ),
    );
  }
}
