import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late IOWebSocketChannel channel;

  @override
  void initState() {
    super.initState();
    // Initialize WebSocket channel in initState
    channel = IOWebSocketChannel.connect('ws://localhost:8765');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Coding Assistant'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Press the button and speak:',
              ),
              IconButton(
                icon: Icon(Icons.mic),
                onPressed: () async {
                  try {
                    // Simulate voice data (replace with actual voice input)
                    String voiceData = "voice_data.wav";

                    // Send voice data to the WebSocket server
                    channel.sink.add(voiceData);

                    // Receive response from the server
                    String response = await channel.stream.first;

                    // Handle the response (you can update the UI here)
                    print("Response: $response");
                  } catch (e) {
                    print("Error: $e");
                    // Handle errors, e.g., show an error message to the user
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Close the WebSocket channel in dispose
    channel.sink.close();
    super.dispose();
  }
}
