import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _firestore.collection('messages').add({
        'text': _messageController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Live Chat"),centerTitle: true,),
      body: Column(
        children: [
          Expanded(child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                var messages = snapshot.data!.docs;
                return ListView.builder(reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    return ListTile(
                      title: Text(message['text']),);
                    },);
                },),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Expanded(child: TextField(controller: _messageController,
                decoration: InputDecoration(hintText: "Enter message..."),),),
                IconButton(icon: Icon(Icons.send), onPressed: _sendMessage,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
