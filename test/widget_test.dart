import 'package:flutter_test/flutter_test.dart';
import 'package:lab5_product_preview/main.dart';

void main() {
  testWidgets('LAB 5 product preview renders core content', (tester) async {
    await tester.pumpWidget(const ProductPreviewApp());

    expect(find.text('iPhone 18 Pro'), findsOneWidget);
    expect(find.text('\$1,199'), findsOneWidget);
    expect(find.text('NOVA MARKET'), findsOneWidget);
    expect(find.text('Satellite SOS'), findsOneWidget);
    expect(find.text('Add to Cart'), findsOneWidget);
  });
}
