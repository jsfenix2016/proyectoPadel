import 'package:Klasspadel/Common/constants_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdvancedSearchScreen extends StatefulWidget {
  const AdvancedSearchScreen({super.key});

  @override
  State<AdvancedSearchScreen> createState() => _AdvancedSearchScreenState();
}

class _AdvancedSearchScreenState extends State<AdvancedSearchScreen> {
  String? selectedOrientation;
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  void search() {
    String name = nameController.text;
    String location = locationController.text;

    // Realizar la búsqueda utilizando los valores de los filtros
    // ...

    // Reiniciar los valores de los filtros después de realizar la búsqueda
    nameController.clear();
    locationController.clear();
    selectedOrientation = "Novato";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Búsqueda Avanzada'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(
                  labelText: 'Localización',
                ),
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: selectedOrientation,
                onChanged: (value) {
                  setState(() {
                    selectedOrientation = value!;
                  });
                },
                items: ConstantsText.orientationsCoach.map((orientation) {
                  return DropdownMenuItem<String>(
                    value: orientation,
                    child: Text(orientation),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'orientation'.tr,
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: search,
                child: const Text('Buscar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
