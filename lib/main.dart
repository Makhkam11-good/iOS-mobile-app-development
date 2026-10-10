import 'package:flutter/material.dart';

void main() {
  runApp(const ProductPreviewApp());
}

class ProductPreviewApp extends StatelessWidget {
  const ProductPreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LAB 5 Product Preview',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00A7B5),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFAFAF7),
        useMaterial3: true,
      ),
      home: const ProductDetailScreen(),
    );
  }
}

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isBookmarked = false;
  int cartCount = 0;
  int selectedColor = 0;
  int selectedStorage = 1;

  final List<Color> colors = const [
    Color(0xFF202124),
    Color(0xFFE7D2B5),
    Color(0xFF87C7D4),
  ];

  final List<String> storageOptions = const ['128', '256', '512'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _StickyActionBar(
        cartCount: cartCount,
        onPressed: () {
          setState(() {
            cartCount++;
          });
        },
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 820;

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                wide ? 32 : 16,
                18,
                wide ? 32 : 16,
                26,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1080),
                  child: wide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 5,
                              child: _HeroGallery(
                                isBookmarked: isBookmarked,
                                onBookmark: _toggleBookmark,
                              ),
                            ),
                            const SizedBox(width: 30),
                            Expanded(
                              flex: 4,
                              child: _ProductPanel(
                                selectedColor: selectedColor,
                                colors: colors,
                                storageOptions: storageOptions,
                                selectedStorage: selectedStorage,
                                onColorChanged: _selectColor,
                                onStorageChanged: _selectStorage,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _HeroGallery(
                              isBookmarked: isBookmarked,
                              onBookmark: _toggleBookmark,
                            ),
                            const SizedBox(height: 22),
                            _ProductPanel(
                              selectedColor: selectedColor,
                              colors: colors,
                              storageOptions: storageOptions,
                              selectedStorage: selectedStorage,
                              onColorChanged: _selectColor,
                              onStorageChanged: _selectStorage,
                            ),
                          ],
                        ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  void _selectColor(int index) {
    setState(() {
      selectedColor = index;
    });
  }

  void _selectStorage(int index) {
    setState(() {
      selectedStorage = index;
    });
  }
}

class _HeroGallery extends StatelessWidget {
  const _HeroGallery({required this.isBookmarked, required this.onBookmark});

  final bool isBookmarked;
  final VoidCallback onBookmark;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: MediaQuery.sizeOf(context).width >= 820 ? 4 / 5 : 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          fit: StackFit.expand,
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFFF2D7),
                    Color(0xFFEAF8F9),
                    Color(0xFF111827),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(28, 44, 28, 28),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?auto=format&fit=crop&w=1200&q=80',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    errorBuilder: (context, error, stackTrace) {
                      return const ColoredBox(
                        color: Color(0xFF111827),
                        child: Icon(
                          Icons.phone_iphone,
                          size: 96,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              left: 18,
              top: 18,
              child: _GlassLabel(
                icon: Icons.auto_awesome,
                text: 'Concept model',
              ),
            ),
            Positioned(
              right: 18,
              top: 18,
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                child: IconButton(
                  tooltip: 'Bookmark',
                  onPressed: onBookmark,
                  icon: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: const Color(0xFF111827),
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 18,
              right: 18,
              bottom: 18,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _GlassLabel(icon: Icons.camera_alt_outlined, text: '48 MP'),
                  _GlassLabel(icon: Icons.bolt_outlined, text: 'A20 Pro'),
                  _GlassLabel(icon: Icons.battery_6_bar, text: '31h'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductPanel extends StatelessWidget {
  const _ProductPanel({
    required this.selectedColor,
    required this.colors,
    required this.storageOptions,
    required this.selectedStorage,
    required this.onColorChanged,
    required this.onStorageChanged,
  });

  final int selectedColor;
  final List<Color> colors;
  final List<String> storageOptions;
  final int selectedStorage;
  final ValueChanged<int> onColorChanged;
  final ValueChanged<int> onStorageChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'NOVA MARKET',
          style: TextStyle(
            color: Color(0xFF00A7B5),
            fontWeight: FontWeight.w900,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                'iPhone 18 Pro',
                style: textTheme.headlineLarge?.copyWith(
                  color: const Color(0xFF111827),
                  fontWeight: FontWeight.w900,
                  height: 1.02,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Text(
              '\$1,199',
              style: textTheme.headlineSmall?.copyWith(
                color: const Color(0xFFE85D3F),
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Row(
          children: [
            Icon(Icons.star_rounded, color: Color(0xFFFFB000), size: 22),
            Icon(Icons.star_rounded, color: Color(0xFFFFB000), size: 22),
            Icon(Icons.star_rounded, color: Color(0xFFFFB000), size: 22),
            Icon(Icons.star_rounded, color: Color(0xFFFFB000), size: 22),
            Icon(Icons.star_half_rounded, color: Color(0xFFFFB000), size: 22),
            SizedBox(width: 8),
            Flexible(
              child: Text(
                '4.9 from 2.4k reviews',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        const Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _Tag(label: 'Satellite SOS'),
            _Tag(label: 'Pro Camera'),
            _Tag(label: 'Titanium'),
            _Tag(label: 'USB-C'),
          ],
        ),
        const SizedBox(height: 22),
        Text(
          'A cleaner flagship concept for students who want fast performance, a bright display, and a camera system ready for videos, notes, and everyday work.',
          style: textTheme.bodyLarge?.copyWith(
            color: const Color(0xFF4B5563),
            height: 1.45,
          ),
        ),
        const SizedBox(height: 24),
        _SectionTitle(text: 'Finish'),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (var i = 0; i < colors.length; i++)
              _ColorChoice(
                color: colors[i],
                isSelected: selectedColor == i,
                onTap: () => onColorChanged(i),
              ),
          ],
        ),
        const SizedBox(height: 24),
        _SectionTitle(text: 'Storage'),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (var i = 0; i < storageOptions.length; i++)
              ChoiceChip(
                selected: selectedStorage == i,
                label: Text('${storageOptions[i]} GB'),
                onSelected: (_) => onStorageChanged(i),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _StickyActionBar extends StatelessWidget {
  const _StickyActionBar({required this.cartCount, required this.onPressed});

  final int cartCount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Row(
        children: [
          Expanded(
            child: FilledButton.icon(
              onPressed: onPressed,
              icon: const Icon(Icons.shopping_bag_outlined),
              label: Text(cartCount == 0 ? 'Add to Cart' : 'Cart: $cartCount'),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF111827),
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassLabel extends StatelessWidget {
  const _GlassLabel({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: const Color(0xFF111827)),
            const SizedBox(width: 6),
            Text(
              text,
              style: const TextStyle(
                color: Color(0xFF111827),
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFFFF2D7),
        border: Border.all(color: const Color(0xFFFFD36D)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF7A4A00),
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF111827),
        fontSize: 16,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

class _ColorChoice extends StatelessWidget {
  const _ColorChoice({
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        width: 52,
        height: 42,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFFE85D3F) : Colors.transparent,
            width: 3,
          ),
        ),
        child: isSelected
            ? const Icon(Icons.check_rounded, color: Colors.white)
            : null,
      ),
    );
  }
}
