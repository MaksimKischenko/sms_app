
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sms_app/styles.dart';

class ActionButton extends StatelessWidget {

  final String name;
  final List<Color> buttonGradientColors;
  final Function() onTap;
  final SizingInformation sizingInformation;

 
  const ActionButton({
    Key? key,
    required this.name,
    required this.buttonGradientColors,
    required this.onTap,
    required this.sizingInformation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double width  = sizingInformation.screenSize.width;
    double height = sizingInformation.screenSize.height;
    bool isWideScreen = height  < width;

    return Ink(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(8), 
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: buttonGradientColors
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.8), blurRadius: 8),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: width,
          padding: EdgeInsets.symmetric(vertical: isWideScreen? (sizingInformation.isMobile? 20 : 40) : 20),
          child: DefaultTextStyle(
            style: isWideScreen? AppStyles.buttonTextStyleWidthScreen: 
             AppStyles.buttonTextStyle, textAlign: TextAlign.center,
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                WavyAnimatedText(name.toUpperCase())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
