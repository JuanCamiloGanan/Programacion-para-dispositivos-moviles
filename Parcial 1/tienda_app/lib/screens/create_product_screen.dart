import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/product.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService api = ApiService();

  String title = "";
  String description = "";
  String category = "electronics";
  double price = 0;

  final String imageUrl =
      "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg";

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    try {
      final product = Product(
        title: title,
        price: price,
        description: description,
        category: category,
        image: imageUrl,
      );

      final res = await api.createProduct(product);

      if (!mounted) return;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Producto creado"),
          content: Text("ID generado: ${res.id}"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // cierra dialog
                Navigator.pop(context, true); // vuelve y refresca
              },
              child: const Text("OK"),
            )
          ],
        ),
      );

    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error al crear producto"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear Producto"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: ListView(
            children: [

              /// TÍTULO
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Título *",
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? "Campo obligatorio" : null,
                onSaved: (v) => title = v!,
              ),

              const SizedBox(height: 12),

              /// PRECIO
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Precio *",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return "Campo obligatorio";
                  if (double.tryParse(v) == null) return "Número inválido";
                  return null;
                },
                onSaved: (v) => price = double.parse(v!),
              ),

              const SizedBox(height: 12),

              /// DESCRIPCIÓN (REQUERIDA)
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Descripción *",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (v) =>
                    v == null || v.isEmpty ? "Campo obligatorio" : null,
                onSaved: (v) => description = v!,
              ),

              const SizedBox(height: 12),

              /// CATEGORÍA
              DropdownButtonFormField<String>(
                value: category,
                decoration: const InputDecoration(
                  labelText: "Categoría",
                  border: OutlineInputBorder(),
                ),
                items: const [
                  "electronics",
                  "jewelery",
                  "men's clothing",
                  "women's clothing"
                ]
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (v) => category = v!,
              ),

              const SizedBox(height: 20),

              /// BOTÓN
              ElevatedButton(
                onPressed: submit,
                child: const Text("Crear Producto"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}