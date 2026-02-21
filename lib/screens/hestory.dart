import 'package:flutter/material.dart';
import 'package:final_projict/screens/home_login.dart';


class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Color.fromARGB(255, 74, 238, 68)),
            onPressed: () {
              setState(() {
                ChatStorage.allChats.clear();
              });
            },
           ),
         ],
        ),
      body: Container(
        decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('lib/assets/back2.png'),
            fit: BoxFit.cover, 
              ),
            ),
        child: ChatStorage.allChats.isEmpty 
            ? const Center(child: Text("No chats yet!"))
            : ListView.builder(
                itemCount: ChatStorage.allChats.length,
                itemBuilder: (context, index) {
                  final chat = ChatStorage.allChats[index];
                  return ListTile(
                    leading: const Icon(Icons.chat_bubble_outline),
                    title: Text("${index + 1}"),
                    subtitle: Text(chat['messages'].last['text'], maxLines: 1), 
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Color.fromARGB(255, 74, 238, 68)),
                      onPressed: () {
                        setState(() {
                          ChatStorage.allChats.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}