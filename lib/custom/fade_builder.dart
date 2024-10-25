import 'package:flutter/material.dart';
import 'package:flutter_markdown_selectionarea/flutter_markdown.dart'
    as renderer;
import 'package:flutter_markdown_selectionarea/flutter_markdown_selectionarea.dart';
import 'package:markdown/markdown.dart' as markdown;

import 'fade_in.dart';

class FadeBuilder extends renderer.MarkdownElementBuilder {
  @override
  Widget visitElementAfter(element, preferredStyle) {
    // Widget? visitText(markdown.Text element, TextStyle? preferredStyle) {
    // We don't currently have a way to control the vertical alignment of text spans.
    // See https://github.com/flutter/flutter/issues/10906#issuecomment-385723664

    final red = getColor(element, "Red");
    final green = getColor(element, "Green");
    final blue = getColor(element, "Blue");

    return FadeIn(
      key: ValueKey(element.textContent),
      child: SelectionArea(
        child: MarkdownBody(
          data: element.textContent,
          styleSheet: renderer.MarkdownStyleSheet(
            p: TextStyle(
              color: Color.fromRGBO(red, green, blue, 1),
            ),
          ),
        ),
      ),
    );
  }

  int getColor(markdown.Element el, String color) =>
      int.tryParse(el.attributes["fontColor$color"] ?? "0") ?? 0;
}
