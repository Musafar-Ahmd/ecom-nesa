import 'package:ecom_nesa/common/custom_button.dart';
import 'package:ecom_nesa/common/custom_input_decoration.dart';
import 'package:ecom_nesa/modules/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({super.key});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _name = TextEditingController();
  final _price = TextEditingController();
  final _description = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: size * 0.1,
                ),
                TextFormField(
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Name Cant be Empty";
                    }
                    _name.text = v;
                  },
                  controller: _name,
                  decoration: inputDecorationWithBorder(
                      color: Colors.black, hintText: "Product Name"),
                ),
                SizedBox(
                  height: size * 0.05,
                ),
                TextFormField(
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Price Cant be Empty";
                    }
                    _price.text = v;
                  },
                  controller: _price,
                  decoration: inputDecorationWithBorder(
                      color: Colors.black, hintText: "Product Price"),
                ),
                SizedBox(
                  height: size * 0.05,
                ),
                TextFormField(
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Description Cant be Empty";
                    }
                    _description.text = v;
                  },
                  controller: _description,
                  maxLines: 5,
                  decoration: inputDecorationWithBorder(
                    hintText: "Product Description",
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: size * 0.2,
                ),
                CustomButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      viewModel.updateProduct(viewModel.productById?.id,
                          context, _name, _description, _price);
                    }
                  },
                  text: "Update",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}