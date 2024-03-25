import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'messages.dart';

void main() {
  runApp(MyApp6());
}

class MyApp6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebSocket Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final _channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
  List<String> _messages = [];
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _loadMessages();
    _channel.stream.listen((message) {
      if (!message.contains(RegExp(r'Request served by [\da-f]+'))) {
        setState(() {
          _messages.add("Server: $message");
          print(message);
         // _saveMessages();
        });
          _saveMessages();
      }
    });
   // _saveMessages();
  }

  String formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    if (timestamp.year == now.year && timestamp.month == now.month && timestamp.day == now.day) {
      return 'Today';
    } else if (timestamp.year == yesterday.year &&
        timestamp.month == yesterday.month &&
        timestamp.day == yesterday.day) {
      return 'Yesterday';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyApp7(),
                    ),
                  );
                },
                child: Icon(Icons.arrow_back)),
            SizedBox(width: 10,),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(50),
               border: Border.all(color: Colors.blue.shade800, width: 2),
                color:Colors.white,
             ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('lib/assets/catimage3.png',),
              ),
            ),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Gura Nicholson",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                Text("Last seen 6.14PM",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.grey),),
              ],
            ),
            Spacer(),
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey.shade100,
              ),
              child: Icon(Icons.search,size: 18,),
            ),
            SizedBox(width: 10,),
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey.shade100,
              ),
              child: Icon(Icons.video_camera_back_outlined,size: 18,),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade200,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
                  child: Text(
                    formatTimestamp(DateTime.now()),
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: _messages.length,
            //     itemBuilder: (context, index) {
            //       return ListTile(
            //         title: Text(_messages[index]),
            //       );
            //     },
            //   ),
            // ),
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isUserMessage = message.startsWith("you:");
                  final alignment = isUserMessage ? CrossAxisAlignment.start : CrossAxisAlignment.end;
                  return ListTile(
                    title: Align(
                      alignment: !isUserMessage ? Alignment.centerLeft : Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                        decoration: BoxDecoration(
                          color: !isUserMessage ? Colors.grey[100] : Colors.indigoAccent,
                          borderRadius: BorderRadius.only(
                            topLeft: !isUserMessage ? Radius.circular(0.0) : Radius.circular(20.0),
                            topRight: !isUserMessage ? Radius.circular(20.0) : Radius.circular(20.0),
                            bottomLeft: !isUserMessage ? Radius.circular(20.0) : Radius.circular(20.0),
                            bottomRight: !isUserMessage ? Radius.circular(20.0) : Radius.circular(0.0),
                          ),
                        ),
                        child: Text(
                          message,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: !isUserMessage ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    dense: true,
                  );
                },
              ),
            ),

            ListTile(
              leading: ClipOval(
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.indigoAccent
                  ),
                  child: Center(
                      child: Text("+",
                        style: TextStyle(fontSize: 20,color: Colors.white,
                        fontWeight: FontWeight.w500
                        ),)),
                ),
              ),
              title: TextField(
                controller: _controller,
                decoration: InputDecoration(hintText: 'Say something...',border: InputBorder.none,),
                onSubmitted: (message) {
                  _sendMessage(message);
                },
              ),
              trailing: Icon(Icons.emoji_emotions_outlined),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage(String message) {
    if (message.isNotEmpty) {
      _channel.sink.add(message);
      setState(() {
        _messages.add("you:$message");
      });
      _controller.clear();
      _saveMessages();
    }
  }

  void _loadMessages() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _messages = prefs.getStringList('messages') ?? [];
    });
  }

  void _saveMessages() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setStringList('messages', _messages);
    print("KJ msg:$_messages");
  }

  @override
  void dispose() {
    _channel.sink.close();
    _saveMessages();
    super.dispose();
  }
}




