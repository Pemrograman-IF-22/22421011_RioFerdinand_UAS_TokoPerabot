import 'package:flutter/material.dart';
import 'package:tokoperabot_uas_rioferdinand_22421011/models/product.dart';
import 'package:tokoperabot_uas_rioferdinand_22421011/controllers/product_controller.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;

  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descController;
  late TextEditingController _priceController;
  late TextEditingController _imageUrlController;
  late TextEditingController _categoryController;

  final ProductController _productController = ProductController();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.product.title);
    _descController = TextEditingController(text: widget.product.description);
    _priceController = TextEditingController(text: widget.product.price.toString());
    _imageUrlController = TextEditingController(text: widget.product.image);
    _categoryController = TextEditingController(text: widget.product.category);
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (widget.product.id == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ID produk tidak ditemukan')),
        );
        return;
      }

      final updatedProduct = Product(
        title: _titleController.text,
        description: _descController.text,
        price: double.tryParse(_priceController.text) ?? 0,
        image: _imageUrlController.text,
        category: _categoryController.text,
      );

      final success = await _productController.updateProduct(
        widget.product.id.toString(),
        updatedProduct,
      );

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Produk berhasil diperbarui!')),
        );
        Navigator.pop(context, updatedProduct);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal memperbarui produk')),
        );
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text("Edit Produk"),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildInputField(
                label: 'Nama Produk',
                controller: _titleController,
              ),
              const SizedBox(height: 16),
              _buildInputField(
                label: 'Deskripsi',
                controller: _descController,
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              _buildInputField(
                label: 'Harga',
                controller: _priceController,
                inputType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _buildInputField(
                label: 'Kategori',
                controller: _categoryController,
              ),
              const SizedBox(height: 16),
              _buildInputField(
                label: 'URL Gambar',
                controller: _imageUrlController,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _submitForm,
                icon: const Icon(Icons.save),
                label: const Text('Perbarui Produk'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    TextInputType inputType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade800, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
    );
  }
}
