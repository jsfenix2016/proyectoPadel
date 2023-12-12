import 'dart:convert';

import 'package:Klasspadel/Common/constant_api.dart';
import 'package:Klasspadel/Common/preferer_user.dart';
import 'package:Klasspadel/main.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class MyWebSocketPage extends StatefulWidget {
  const MyWebSocketPage({super.key});

  @override
  State<MyWebSocketPage> createState() => _MyWebSocketPageState();
}

class _MyWebSocketPageState extends State<MyWebSocketPage> {
  IOWebSocketChannel? channeltemp;
  @override
  void initState() {
    super.initState();
// // Escuchar mensajes del servidor
    //   channel?.stream.listen((message) {
    //     final data = jsonDecode(message);
    //     final action = data['action'];

    //     if (action == 'receiveInvitation') {
    //       final senderId = data['senderId'];
    //       final receiverId = data['receiverId'];

    //       // Mostrar notificación o pantalla para la invitación recibida
    //       // Permitir al usuario responder a la invitación y llamar a respondToInvitation() con la respuesta correspondiente
    //     } else if (action == 'invitationResponse') {
    //       final receiverId = data['receiverId'];
    //       final response = data['response'];

    //       // Actualizar el estado de la invitación en la aplicación móvil según la respuesta recibida
    //     }
    //   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebSocket Example'),
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: channeltemp?.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return const Text('Connection Closed');
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                // Aquí puedes procesar y mostrar los mensajes recibidos
                final message = snapshot.data as String;
                return Text('Received: $message');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          ElevatedButton(
            child: const Text('Send Invitation'),
            onPressed: () {
              // Establecer la conexión WebSocket al presionar el botón

              if (status.goingAway.isFinite) {}
              // Enviar un mensaje al servidor WebSocket
              PreferenceUser prefs = PreferenceUser();

              final inv = {
                'action': 'invitation',
                'user': 1,
                'userInvited': 2,
              };
              channelWeb = IOWebSocketChannel.connect(
                  'wss://${ConstantApi.baseApiWS}/websocket');

              channelWeb?.sink.add(jsonEncode(inv));
              // channelWeb?.sink.close(status.goingAway);
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    channelWeb?.sink.close();
    super.dispose();
  }
}
