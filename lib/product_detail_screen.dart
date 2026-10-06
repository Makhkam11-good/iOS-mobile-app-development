import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Preview'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: ColoredBox(
                      color: Color(0xfff2f4f7),
                      child: Image(
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1542291026-7eec264c27ff',
                        ),
                        fit: BoxFit.contain,
                        errorBuilder: _imageErrorBuilder,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _imageErrorBuilder(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return const Center(
      child: Icon(
        Icons.image_not_supported_outlined,
        size: 72,
        color: Colors.grey,
      ),
    );
  }
}