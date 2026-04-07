import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import 'edit_product_screen.dart';

class DetailScreen extends StatelessWidget {
  final Product product;
  final ApiService api = ApiService();

  DetailScreen({super.key, required this.product});

  Future<void> delete(BuildContext context) async {
    try {
      await api.deleteProduct(product.id!);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Producto eliminado")),
        );

        Navigator.pop(context, true); // <- refresca Home
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error al eliminar")),
      );
    }
  }

  Future<void> goToEdit(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditProductScreen(product: product),
      ),
    );

    if (result == true && context.mounted) {
      Navigator.pop(context, true); // <- refresca Home
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle del Producto"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// IMAGEN GRANDE
              Center(
                child: Image.network(
                  product.image,
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 16),

              /// TÍTULO
              Text(
                product.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              /// PRECIO
              Text(
                "\$${product.price}",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              /// CATEGORÍA
              Text(
                "Categoría: ${product.category}",
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 16),

              /// DESCRIPCIÓN
              Text(
                product.description,
                style: const TextStyle(fontSize: 15),
              ),

              const SizedBox(height: 16),

              /// RATING
              if (product.rating != null)
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    const SizedBox(width: 5),
                    Text(
                      "${product.rating!.rate} (${product.rating!.count} reviews)",
                    ),
                  ],
                ),

              const SizedBox(height: 30),

              /// BOTONES
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  ElevatedButton.icon(
                    onPressed: () => goToEdit(context),
                    icon: const Icon(Icons.edit),
                    label: const Text("Editar"),
                  ),

                  ElevatedButton.icon(
                    onPressed: () => delete(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    icon: const Icon(Icons.delete),
                    label: const Text("Eliminar"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}