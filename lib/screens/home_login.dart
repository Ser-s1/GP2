import 'package:flutter/material.dart';
import 'package:final_projict/control/gemini_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:final_projict/control/Button.dart';
import 'package:final_projict/screens/home.dart';
import 'package:final_projict/screens/hestory.dart';

class HomeLogin extends StatefulWidget {
  const HomeLogin({super.key});

  @override
  State<HomeLogin> createState() => _HomeLoginState();
}

class _HomeLoginState extends State<HomeLogin> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = []; 
  final RealEstateAgent _agent = RealEstateAgent(); 
  bool _isLoading = false; 

  void _sendMessage() async {
    final text = _controller.text;
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': text});
      _isLoading = true;
    });
    _controller.clear();

    try {
      final response = await _agent.sendMessage(text);

      setState(() {
        _messages.add({'sender': 'gemini', 'text': response});
      });
    } catch (e) {
      setState(() {
        _messages.add({'sender': 'gemini', 'text': 'عذراً، حدث خطأ: $e'});
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: 
      AppBar(
      leading: PopupMenuButton(
        icon: const Icon(Icons.menu), 
        itemBuilder: (context) => [
          PopupMenuItem(
            onTap: () => context.push(Home()),
            child: const Text("Home"),
          ),
          PopupMenuItem(
            onTap: () {
              if (_messages.isNotEmpty) {
                ChatStorage.allChats.add({
                  'messages': List.from(_messages), 
                });
              }
              context.push(HistoryPage());
            },
            child: const Text("History"),
          ),
          PopupMenuItem(
        onTap: () {
          setState(() {
            _messages.clear(); 
          });
        },
        child: const Row(
          children: [
            Icon(Icons.add, color: Colors.black),
            SizedBox(width: 10),
            Text("New Chat"),
          ],
        ),
      ),
        ],
      ),
  ),

      body:
      
       Container(
         decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('lib/assets/back2.png'),
            fit: BoxFit.cover,
              ),
            ),
         child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  final isUser = msg['sender'] == 'user';
                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.teal[100] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        msg['text'] ?? '',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    
                  );
                  
                },
              
              ),
            ),
            
            if (_isLoading)
              Align(
                alignment: Alignment.centerLeft, 
                     child:  LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.teal,
                        size: 25, 
                      ), 
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                    decoration: BoxDecoration(
                    boxShadow: [ BoxShadow(
                      offset: Offset(5,5),
                      blurRadius: 4,)
                    ],
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(30),
                  ),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.teal),
                    onPressed: _sendMessage,
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

class ChatStorage {
  static List<Map<String, dynamic>> allChats = [];
}