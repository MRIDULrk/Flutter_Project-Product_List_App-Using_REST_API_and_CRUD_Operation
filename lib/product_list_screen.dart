
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:product_list_app/Product_Model_Class.dart';
import 'package:product_list_app/add_product_screen.dart';
import 'package:product_list_app/update_product_screen.dart';
import 'package:http/http.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  bool _ProductListInProgress = false;
  List<ProductModel> productList = [];

  @override
  void initState() {

    super.initState();
    _getProductList();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      
      body: RefreshIndicator(
        onRefresh: _getProductList,
          child: Visibility(
            visible: _ProductListInProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),


          child:
          ListView.separated(

              itemCount: productList.length,

              itemBuilder: (context,index){

                return _buildProductList(productList[index]);

              },
                separatorBuilder: (context,index){
                  return const Divider();
                },
              ),
        ),
      ),

            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.lightGreen,
              foregroundColor: Colors.white,

              onPressed: (){
                Navigator.push(context,
                 MaterialPageRoute(builder: (context) => const AddProductScreen()));
            },
              child: Icon(Icons.add),
            ),


    );
  }

  Future<void> _getProductList() async{

    _ProductListInProgress = true;
    setState(() {});
    productList.clear();
    const String ProductListURL ='https://crud.teamrabbil.com/api/v1/ReadProduct';
    Uri uri = Uri.parse(ProductListURL);
    Response response = await get(uri);
    print(response.statusCode);

    if(response.statusCode==200){
      final decodeData = jsonDecode(response.body);

      final jsonProductList = decodeData['data'];

      for(Map<String,dynamic> json in jsonProductList){
        ProductModel productmodel = ProductModel.fromJson(json);
        productList.add(productmodel);

      }

    }else {
      _ProductListInProgress = false;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fetching product failed! Try again.')),
      );
    }

    _ProductListInProgress = false;
    setState(() {});

  }


  Widget _buildProductList(ProductModel product) {
    return ListTile(

          leading: Image.network('${product.img}',
          height: 80,
          width: 80,
          ),
            title:  Text(product.productName ?? 'Unknown'),
            subtitle: Wrap(
              spacing: 16,
                children: [
                  Text('Unit Price: ${product.unitPrice}'),
                  Text('Quantity: ${product.qty}'),
                  Text('Total Price: ${product.totalPrice}'),

                ]
            ),
            trailing: Wrap(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateProductScreen(product: product)
                      ),
                    );
                  },
                ),


              IconButton(
                    icon:  Icon(Icons.delete_outline_sharp),
                    onPressed: (){
                      _ShowDeleteDialouge('${product.Id}');

                    },),

              ],
            ),
          );
  }

  void _ShowDeleteDialouge(String productID) {
    showDialog(context: context, builder: (context)
      {
        return AlertDialog(
          title: const Text('Delete'),
          content: const Text('Are You Want to sure to delete?'),
          actions: [
            TextButton(onPressed: () {
              Navigator.pop(context);

            }, child: const Text('Cancel')),

            TextButton(onPressed: () {

              _deleteProductList(productID);
              Navigator.pop(context);

            }, child: const Text('Yes')),

          ],
        );
      });
  }


  Future<void> _deleteProductList(String productID) async{

    _ProductListInProgress = true;
    setState(() {});

    String DeleteProductURL ='https://crud.teamrabbil.com/api/v1/DeleteProduct/$productID';
    Uri uri = Uri.parse(DeleteProductURL);
    Response response = await get(uri);
    print(response.statusCode);

    if(response.statusCode==200){

      _getProductList();


      }else {
      _ProductListInProgress = false;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Delete product failed! Try again.')),
      );
    }



    }



  }



