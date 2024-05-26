import 'dart:convert';
import 'package:flutter/material.dart';
import'package:http/http.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  final TextEditingController _productNameTEController= TextEditingController();
  final TextEditingController _productCodeTEController= TextEditingController();
  final TextEditingController _unitPriceTEController= TextEditingController();
  final TextEditingController _quantityTEController= TextEditingController();
  final TextEditingController _totalTEController= TextEditingController();
  final TextEditingController _imageTEController= TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool addingInProgress = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(

            key: _formkey,

            child: Column(
              children: [

                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _productNameTEController,
                  decoration: const InputDecoration(
                    hintText: 'Product Name',
                    labelText: 'Enter Product Name',
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return ('Enter Product Name');
                    }
                    else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _productCodeTEController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(

                    hintText: 'Product Code',
                    labelText: 'Enter product Code',
                  ),
                  validator: (String? value) {
                    if (value == null || value
                        .trim()
                        .isEmpty) {
                      return ('Enter Product Code');
                    }
                    else {
                      return null;
                    }
                  },

                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _unitPriceTEController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(

                    hintText: 'Unit Price',
                    labelText: 'Enter Unit Price',
                  ),
                  validator: (String? value) {
                    if (value == null || value
                        .trim()
                        .isEmpty) {
                      return ('Enter Unit Price');
                    }
                    else {
                      return null;
                    }
                  },

                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _quantityTEController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Quantity',
                    labelText: 'Enter Quantity',
                  ),
                  validator: (String? value) {
                    if (value == null || value
                        .trim()
                        .isEmpty) {
                      return ('Enter Quantity');
                    }
                    else {
                      return null;
                    }
                  },

                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _totalTEController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Total Price',
                    labelText: 'EnterTotal Price',
                  ),

                  validator: (String? value) {
                    if (value == null || value
                        .trim()
                        .isEmpty) {
                      return ('Enter Total Price');
                    }
                    else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _imageTEController,
                  decoration: const InputDecoration(
                    hintText: 'Image',
                    labelText: 'Enter Image Link',
                  ),
                  validator: (String? value) {
                    if (value == null || value
                        .trim()
                        .isEmpty) {
                      return ('Enter Image Link');
                    }
                    else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 16),


                if(addingInProgress ==true)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else
                  ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {

                      _addProduct();


                    }
                  },
                  child: const Text('Add'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addProduct() async{

    addingInProgress = true;
    setState(() {});

    const String addURL='https://crud.teamrabbil.com/api/v1/CreateProduct';

    Map<String,dynamic> inputdata ={
        "Img":_imageTEController.text.trim(),
        "ProductCode":_productCodeTEController.text,
        "ProductName":_productNameTEController.text,
        "Qty":_quantityTEController.text,
        "TotalPrice":_totalTEController.text,
        "UnitPrice":_unitPriceTEController.text
    };

    Uri uri = Uri.parse(addURL);
    Response response = await post(uri,body: jsonEncode(inputdata),headers: {
      'content-type' : 'application/json'});
    print(response.statusCode);

    addingInProgress = false;
    setState(() {});


}


  @override
  void dispose() {
    _productNameTEController.dispose();
    _unitPriceTEController.dispose();
    _quantityTEController.dispose();
    _totalTEController.dispose();
    _imageTEController.dispose();
    _productCodeTEController.dispose();
    super.dispose();
  }

}
