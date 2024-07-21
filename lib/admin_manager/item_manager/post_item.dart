import 'package:flutter/material.dart';
import 'package:food_app/api/api_post.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';

class PostItem extends StatefulWidget {
  const PostItem({super.key});

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  final _formKey = GlobalKey<FormState>();
  final _idSPController = TextEditingController();
  final _idNhaHangController = TextEditingController();
  final _tenSPController = TextEditingController();
  final _chiTietController = TextEditingController();
  final _rateController = TextEditingController();
  final _giaTienController = TextEditingController();
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
    _idSPController.dispose();
    _idNhaHangController.dispose();
    _tenSPController.dispose();
    _chiTietController.dispose();
    _rateController.dispose();
    _giaTienController.dispose();
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
        'idSP': int.parse(_idSPController.text),
        'idNhaHang': int.parse(_idNhaHangController.text),
        'tenSP': _tenSPController.text,
        'ChiTiet': _chiTietController.text,
        'Rate': double.parse(_rateController.text),
        'GiaTien': int.parse(_giaTienController.text),
        'image': _imageController.text.isNotEmpty ? _imageController.text : _imageUrlController.text,
      };

      try {
        await postItem(product);
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
        title: Text('Thêm sản phẩm'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _idSPController,
                decoration: InputDecoration(labelText: 'ID Sản phẩm'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Hãy nhập ID sản phẩm';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _idNhaHangController,
                decoration: InputDecoration(labelText: 'ID Nhà Hàng'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Hãy nhập ID Nhà Hàng';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tenSPController,
                decoration: InputDecoration(labelText: 'Tên sản phẩm'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Hãy nhập tên sản phẩm';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _chiTietController,
                decoration: InputDecoration(labelText: 'Chi Tiết'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Hãy nhập Chi Tiết';
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
                    return 'Hãy nhập Rate';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _giaTienController,
                decoration: InputDecoration(labelText: 'Giá Tiền'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Hãy nhập Giá Tiền';
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
                child: Text('Thêm sản phẩm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

