import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:four_words_game/core/extensions/context_x.dart';
import 'package:four_words_game/core/ui/heart_particles.dart';

class EndOfGameScreen extends StatelessWidget {
  final VoidCallback onPop;

  const EndOfGameScreen({super.key, required this.onPop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/svg/super_thank_you.svg', height: MediaQuery.of(context).size.height * 0.3),
                const SizedBox(height: 16),
                Text("Congratulations!", style: context.textTheme.displaySmall),
                Text(
                  "You've completed all the words.",
                  style: context.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Thank you so much for playing <3",
                  style: context.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                ElevatedButton(onPressed: onPop, child: const Text('Back to Menu')),
              ],
            ),
          ),
          const IgnorePointer(child: HeartParticles()),
        ],
      ),
    );
  }
}
