import 'dart:convert';
import 'package:assignment_3/data/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:assignment_3/data/utils/urls.dart';

class ProductController{
  List<Data> products = [];

  Future<void> fetchProducts() async{
    final response = await http.get(Uri.parse(Urls.readProduct));
    //print(response.body);
    print(response.statusCode);
    if(response.statusCode ==200){
      final data = jsonDecode(response.body);
      productModel model = productModel.fromJson(data);
      products = model.data ?? [];
    }
    //print(products);
  }

  Future<void> createProduct(String name,String img,int qty, int price, int totalPrice) async{
    final response = await http.post(Uri.parse(Urls.createProduct),
        headers: {'Content-Type' : 'application/json'},
        body: jsonEncode({

          "ProductName": name,
          "ProductCode": DateTime.now().microsecondsSinceEpoch,
          "Img": img,
          "Qty": qty,
          "UnitPrice": price,
          "TotalPrice": totalPrice

        })

    );
    //print(response.body);
    print(response.statusCode);
    if(response.statusCode ==201){
      fetchProducts();
    }
    //print(products);
  }

  Future<void> updateProduct(String id,String name,String img,int qty, int price, int totalPrice) async{
    final response = await http.post(Uri.parse(Urls.updateProduct(id)),
        headers: {'Content-Type' : 'application/json'},
        body: jsonEncode({

          "ProductName": name,
          "ProductCode": DateTime.now().microsecondsSinceEpoch,
          "Img": img,
          "Qty": qty,
          "UnitPrice": price,
          "TotalPrice": totalPrice

        })

    );
    //print(response.body);
    print(response.statusCode);
    if(response.statusCode ==201){
      fetchProducts();
    }
    //print(products);
  }

  Future<bool> deleteProducts(String id) async{
    final response = await http.get(Uri.parse(Urls.deleteProduct(id)));
    //print(response.body);
    print(response.statusCode);
    if(response.statusCode ==200){
      return true;
    }else{
      return false;
    }
    //print(products);
  }
}