import 'package:ecom_nesa/modules/home/model/products_model.dart';
import 'package:ecom_nesa/modules/home/view/product_detail.dart';
import 'package:flutter/material.dart';

class AllProductsGridHome extends StatefulWidget {
  List<Products> products;

  AllProductsGridHome({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  State<AllProductsGridHome> createState() => _AllProductsGridHomeState();
}

class _AllProductsGridHomeState extends State<AllProductsGridHome> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.66,
      ),
      itemCount: widget.products.length,
      itemBuilder: (context, index) {
        var products = widget.products[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetail(id: products?.id)));
          },
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                      child: Image.network(
                        "${products?.thumbnail}",
                        errorBuilder: (context, error, stackTrace) =>
                            CircularProgressIndicator(),
                      )),
                  SizedBox(
                    height: size * 0.02,
                  ),
                  Text(
                    (products?.title != null && products!.title!.length > 15)
                        ? "${products.title?.substring(0, 10)}..."
                        : products?.title ?? "",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.fade,
                  ),

                  SizedBox(
                    height: size * 0.02,
                  ),
                  Text(
                    "\$ ${products?.price ?? 0}",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ],
              )),
        );
      },
    );
  }
}
