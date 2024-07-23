import 'package:flutter/material.dart';
import 'package:food_app/api/api_put.dart';

class UpdateItem extends StatefulWidget {
  final Map item;

  const UpdateItem({Key? key, required this.item}) : super(key: key);

  @override
  State<UpdateItem> createState() => _UpdateItemState();
}

class _UpdateItemState extends State<UpdateItem> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _detailsController;
  late TextEditingController _rateController;
  late TextEditingController _priceController;
  late TextEditingController _imageController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item['tenSP']);
    _detailsController = TextEditingController(text: widget.item['ChiTiet']);
    _rateController = TextEditingController(text: widget.item['Rate'].toString());
    _priceController = TextEditingController(text: widget.item['GiaTien'].toString());
    _imageController = TextEditingController(text: widget.item['image']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _detailsController.dispose();
    _rateController.dispose();
    _priceController.dispose();
    _imageController.dispose();
    super.dispose();
  }
  Future<void> _updateItem() async {
    if (_formKey.currentState!.validate()) {
      final updatedItem = {
        'idSP': widget.item['idSP'],
        'idNhaHang': widget.item['idNhaHang'],
        'tenSP': _nameController.text,
        'ChiTiet': _detailsController.text,
        'Rate': int.parse(_rateController.text),
        'GiaTien': int.parse(_priceController.text),
        'image': _imageController.text,
      };

      try {
        await updateItem(widget.item['idSP'].toString(), updatedItem);
        Navigator.pop(context, updatedItem);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update item: $e')),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chỉnh sửa sản phẩm'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _detailsController,
                decoration: InputDecoration(labelText: 'Details'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter details';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _rateController,
                decoration: InputDecoration(labelText: 'Rate'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a rate';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageController,
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateItem,
                child: Text('Update Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}