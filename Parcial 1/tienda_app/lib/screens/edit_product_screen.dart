import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;
  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _api = ApiService();

  late String title;
  late String description;
  late String category;
  late double price;
  late String imageUrl;

  @override
  void initState() {
    super.initState();
    title = widget.product.title;
    description = widget.product.description;
    category = widget.product.category;
    price = widget.product.price;
    imageUrl = widget.product.image;
  }

  Future<void> _updateProduct() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    try {
      final updatedProduct = Product(
        id: widget.product.id,
        title: title,
        price: price,
        description: description,
        category: category,
        image: imageUrl,
      );

      await _api.updateProduct(widget.product.id!, updatedProduct);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Producto actualizado con éxito')),
        );
        Navigator.pop(context, true); // devuelve true para refrescar
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Producto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: title,
                decoration: const InputDecoration(labelText: 'Título *'),
                validator: (v) => v == null || v.isEmpty ? 'Obligatorio' : null,
                onSaved: (v) => title = v!,
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: price.toString(),
                decoration: const InputDecoration(labelText: 'Precio *'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Obligatorio';
                  if (double.tryParse(v) == null) return 'Número válido';
                  return null;
                },
                onSaved: (v) => price = double.parse(v!),
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: description,
                decoration: const InputDecoration(labelText: 'Descripción *'),
                maxLines: 3,
                validator: (v) => v == null || v.isEmpty ? 'Obligatorio' : null,
                onSaved: (v) => description = v!,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: category,
                decoration: const InputDecoration(labelText: 'Categoría *'),
                items: const [
                  'electronics',
                  'jewelery',
                  "men's clothing",
                  "women's clothing"
                ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) => category = v!,
                validator: (v) => v == null ? 'Selecciona una categoría' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: imageUrl,
                decoration: const InputDecoration(labelText: 'URL de imagen'),
                onSaved: (v) => imageUrl = v!,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _updateProduct,
                child: const Text('Actualizar Producto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}