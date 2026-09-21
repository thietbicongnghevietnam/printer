import 'dart:convert';
import 'package:http/http.dart' as http;

import '../ModelUI/class_api_IQC.dart';

Future<List<Map<String, dynamic>>> Query_Login(String userid) async {
  //String apiUrl = 'http://10.92.184.22:8028/api/Free/Query_Login';
  String apiUrl = 'http://192.168.128.131:8031/Query_Login';
  // Create the request body using a Map
  Map<String, String> requestData = {
    "userid": userid,
  };

  // Encode the request data to JSON
  String requestBody = json.encode(requestData);

  // Make the API POST request
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  );

  if (response.statusCode == 200) {
    // old
    //List<dynamic> responseData = json.decode(response.body);
    //2026
    final List<dynamic> responseData = json.decode(response.body) as List<dynamic>;
    // Convert the response data to a List<Map<String, dynamic>>
    List<Map<String, dynamic>> dataTable = List<Map<String, dynamic>>.from(responseData);

    return dataTable;
  } else {
    throw Exception(
        'Failed API login: ${response.statusCode}');
  }
}

Future<List<Map<String, dynamic>>> Query_thongtinbarcode(String chuoibarcode, String typerecheck) async {
  //String apiUrl = 'http://10.92.184.22:8028/api/Free/Query_thongtinbarcode';
  String apiUrl = 'http://192.168.128.131:8031/Query_thongtinbarcode';
  // Create the request body using a Map
  Map<String, String> requestData = {
    "chuoibarcode": chuoibarcode,
    "typerecheck": typerecheck,
  };

  // Encode the request data to JSON
  String requestBody = json.encode(requestData);

  // Make the API POST request
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  );

  if (response.statusCode == 200) {
    // Decode the response JSON
    //List<dynamic> responseData = json.decode(response.body);
    final List<dynamic> responseData = json.decode(response.body) as List<dynamic>;

    // Convert the response data to a List<Map<String, dynamic>>
    List<Map<String, dynamic>> dataTable = List<Map<String, dynamic>>.from(responseData);

    return dataTable;
  } else {
    throw Exception(
        'Failed API login: ${response.statusCode}');
  }
}

Future<List<Map<String, dynamic>>> Query_CheckUnitbox(String chuoibarcode) async {
  //String apiUrl = 'http://10.92.184.22:8028/api/Free/Query_CheckUnitbox';
  String apiUrl = 'http://192.168.128.131:8031/Query_CheckUnitbox';
  // Create the request body using a Map
  Map<String, String> requestData = {
    "chuoibarcode": chuoibarcode
  };

  // Encode the request data to JSON
  String requestBody = json.encode(requestData);

  // Make the API POST request
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  );

  if (response.statusCode == 200) {
    // Decode the response JSON
    //List<dynamic> responseData = json.decode(response.body);
    final List<dynamic> responseData = json.decode(response.body) as List<dynamic>;

    // Convert the response data to a List<Map<String, dynamic>>
    List<Map<String, dynamic>> dataTable = List<Map<String, dynamic>>.from(responseData);

    return dataTable;
  } else {
    throw Exception(
        'Failed API login: ${response.statusCode}');
  }
}

Future<List<Map<String, dynamic>>> Query_thongtinbarcode2(String chuoibarcode) async {
  //String apiUrl = 'http://10.92.184.22:8028/api/Free/Query_thongtinbarcode2';
  String apiUrl = 'http://192.168.128.131:8031/Query_thongtinbarcode2';
  // Create the request body using a Map
  Map<String, String> requestData = {
    "chuoibarcode": chuoibarcode,
  };

  // Encode the request data to JSON
  String requestBody = json.encode(requestData);

  // Make the API POST request
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  );

  if (response.statusCode == 200) {
    // Decode the response JSON
    //List<dynamic> responseData = json.decode(response.body);
    final List<dynamic> responseData = json.decode(response.body) as List<dynamic>;

    // Convert the response data to a List<Map<String, dynamic>>
    List<Map<String, dynamic>> dataTable = List<Map<String, dynamic>>.from(responseData);

    return dataTable;
  } else {
    throw Exception(
        'Failed API login: ${response.statusCode}');
  }
}

Future<List<Map<String, dynamic>>> Query_thongtinreceivingcard(String chuoibarcode, String typerecheck) async {
  //String apiUrl = 'http://10.92.184.22:8028/api/Free/Query_thongtinreceivingcard';
  String apiUrl = 'http://192.168.128.131:8031/Query_thongtinreceivingcard';
  // Create the request body using a Map
  Map<String, String> requestData = {
    "chuoibarcode": chuoibarcode,
    "typerecheck": typerecheck,
  };

  // Encode the request data to JSON
  String requestBody = json.encode(requestData);

  // Make the API POST request
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  );

  if (response.statusCode == 200) {
    // Decode the response JSON
    //List<dynamic> responseData = json.decode(response.body);
    final List<dynamic> responseData = json.decode(response.body) as List<dynamic>;

    // Convert the response data to a List<Map<String, dynamic>>
    List<Map<String, dynamic>> dataTable = List<Map<String, dynamic>>.from(responseData);

    return dataTable;
  } else {
    throw Exception(
        'Failed API login: ${response.statusCode}');
  }
}

Future<List<Map<String, dynamic>>> Query_update_check_QC(String ID,String codate,String remark,String soluonghuy_spl,String soluonghuy_rohs,String user_finished_spl,String user_finished_rohs,String user_check_spl, String user_check_rohs,String ketqua_spl,String ketqua_rohs,String kieucheck,String user_dangnhap,String trangthai_check_sql, String trangthai_check_rohs, String trangthai_TTcheck, String invoice_,SLNG, String typerecheck, String check1lan, String barcodebox) async {
  //String apiUrl = 'http://10.92.184.22:8028/api/Free/Query_update_check_QC';
  String apiUrl = 'http://192.168.128.131:8031/Query_update_check_QC';
  // Create the request body using a Map
  Map<String, String> requestData = {
    "ID": ID,
    "codate": codate,
    "remark": remark,
    "soluonghuy_spl": soluonghuy_spl,
    "soluonghuy_rohs": soluonghuy_rohs,
    "user_finished_spl": user_finished_spl,
    "user_finished_rohs": user_finished_rohs,
    "user_check_spl": user_check_spl,
    "user_check_rohs": user_check_rohs,
    "ketqua_spl": ketqua_spl,
    "ketqua_rohs": ketqua_rohs,
    "kieucheck": kieucheck,
    "user_dangnhap": user_dangnhap,
    "trangthai_check_sql": trangthai_check_sql,
    "trangthai_check_rohs": trangthai_check_rohs,
    "trangthai_TTcheck": trangthai_TTcheck,
    "invoice_": invoice_,
    "SLNG": SLNG.toString(),
    "typerecheck": typerecheck,
    "check1lan": check1lan,
    "barcodebox": barcodebox,
  };

  // Encode the request data to JSON
  String requestBody = json.encode(requestData);

  // Make the API POST request
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  );

  if (response.statusCode == 200) {
    // Decode the response JSON
    //List<dynamic> responseData = json.decode(response.body);
    final List<dynamic> responseData = json.decode(response.body) as List<dynamic>;

    // Convert the response data to a List<Map<String, dynamic>>
    List<Map<String, dynamic>> dataTable = List<Map<String, dynamic>>.from(responseData);

    return dataTable;
  } else {
    throw Exception(
        'Failed Query_update_check_QC: ${response.statusCode}');
  }
}

Future<List<Map<String, dynamic>>> Query_update_check_QC_1nam(String ID,String codate,String remark,String soluonghuy_spl,String soluonghuy_rohs,String user_finished_spl,String user_finished_rohs,String user_check_spl, String user_check_rohs,String ketqua_spl,String ketqua_rohs,String kieucheck,String user_dangnhap,String trangthai_check_sql, String trangthai_check_rohs, String trangthai_TTcheck, String invoice_,SLNG, String typerecheck, String check1lan) async {
  //String apiUrl = 'http://10.92.184.22:8028/api/Free/Query_update_check_QC_1nam';
  String apiUrl = 'http://192.168.128.131:8031/Query_update_check_QC_1nam';
  // Create the request body using a Map
  Map<String, String> requestData = {
    "ID": ID,
    "codate": codate,
    "remark": remark,
    "soluonghuy_spl": soluonghuy_spl,
    "soluonghuy_rohs": soluonghuy_rohs,
    "user_finished_spl": user_finished_spl,
    "user_finished_rohs": user_finished_rohs,
    "user_check_spl": user_check_spl,
    "user_check_rohs": user_check_rohs,
    "ketqua_spl": ketqua_spl,
    "ketqua_rohs": ketqua_rohs,
    "kieucheck": kieucheck,
    "user_dangnhap": user_dangnhap,
    "trangthai_check_sql": trangthai_check_sql,
    "trangthai_check_rohs": trangthai_check_rohs,
    "trangthai_TTcheck": trangthai_TTcheck,
    "invoice_": invoice_,
    "SLNG": SLNG.toString(),
    "typerecheck": typerecheck,
    "check1lan": check1lan,
  };

  // Encode the request data to JSON
  String requestBody = json.encode(requestData);

  // Make the API POST request
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  );

  if (response.statusCode == 200) {
    // Decode the response JSON
    //List<dynamic> responseData = json.decode(response.body);
    final List<dynamic> responseData = json.decode(response.body) as List<dynamic>;

    // Convert the response data to a List<Map<String, dynamic>>
    List<Map<String, dynamic>> dataTable = List<Map<String, dynamic>>.from(responseData);

    return dataTable;
  } else {
    throw Exception(
        'Failed API login: ${response.statusCode}');
  }
}

Future<List<Map<String, dynamic>>> Query_update_check_QC_recheck(String ID,String codate,String remark,String soluonghuy_spl,String soluonghuy_rohs,String user_finished_spl,String user_finished_rohs,String user_check_spl, String user_check_rohs,String ketqua_spl,String ketqua_rohs,String kieucheck,String user_dangnhap,String trangthai_check_sql, String trangthai_check_rohs, String trangthai_TTcheck, String invoice_,SLNG, String typerecheck, String check1lan) async {
  //String apiUrl = 'http://10.92.184.22:8028/api/Free/Query_update_check_QC_recheck';
  String apiUrl = 'http://192.168.128.131:8031/Query_update_check_QC_recheck';
  // Create the request body using a Map
  Map<String, String> requestData = {
    "ID": ID,
    "codate": codate,
    "remark": remark,
    "soluonghuy_spl": soluonghuy_spl,
    "soluonghuy_rohs": soluonghuy_rohs,
    "user_finished_spl": user_finished_spl,
    "user_finished_rohs": user_finished_rohs,
    "user_check_spl": user_check_spl,
    "user_check_rohs": user_check_rohs,
    "ketqua_spl": ketqua_spl,
    "ketqua_rohs": ketqua_rohs,
    "kieucheck": kieucheck,
    "user_dangnhap": user_dangnhap,
    "trangthai_check_sql": trangthai_check_sql,
    "trangthai_check_rohs": trangthai_check_rohs,
    "trangthai_TTcheck": trangthai_TTcheck,
    "invoice_": invoice_,
    "SLNG": SLNG.toString(),
    "typerecheck": typerecheck,
    "check1lan": check1lan,
  };

  // Encode the request data to JSON
  String requestBody = json.encode(requestData);

  // Make the API POST request
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  );

  if (response.statusCode == 200) {
    // Decode the response JSON
    final List<dynamic> responseData = json.decode(response.body) as List<dynamic>;

    // Convert the response data to a List<Map<String, dynamic>>
    List<Map<String, dynamic>> dataTable = List<Map<String, dynamic>>.from(responseData);

    return dataTable;
  } else {
    throw Exception(
        'Failed API login: ${response.statusCode}');
  }
}

Future<List<Map<String, dynamic>>> Query_insert_recheck(String barcode,String mahang,String vitri,String soluong,String plant,String deliverydate,String dano,String pono,String vender,String ctrkey,String ctrt,String sloc,String lotdate, String CateQC, String invoice,String idrecheck, String codate,String remark, String createuser,String typerecheck) async {
  //String apiUrl = 'http://10.92.184.22:8028/api/Free/Query_insert_recheck';
  String apiUrl = 'http://192.168.128.131:8031/Query_insert_recheck';
  // Create the request body using a Map
  Map<String, String> requestData = {
    "barcode": barcode,
    "mahang": mahang,
    "vitri": vitri,
    "soluong": soluong,
    "plant": plant,
    "deliverydate": deliverydate,
    "dano": dano,
    "pono": pono,
    "vender": vender,
    "ctrkey": ctrkey,
    "ctrt": ctrt,
    "sloc": sloc,
    "lotdate": lotdate,
    "CateQC": CateQC,
    "invoice": invoice,
    "idrecheck": idrecheck,
    "codate": codate,
    "remark": remark,
    "createuser": createuser,
    "typerecheck": typerecheck,
  };

  // Encode the request data to JSON
  String requestBody = json.encode(requestData);

  // Make the API POST request
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  );

  if (response.statusCode == 200) {
    // Decode the response JSON
    final List<dynamic> responseData = json.decode(response.body) as List<dynamic>;

    // Convert the response data to a List<Map<String, dynamic>>
    List<Map<String, dynamic>> dataTable = List<Map<String, dynamic>>.from(responseData);

    return dataTable;
  } else {
    throw Exception(
        'Failed API login: ${response.statusCode}');
  }
}

Future<List<Map<String, dynamic>>> Query_insert_recheck2(String barcode,String mahang,String vitri,String soluong,String plant,String deliverydate,String dano,String pono,String vender,String ctrkey,String ctrt,String sloc,String lotdate, String CateQC, String invoice,String idrecheck, String codate,String remark, String createuser,String typerecheck) async {
  //String apiUrl = 'http://10.92.184.22:8028/api/Free/Query_insert_recheck2';
  String apiUrl = 'http://192.168.128.131:8031/Query_insert_recheck2';
  // Create the request body using a Map
  Map<String, String> requestData = {
    "barcode": barcode,
    "mahang": mahang,
    "vitri": vitri,
    "soluong": soluong,
    "plant": plant,
    "deliverydate": deliverydate,
    "dano": dano,
    "pono": pono,
    "vender": vender,
    "ctrkey": ctrkey,
    "ctrt": ctrt,
    "sloc": sloc,
    "lotdate": lotdate,
    "CateQC": CateQC,
    "invoice": invoice,
    "idrecheck": idrecheck,
    "codate": codate,
    "remark": remark,
    "createuser": createuser,
    "typerecheck": typerecheck,
  };

  // Encode the request data to JSON
  String requestBody = json.encode(requestData);

  // Make the API POST request
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  );

  if (response.statusCode == 200) {
    // Decode the response JSON
    final List<dynamic> responseData = json.decode(response.body) as List<dynamic>;

    // Convert the response data to a List<Map<String, dynamic>>
    List<Map<String, dynamic>> dataTable = List<Map<String, dynamic>>.from(responseData);

    return dataTable;
  } else {
    throw Exception(
        'Failed API login: ${response.statusCode}');
  }
}

Future<List<Map<String, dynamic>>> Query_insert_recheck3(String barcode,String mahang,String vitri,String soluong,String plant,String deliverydate,String dano,String pono,String vender,String ctrkey,String ctrt,String sloc,String lotdate, String CateQC, String invoice,String idrecheck, String codate,String remark, String createuser,String typerecheck, String _typecheck, String usercheck) async {
  //String apiUrl = 'http://10.92.184.22:8028/api/Free/Query_insert_recheck3';
  String apiUrl = 'http://192.168.128.131:8031/Query_insert_recheck3';
  // Create the request body using a Map
  Map<String, String> requestData = {
    "barcode": barcode,
    "mahang": mahang,
    "vitri": vitri,
    "soluong": soluong,
    "plant": plant,
    "deliverydate": deliverydate,
    "dano": dano,
    "pono": pono,
    "vender": vender,
    "ctrkey": ctrkey,
    "ctrt": ctrt,
    "sloc": sloc,
    "lotdate": lotdate,
    "CateQC": CateQC,
    "invoice": invoice,
    "idrecheck": idrecheck,
    "codate": codate,
    "remark": remark,
    "createuser": createuser,
    "typerecheck": typerecheck,
    "_typecheck": _typecheck,
    "usercheck": usercheck,
  };

  // Encode the request data to JSON
  String requestBody = json.encode(requestData);

  // Make the API POST request
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  );

  if (response.statusCode == 200) {
    // Decode the response JSON
    final List<dynamic> responseData = json.decode(response.body) as List<dynamic>;

    // Convert the response data to a List<Map<String, dynamic>>
    List<Map<String, dynamic>> dataTable = List<Map<String, dynamic>>.from(responseData);

    return dataTable;
  } else {
    throw Exception(
        'Failed API login: ${response.statusCode}');
  }
}

Future<List<Map<String, dynamic>>> Query_insert_recheck4(String barcode,String mahang,String vitri,String soluong,String plant,String deliverydate,String dano,String pono,String vender,String ctrkey,String ctrt,String sloc,String lotdate, String CateQC, String invoice,String idrecheck, String codate,String remark, String createuser,String typerecheck, String _typecheck, String usercheck) async {
  //String apiUrl = 'http://10.92.184.22:8028/api/Free/Query_insert_recheck4';
  String apiUrl = 'http://192.168.128.131:8031/Query_insert_recheck4';
  // Create the request body using a Map
  Map<String, String> requestData = {
    "barcode": barcode,
    "mahang": mahang,
    "vitri": vitri,
    "soluong": soluong,
    "plant": plant,
    "deliverydate": deliverydate,
    "dano": dano,
    "pono": pono,
    "vender": vender,
    "ctrkey": ctrkey,
    "ctrt": ctrt,
    "sloc": sloc,
    "lotdate": lotdate,
    "CateQC": CateQC,
    "invoice": invoice,
    "idrecheck": idrecheck,
    "codate": codate,
    "remark": remark,
    "createuser": createuser,
    "typerecheck": typerecheck,
    "_typecheck": _typecheck,
    "usercheck": usercheck,
  };

  // Encode the request data to JSON
  String requestBody = json.encode(requestData);

  // Make the API POST request
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  );

  if (response.statusCode == 200) {
    // Decode the response JSON
    final List<dynamic> responseData = json.decode(response.body) as List<dynamic>;

    // Convert the response data to a List<Map<String, dynamic>>
    List<Map<String, dynamic>> dataTable = List<Map<String, dynamic>>.from(responseData);

    return dataTable;
  } else {
    throw Exception(
        'Failed API login: ${response.statusCode}');
  }
}

Future<List<Map<String, dynamic>>> Query_insert_recheck6(String barcode,String mahang,String vitri,String soluong,String plant,String deliverydate,String dano,String pono,String vender,String ctrkey,String ctrt,String sloc,String lotdate, String CateQC, String invoice,String idrecheck, String codate,String remark, String createuser,String typerecheck, String _typecheck, String usercheck,String kequacheck) async {
  //String apiUrl = 'http://10.92.184.22:8028/api/Free/Query_insert_recheck6';
  String apiUrl = 'http://192.168.128.131:8031/Query_insert_recheck6';
  // Create the request body using a Map
  Map<String, String> requestData = {
    "barcode": barcode,
    "mahang": mahang,
    "vitri": vitri,
    "soluong": soluong,
    "plant": plant,
    "deliverydate": deliverydate,
    "dano": dano,
    "pono": pono,
    "vender": vender,
    "ctrkey": ctrkey,
    "ctrt": ctrt,
    "sloc": sloc,
    "lotdate": lotdate,
    "CateQC": CateQC,
    "invoice": invoice,
    "idrecheck": idrecheck,
    "codate": codate,
    "remark": remark,
    "createuser": createuser,
    "typerecheck": typerecheck,
    "_typecheck": _typecheck,
    "usercheck": usercheck,
    "kequacheck": kequacheck,
  };

  // Encode the request data to JSON
  String requestBody = json.encode(requestData);

  // Make the API POST request
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  );

  if (response.statusCode == 200) {
    // Decode the response JSON
    final List<dynamic> responseData = json.decode(response.body) as List<dynamic>;

    // Convert the response data to a List<Map<String, dynamic>>
    List<Map<String, dynamic>> dataTable = List<Map<String, dynamic>>.from(responseData);

    return dataTable;
  } else {
    throw Exception(
        'Failed API login: ${response.statusCode}');
  }
}

Future<List<Map<String, dynamic>>> Query_insert_recheck5(String barcode,String mahang,String vitri,String soluong,String plant,String deliverydate,String dano,String pono,String vender,String ctrkey,String ctrt,String sloc,String lotdate, String CateQC, String invoice,String idrecheck, String codate,String remark, String createuser,String typerecheck, String _typecheck, String usercheck,String soluongNG) async {
  //String apiUrl = 'http://10.92.184.22:8028/api/Free/Query_insert_recheck5';
  String apiUrl = 'http://192.168.128.131:8031/Query_insert_recheck5';
  // Create the request body using a Map
  Map<String, String> requestData = {
    "barcode": barcode,
    "mahang": mahang,
    "vitri": vitri,
    "soluong": soluong,
    "plant": plant,
    "deliverydate": deliverydate,
    "dano": dano,
    "pono": pono,
    "vender": vender,
    "ctrkey": ctrkey,
    "ctrt": ctrt,
    "sloc": sloc,
    "lotdate": lotdate,
    "CateQC": CateQC,
    "invoice": invoice,
    "idrecheck": idrecheck,
    "codate": codate,
    "remark": remark,
    "createuser": createuser,
    "typerecheck": typerecheck,
    "_typecheck": _typecheck,
    "usercheck": usercheck,
    "soluongNG": soluongNG,
  };

  // Encode the request data to JSON
  String requestBody = json.encode(requestData);

  // Make the API POST request
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  );

  if (response.statusCode == 200) {
    // Decode the response JSON
    final List<dynamic> responseData = json.decode(response.body) as List<dynamic>;

    // Convert the response data to a List<Map<String, dynamic>>
    List<Map<String, dynamic>> dataTable = List<Map<String, dynamic>>.from(responseData);

    return dataTable;
  } else {
    throw Exception(
        'Failed API login: ${response.statusCode}');
  }
}

Future<bool> Query_update_qtyrecheck(String bacodeid,String soluonginput, String typerecheck,String userupdate) async{
  //final String apiUrl = 'http://10.92.184.22:8028/api/Free/Query_update_qtyrecheck';
  final String apiUrl = 'http://192.168.128.131:8031/Query_update_qtyrecheck';
  Map<String, String> requestData = {
    'bacodeid': bacodeid,
    'soluonginput': soluonginput,
    'typerecheck': typerecheck,
    'userupdate': userupdate,
  };
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(requestData),
  );
  //print(response.body);
  if (response.statusCode == 200) {
    if(response.body == 'true')
    {
      return true;
    }else
    {
      return false;
    }
  } else {
    //return false;
    throw Exception('query_update_pallet FA!');
  }
}

Future<List<Get_Recheck>?> Freelocation_get_recheck() async {
  //final String apiUrl = 'http://10.92.184.22:8028/api/Free/Freelocation_get_recheck';
  final String apiUrl = 'http://192.168.128.131:8031/Freelocation_get_recheck';
  Map<String, String> requestData = {
    // "cate": "cate",
  };

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(requestData),
  );

  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);
    final List<dynamic> dataList = responseBody as List<dynamic>;
    //old
    //return dataList.map((json) => Get_Recheck.fromJson(json)).toList();
    //2026
    return dataList.map((json) => Get_Recheck.fromJson(json as Map<String, dynamic>)).toList();

  }
  else
  {
    throw Exception(
        'Fail API:Freelocation_get_recheck  ${response.statusCode}');
  }
}

Future<bool> Auto_Sap_rohs_Iqc(String barcode,String barcodeBox, String qty) async{
  final String apiUrl = 'http://192.168.128.131:8031/Auto_Sap_rohs_Iqc';
  Map<String, String> requestData = {
    "barcode": barcode,
    "barcodeBox": barcodeBox,
    "qty": qty,
  };
  //print(response.body);
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );
    // Kiểm tra trạng thái HTTP
    if (response.statusCode == 200) {
      if(response.body.trim() == 'true')
      {
        return true;
      }else
      {
        return false;
      }
    }
    else
    {
      throw Exception('Lỗi khi tải dữ liệu: ${response.statusCode}');
    }
  } catch (e) {
    // Xử lý lỗi
    print('Error: $e');
    return false; // Hoặc ném lỗi nếu cần
  }
}

// Future<bool> Auto_Sap_rohs_Iqc(String barcode,String barcodeBox, String qty) async{
//   //final String apiUrl = 'http://192.168.128.131:8010/goodreceipt/updatercforsamplerosh';
//   //final String apiUrl = 'http://192.168.128.130:8031/updatercforsamplerosh_new'; //bi mat code sai code
//   final String apiUrl = 'http://192.168.128.131:8031/updatercforsamplerosh_new';
//   Map<String, String> requestData = {
//     "barcode": barcode,
//     "barcodeBox": barcodeBox,
//     "qty": qty,
//   };
//   //print(response.body);
//   try {
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(requestData),
//     );
//     // Kiểm tra trạng thái HTTP
//     if (response.statusCode == 200) {
//       // Giải mã JSON và trích xuất giá trị
//       Map<String, dynamic> responseData = jsonDecode(response.body);
//       int statusCode = responseData["status"];
//       //print(responseData["data"]);
//       int ketqua = responseData["data"]["result"];
//       //print('Success value: $ketqua');
//       if(ketqua == 1)
//       {
//         return true;
//       }
//       else
//       {
//         return false;
//       }
//     }
//     else
//     {
//       throw Exception('Lỗi khi tải dữ liệu: ${response.statusCode}');
//     }
//   } catch (e) {
//     // Xử lý lỗi
//     print('Error: $e');
//     return false; // Hoặc ném lỗi nếu cần
//   }
// }

Future<List<Map<String, dynamic>>> Freelocation_delete_inspection_mobile(String IDmahang, String barcode, String cateQC, String codedate, String remark, String userid) async {
  //String apiUrl = 'http://10.92.184.22:8028/api/Free/Freelocation_delete_inspection_mobile';
  String apiUrl = 'http://192.168.128.131:8031/Freelocation_delete_inspection_mobile';
  Map<String, String> requestData = {
    "IDmahang": IDmahang,
    "barcode": barcode,
    "cateQC": cateQC,
    "codedate": codedate,
    "remark": remark,
    "userid": userid
  };

  // Encode the request data to JSON
  String requestBody = json.encode(requestData);

  // Make the API POST request
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  );

  if (response.statusCode == 200) {
    // Decode the response JSON
    final List<dynamic> responseData = json.decode(response.body) as List<dynamic>;

    // Convert the response data to a List<Map<String, dynamic>>
    List<Map<String, dynamic>> dataTable = List<Map<String, dynamic>>.from(responseData);

    return dataTable;
  } else {
    throw Exception(
        'Failed API login: ${response.statusCode}');
  }
}

Future<List<Map<String, dynamic>>> Auto_Sap_rohs_Iqc_new(String barcode, String barcodeBox, String qty) async {
  String apiUrl = 'http://192.168.128.131:8031/Auto_Sap_rohs_Iqc';
  // Create the request body using a Map   //C:\inetpub\logs\LogFiles\W3SVC5
  Map<String, String> requestData = {
    "barcode": barcode,
    "barcodeBox": barcodeBox,
    "qty": qty,
  };

  // Encode the request data to JSON
  String requestBody = json.encode(requestData);

  // Make the API POST request
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  );

  if (response.statusCode == 200) {
    // Decode the response JSON
    final List<dynamic> responseData = json.decode(response.body) as List<dynamic>;

    // Convert the response data to a List<Map<String, dynamic>>
    List<Map<String, dynamic>> dataTable = List<Map<String, dynamic>>.from(responseData);

    return dataTable;
  } else {
    throw Exception(
        'Failed API login: ${response.statusCode}');
  }
}

Future<List<Map<String, dynamic>>> Auto_Sap_rohs_Iqc_new2(String barcode, String barcodeBox, String qty,String typeIQC) async {
  String apiUrl = 'http://192.168.128.131:8031/Auto_Sap_rohs_Iqc2';
  // Create the request body using a Map   //C:\inetpub\logs\LogFiles\W3SVC5
  Map<String, String> requestData = {
    "barcode": barcode,
    "barcodeBox": barcodeBox,
    "qty": qty,
    "typeIQC": typeIQC
  };

  // Encode the request data to JSON
  String requestBody = json.encode(requestData);

  // Make the API POST request
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  );

  if (response.statusCode == 200) {
    // Decode the response JSON
    final List<dynamic> responseData = json.decode(response.body) as List<dynamic>;

    // Convert the response data to a List<Map<String, dynamic>>
    List<Map<String, dynamic>> dataTable = List<Map<String, dynamic>>.from(responseData);

    return dataTable;
  } else {
    throw Exception(
        'Failed API login: ${response.statusCode}');
  }
}

Future<List<Map<String, dynamic>>> Auto_Sap_rohs_Iqc_NG(String barcode, String barcodeBox, String qty) async {
  String apiUrl = 'http://192.168.128.131:8031/Auto_Sap_rohs_Iqc_NGLOT';
  // Create the request body using a Map
  Map<String, String> requestData = {
    "barcode": barcode,
    "barcodeBox": barcodeBox,
    "qty": qty,
  };

  // Encode the request data to JSON
  String requestBody = json.encode(requestData);

  // Make the API POST request
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  );

  if (response.statusCode == 200) {
    // Decode the response JSON
    final List<dynamic> responseData = json.decode(response.body) as List<dynamic>;

    // Convert the response data to a List<Map<String, dynamic>>
    List<Map<String, dynamic>> dataTable = List<Map<String, dynamic>>.from(responseData);

    return dataTable;
  } else {
    throw Exception(
        'Failed API login: ${response.statusCode}');
  }
}

Future<List<Map<String, dynamic>>> Auto_Sap_rohs_Iqc_NG_revert(String barcode, String barcodeBox, String qty) async {
  String apiUrl = 'http://192.168.128.131:8031/Auto_Sap_rohs_Iqc_NG_revert';
  // Create the request body using a Map
  Map<String, String> requestData = {
    "barcode": barcode,
    "barcodeBox": barcodeBox,
    "qty": qty,
  };

  // Encode the request data to JSON
  String requestBody = json.encode(requestData);

  // Make the API POST request
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  );

  if (response.statusCode == 200) {
    // Decode the response JSON
    final List<dynamic> responseData = json.decode(response.body) as List<dynamic>;

    // Convert the response data to a List<Map<String, dynamic>>
    List<Map<String, dynamic>> dataTable = List<Map<String, dynamic>>.from(responseData);

    return dataTable;
  } else {
    throw Exception(
        'Failed API login: ${response.statusCode}');
  }
}

Future<List<Map<String, dynamic>>> Query_CheckBoxCard(String barcode, String barcodeBox) async {
  String apiUrl = 'http://192.168.128.131:8031/Query_CheckBoxCard';
  // Create the request body using a Map
  Map<String, String> requestData = {
    "barcode": barcode,
    "barcodeBox": barcodeBox,
  };

  // Encode the request data to JSON
  String requestBody = json.encode(requestData);

  // Make the API POST request
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  );

  if (response.statusCode == 200) {
    // Decode the response JSON
    final List<dynamic> responseData = json.decode(response.body) as List<dynamic>;

    // Convert the response data to a List<Map<String, dynamic>>
    List<Map<String, dynamic>> dataTable = List<Map<String, dynamic>>.from(responseData);

    return dataTable;
  } else {
    throw Exception(
        'Failed API login: ${response.statusCode}');
  }
}

Future<List<Map<String, dynamic>>> Query_CheckBoxCard_manybox(String barcode, String barcodeBox, String QtyRC) async {
  String apiUrl = 'http://192.168.128.131:8031/Query_CheckBoxCard_manybox';
  // Create the request body using a Map
  Map<String, String> requestData = {
    "barcode": barcode,
    "barcodeBox": barcodeBox,
    "QtyRC": QtyRC,
  };

  // Encode the request data to JSON
  String requestBody = json.encode(requestData);

  // Make the API POST request
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  );

  if (response.statusCode == 200) {
    // Decode the response JSON
    final List<dynamic> responseData = json.decode(response.body) as List<dynamic>;

    // Convert the response data to a List<Map<String, dynamic>>
    List<Map<String, dynamic>> dataTable = List<Map<String, dynamic>>.from(responseData);

    return dataTable;
  } else {
    throw Exception(
        'Failed API login: ${response.statusCode}');
  }
}

Future<List<Map<String, dynamic>>> Query_Check_GR(String barcode, String SLNG) async {
  String apiUrl = 'http://192.168.128.131:8031/Query_Check_GR';
  // Create the request body using a Map
  Map<String, String> requestData = {
    "barcode": barcode,
    "SLNG": SLNG,
  };

  // Encode the request data to JSON
  String requestBody = json.encode(requestData);

  // Make the API POST request
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  );

  if (response.statusCode == 200) {
    // Decode the response JSON
    final List<dynamic> responseData = json.decode(response.body) as List<dynamic>;

    // Convert the response data to a List<Map<String, dynamic>>
    List<Map<String, dynamic>> dataTable = List<Map<String, dynamic>>.from(responseData);

    return dataTable;
  } else {
    throw Exception(
        'Failed API login: ${response.statusCode}');
  }
}



// Future<bool?> mcsconfirm(String line_name, String model_code, String jtf_production_time) async{
//   final String apiUrl = 'http://192.168.128.128:8080/api/pull-material-plans/mcs-confirm';
//   //final String apiUrl = 'http://10.92.184.22:8028/api/pull-material-plans/mcs-confirm';
//   Map<String, String> requestData = {
//     'line_name': line_name,
//     'model_code': model_code,
//     'jtf_production_time': jtf_production_time,
//   };
//   final response = await http.put(
//     Uri.parse(apiUrl),
//     headers: {'Content-Type': 'application/json'},
//     body: jsonEncode(requestData),
//   );
//
//   //print(response.body);
//   final data = json.decode(response.body);
//   //print(data);
//   if (response.statusCode == 200) {
//     // Xử lý kết quả nếu thành công
//     Map<String, dynamic> responseData = jsonDecode(response.body);
//     String statusCode = responseData['statusCode'];
//     String message = responseData['message'];
//     // Xử lý dữ liệu hoặc hiển thị thông báo thành công
//     print('StatusCode: $statusCode, Message: $message');
//     bool ketqua = responseData['data']['success'];
//     print('Success value: $ketqua');
//     //print(ketqua);
//     if(message == 'success')
//     {
//       return true;
//     }
//     else
//     {
//       return false;
//     }
//   }
//   else
//   {
//     //return false;
//     throw Exception('Failed API: mcs-confirm');
//   }
// }

// Future<String> Query_checkitting_SMT(String Linename, String Modelname, String Deliverydate) async{
//   final String apiUrl = 'http://10.92.184.22:8028/api/SmtDip/Query_checkitting_SMT';
//   Map<String, String> requestData = {
//     'Linename': Linename,
//     'Modelname': Modelname,
//     'Deliverydate': Deliverydate,
//   };
//   final response = await http.post(
//     Uri.parse(apiUrl),
//     headers: {'Content-Type': 'application/json'},
//     body: jsonEncode(requestData),
//   );
//   String kq='';
//   if (response.statusCode == 200) {
//     if(response.body != '"0"')
//     {
//       kq =  response.body.replaceAll('"', '');
//       //print(kq);
//       return kq;
//     }
//     else
//     {
//       return kq;
//     }
//   }
//   else
//   {
//     //return kq;
//     throw Exception('API: Query_checkitting_SMT');
//   }
// }

//17.09.2026 ==> chuc nang in receving card cho IQC & FA return
//http://10.92.184.22:8036/swagger/index.html
/// Lay thong tin Receiving Card de in lai.
/// typeSource: 'KittingCard' hoac 'ReceivingCard'
// =====================================================================
/// Lay thong tin Receiving Card de in lai.
/// typeSource: 'KittingCard' hoac 'ReceivingCard'
/// Lay thong tin Receiving Card de in lai.
/// typeSource: 'KittingCard' hoac 'ReceivingCard'
/// Lay thong tin Receiving Card de in lai.
/// typeSource: 'KittingCard' hoac 'ReceivingCard'
Future<List<Map<String, dynamic>>> Query_ReceivingCard_Reprint(
    String barcode, String typeSource) async {
  String apiUrl = 'http://10.92.184.22:8036/Query_ReceivingCard_Reprint';
  // Create the request body using a Map
  Map<String, String> requestData = {
    "barcode": barcode,
    "typeSource": typeSource,
  };

  // Encode the request data to JSON
  String requestBody = json.encode(requestData);

  // Make the API POST request
  final response = await http
      .post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  )
      .timeout(const Duration(seconds: 15));

  // In ra de kiem tra API tra ve gi (xem trong Run/Debug console)
  print('Query_ReceivingCard_Reprint ${response.statusCode}: ${response.body}');

  if (response.statusCode != 200) {
    throw Exception('API lỗi ${response.statusCode}, liên hệ IT!');
  }

  final dynamic decoded;
  try {
    decoded = json.decode(response.body);
  } catch (e) {
    throw Exception('API trả về không đúng định dạng JSON!');
  }

  // Dang chuan: [ {...}, {...} ]
  if (decoded is List) {
    return decoded
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  // Phong truong hop API boc trong object: { "data": [ ... ] }
  if (decoded is Map && decoded['data'] is List) {
    return (decoded['data'] as List)
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  // API tra ve 1 object don: { ... }
  if (decoded is Map) {
    return [Map<String, dynamic>.from(decoded)];
  }

  return [];
}


/// Lay danh sach may in tu bang [dbo].[tblPrinterDevice]
/// Tra ve cac dong co cot: ID (ten nhan may in, VD: VT 003514), MacAddress
Future<List<Map<String, dynamic>>> Query_PrinterDevice_List() async {
  String apiUrl = 'http://10.92.184.22:8036/Query_PrinterDevice_List';
  // Khong can tham so, gui body rong cho giong cac API khac
  Map<String, String> requestData = {};

  String requestBody = json.encode(requestData);

  final response = await http
      .post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  )
      .timeout(const Duration(seconds: 15));

  if (response.statusCode != 200) {
    throw Exception('API danh sách máy in lỗi ${response.statusCode}, liên hệ IT!');
  }

  final dynamic decoded;
  try {
    decoded = json.decode(response.body);
  } catch (e) {
    throw Exception('API danh sách máy in trả về không đúng JSON!');
  }

  if (decoded is List) {
    return decoded
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }
  if (decoded is Map && decoded['data'] is List) {
    return (decoded['data'] as List)
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }
  return [];
}

//combox ly do
Future<List<Map<String, dynamic>>> Query_List_Lydo311() async {
  String apiUrl = 'http://10.92.184.22:8036/Query_List_Lydo311';
  // Khong can tham so, gui body rong cho giong cac API khac
  Map<String, String> requestData = {};

  String requestBody = json.encode(requestData);

  final response = await http
      .post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  )
      .timeout(const Duration(seconds: 15));

  if (response.statusCode != 200) {
    throw Exception(
        'API danh sách Query_List_Lydo311 lỗi ${response.statusCode}, liên hệ IT!');
  }

  dynamic data;
  try {
    data = json.decode(response.body);
  } catch (e) {
    throw Exception('API danh sách Query_List_Lydo311 về không đúng JSON!');
  }

  // API tra ve Ok(json) voi json la string => phai decode them 1 lan nua
  if (data is String) {
    try {
      data = json.decode(data);
    } catch (e) {
      throw Exception('API danh sách Query_List_Lydo311 về không đúng JSON!');
    }
  }

  if (data is List) {
    return data
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }
  if (data is Map && data['data'] is List) {
    return (data['data'] as List)
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }
  return [];
}

Future<List<Map<String, dynamic>>> Query_List_Tcode() async {
  String apiUrl = 'http://10.92.184.22:8036/Query_List_Tcode';
  // Khong can tham so, gui body rong cho giong cac API khac
  Map<String, String> requestData = {};

  String requestBody = json.encode(requestData);

  final response = await http
      .post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  )
      .timeout(const Duration(seconds: 15));

  if (response.statusCode != 200) {
    throw Exception(
        'API danh sách Query_List_Tcode lỗi ${response.statusCode}, liên hệ IT!');
  }

  dynamic data;
  try {
    data = json.decode(response.body);
  } catch (e) {
    throw Exception('API danh sách Query_List_Tcode về không đúng JSON!');
  }

  // API tra ve Ok(json) voi json la string => phai decode them 1 lan nua
  if (data is String) {
    try {
      data = json.decode(data);
    } catch (e) {
      throw Exception('API danh sách Query_List_Tcode về không đúng JSON!');
    }
  }

  if (data is List) {
    return data
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }
  if (data is Map && data['data'] is List) {
    return (data['data'] as List)
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }
  return [];
}


/// Ghi nhan thong tin chuyen kho / in lai Receiving Card len server.
/// Tra ve dong ket qua dau tien (thuong co cot kq / Message).
Future<Map<String, dynamic>> Insert_ReceivingCard_RepLoc({
  required String barcode,
  required String typeSource,
  required String plant,
  required String material,
  required String quantity,
  required String sloc,
  required String repLoc,
  required String tcode,
  required String reason,
  required String userName,
}) async {
  String apiUrl = 'http://10.92.184.22:8036/Insert_ReceivingCard_RepLoc';

  Map<String, String> requestData = {
    "barcode": barcode,
    "typeSource": typeSource, // ReceivingCard / KittingCard
    "plant": plant,
    "material": material,
    "quantity": quantity,
    "sloc": sloc,
    "repLoc": repLoc,
    "tcode": tcode,
    "reason": reason,
    "userName": userName,
  };

  String requestBody = json.encode(requestData);

  final response = await http
      .post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  )
      .timeout(const Duration(seconds: 15));

  print('Insert_ReceivingCard_RepLoc ${response.statusCode}: ${response.body}');

  if (response.statusCode != 200) {
    throw Exception('API ghi nhận lỗi ${response.statusCode}, liên hệ IT!');
  }

  dynamic data;
  try {
    data = json.decode(response.body);
  } catch (e) {
    throw Exception('API ghi nhận trả về không đúng định dạng JSON!');
  }

  // API tra ve Ok(json) voi json la string => decode them 1 lan
  if (data is String) {
    try {
      data = json.decode(data);
    } catch (e) {
      throw Exception('API ghi nhận trả về không đúng định dạng JSON!');
    }
  }

  if (data is List) {
    final rows = data.whereType<Map>().toList();
    return rows.isEmpty ? {} : Map<String, dynamic>.from(rows.first);
  }
  if (data is Map && data['data'] is List) {
    final rows = (data['data'] as List).whereType<Map>().toList();
    return rows.isEmpty ? {} : Map<String, dynamic>.from(rows.first);
  }
  if (data is Map) return Map<String, dynamic>.from(data);

  return {};
}

// show thong tin kitting card outside
Future<List<Map<String, dynamic>>> Query_KittingCard_Outside(
    String barcode, String userId) async {
  String apiUrl = 'http://10.92.184.22:8036/Query_KittingCard_Outside';
  Map<String, String> requestData = {
    "barcode": barcode,
    "userId" : userId,
  };

  // Encode the request data to JSON
  String requestBody = json.encode(requestData);

  // Make the API POST request
  final response = await http
      .post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  )
      .timeout(const Duration(seconds: 15));

  // In ra de kiem tra API tra ve gi (xem trong Run/Debug console)
  print('Query_KittingCard_Outside ${response.statusCode}: ${response.body}');

  if (response.statusCode != 200) {
    throw Exception('API lỗi ${response.statusCode}, liên hệ IT!');
  }

  final dynamic decoded;
  try {
    decoded = json.decode(response.body);
  } catch (e) {
    throw Exception('API trả về không đúng định dạng JSON!');
  }

  // Dang chuan: [ {...}, {...} ]
  if (decoded is List) {
    return decoded
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  // Phong truong hop API boc trong object: { "data": [ ... ] }
  if (decoded is Map && decoded['data'] is List) {
    return (decoded['data'] as List)
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  // API tra ve 1 object don: { ... }
  if (decoded is Map) {
    return [Map<String, dynamic>.from(decoded)];
  }

  return [];
}

//update thong tin kitting card outside
/// Xac nhan cap hang Kitting Card ra ngoai.
/// Tra ve dong ket qua dau tien (thuong co cot kq / Message).
Future<Map<String, dynamic>> Update_SupplyKittingOutside({
  required String barcode,
  required String line,
  required String userName,
}) async {
  String apiUrl = 'http://10.92.184.22:8036/Update_SupplyKittingOutside';

  Map<String, String> requestData = {
    "barcode": barcode,
    "line": line,
    "userName": userName,
  };

  String requestBody = json.encode(requestData);

  final response = await http
      .post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: requestBody,
  )
      .timeout(const Duration(seconds: 15));

  // In ra de kiem tra API tra ve gi (xem trong Run/Debug console)
  print('Update_SupplyKittingOutside ${response.statusCode}: ${response.body}');

  if (response.statusCode != 200) {
    throw Exception('API lỗi ${response.statusCode}, liên hệ IT!');
  }

  dynamic data;
  try {
    data = json.decode(response.body);
  } catch (e) {
    throw Exception('API trả về không đúng định dạng JSON!');
  }

  // API tra ve Ok(json) voi json la string => phai decode them 1 lan nua
  if (data is String) {
    try {
      data = json.decode(data);
    } catch (e) {
      throw Exception('API trả về không đúng định dạng JSON!');
    }
  }

  // Dang chuan: [ {...}, {...} ]
  if (data is List) {
    final rows = data.whereType<Map>().toList();
    return rows.isEmpty ? {} : Map<String, dynamic>.from(rows.first);
  }

  // Phong truong hop API boc trong object: { "data": [ ... ] }
  if (data is Map && data['data'] is List) {
    final rows = (data['data'] as List).whereType<Map>().toList();
    return rows.isEmpty ? {} : Map<String, dynamic>.from(rows.first);
  }

  // API tra ve 1 object don: { ... }
  if (data is Map) return Map<String, dynamic>.from(data);

  return {};
}
