import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/models/category_model.dart';
import '../controllers/home_controller.dart';
import '../../../widgets/category_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 🔹 Bagian Header
          SliverAppBar(
            pinned: true,
            expandedHeight: 160,
            elevation: 0,
            backgroundColor: cs.surface,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: _Header(cs: cs),
              titlePadding: const EdgeInsetsDirectional.only(
                start: 16,
                bottom: 14,
                end: 16,
              ),
              title: Text(
                'Catalogue E-BOOK',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
            ),
            actions: [
              IconButton(
                tooltip: 'Tentang Mitra',
                icon: const Icon(Icons.info_outline),
                onPressed: () => controller.toAbout(),
              ),
            ],
          ),

          // 🔹 Grid kategori (UI lama kamu)
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            sliver: SliverLayoutBuilder(
              builder: (context, constraints) {
                final w = constraints.crossAxisExtent;
                final cross = w < 500 ? 2 : (w < 900 ? 3 : 4);
                return Obx(() {
                  return SliverGrid.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: cross,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: controller.categories.length,
                    itemBuilder: (context, i) {
                      final c = controller.categories[i];
                      return Hero(
                        tag: 'cat-${c.name}',
                        flightShuttleBuilder:
                            (ctx, anim, dir, from, to) => to.widget,
                        child: CategoryCard(
                          category: c,
                          onTap: () => controller.openUrl(c),
                        ),
                      );
                    },
                  );
                });
              },
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Eksperimen HTTP vs Dio",
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Klik tombol di bawah untuk menguji performa kedua library.",
                        style: GoogleFonts.inter(fontSize: 14),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.network_check),
                          label: const Text("Jalankan Tes API"),
                          onPressed: controller.compareApis,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "HTTP Time: ${controller.httpTime.value} ms",
                              style: GoogleFonts.inter(fontSize: 14),
                            ),
                            Text(
                              "DIO Time: ${controller.dioTime.value} ms",
                              style: GoogleFonts.inter(fontSize: 14),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "HTTP Result (potongan):",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              controller.httpResult.toString(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "DIO Result (potongan):",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              controller.dioResult.toString(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final ColorScheme cs;
  const _Header({required this.cs});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cs.primary, cs.tertiary, cs.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 22),
              child: Text(
                '',
                style: GoogleFonts.inter(
                  color: cs.onPrimary.withOpacity(0.9),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Positioned(
            right: -30,
            top: -30,
            child: _blob(120, cs.onPrimary.withOpacity(0.08)),
          ),
          Positioned(
            right: 30,
            top: 20,
            child: _blob(80, cs.onPrimary.withOpacity(0.06)),
          ),
        ],
      ),
    );
  }

  Widget _blob(double size, Color color) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}
