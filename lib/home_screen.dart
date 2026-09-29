import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'categories.dart';
import 'furniture_page.dart';
import 'outfits_screen.dart';
import 'providers.dart';
import 'weather_log_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final PickConfig? pick;
  const HomeScreen({super.key, this.pick});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pick = widget.pick;
    final furnitures = ref.watch(furnituresProvider).value ?? [];
    final editing = ref.watch(editModeProvider) && pick == null;
    final selected = ref.watch(pickSelectionProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            if (pick != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(pick.title,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 18)),
                  ],
                ),
              ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                physics: editing
                    ? const NeverScrollableScrollPhysics()
                    : const BouncingScrollPhysics(),
                itemCount: furnitures.length,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (_, i) =>
                    FurniturePage(furniture: furnitures[i], pick: pick),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                furnitures.length,
                (i) => Container(
                  margin: const EdgeInsets.all(4),
                  width: i == _page ? 18 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: i == _page ? Colors.white : Colors.white38,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: pick == null
                  ? Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const OutfitsScreen())),
                            child: const Text('Kombinler'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FilledButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const WeatherLogScreen())),
                            child: const Text('Havaya göre'),
                          ),
                        ),
                      ],
                    )
                  : pick.single
                      ? const Text(
                          'Bir alana, sonra kıyafete dokun',
                          style: TextStyle(color: Colors.white70),
                        )
                      : SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () => Navigator.pop(context,
                                ref.read(pickSelectionProvider).toList()),
                            child: Text('Bitti (${selected.length})'),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}