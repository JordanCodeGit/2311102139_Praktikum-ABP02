import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum Modul 6-9',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initNotification();
  }

  // Inisialisasi pengaturan notifikasi lokal
  Future<void> _initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _localNotificationsPlugin.initialize(initializationSettings);

    // Meminta izin notifikasi khusus untuk Android 13+
    _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  // Fungsi untuk memicu notifikasi lokal
  Future<void> _showNotification(String sourceName) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'hardware_api_channel',
      'Notifikasi Perangkat Keras',
      channelDescription: 'Saluran untuk notifikasi sukses ambil gambar',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await _localNotificationsPlugin.show(
      0,
      'Foto Berhasil Dimuat!',
      'Gambar berhasil diambil melalui $sourceName.',
      platformDetails,
    );
  }

  // Fungsi untuk mengambil gambar dari kamera atau galeri
  Future<void> _pickImage(ImageSource source, String sourceName) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        // Memicu notifikasi setelah foto berhasil dipilih/diambil
        await _showNotification(sourceName);
      }
    } catch (e) {
      debugPrint('Error mengambil gambar: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi & API Perangkat Keras'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              // Area Tampilan Foto
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: _image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(11),
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Center(
                        child: Text(
                          'Belum ada foto yang dipilih',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
              ),
              const SizedBox(height: 30),

              // Tombol Buka Kamera Langsung
              ElevatedButton.icon(
                onPressed: () => _pickImage(ImageSource.camera, 'Kamera langsung'),
                icon: const Icon(Icons.camera_alt),
                label: const Text('Buka Kamera Langsung (Camera API)'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              const SizedBox(height: 15),

              // Tombol Pilih Foto dari Galeri
              ElevatedButton.icon(
                onPressed: () => _pickImage(ImageSource.gallery, 'Galeri'),
                icon: const Icon(Icons.photo_library),
                label: const Text('Pilih Foto dari Galeri (Image Picker)'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}