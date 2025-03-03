import 'package:flutter/material.dart';
import 'package:assignment_3/presentation/ui/screens/product_controller.dart';
import 'package:assignment_3/presentation/ui/widgets/product_card.dart';

class CrudProject extends StatefulWidget{
  const CrudProject({super.key});

  @override
  State<CrudProject> createState()=> _CrudProject();
}

class _CrudProject extends State<CrudProject>{


  final ProductController productController = ProductController();




  void productDialog({String ? id, String ? name, int ? qty,String ? img, int ? unitPrice, int ? totalPrice}){



    TextEditingController productNameController = TextEditingController();
    TextEditingController productCodeController = TextEditingController();
    TextEditingController productQtyController = TextEditingController();
    TextEditingController productImageController = TextEditingController();
    TextEditingController productUnitPriceController = TextEditingController();
    TextEditingController productTotalPriceController = TextEditingController();

    productNameController.text = name?? '';
    productQtyController.text = qty !=null ? qty.toString(): '0';
    productImageController.text = img ?? '';
    productUnitPriceController.text = unitPrice !=null ? unitPrice.toString(): '0';
    productTotalPriceController.text = totalPrice!=null ? totalPrice.toString(): '0';

    showDialog(context: context, builder: (context)=>AlertDialog(
      title: Text(id == null ? 'Add Product': 'Update product'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: productNameController,
            decoration: InputDecoration(labelText: 'Product Name'),),

          TextField(
            controller:  productImageController,
            decoration: InputDecoration(labelText: 'Product Image'),),
          TextField(
            controller: productQtyController,
            decoration: InputDecoration(labelText: 'Product Qty'),),
          TextField(
            controller: productUnitPriceController,
            decoration: InputDecoration(labelText: 'Product unitPrice'),),
          TextField(
            controller: productTotalPriceController,
            decoration: InputDecoration(labelText: 'Total Price'),),
          SizedBox(height: 10,),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Close')),
              SizedBox(width: 5,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: (){

                    if(id == null) {
                      productController.createProduct(productNameController
                          .text, productImageController.text, int.parse(
                          productQtyController.text), int.parse(
                          productUnitPriceController.text), int.parse(
                          productTotalPriceController.text));
                    }else{
                      productController.updateProduct(id,productNameController
                          .text, productImageController.text, int.parse(
                          productQtyController.text), int.parse(
                          productUnitPriceController.text), int.parse(
                          productTotalPriceController.text));
                    }

                    fetchData();
                    Navigator.pop(context);
                    setState(() {



                    });
                  }, child: Text(id == null ? 'Add Product': 'Update product')),
            ],
          )
        ],
      ),
    ));
  }

  Future<void> fetchData() async{
    await productController.fetchProducts();
    print(productController.products.length);
    setState(()  {

    });


  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    fetchData();
    //ProductController().fetchProducts();
    //print(ProductController().products.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('Products'),
        backgroundColor: Colors.blue,
        centerTitle: true,

      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemCount: productController.products.length,
        itemBuilder: (context,index){
          var product = productController.products[index];
          return  ProductCard(product: product,
            onEdit: ()=>productDialog(
              id: product.sId,
              name: product.productName,
              img: product.img,
              qty: product.qty,
              unitPrice: product.unitPrice,
              totalPrice: product.totalPrice,
            ),
            onDelete: (){
              productController.deleteProducts(product.sId.toString()).then((value){
                if(value){
                  setState(() {
                    fetchData();
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Product Deleted"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Something wrong try again"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: ()=>productDialog(),

        child: Icon(Icons.add),),
    );
  }
}