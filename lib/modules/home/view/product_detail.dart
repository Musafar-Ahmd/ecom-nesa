import 'package:ecom_nesa/common/custom_button.dart';
import 'package:ecom_nesa/constants/app_colors.dart';
import 'package:ecom_nesa/modules/home/view/edit_product.dart';
import 'package:ecom_nesa/modules/home/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/home_view_model.dart';

class ProductDetail extends StatefulWidget {
  final int? id;

  const ProductDetail({super.key, required this.id});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  void initState() {
    final viewModel = Provider.of<HomeViewModel>(context, listen: false);
    viewModel.getProductsByID(widget.id);
    super.initState();
  }

  int imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    final product = viewModel.productById;
    var size = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: AppBar(
          backgroundColor: AppColors.scaffoldColor,
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (Route route) => false);
              },
              child: Icon(Icons.arrow_back)),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.favorite_border),
            ),
          ],
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: size * .05),
            _buildProductImagesSection(viewModel),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\$ ${product?.price ?? ""}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size * .07,
                        color: Colors.blue),
                  ),
                  SizedBox(height: size * .05),
                  Row(
                    children: [
                      Text(
                        product?.title ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size * .02,
                  ),
                  SizedBox(height: size * .02),
                  Wrap(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 0),
                          child: Text(
                            product?.description ?? "",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: size * .04,
                                color: Colors.grey),
                          ))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size * .1,
            ),
          ]),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomButton(
              borderRadius: 8,
              text: "Edit Product",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => EditProduct(
                              desciption: "${product?.description}",
                              name: "${product?.title}",
                              price: "${product?.price}",
                            )));
              }),
        ),
      ),
    );
  }

  Widget _buildProductImagesSection(HomeViewModel viewModel) {
    final product = viewModel.productById;
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(23),
          topRight: Radius.circular(23),
        ),
      ),
      child: Column(
        children: [
          if (imageIndex != null && imageIndex < (product?.images?.length ?? 0))
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, top: 5, bottom: 16, right: 15),
                  child: SizedBox(
                    height: 350,
                    width: 350,
                    child: PageView.builder(
                      itemCount: product?.images?.length ?? 0,
                      controller: PageController(initialPage: imageIndex ?? 0),
                      onPageChanged: (index) {
                        setState(() {
                          imageIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Image.network(
                          "${product?.images?[imageIndex]}",
                          fit: BoxFit.fill,
                          height: 250,
                          width: 250,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          if (product?.images != null)
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: SizedBox(
                height: 75,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: product?.images?.length ?? 0,
                  itemBuilder: (context, index) {
                    String imageUrl = product?.images?[index] ?? '';
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            imageIndex = index;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 12, left: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black)),
                            //   color: Colors.red,
                            height: 250,
                            child: AspectRatio(
                              aspectRatio: 7 / 7,
                              child: Image.network("$imageUrl"),
                            ),
                          ),
                        ));
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
