import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modul Flutter 1-5',
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Data array for ListView.builder
  final List<String> buahList = const [
    'Apel', 'Mangga', 'Jeruk', 'Pisang', 'Anggur',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Widget Demo by Jordan (2311102139)')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── 1. CONTAINER ──────────────────────────────────
            const Text('1. Container', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 80,
              color: Colors.blue,
              alignment: Alignment.center,
              child: const Text('Ini Container', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),

            const SizedBox(height: 24),

            // ── 2. GRIDVIEW (6 items, fixed height) ───────────
            const Text('2. GridView', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            SizedBox(
              height: 220,
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(6, (i) {
                  final colors = [Colors.red, Colors.green, Colors.orange,
                                  Colors.purple, Colors.teal, Colors.pink];
                  return Container(
                    color: colors[i],
                    alignment: Alignment.center,
                    child: Text('Item ${i + 1}', style: const TextStyle(color: Colors.white)),
                  );
                }),
              ),
            ),

            const SizedBox(height: 24),

            // ── 3. LISTVIEW (3 items: A, B, C) ────────────────
            const Text('3. ListView', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            SizedBox(
              height: 150,
              child: ListView(
                children: const [
                  ListTile(leading: Icon(Icons.label), title: Text('Item A')),
                  ListTile(leading: Icon(Icons.label), title: Text('Item B')),
                  ListTile(leading: Icon(Icons.label), title: Text('Item C')),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── 4. LISTVIEW.BUILDER (from array) ──────────────
            const Text('4. ListView.builder', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: buahList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.circle, color: Colors.blue),
                    title: Text(buahList[index]),
                    trailing: Text('No. ${index + 1}'),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // ── 5. LISTVIEW.SEPARATED (with divider) ──────────
            const Text('5. ListView.separated', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: ListView.separated(
                itemCount: buahList.length,
                separatorBuilder: (context, index) => const Divider(color: Colors.grey),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(buahList[index]),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // ── 6. STACK (overlapping box + text) ─────────────
            const Text('6. Stack', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            SizedBox(
              height: 120,
              child: Stack(
                children: [
                  Container(color: Colors.amber, width: double.infinity, height: 120),
                  Positioned(
                    top: 10, left: 10,
                    child: Container(width: 80, height: 80, color: Colors.red),
                  ),
                  const Positioned(
                    bottom: 10, right: 10,
                    child: Text(
                      'Teks di atas kotak',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}