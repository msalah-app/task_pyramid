import 'package:flutter/material.dart';

import '../../../../core/constant/constant.dart';

class LazyLoading extends StatefulWidget {
  const LazyLoading({Key? key}) : super(key: key);

  @override
  _LazyLoadingState createState() => _LazyLoadingState();
}

class _LazyLoadingState extends State<LazyLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Color?> animationColor1;
  late Animation<Color?> animationColor2;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    animationColor1 = ColorTween(
            begin: const Color(0xffCA252B),
            end: Constant.background) //Color(0xffC0C0C0)
        .animate(controller);
    animationColor2 =
        ColorTween(end: const Color(0xffCA252B), begin: Constant.background)
            .animate(controller);
    controller.forward();
    controller.addListener(() {
      if (controller.status == AnimationStatus.completed) {
        controller.reverse();
      } else if (controller.status == AnimationStatus.dismissed) {
        controller.forward();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
                colors: [animationColor1.value!, animationColor2.value!])
            .createShader(rect);
      },
      child: const LoadingUnit(
        hight: 233,
      ),
    ));
  }
}

class LoadingUnit extends StatelessWidget {
  const LoadingUnit({
    Key? key,
    required this.hight,
  }) : super(key: key);
  final double hight;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Constant.kPaddingA2,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            height: hight,
          ),
        ],
      ),
    );
  }
}
