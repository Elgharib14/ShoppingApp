// class SearchModell {
//   bool? status;
//   Data? data;

//   SearchModell({this.status, this.data});

//   SearchModell.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }

// }

// class Data {
//   dynamic currentPage;
//   List<SearchData>? data;
//   String? firstPageUrl;
//   dynamic from;
//   dynamic lastPage;
//   String? lastPageUrl;
//   Null? nextPageUrl;
//   String? path;
//   dynamic perPage;
//   Null? prevPageUrl;
//   dynamic to;
//   dynamic total;

//   Data(
//       {this.currentPage,
//       this.data,
//       this.firstPageUrl,
//       this.from,
//       this.lastPage,
//       this.lastPageUrl,
//       this.nextPageUrl,
//       this.path,
//       this.perPage,
//       this.prevPageUrl,
//       this.to,
//       this.total});

//   Data.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
//     if (json['data'] != null) {
//       data = <SearchData>[];
//       json['data'].forEach((v) {
//         data!.add(new SearchData.fromJson(v));
//       });
//     }
//     firstPageUrl = json['first_page_url'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     lastPageUrl = json['last_page_url'];
//     nextPageUrl = json['next_page_url'];
//     path = json['path'];
//     perPage = json['per_page'];
//     prevPageUrl = json['prev_page_url'];
//     to = json['to'];
//     total = json['total'];
//   }

 
// }

// class SearchData {
//   int? id;
//   dynamic price;
//   String? image;
//   String? name;
//   String? description;
//   List<String>? images;
//   // bool? inFavorites;
//   bool? inCart;

//   SearchData(
//       {this.id,
//       this.price,
//       this.image,
//       this.name,
//       this.description,
//       this.images,
//       // this.inFavorites,
//       this.inCart});

//   SearchData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     price = json['price'];
//     image = json['image'];
//     name = json['name'];
//     description = json['description'];
//     images = json['images'].cast<String>();
//     // inFavorites = json['in_favorites'];
//     inCart = json['in_cart'];
//   }

  
// }

class SearchModel {
  bool? status;
  String? message;
  Data? data;

  SearchModel({this.status, this.message, this.data});

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<Product>? data;
  String? firstPageUrl;
 
  String? lastPageUrl;
  Null? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
 

  Data(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      });

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Product>[];
      json['data'].forEach((v) {
        data!.add(new Product.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
   
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
   
  }
}
class Product {
  dynamic id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  Product(
      {this.id,
      this.price,
      this.oldPrice,
      this.discount,
      this.image,
      this.name,
      this.description});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['discount'] = this.discount;
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}