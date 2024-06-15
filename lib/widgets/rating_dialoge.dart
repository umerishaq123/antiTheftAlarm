import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

class RatingDialog extends StatelessWidget {
  final String appStoreUrl =
      'https://play.google.com/store/apps/details?id=com.ginnie.dont.touch.phone.antitheft';
  final String feedbackEmail = 'feedback@yourapp.com';
  final String feedbackSubject = 'App Feedback';

  void _rateApp(BuildContext context, double rating) {
    Navigator.of(context).pop();
    if (rating >= 4) {
      _launchURL(appStoreUrl, context);
    } else {
      _sendFeedbackEmail(context);
    }
  }

  Future<void> _launchURL(String url, BuildContext context) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _showErrorDialog(context, 'Could not launch $url');
    }
  }

  // Future<void> _sendEmail(BuildContext context) async {
  //   final Uri params = Uri(
  //     scheme: 'mailto',
  //     path: feedbackEmail,
  //     query: 'subject=$feedbackSubject', // add subject and body here
  //   );

  //   String url = params.toString();
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     _showErrorDialog(context, 'Could not launch email client');
  //   }
  // }
  Future<void> _sendFeedbackEmail(BuildContext context) async {
  final mailtoLink = Mailto(
    to: ['to@example.com'],
    cc: ['cc1@example.com', 'cc2@example.com'],
    subject: 'mailto example subject',
    body: 'mailto example body',
  );
  // Convert the Mailto instance into a string.
  // Use either Dart's string interpolation
  // or the toString() method.
  await launch('$mailtoLink');
}



  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Rate our app'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Please rate the app.'),
          SizedBox(height: 16.0),
          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              _rateApp(context, rating);
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

void showRatingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => RatingDialog(),
  );
}
