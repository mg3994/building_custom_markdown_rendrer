import 'package:flutter_markdown_selectionarea/flutter_markdown.dart'
    as renderer;
import 'package:markdown/markdown.dart' as markdown;

class FadeSyntax extends markdown.InlineSyntax {
  FadeSyntax()
      : super(
            r'''<span(?:.*?)data-color=['"]rgb *\((?: *([0-9]{1,3}))[, ]+(?: *([0-9]{1,3}))[, ]+(?: *([0-9]{1,3}))[, ]*\)['"](?:.*?)>([^<]*?)</span>''');

  @override
  bool onMatch(markdown.InlineParser parser, Match match) {
      markdown.Element fadeElement  =
          markdown.Element.text('fadein', match.group(4) ?? "matched text");
     fadeElement .attributes["fontColorRed"] = match.group(1) ?? "0";
      fadeElement .attributes["fontColorGreen"] = match.group(2) ?? "0";
      fadeElement .attributes["fontColorBlue"] = match.group(3) ?? "0";
      parser.addNode(fadeElement );
      return true;

    // // Create a new HTML-like element for fading
    // final fadeElement = markdown.Element('fadein',
    //     [markdown.Element.text('span', match.group(4) ?? "matched text")]);

    // // Set attributes for the fade effect
    // fadeElement.attributes["style"] =
    //     'opacity: 0; transition: opacity 2s; color: rgb(${match.group(1)}, ${match.group(2)}, ${match.group(3)})';

    // // JavaScript for triggering fade-in on load
    // fadeElement.attributes["onLoad"] = "this.style.opacity=1;";

    // parser.addNode(fadeElement);
    // return true;
  }
}
