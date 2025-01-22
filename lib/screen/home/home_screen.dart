import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;

  Future<void> uploadImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    setState(() => _isUploading = true);

    try {
      final File file = File(pickedFile.path);
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.png'; // 🔹 Fixed Path

      await supabase.storage.from('images').upload(fileName, file);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image uploaded!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
    } finally {
      setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Upload Image')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Image.network("", fit: BoxFit.cover),
              ),
              SizedBox(height: 100),
              ElevatedButton(
                onPressed: _isUploading ? null : uploadImage,
                child: _isUploading ? CircularProgressIndicator() : Text('Upload Image'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => GalleryScreen())),
                child: Text('View Images'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  late Future<List<String>> _imageUrls;

  @override
  void initState() {
    super.initState();
    _imageUrls = fetchImages();
  }

  Future<List<String>> fetchImages() async {
    final response = await supabase.storage.from('images').list();

    return response.map((file) {
      return supabase.storage.from('images').getPublicUrl(file.name); // ✅ Correct Path
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Gallery')),
      body: FutureBuilder<List<String>>(
        future: _imageUrls,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No images found'));
          } else {
            return GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Image.network(snapshot.data![index], fit: BoxFit.cover);
              },
            );
          }
        },
      ),
    );
  }
}
