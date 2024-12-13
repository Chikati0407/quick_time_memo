import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:time_memo_app/pages/task_page.dart';
import 'package:url_launcher/url_launcher.dart';

Future<List<Widget>> create_url_suggest(String content) async {

  final urlRegExp = RegExp(
      r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?"
  );
  final urlMatchs = urlRegExp.allMatches(content);

  if (urlMatchs.isEmpty) {
    return [];
  } else {
    final chipList = <Widget>[];
    var rem_text = content;

    for (final regExpMatch in urlMatchs) {
      final url = content.substring(regExpMatch.start, regExpMatch.end);
      final index = rem_text.indexOf(url);

      if (index != 0) {
        rem_text = rem_text.substring(index);
      }

      chipList.add(
        await CustomInputChip(rem_text.substring(0,url.length)),
      );

      rem_text = rem_text.substring(url.length);
    }

    return Future.value(chipList);
  }



}

Future<Widget> CustomInputChip(String url_text) async {

  String title;

  try{
    Response response = await get(Uri.parse(url_text));
    var resp_text = parse(utf8.decode(response.bodyBytes));
    title = resp_text.head!.getElementsByTagName("title")[0].innerHtml;

  } catch (e) {
    title = "エラー";
  }



  return Animate(
    effects: const [
      ScaleEffect(
        duration: Duration(milliseconds: 50),
      ),
      FadeEffect(),
    ],
    child: Container(
      constraints: const BoxConstraints(
        maxWidth: 150
      ),
      child: Tooltip(
        message: title,
        child: InputChip(
          label: Text(title,overflow: TextOverflow.ellipsis,),
          onPressed: (){
            launchUrl(
                Uri.parse(url_text),
                mode: LaunchMode.platformDefault,
                webOnlyWindowName: "_blank"
            );
          },
        ),
      ),
    ),
  );
}
