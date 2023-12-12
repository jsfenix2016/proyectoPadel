import 'package:Klasspadel/Page/Search/filter_screen.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> searchResults = []; // Lista de resultados de búsqueda

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Búsqueda'),
      ),
      body: Column(
        children: [
          // Botón de filtro
          ElevatedButton(
            onPressed: () {
              // Mostrar pantalla de filtro al presionar el botón
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FilterScreen()),
              );
            },
            child: Text('Filtrar'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(searchResults[index]),
                  // Resto de información de cada elemento de la lista
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
