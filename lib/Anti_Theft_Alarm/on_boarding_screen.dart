import 'package:antitheftalarm/Anti_Theft_Alarm/homepage.dart';
import 'package:antitheftalarm/controller/ad_manager.dart';
import 'package:antitheftalarm/theme/themecolors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themecolor.black,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 61.65, right: 43.75, top: 121.76),
              child: Image.asset('assets/images/app_icon.png'),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70, left: 35, right: 34),
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'We\'re thrilled to welcome to ',
                          style: TextStyle(
                            // fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Themecolor.white,
                          ),
                        ),
                        TextSpan(
                          text: 'Anti theft alarm',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.amber,
                          ),
                        ),
                        TextSpan(
                          text:
                              ',your ultimate companion in safeguarding your belongings and ensuring peace of mind wherever you go.',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Themecolor.white,
                          ),
                        )
                      ])),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding:
            const EdgeInsets.only(top: 65, left: 32, right: 32, bottom: 57),
        child: PrimaryButton(
          onTap: () {
            // Handle button tap
            _completeOnboarding();
          },
          text: 'Get Started',
          bgColor: Themecolor.primary,
          borderRadius: 8,
          height: 48,
          width: 326,
          textColor: Themecolor.white,
        ),
      ),
    );
  }

  Future<void> _completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);
    AdManager.showInterstitialAdOnSplash(
        onComplete: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Homepage()),
          );
        },
        context: context);
  }
}

class PrimaryButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? fontSize;
  final IconData? iconData;
  final Color? textColor, bgColor;
  const PrimaryButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.width,
    this.height,
    this.borderRadius,
    this.fontSize,
    required this.textColor,
    required this.bgColor,
    this.iconData,
  }) : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _tween.animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        ),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
          ),
          child: Container(
            height: widget.height ?? 55,
            alignment: Alignment.center,
            width: widget.width ?? double.maxFinite,
            decoration: BoxDecoration(
              color: widget.bgColor,
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.iconData != null) ...[
                  Icon(
                    widget.iconData,
                    color: widget.textColor,
                  ),
                  const SizedBox(width: 4),
                ],
                Text(
                  widget.text,
                  style: TextStyle(
                    color: widget.textColor,
                    fontSize: widget.fontSize ?? 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Placeholder classes to make the code run



