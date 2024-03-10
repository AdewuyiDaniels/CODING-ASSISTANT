import asyncio
import websockets
import speech_recognition as sr

recognizer = sr.Recognizer()

async def handle_voice(websocket, path):
    while True:
        try:
            # Receive voice data from the client
            voice_data = await websocket.recv()

            # Convert voice data to text
            with sr.AudioFile(voice_data) as source:
                audio_text = recognizer.recognize_google(source)

            # Process the text (coding assistance logic)
            response = process_text(audio_text)

            # Send the response back to the client
            await websocket.send(response)

        except websockets.exceptions.ConnectionClosedError:
            break

def process_text(text):
    # Implement your coding assistance logic here
    # For now, return a simple response
    return f"You said: {text}"

# Start the WebSocket server
start_server = websockets.serve(handle_voice, "localhost", 8765)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()