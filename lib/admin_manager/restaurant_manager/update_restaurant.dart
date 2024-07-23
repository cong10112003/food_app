import 'package:flutter/material.dart';
import 'package:food_app/api/api_put.dart';

class UpdateRestaurant extends StatefulWidget {
  final Map item;

  const UpdateRestaurant({Key? key, required this.item}) : super(key: key);

  @override
  State<UpdateRestaurant> createState() => _UpdateRestaurantState();
}

class _UpdateRestaurantState extends State<UpdateRestaurant> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _detailsController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;
  late TextEditingController _imageController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item['TenNH']);
    _detailsController = TextEditingController(text: widget.item['ChiTietNH']);
    _addressController = TextEditingController(text: widget.item['DiaChi'].toString());
    _phoneController = TextEditingController(text: widget.item['SDT'].toString());
    _imageController = TextEditingController(text: widget.item['image']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _detailsController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _imageController.dispose();
    super.dispose();
  }
  Future<void> _updateRestaurant() async {
    if (_formKey.currentState!.validate()) {
      final updatedRestaurant = {
        'idNhaHang': widget.item['idNhaHang'],
        'tenNH': _nameController.text,
        'ChiTietNH': _detailsController.text,
        'DiaChi': _addressController.text,
        'SDT': int.parse(_phoneController.text),
        'image': _imageController.text,
      };

      try {
        await updateRestaurant(widget.item['idNhaHang'].toString(), updatedRestaurant);
        Navigator.pop(context, updatedRestaurant);
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
        title: Text('Chỉnh sửa nhà hàng'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Tên nhà hàng'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên nhà hàng';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _detailsController,
                decoration: InputDecoration(labelText: 'Chi tiết'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mô tả';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Địa chỉ'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập địa chỉ';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Số điện thoại'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số điện thoại';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Số điện thoại phải là chữ số';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageController,
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập image URL';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateRestaurant,
                child: Text('Cập nhật nhà hàng'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}