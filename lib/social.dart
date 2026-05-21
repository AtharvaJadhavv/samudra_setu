/*
// lib/social.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'map.dart';
import 'report.dart';

// --- Data Models ---
class SafetyVideo {
  final String title;
  final String duration;
  final String videoUrl;
  SafetyVideo({required this.title, required this.duration, required this.videoUrl});
}

class CommunityPost {
  final String userName;
  final String userAvatar;
  final String userLocation;
  final String timeAgo;
  final String content;
  final String? imageUrl;
  final XFile? localImage;
  int likes;
  int comments;

  CommunityPost({
    required this.userName,
    required this.userAvatar,
    required this.userLocation,
    required this.timeAgo,
    required this.content,
    this.imageUrl,
    this.localImage,
    this.likes = 0,
    this.comments = 0,
  });
}

// --- Main Social Screen Widget ---
class SocialScreen extends StatefulWidget {
  const SocialScreen({super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  // --- UPDATED video URLs ---
  final List<SafetyVideo> _safetyDemos = [
    SafetyVideo(title: 'Tsunami Safety Tips', duration: '0:20', videoUrl: 'https://assets.mixkit.co/videos/preview/mixkit-waves-in-the-storm-2259-large.mp4'),
    SafetyVideo(title: 'Evacuation Guide', duration: '0:15', videoUrl: 'https://assets.mixkit.co/videos/preview/mixkit-people-walking-on-a-beach-on-a-cloudy-day-4533-large.mp4'),
    SafetyVideo(title: 'Emergency First Aid', duration: '0:28', videoUrl: 'https://assets.mixkit.co/videos/preview/mixkit-hands-of-a-man-and-a-woman-in-the-sea-31931-large.mp4'),
  ];

  final List<CommunityPost> _communityPosts = [
    CommunityPost(
      userName: 'Ravi Kumar',
      userAvatar: 'RK',
      userLocation: 'Marina Beach, Chennai',
      timeAgo: '2h ago',
      content: 'High waves observed at Marina Beach today. Water level seems higher than usual. Everyone please stay cautious! 🌊⚠️',
      imageUrl: 'https://images.pexels.com/photos/355321/pexels-photo-355321.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2', // <-- FIXED IMAGE LINK
      likes: 24,
      comments: 8,
    ),
    // --- NEW COMMUNITY POST ---
    CommunityPost(
      userName: 'Anand Shetty',
      userAvatar: 'AS',
      userLocation: 'Kovalam, Kerala',
      timeAgo: '8h ago',
      content: 'Just a heads up for fishers near Kovalam. The sea is a bit rough today. Please check the official advisories before heading out.',
      imageUrl: 'https://images.pexels.com/photos/1680246/pexels-photo-1680246.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
      likes: 45,
      comments: 12,
    ),
  ];

  void _addPost(String content, XFile? image) {
    setState(() {
      _communityPosts.insert(
        0,
        CommunityPost(
          userName: 'You',
          userAvatar: 'ME',
          userLocation: 'Your Location',
          timeAgo: 'Just now',
          content: content,
          localImage: image,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: ListView(
        children: [
          _buildSectionHeader('Safety Demos', Icons.video_library_outlined),
          _buildSafetyDemosList(),
          _buildSectionHeader('Community Feed', Icons.people_outline),
          _buildCommunityFeed(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddPostDialog(context),
        backgroundColor: const Color(0xFF0A4E6C),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Add Post", style: TextStyle(color: Colors.white)),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF0A4E6C),
      title: const Text('Community Pulse', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      elevation: 0,
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[700]),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildSafetyDemosList() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _safetyDemos.length,
        itemBuilder: (context, index) {
          final demo = _safetyDemos[index];
          return _buildVideoCard(demo);
        },
      ),
    );
  }

  Widget _buildVideoCard(SafetyVideo demo) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => VideoPlayerScreen(videoUrl: demo.videoUrl)));
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF81D4FA),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.play_circle_outline, color: Colors.white, size: 40),
            Positioned(top: 8, right: 8, child: Container(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2), decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(4)), child: Text(demo.duration, style: const TextStyle(color: Colors.white, fontSize: 12)))),
            Positioned(bottom: 8, left: 8, right: 8, child: Text(demo.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
          ],
        ),
      ),
    );
  }

  Widget _buildCommunityFeed() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _communityPosts.length,
      itemBuilder: (context, index) {
        return _buildPostCard(_communityPosts[index]);
      },
    );
  }

  Widget _buildPostCard(CommunityPost post) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundColor: Colors.blue.shade800, child: Text(post.userAvatar, style: const TextStyle(color: Colors.white))),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.userName, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Row(children: [Icon(Icons.location_on, size: 14, color: Colors.grey), Text(post.userLocation, style: const TextStyle(color: Colors.grey, fontSize: 12))]),
                  ],
                ),
                const Spacer(),
                Text(post.timeAgo, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(post.content, style: const TextStyle(fontSize: 15, height: 1.4)),
            ),
            if (post.imageUrl != null || post.localImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: post.localImage != null
                    ? Image.file(File(post.localImage!.path))
                    : Image.network(post.imageUrl!, fit: BoxFit.cover, width: double.infinity, height: 180),
              ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(icon: Icons.favorite_border, label: post.likes.toString(), onTap: () => setState(() => post.likes++)),
                _buildActionButton(icon: Icons.chat_bubble_outline, label: post.comments.toString(), onTap: () {}),
                _buildActionButton(icon: Icons.share_outlined, label: 'Share', onTap: () {}),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.grey.shade700),
            const SizedBox(width: 4),
            Text(label, style: TextStyle(color: Colors.grey.shade700)),
          ],
        ),
      ),
    );
  }

  void _showAddPostDialog(BuildContext context) {
    final TextEditingController postController = TextEditingController();
    XFile? postImage;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Create a New Post', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  TextField(
                    controller: postController,
                    decoration: const InputDecoration(hintText: "What's on your mind?", border: OutlineInputBorder()),
                    maxLines: 4,
                  ),
                  const SizedBox(height: 12),
                  if (postImage != null)
                    Image.file(File(postImage!.path), height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        icon: const Icon(Icons.image_outlined),
                        label: const Text('Add Image'),
                        onPressed: () async {
                          final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                          if (pickedFile != null) {
                            setModalState(() => postImage = pickedFile);
                          }
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (postController.text.isNotEmpty) {
                            _addPost(postController.text, postImage);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Post'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  BottomNavigationBar _buildBottomNavBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
        BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'MAP'),
        BottomNavigationBarItem(icon: Icon(Icons.report_problem_outlined), label: 'REPORT'),
        BottomNavigationBarItem(icon: Icon(Icons.group_outlined), label: 'SOCIAL'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_active_outlined), label: 'ALERTS'),
      ],
      currentIndex: 3,
      selectedItemColor: const Color(0xFF0A4E6C),
      unselectedItemColor: Colors.grey[600],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.popUntil(context, (route) => route.isFirst);
            break;
          case 1:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MapScreen()));
            break;
          case 2:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ReportScreen()));
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    );
  }
}

// --- Separate Screen for Video Player ---
class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerScreen({super.key, required this.videoUrl});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black, iconTheme: const IconThemeData(color: Colors.white)),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : const CircularProgressIndicator(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying ? _controller.pause() : _controller.play();
          });
        },
        child: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}*//*

// lib/social.dart
*/
/*
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'map.dart';
import 'report.dart';

// --- Data Models ---
class SafetyVideo {
  final String title;
  final String duration;
  final String videoUrl;
  SafetyVideo({required this.title, required this.duration, required this.videoUrl});
}

class CommunityPost {
  final String userName;
  final String userAvatar;
  final String userLocation;
  final String timeAgo;
  final String content;
  final String? imagePath; // Changed from imageUrl to a more generic path
  final XFile? localImage;
  int likes;
  int comments;

  CommunityPost({
    required this.userName,
    required this.userAvatar,
    required this.userLocation,
    required this.timeAgo,
    required this.content,
    this.imagePath,
    this.localImage,
    this.likes = 0,
    this.comments = 0,
  });
}

// --- Main Social Screen Widget ---
class SocialScreen extends StatefulWidget {
  const SocialScreen({super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  final List<SafetyVideo> _safetyDemos = [
    SafetyVideo(title: 'Tsunami Safety Tips', duration: '0:20', videoUrl: 'https://assets.mixkit.co/videos/preview/mixkit-waves-in-the-storm-2259-large.mp4'),
    SafetyVideo(title: 'Evacuation Guide', duration: '0:15', videoUrl: 'https://assets.mixkit.co/videos/preview/mixkit-people-walking-on-a-beach-on-a-cloudy-day-4533-large.mp4'),
    SafetyVideo(title: 'Emergency First Aid', duration: '0:28', videoUrl: 'https://assets.mixkit.co/videos/preview/mixkit-hands-of-a-man-and-a-woman-in-the-sea-31931-large.mp4'),
  ];

  final List<CommunityPost> _communityPosts = [
    // --- UPDATED to use your local images ---
    CommunityPost(
      userName: 'Ravi Kumar',
      userAvatar: 'RK',
      userLocation: 'Marina Beach, Chennai',
      timeAgo: '2h ago',
      content: 'High waves observed at Marina Beach today. Water level seems higher than usual. Everyone please stay cautious! 🌊⚠️',
      imagePath: 'assets/images/highwaves.png', // <-- Using your local image
      likes: 24,
      comments: 8,
    ),
    CommunityPost(
      userName: 'Anand Shetty',
      userAvatar: 'AS',
      userLocation: 'Kovalam, Kerala',
      timeAgo: '8h ago',
      content: 'Just a heads up for fishers near Kovalam. The sea is a bit rough today due to the rain. Please check the official advisories before heading out.',
      imagePath: 'assets/images/rain.jpg', // <-- Using your local image
      likes: 45,
      comments: 12,
    ),
  ];

  void _addPost(String content, XFile? image) {
    setState(() {
      _communityPosts.insert(
        0,
        CommunityPost(
          userName: 'You',
          userAvatar: 'ME',
          userLocation: 'Your Location',
          timeAgo: 'Just now',
          content: content,
          localImage: image,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: ListView(
        children: [
          _buildSectionHeader('Safety Demos', Icons.video_library_outlined),
          _buildSafetyDemosList(),
          _buildSectionHeader('Community Feed', Icons.people_outline),
          _buildCommunityFeed(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddPostDialog(context),
        backgroundColor: const Color(0xFF0A4E6C),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Add Post", style: TextStyle(color: Colors.white)),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF0A4E6C),
      title: const Text('Community Pulse', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      elevation: 0,
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[700]),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildSafetyDemosList() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _safetyDemos.length,
        itemBuilder: (context, index) {
          final demo = _safetyDemos[index];
          return _buildVideoCard(demo);
        },
      ),
    );
  }

  Widget _buildVideoCard(SafetyVideo demo) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => VideoPlayerScreen(videoUrl: demo.videoUrl)));
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF81D4FA),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.play_circle_outline, color: Colors.white, size: 40),
            Positioned(top: 8, right: 8, child: Container(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2), decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(4)), child: Text(demo.duration, style: const TextStyle(color: Colors.white, fontSize: 12)))),
            Positioned(bottom: 8, left: 8, right: 8, child: Text(demo.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
          ],
        ),
      ),
    );
  }

  Widget _buildCommunityFeed() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _communityPosts.length,
      itemBuilder: (context, index) {
        return _buildPostCard(_communityPosts[index]);
      },
    );
  }

  Widget _buildPostCard(CommunityPost post) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundColor: Colors.blue.shade800, child: Text(post.userAvatar, style: const TextStyle(color: Colors.white))),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.userName, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Row(children: [Icon(Icons.location_on, size: 14, color: Colors.grey), Text(post.userLocation, style: const TextStyle(color: Colors.grey, fontSize: 12))]),
                  ],
                ),
                const Spacer(),
                Text(post.timeAgo, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(post.content, style: const TextStyle(fontSize: 15, height: 1.4)),
            ),
            if (post.imagePath != null || post.localImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                // --- UPDATED LOGIC to show local or uploaded images ---
                child: post.localImage != null
                    ? Image.file(File(post.localImage!.path))
                    : Image.asset(post.imagePath!, fit: BoxFit.cover, width: double.infinity, height: 180),
              ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(icon: Icons.favorite_border, label: post.likes.toString(), onTap: () => setState(() => post.likes++)),
                _buildActionButton(icon: Icons.chat_bubble_outline, label: post.comments.toString(), onTap: () {}),
                _buildActionButton(icon: Icons.share_outlined, label: 'Share', onTap: () {}),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.grey.shade700),
            const SizedBox(width: 4),
            Text(label, style: TextStyle(color: Colors.grey.shade700)),
          ],
        ),
      ),
    );
  }

  void _showAddPostDialog(BuildContext context) {
    final TextEditingController postController = TextEditingController();
    XFile? postImage;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Create a New Post', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  TextField(
                    controller: postController,
                    decoration: const InputDecoration(hintText: "What's on your mind?", border: OutlineInputBorder()),
                    maxLines: 4,
                  ),
                  const SizedBox(height: 12),
                  if (postImage != null)
                    Image.file(File(postImage!.path), height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        icon: const Icon(Icons.image_outlined),
                        label: const Text('Add Image'),
                        onPressed: () async {
                          final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                          if (pickedFile != null) {
                            setModalState(() => postImage = pickedFile);
                          }
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (postController.text.isNotEmpty) {
                            _addPost(postController.text, postImage);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Post'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  BottomNavigationBar _buildBottomNavBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
        BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'MAP'),
        BottomNavigationBarItem(icon: Icon(Icons.report_problem_outlined), label: 'REPORT'),
        BottomNavigationBarItem(icon: Icon(Icons.group_outlined), label: 'SOCIAL'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_active_outlined), label: 'ALERTS'),
      ],
      currentIndex: 3,
      selectedItemColor: const Color(0xFF0A4E6C),
      unselectedItemColor: Colors.grey[600],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.popUntil(context, (route) => route.isFirst);
            break;
          case 1:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MapScreen()));
            break;
          case 2:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ReportScreen()));
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    );
  }
}

// --- Separate Screen for Video Player ---
class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerScreen({super.key, required this.videoUrl});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black, iconTheme: const IconThemeData(color: Colors.white)),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : const CircularProgressIndicator(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying ? _controller.pause() : _controller.play();
          });
        },
        child: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}*//*

// lib/social.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import 'map.dart';
import 'report.dart';

// --- Data Models (UPDATED) ---
class SafetyVideo {
  final String title;
  final String duration;
  final String videoUrl;
  SafetyVideo({required this.title, required this.duration, required this.videoUrl});
}

class CommunityPost {
  final String userName;
  final String userAvatar;
  final String userLocation;
  final String timeAgo;
  final String content;
  final String? imagePath;
  final XFile? localImage;
  int likes;
  List<String> comments; // Changed to a list
  bool isLiked; // To track like state

  CommunityPost({
    required this.userName,
    required this.userAvatar,
    required this.userLocation,
    required this.timeAgo,
    required this.content,
    this.imagePath,
    this.localImage,
    this.likes = 0,
    required this.comments,
    this.isLiked = false,
  });
}

// --- Main Social Screen Widget ---
class SocialScreen extends StatefulWidget {
  const SocialScreen({super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  final List<SafetyVideo> _safetyDemos = [
    SafetyVideo(title: 'Tsunami Safety Tips', duration: '0:20', videoUrl: 'https://assets.mixkit.co/videos/preview/mixkit-waves-in-the-storm-2259-large.mp4'),
    SafetyVideo(title: 'Evacuation Guide', duration: '0:15', videoUrl: 'https://assets.mixkit.co/videos/preview/mixkit-people-walking-on-a-beach-on-a-cloudy-day-4533-large.mp4'),
    SafetyVideo(title: 'Emergency First Aid', duration: '0:28', videoUrl: 'https://assets.mixkit.co/videos/preview/mixkit-hands-of-a-man-and-a-woman-in-the-sea-31931-large.mp4'),
  ];

  final List<CommunityPost> _communityPosts = [
    CommunityPost(
      userName: 'Ravi Kumar',
      userAvatar: 'RK',
      userLocation: 'Marina Beach, Chennai',
      timeAgo: '2h ago',
      content: 'High waves observed at Marina Beach today. Water level seems higher than usual. Everyone please stay cautious! 🌊⚠️',
      imagePath: 'assets/images/highwaves.png',
      likes: 24,
      comments: ['Stay safe!', 'Thanks for the update.'],
    ),
    CommunityPost(
      userName: 'Anand Shetty',
      userAvatar: 'AS',
      userLocation: 'Kovalam, Kerala',
      timeAgo: '8h ago',
      content: 'Just a heads up for fishers near Kovalam. The sea is a bit rough today due to the rain. Please check the official advisories before heading out.',
      imagePath: 'assets/images/rain.jpg',
      likes: 45,
      comments: ['Good advice.', 'Thanks for the warning.'],
      isLiked: true, // Example of an already-liked post
    ),
  ];

  void _addPost(String content, XFile? image) {
    setState(() {
      _communityPosts.insert(
        0,
        CommunityPost(
          userName: 'You',
          userAvatar: 'ME',
          userLocation: 'Your Location',
          timeAgo: 'Just now',
          content: content,
          localImage: image,
          comments: [],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: ListView(
        children: [
          _buildSectionHeader('Safety Demos', Icons.video_library_outlined),
          _buildSafetyDemosList(),
          _buildSectionHeader('Community Feed', Icons.people_outline),
          _buildCommunityFeed(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddPostDialog(context),
        backgroundColor: const Color(0xFF0A4E6C),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Add Post", style: TextStyle(color: Colors.white)),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF0A4E6C),
      title: const Text('Community Pulse', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      elevation: 0,
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[700]),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildSafetyDemosList() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _safetyDemos.length,
        itemBuilder: (context, index) {
          final demo = _safetyDemos[index];
          return _buildVideoCard(demo);
        },
      ),
    );
  }

  Widget _buildVideoCard(SafetyVideo demo) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => VideoPlayerScreen(videoUrl: demo.videoUrl)));
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF81D4FA),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.play_circle_outline, color: Colors.white, size: 40),
            Positioned(top: 8, right: 8, child: Container(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2), decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(4)), child: Text(demo.duration, style: const TextStyle(color: Colors.white, fontSize: 12)))),
            Positioned(bottom: 8, left: 8, right: 8, child: Text(demo.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
          ],
        ),
      ),
    );
  }

  Widget _buildCommunityFeed() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _communityPosts.length,
      itemBuilder: (context, index) {
        return _buildPostCard(_communityPosts[index]);
      },
    );
  }

  // --- UPDATED POST CARD with new functional buttons ---
  Widget _buildPostCard(CommunityPost post) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User info header (no changes)
            Row(
              children: [
                CircleAvatar(backgroundColor: Colors.blue.shade800, child: Text(post.userAvatar, style: const TextStyle(color: Colors.white))),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.userName, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Row(children: [Icon(Icons.location_on, size: 14, color: Colors.grey), Text(post.userLocation, style: const TextStyle(color: Colors.grey, fontSize: 12))]),
                  ],
                ),
                const Spacer(),
                Text(post.timeAgo, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(post.content, style: const TextStyle(fontSize: 15, height: 1.4)),
            ),
            if (post.imagePath != null || post.localImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: post.localImage != null
                    ? Image.file(File(post.localImage!.path))
                    : Image.asset(post.imagePath!, fit: BoxFit.cover, width: double.infinity, height: 180),
              ),
            const Divider(height: 24),
            // Functional action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(
                  icon: post.isLiked ? Icons.favorite : Icons.favorite_border,
                  label: post.likes.toString(),
                  color: post.isLiked ? Colors.red : Colors.grey.shade700,
                  onTap: () => setState(() {
                    post.isLiked = !post.isLiked;
                    post.isLiked ? post.likes++ : post.likes--;
                  }),
                ),
                _buildActionButton(
                  icon: Icons.chat_bubble_outline,
                  label: post.comments.length.toString(),
                  color: Colors.grey.shade700,
                  onTap: () => _showCommentsSheet(context, post),
                ),
                _buildActionButton(
                  icon: Icons.share_outlined,
                  label: 'Share',
                  color: Colors.grey.shade700,
                  onTap: () {
                    Share.share('Check out this post from SamudraSetu: "${post.content}"');
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({required IconData icon, required String label, required VoidCallback onTap, required Color color}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 4),
            Text(label, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }

  // --- NEW Comments Bottom Sheet ---
  void _showCommentsSheet(BuildContext context, CommunityPost post) {
    final TextEditingController commentController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 16),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  children: [
                    Text('Comments (${post.comments.length})', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: post.comments.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              leading: const CircleAvatar(child: Icon(Icons.person)),
                              title: Text(post.comments[index]),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: commentController,
                              decoration: const InputDecoration(hintText: 'Add a comment...', border: OutlineInputBorder()),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              if (commentController.text.isNotEmpty) {
                                setModalState(() {
                                  post.comments.add(commentController.text);
                                });
                                // Also update the main screen state
                                setState(() {});
                                commentController.clear();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showAddPostDialog(BuildContext context) {
    // This function remains the same
    final TextEditingController postController = TextEditingController();
    XFile? postImage;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Create a New Post', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  TextField(
                    controller: postController,
                    decoration: const InputDecoration(hintText: "What's on your mind?", border: OutlineInputBorder()),
                    maxLines: 4,
                  ),
                  const SizedBox(height: 12),
                  if (postImage != null)
                    Image.file(File(postImage!.path), height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        icon: const Icon(Icons.image_outlined),
                        label: const Text('Add Image'),
                        onPressed: () async {
                          final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                          if (pickedFile != null) {
                            setModalState(() => postImage = pickedFile);
                          }
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (postController.text.isNotEmpty) {
                            _addPost(postController.text, postImage);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Post'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  BottomNavigationBar _buildBottomNavBar() {
    // This function remains the same
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
        BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'MAP'),
        BottomNavigationBarItem(icon: Icon(Icons.report_problem_outlined), label: 'REPORT'),
        BottomNavigationBarItem(icon: Icon(Icons.group_outlined), label: 'SOCIAL'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_active_outlined), label: 'ALERTS'),
      ],
      currentIndex: 3,
      selectedItemColor: const Color(0xFF0A4E6C),
      unselectedItemColor: Colors.grey[600],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.popUntil(context, (route) => route.isFirst);
            break;
          case 1:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MapScreen()));
            break;
          case 2:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ReportScreen()));
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    );
  }
}

// --- Video Player Screen (no changes) ---
class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerScreen({super.key, required this.videoUrl});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black, iconTheme: const IconThemeData(color: Colors.white)),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : const CircularProgressIndicator(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying ? _controller.pause() : _controller.play();
          });
        },
        child: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}*/
// lib/social.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import 'map.dart';
import 'report.dart';
import 'alert.dart';

class SafetyVideo {
  final String title;
  final String duration;
  final String videoUrl;
  SafetyVideo({required this.title, required this.duration, required this.videoUrl});
}

class CommunityPost {
  final String userName;
  final String userAvatar;
  final String userLocation;
  final String timeAgo;
  final String content;
  final String? imagePath;
  final XFile? localImage;
  int likes;
  List<String> comments;
  bool isLiked;

  CommunityPost({required this.userName, required this.userAvatar, required this.userLocation, required this.timeAgo, required this.content, this.imagePath, this.localImage, this.likes = 0, required this.comments, this.isLiked = false});
}

class SocialScreen extends StatefulWidget {
  const SocialScreen({super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  final List<SafetyVideo> _safetyDemos = [
    SafetyVideo(title: 'Tsunami Safety Tips', duration: '0:20', videoUrl: 'https://assets.mixkit.co/videos/preview/mixkit-waves-in-the-storm-2259-large.mp4'),
    SafetyVideo(title: 'Evacuation Guide', duration: '0:15', videoUrl: 'https://assets.mixkit.co/videos/preview/mixkit-people-walking-on-a-beach-on-a-cloudy-day-4533-large.mp4'),
    SafetyVideo(title: 'Emergency First Aid', duration: '0:28', videoUrl: 'https://assets.mixkit.co/videos/preview/mixkit-hands-of-a-man-and-a-woman-in-the-sea-31931-large.mp4'),
  ];

  final List<CommunityPost> _communityPosts = [
    CommunityPost(userName: 'Ravi Kumar', userAvatar: 'RK', userLocation: 'Marina Beach, Chennai', timeAgo: '2h ago', content: 'High waves observed at Marina Beach today. Water level seems higher than usual. Everyone please stay cautious! 🌊⚠️', imagePath: 'assets/images/highwaves.png', likes: 24, comments: ['Stay safe!', 'Thanks for the update.']),
    CommunityPost(userName: 'Anand Shetty', userAvatar: 'AS', userLocation: 'Kovalam, Kerala', timeAgo: '8h ago', content: 'Just a heads up for fishers near Kovalam. The sea is a bit rough today due to the rain. Please check the official advisories before heading out.', imagePath: 'assets/images/rain.jpg', likes: 45, comments: ['Good advice.', 'Thanks for the warning.'], isLiked: true),
  ];

  void _addPost(String content, XFile? image) {
    setState(() => _communityPosts.insert(0, CommunityPost(userName: 'You', userAvatar: 'ME', userLocation: 'Your Location', timeAgo: 'Just now', content: content, localImage: image, comments: [])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: ListView(
        children: [
          _buildSectionHeader('Safety Demos', Icons.video_library_outlined),
          _buildSafetyDemosList(),
          _buildSectionHeader('Community Feed', Icons.people_outline),
          _buildCommunityFeed(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddPostDialog(context),
        backgroundColor: const Color(0xFF0A4E6C),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Add Post", style: TextStyle(color: Colors.white)),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF0A4E6C),
      title: const Text('Community Pulse', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      elevation: 0,
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[700]),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildSafetyDemosList() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _safetyDemos.length,
        itemBuilder: (context, index) => _buildVideoCard(_safetyDemos[index]),
      ),
    );
  }

  Widget _buildVideoCard(SafetyVideo demo) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => VideoPlayerScreen(videoUrl: demo.videoUrl))),
      child: Container(
        width: 150,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(color: const Color(0xFF81D4FA), borderRadius: BorderRadius.circular(16)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.play_circle_outline, color: Colors.white, size: 40),
            Positioned(top: 8, right: 8, child: Container(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2), decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(4)), child: Text(demo.duration, style: const TextStyle(color: Colors.white, fontSize: 12)))),
            Positioned(bottom: 8, left: 8, right: 8, child: Text(demo.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
          ],
        ),
      ),
    );
  }

  Widget _buildCommunityFeed() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _communityPosts.length,
      itemBuilder: (context, index) => _buildPostCard(_communityPosts[index]),
    );
  }

  Widget _buildPostCard(CommunityPost post) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundColor: Colors.blue.shade800, child: Text(post.userAvatar, style: const TextStyle(color: Colors.white))),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.userName, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Row(children: [Icon(Icons.location_on, size: 14, color: Colors.grey), Text(post.userLocation, style: const TextStyle(color: Colors.grey, fontSize: 12))]),
                  ],
                ),
                const Spacer(),
                Text(post.timeAgo, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(post.content, style: const TextStyle(fontSize: 15, height: 1.4)),
            ),
            if (post.imagePath != null || post.localImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: post.localImage != null ? Image.file(File(post.localImage!.path)) : Image.asset(post.imagePath!, fit: BoxFit.cover, width: double.infinity, height: 180),
              ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(icon: post.isLiked ? Icons.favorite : Icons.favorite_border, label: post.likes.toString(), color: post.isLiked ? Colors.red : Colors.grey.shade700, onTap: () => setState(() { post.isLiked = !post.isLiked; post.isLiked ? post.likes++ : post.likes--; })),
                _buildActionButton(icon: Icons.chat_bubble_outline, label: post.comments.length.toString(), color: Colors.grey.shade700, onTap: () => _showCommentsSheet(context, post)),
                _buildActionButton(icon: Icons.share_outlined, label: 'Share', color: Colors.grey.shade700, onTap: () => Share.share('Check out this post from SamudraSetu: "${post.content}"')),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({required IconData icon, required String label, required VoidCallback onTap, required Color color}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 4),
            Text(label, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }

  void _showCommentsSheet(BuildContext context, CommunityPost post) {
    final TextEditingController commentController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 16),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                children: [
                  Text('Comments (${post.comments.length})', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: post.comments.length,
                      itemBuilder: (context, index) => Card(child: ListTile(leading: const CircleAvatar(child: Icon(Icons.person)), title: Text(post.comments[index]))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(child: TextField(controller: commentController, decoration: const InputDecoration(hintText: 'Add a comment...', border: OutlineInputBorder()))),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            if (commentController.text.isNotEmpty) {
                              setModalState(() => post.comments.add(commentController.text));
                              setState(() {});
                              commentController.clear();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showAddPostDialog(BuildContext context) {
    final TextEditingController postController = TextEditingController();
    XFile? postImage;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Create a New Post', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextField(controller: postController, decoration: const InputDecoration(hintText: "What's on your mind?", border: OutlineInputBorder()), maxLines: 4),
                const SizedBox(height: 12),
                if (postImage != null) Image.file(File(postImage!.path), height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      icon: const Icon(Icons.image_outlined),
                      label: const Text('Add Image'),
                      onPressed: () async {
                        final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                        if (pickedFile != null) setModalState(() => postImage = pickedFile);
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (postController.text.isNotEmpty) {
                          _addPost(postController.text, postImage);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Post'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  BottomNavigationBar _buildBottomNavBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
        BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'MAP'),
        BottomNavigationBarItem(icon: Icon(Icons.report_problem_outlined), label: 'REPORT'),
        BottomNavigationBarItem(icon: Icon(Icons.group_outlined), label: 'SOCIAL'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_active_outlined), label: 'ALERTS'),
      ],
      currentIndex: 3,
      selectedItemColor: const Color(0xFF0A4E6C),
      unselectedItemColor: Colors.grey[600],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.popUntil(context, (route) => route.isFirst);
            break;
          case 1:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MapScreen()));
            break;
          case 2:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ReportScreen()));
            break;
          case 4:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AlertsScreen()));
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerScreen({super.key, required this.videoUrl});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black, iconTheme: const IconThemeData(color: Colors.white)),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(aspectRatio: _controller.value.aspectRatio, child: VideoPlayer(_controller))
            : const CircularProgressIndicator(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _controller.value.isPlaying ? _controller.pause() : _controller.play()),
        child: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}