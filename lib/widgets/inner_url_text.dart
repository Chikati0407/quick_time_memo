// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class InnerUrlText extends ConsumerWidget {
  const InnerUrlText({super.key, required this.text, this.style, this.maxLines});

  final String text;
  final TextStyle? style;
  final int? maxLines;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final urlRegExp = RegExp(
      r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?"
    );
    final urlMatchs = urlRegExp.allMatches(text);


    if (urlMatchs.isEmpty) {
      return SelectableText(
        text,
        style: style,
        maxLines: maxLines,

      );
    } else {
      final textSpanList = <TextSpan>[];
      var remainingText = text;

      for (final regExpMatch in urlMatchs) {
        final url = text.substring(regExpMatch.start, regExpMatch.end);
        final index = remainingText.indexOf(url);

        if (index != 0) {
          textSpanList.add(
            CustomTextSpan.normalTextSpan(remainingText.substring(0, index), style, context)
          );
          remainingText = remainingText.substring(index);
        }

        textSpanList.add(
          CustomTextSpan.urlTextSpan(remainingText.substring(0,url.length), style, context)
        );
        remainingText = remainingText.substring(url.length);
      }

      if (remainingText.isNotEmpty) {
        textSpanList.add(CustomTextSpan.normalTextSpan(remainingText, style, context));
      }

      return SelectableText.rich(
        TextSpan(
          children: textSpanList
        ),
        maxLines: maxLines,
      );
    }

  }
}


class CustomTextSpan {
  const CustomTextSpan();



  static TextSpan urlTextSpan(String text,TextStyle? style, BuildContext context) {
    // return WidgetSpan(
    //   child: GestureDetector(
    //     onTap: (){
    //       launchUrl(Uri.parse(text));
    //     },
    //     onLongPress: (){
    //       launchUrl(Uri.parse(text));
    //     },
    //   )
    // );
    return TextSpan(
      text: text,
      style: TextStyle(
        fontSize: style?.fontSize,
        color: Theme.of(context).colorScheme.primary,
        decoration: TextDecoration.underline,
      ),
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          launchUrl(
            Uri.parse(text),
            mode: LaunchMode.platformDefault,
            webOnlyWindowName: "_blank"
          );
        },
    );
  }

  static TextSpan normalTextSpan(String text,TextStyle? style, BuildContext context) {
    return TextSpan(
      text: text,
      style: style
    );
  }
}
