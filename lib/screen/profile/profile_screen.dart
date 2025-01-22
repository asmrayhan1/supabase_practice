import 'package:flutter/material.dart';
import 'package:supabase_project/auth/login/login_screen.dart';
import 'package:supabase_project/auth/service/auth_service.dart';
import 'package:supabase_project/screen/home/home_screen.dart';
import 'package:supabase_project/screen/profile/profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () async {
                await AuthService().signOUt();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Icon(Icons.logout, size: 30, color: Colors.green)
            ),
          )
        ],
      ),
      body: Column(
        children: [
          GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => CommentSection()));
              },
              child: Text("Click Here", style: TextStyle(fontSize: 30),)
          ),
          Center(child: Text("Hey, Welcome Back Once Again!", textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),),
          SizedBox(height: 40),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
            },
            child: Text("Profile Screen", style: TextStyle(fontSize: 30, color: Colors.green),)
          ),
          SizedBox(height: 40),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: Text("Home", style: TextStyle(fontSize: 30, color: Colors.blueAccent),)
          ),
        ],
      ),
    );
  }
}












class CommentSection extends StatefulWidget {
  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  bool showCommentField = false;
  bool showReplyField = false;
  String? replyingTo;

  TextEditingController commentController = TextEditingController();
  TextEditingController replyController = TextEditingController();

  // Focus nodes to manage focus for comment and reply fields
  FocusNode commentFocusNode = FocusNode();
  FocusNode replyFocusNode = FocusNode();

  @override
  void dispose() {
    commentController.dispose();
    replyController.dispose();
    commentFocusNode.dispose();
    replyFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" "),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display existing comments
              Column(
                children: [
                  CommentTile(
                    userName: "User 1",
                    comment: "This is a comment",
                    onReplyPressed: () {
                      setState(() {
                        replyingTo = "User 1";
                        showReplyField = true;
                        // Focus the reply field when replying
                        FocusScope.of(context).requestFocus(replyFocusNode);
                      });
                    },
                  ),
                  CommentTile(
                    userName: "User 2",
                    comment: "Another comment",
                    onReplyPressed: () {
                      setState(() {
                        replyingTo = "User 2";
                        showReplyField = true;
                        // Focus the reply field when replying
                        FocusScope.of(context).requestFocus(replyFocusNode);
                      });
                    },
                  ),
                ],
              ),
          
              // Show the comment text field when tapping on "Comment"
              if (showCommentField)
                TextField(
                  controller: commentController,
                  focusNode: commentFocusNode,
                  decoration: InputDecoration(
                    hintText: "Add a comment...",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        // Handle sending comment
                        print("Comment: ${commentController.text}");
                        setState(() {
                          showCommentField = false;
                        });
                        commentController.clear();
                      },
                    ),
                  ),
                ),
              // "Add Comment" button
              if (!showCommentField)
                TextButton(
                  onPressed: () {
                    setState(() {
                      showCommentField = true;
                    });
                    // Focus the comment field when adding a new comment
                    FocusScope.of(context).requestFocus(commentFocusNode);
                  },
                  child: Text("Add Comment"),
                ),
          
              // Show the reply text field if "Reply" button was tapped
              if (showReplyField)
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: replyController,
                    focusNode: replyFocusNode,
                    decoration: InputDecoration(
                      hintText: "Reply to $replyingTo...",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          // Handle sending reply
                          print("Reply to $replyingTo: ${replyController.text}");
                          setState(() {
                            showReplyField = false;
                            replyingTo = null;
                          });
                          replyController.clear();
                        },
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommentTile extends StatelessWidget {
  final String userName;
  final String comment;
  final VoidCallback onReplyPressed;

  CommentTile({
    required this.userName,
    required this.comment,
    required this.onReplyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        title: Text(userName),
        subtitle: Text(comment),
        trailing: TextButton(
          onPressed: onReplyPressed,
          child: Text("Reply"),
        ),
      ),
    );
  }
}
