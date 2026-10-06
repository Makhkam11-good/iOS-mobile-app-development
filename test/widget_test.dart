import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_app1/main.dart';

void main() {
  testWidgets('product detail interactions work', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Nike Air Max 270'), findsOneWidget);
    expect(find.text('Add to Cart'), findsOneWidget);
    expect(find.byIcon(Icons.bookmark_border), findsOneWidget);

    await tester.tap(find.byIcon(Icons.bookmark_border));
    await tester.pump();
    expect(find.byIcon(Icons.bookmark), findsOneWidget);

    await tester.tap(find.text('Add to Cart'));
    await tester.pump();
    expect(find.text('Items in cart: 1'), findsOneWidget);
    expect(find.text('Product added to cart!'), findsOneWidget);
  });
}
