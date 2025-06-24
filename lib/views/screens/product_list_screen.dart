import 'package:flutter/material.dart';
import 'package:tokoperabot_uas_rioferdinand_22421011/models/product.dart';
import 'package:tokoperabot_uas_rioferdinand_22421011/controllers/product_controller.dart';
import 'edit_product_screen.dart'; // pastikan file ini ada

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductController _controller = ProductController();
  List<Product> _products = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final products = await _controller.getProducts(); // pastikan method ini ada
    setState(() {
      _products = products;
      _loading = false;
    });
  }

  void _deleteProduct(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Yakin ingin menghapus produk ini?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Batal")),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text("Hapus")),
        ],
      ),
    );

    if (confirm == true) {
      final success = await _controller.deleteProduct(id);
      if (success) {
        _fetchProducts(); // refresh
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Produk dihapus.')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Gagal hapus produk.')));
      }
    }
  }

  void _editProduct(Product product) async {
    final updated = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EditProductScreen(product: product)),
    );

    if (updated != null) {
      _fetchProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Produk")),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (_, index) {
          final product = _products[index];
          return ListTile(
            leading: Image.network(product.image ?? '-', width: 50, errorBuilder: (_, __, ___) => const Icon(Icons.image)),
            title: Text(product.title),
            subtitle: Text(product.category),
            trailing: Wrap(
              spacing: 8,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _editProduct(product),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteProduct(product.id.toString()),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
