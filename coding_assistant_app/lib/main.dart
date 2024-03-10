import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

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
          title: const Text('Coding Assistant'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Press the button and speak:',
              ),
              IconButton(
                icon: const Icon(Icons.mic),
                onPressed: () async {
                  try {
                    // Simulate voice data (replace with actual voice input)
                    const String voiceData = "voice_data.wav";

                    // Send voice data to the WebSocket server
                    channel.sink.add(voiceData);

                    // Receive response from the server
                    final String response = await channel.stream.first;

                    // Handle the response (you can update the UI here)
                    print("Response: $response");
                  } catch (e) {
                    // Handle errors using a logging framework (e.g., logger package)
                    print("Error: $e");
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
