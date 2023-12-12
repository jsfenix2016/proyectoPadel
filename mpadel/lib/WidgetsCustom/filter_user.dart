import 'package:Klasspadel/Page/Loading/loading_screen.dart';
import 'package:Klasspadel/WidgetsCustom/user_custom_select.dart';
import 'package:flutter/material.dart';

class FilterContactListScreen extends StatefulWidget {
  final void Function(String) oncontactSelected;

  const FilterContactListScreen({super.key, required this.oncontactSelected});

  @override
  State<FilterContactListScreen> createState() =>
      _FilterContactListScreenState();
}

class _FilterContactListScreenState extends State<FilterContactListScreen> {
  String searchQuery = "";
  List<String> contactlistTemp = ['Alumnos', 'Carlos', 'Javier', 'Otros mas'];

  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // starTap();
    // NotificationCenter().subscribe('getContact', _getContacts);
    // Get the list of contacts from the device
    // _checkPermissionIsEnabled();
    // contactlistTemp = contactlist;
  }

  @override
  Widget build(BuildContext context) {
    List<String> filteredcontact = contactlistTemp
        .where((contact) =>
            contact.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return LoadingIndicator(
      isLoading: isLoading,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(255, 154, 0, 0.88),
          title: TextField(
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            decoration: const InputDecoration(
              labelText: "Buscar jugadores",
              labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
        body: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: WillPopScope(
            onWillPop: () async {
              // Cierra el teclado antes de retroceder
              Future.sync(() => FocusScope.of(context).unfocus());
              Navigator.pop(context, true);
              return true; // Permite la navegación hacia atrás
            },
            child: Container(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: ListView.builder(
                itemCount: filteredcontact.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      widget.oncontactSelected(filteredcontact[index]);
                      Navigator.pop(context, filteredcontact[index]);
                    },
                    child: UserCustomSelect(
                      isFilter: true,
                      name: filteredcontact[index],
                      onDelete: (bool value) {},
                    ),
                  );
                  // return ListTile(
                  //   title: Text(filteredcontact[index]),
                  //   onTap: () {
                  //     widget.oncontactSelected("contact");

                  //     Navigator.pop(
                  //         context, "contact"); // Volver a la pantalla anterior
                  //   },
                  // );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
