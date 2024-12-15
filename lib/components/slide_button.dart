import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

class SlideToActWidget extends StatelessWidget {
  const SlideToActWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final GlobalKey<SlideActionState> key = GlobalKey();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SlideAction(
            textColor: Colors.black,
            innerColor: Colors.white,
            outerColor: Colors.amber[700],
            sliderButtonIcon: const Icon(
              Icons.arrow_forward,
              color: Colors.black,
            ),
            key: key,
            onSubmit: () {
              Future.delayed(
                const Duration(seconds: 1),
                    () => key.currentState!.reset(),
              );
              return null;
            },
          ),
        );
      },
    );
  }
}
