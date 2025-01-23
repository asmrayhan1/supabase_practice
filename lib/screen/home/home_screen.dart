import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final SupabaseClient _supabaseClient;
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    _supabaseClient = Supabase.instance.client;
    _fetchImages();
  }

  // Fetch all image URLs
  Future<void> _fetchImages() async {
    final response = await _supabaseClient.storage.from('your-bucket-name').list('images/');

    if (response.error != null) {
      print('Error fetching images: ${response.error?.message}');
    } else {
      setState(() {
        imageUrls = response.data!.map<String>((e) => _supabaseClient.storage.from('your-bucket-name').getPublicUrl(e.name).toString()).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image List')),
      body: imageUrls.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Image.network(imageUrls[index]);
        },
      ),
    );
  }
}
