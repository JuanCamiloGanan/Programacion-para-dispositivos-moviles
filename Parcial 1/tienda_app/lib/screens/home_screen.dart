import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/product.dart';
import 'detail_screen.dart';
import 'create_product_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> futureProducts;
  final api = ApiService();

  @override
  void initState() {
    super.initState();
    futureProducts = api.fetchProducts();
  }

  void reload() {
    setState(() {
      futureProducts = api.fetchProducts();
    });
  }

  Future<void> refresh() async {
    reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tienda"),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CreateProductScreen()),
          );

          if (result != null) reload();
        },
      ),

      body: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Error al cargar productos"),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: reload,
                    child: const Text("Reintentar"),
                  )
                ],
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("No hay productos"));
          }

          final products = snapshot.data!;

          return RefreshIndicator(
            onRefresh: refresh,
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (_, i) {
                final p = products[i];

                return GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(product: p),
                      ),
                    );

                    if (result != null) reload();
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Image.network(
                              p.image,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            p.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          "\$${p.price}",
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}