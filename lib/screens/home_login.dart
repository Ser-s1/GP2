import 'package:flutter/material.dart';
import 'package:final_projict/control/gemini_service.dart';


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
    var screenWidth = MediaQuery.sizeOf(context).width;
    var screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Color.fromARGB(255, 52, 32, 74),
      ),
      body: Column(
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
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
    );
  }
}