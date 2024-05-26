import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_list_app/Product_Model_Class.dart';
import 'package:http/http.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key,required this.product});

  final ProductModel product;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreen();
}

class _UpdateProductScreen extends State<UpdateProductScreen> {

  final TextEditingController _productNameTEController= TextEditingController();
  final TextEditingController _productCodeTEController= TextEditingController();
  final TextEditingController _unitPriceTEController= TextEditingController();
  final TextEditingController _quantityTEController= TextEditingController();
  final TextEditingController _totalTEController= TextEditingController();
  final TextEditingController _imageTEController= TextEditingController();


  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool updateProductInProgess = false;


  @override
  void initState() {
    super.initState();

    _productNameTEController.text = widget.product.productName!;
    _productCodeTEController.text = widget.product.productCode!;
    _unitPriceTEController.text = widget.product.unitPrice!;
    _quantityTEController.text = widget.product.qty!;
    _totalTEController.text = widget.product.totalPrice!;
    _imageTEController.text = widget.product.img!;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
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
                    labelText: 'Edit Product Name',
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return ('Edit Product Name');
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
                    labelText: 'Edit product Code',
                  ),
                  validator: (String? value) {
                    if (value == null || value
                        .trim()
                        .isEmpty) {
                      return ('Edit Product Code');
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
                    labelText: 'Edit Unit Price',
                  ),
                  validator: (String? value) {
                    if (value == null || value
                        .trim()
                        .isEmpty) {
                      return ('Edit Unit Price');
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
                    labelText: 'Edit Quantity',
                  ),
                  validator: (String? value) {
                    if (value == null || value
                        .trim()
                        .isEmpty) {
                      return ('Edit Quantity');
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
                    labelText: 'Edit Total Price',
                  ),

                  validator: (String? value) {
                    if (value == null || value
                        .trim()
                        .isEmpty) {
                      return ('Edit Total Price');
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
                    labelText: 'ReEnter Image Link',
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return ('ReEnter Image Link');
                    }
                    else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 16),

                Visibility(
                  visible: updateProductInProgess == false,
                  replacement: Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {

                        _updateProduct();


                      }
                    },
                    child: const Text('Update'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> _updateProduct() async{
    updateProductInProgess =true;
    setState(() {});

    Map<String, String> inputData = {
      "Img":_imageTEController.text.trim(),
      "ProductCode":_productCodeTEController.text,
      "ProductName":_productNameTEController.text,
      "Qty":_quantityTEController.text,
      "TotalPrice":_totalTEController.text,
      "UnitPrice":_unitPriceTEController.text
    };

    String updateProductUrl =
        'https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.Id}';
    Uri uri = Uri.parse(updateProductUrl);
    Response response = await post(uri,
        headers: {'content-type': 'application/json'},
        body: jsonEncode(inputData));

    print(response.statusCode);


    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product has been updated')),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Update product failed! Try again.')),
      );
    }

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
