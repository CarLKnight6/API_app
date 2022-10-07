

import 'package:api_app/views/addproduct.dart';

class AuthServices {


  AddProduct(){
          var response = await http.post(
        url,
        body: body,
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "Access-Control-Allow-Origin": "*",
          "Authorization": 'Bearer $token'
        },
      );
  }


  
}