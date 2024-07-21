import 'package:flutter/material.dart';
import 'package:food_app/api/api_post.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';

class PostRestaurant extends StatefulWidget {
  const PostRestaurant({super.key});

  @override
  State<PostRestaurant> createState() => _PostRestaurantState();
}

class _PostRestaurantState extends State<PostRestaurant> {
  final _formKey = GlobalKey<FormState>();
  final _idNhaHangController = TextEditingController();
  final _TenNHController = TextEditingController();
  final _ChiTietNHController = TextEditingController();
  final _DiaChiController = TextEditingController();
  final _SDTController = TextEditingController();
  final _imageController = TextEditingController();
  final _imageUrlController = TextEditingController();
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _imageUrlController.addListener(_onImageUrlChanged);
  }

  @override
  void dispose() {
    _idNhaHangController.dispose();
    _TenNHController.dispose();
    _ChiTietNHController.dispose();
    _DiaChiController.dispose();
    _SDTController.dispose();
    _imageController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _onImageUrlChanged() {
    setState(() {
      if (_imageUrlController.text.isNotEmpty) {
        _imageFile = null;
        _imageController.clear();
      }
    });
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
        _imageUrlController.clear();
      });

      final bytes = await File(image.path).readAsBytes();
      String base64Image = base64Encode(bytes);
      _imageController.text = base64Image;
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final product = {
        'idNhaHang': int.parse(_idNhaHangController.text),
        'TenNH': _TenNHController.text,
        'ChiTietNH': _ChiTietNHController.text,
        'DiaChi': _DiaChiController.text,
        'SDT': int.parse(_SDTController.text),
        'image': _imageController.text.isNotEmpty ? _imageController.text : _imageUrlController.text,
      };

      try {
        await postRestaurant(product);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Thêm thành công'),
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Thêm thất bại'),
        ));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Thêm nhà hàng'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _idNhaHangController,
                decoration: InputDecoration(labelText: 'ID Nhà Hàng'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ID Nhà Hàng';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _TenNHController,
                decoration: InputDecoration(labelText: 'Tên nhà hàng'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Tên SP';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ChiTietNHController,
                decoration: InputDecoration(labelText: 'Chi Tiết'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Chi Tiết';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _DiaChiController,
                decoration: InputDecoration(labelText: 'Địa chỉ'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Rate';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _SDTController,
                decoration: InputDecoration(labelText: 'Số điện thoại'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Giá Tiền';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    if (_imageController.text.isEmpty) {
                      return 'Please pick an image or enter an Image URL';
                    }
                  }
                  return null;
                },
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: _imageUrlController.text.isEmpty ? _pickImage : null,
                child: Text('Pick Image'),
              ),
              SizedBox(height: 20),
              _imageFile != null
                  ? Image.file(
                      _imageFile!,
                      height: 200,
                    )
                  : Container(),
              TextFormField(
                controller: _imageController,
                decoration: InputDecoration(labelText: 'Image (Base64)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    if (_imageUrlController.text.isEmpty) {
                      return 'Please pick an image or enter an Image URL';
                    }
                  }
                  return null;
                },
                readOnly: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Thêm nhà hàng'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
