import 'package:markdown/markdown.dart';

class FadeBlockSyntax extends BlockSyntax {
  @override
  RegExp get pattern => RegExp(
        r'''<span(?:.*?)data-color=['"]rgb *\((?: *([0-9]{1,3}))[, ]+(?: *([0-9]{1,3}))[, ]+(?: *([0-9]{1,3}))[, ]*\)['"](?:.*?)>([^<]*?)</span>''',
      );
  @override
  List<Line> parseChildLines(BlockParser parser) {
    final m = pattern.firstMatch(parser.current.content);
    if (m?[4] != null) {
      parser.advance();
      return [Line(m?[4] ?? '')];
    }

    final childLines = <Line>[];
    parser.advance();

    while (!parser.isDone) {
      final match = pattern.hasMatch(parser.current.content);
      if (!match) {
        childLines.add(parser.current);
        parser.advance();
      } else {
        parser.advance();
        break;
      }
    }

    return childLines;
  }

  @override
  Node parse(BlockParser parser) {
    final lines = parseChildLines(parser);
    final content = lines.map((e) => e.content).join('\n').trim();
    final textElement = Element.text('fadein', content);
    // textElement.attributes['MathStyle'] = 'display';

    return Element('p', [textElement]);
  }
}
