import 'dart:convert';

import 'package:Klasspadel/Common/decoder_custom.dart';

import 'package:Klasspadel/Models/player_model.dart';
import 'package:Klasspadel/main.dart';
import 'package:flutter/material.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key, required this.list});
  final List<PlayerModel> list;
  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  List<PlayerModel> filteredData = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredData = widget.list;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    channelWeb?.sink.close();
  }

  void filterData(String query) {
    List<PlayerModel> tempList = [];
    if (query.isNotEmpty) {
      for (var person in widget.list) {
        if (person.name.toLowerCase().contains(query.toLowerCase())) {
          tempList.add(person);
        }
      }
    } else {
      tempList = widget.list;
    }
    setState(() {
      filteredData = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asignar jugador'),
      ),
      body: Container(
        decoration: decorationCustom(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                child: TextField(
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                  controller: searchController,
                  onChanged: filterData,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    hintText: 'Buscar...',
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/player.png'),
                    ),
                    title: Text(
                      filteredData[index].name.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Acción del botón invitar
                        final inv = {
                          'action': 'invitation',
                          'user': '3',
                          'userInvited': "12",
                        };
                        print(inv);
                        // channelWeb = IOWebSocketChannel.connect(
                        //     'wss://${ConstantApi.baseApiWS}/websocket');

                        channelWeb?.sink.add(jsonEncode(inv));
                      },
                      child: const Text(
                        'Invitar',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
