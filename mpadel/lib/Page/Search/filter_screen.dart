import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  double starRating = 0; // Valor seleccionado para las estrellas
  double distance = 0; // Valor seleccionado para la distancia
  String? orientation = 'Bajo'; // Valor seleccionado para la orientación

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtrar'),
      ),
      body: Column(
        children: [
          // Selección de estrellas
          Slider(
            label: "Estrellas:",
            value: starRating,
            min: 0,
            max: 5,
            divisions: 5,
            onChanged: (value) {
              setState(() {
                starRating = value;
              });
            },
          ),
          // Selección de distancia
          Slider(
            label: "Distancia de busqueda",
            value: distance,
            min: 0,
            max: 10,
            divisions: 10,
            onChanged: (value) {
              setState(() {
                distance = value;
              });
            },
          ),
          // Selección de orientación
          DropdownButtonFormField<String>(
            value: orientation,
            items: ['Bajo', 'Medio', 'Avanzado', 'Profesional']
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                orientation = value!;
              });
            },
            decoration: InputDecoration(
              labelText: 'Orientación',
            ),
          ),
          // Botón para aplicar los filtros
          ElevatedButton(
            onPressed: () {
              // Verificar que se haya seleccionado una orientación
              if (orientation!.isNotEmpty) {
                // Aplicar filtros y volver a la pantalla de búsqueda
                Navigator.pop(context);
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Error'),
                      content: Text('Por favor, selecciona una orientación.'),
                      actions: [
                        TextButton(
                          child: Text('Aceptar'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: Text('Aplicar filtros'),
          ),
        ],
      ),
    );
  }
}
