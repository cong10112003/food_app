import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String FOOD_ITEM = "http://192.168.1.13:3030/api/";
class DeleteItem extends StatefulWidget {
  const DeleteItem({super.key});

  @override
  State<DeleteItem> createState() => _DeleteItemState();
}

class _DeleteItemState extends State<DeleteItem> {
  final _formKey = GlobalKey<FormState>();
  final _idSPController = TextEditingController();

  Future<void> deleteProduct(int idSP) async {
    final response = await http.delete(Uri.parse('$FOOD_ITEM/SanPhams/$idSP'));

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product deleted successfully.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete product.')),
      );
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final idSP = int.parse(_idSPController.text);
      deleteProduct(idSP);
    }
  }

  @override
  void dispose() {
    _idSPController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _idSPController,
                decoration: InputDecoration(labelText: 'ID SP'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ID SP';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Delete Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}