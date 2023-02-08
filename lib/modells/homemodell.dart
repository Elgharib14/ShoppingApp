class HomeModell {
	bool? status;

	Data? data;

	HomeModell({this.status,this.data});

	HomeModell.fromJson(Map<String, dynamic> json) {
		status = json['status'];
		data = json['data'] != null ? new Data.fromJson(json['data']) : null;
	}

	
}

class Data {
	List<Banners>? banners;
	List<Products>? products;


	Data({this.banners, this.products,});

	Data.fromJson(Map<String, dynamic> json) {
		if (json['banners'] != null) {
			banners = <Banners>[];
			json['banners'].forEach((v) { banners!.add(new Banners.fromJson(v)); });
		}
		if (json['products'] != null) {
			products = <Products>[];
			json['products'].forEach((v) { products!.add(new Products.fromJson(v)); });
		}
	
	}

	
}

class Banners {
	int? id;
	String? image;
	

	Banners({this.id, this.image,});

	Banners.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		image = json['image'];
		
	}

	
}

class Products {
	int? id;
	dynamic price;
	dynamic oldPrice;
	int? discount;
	String? image;
	String? name;
	String? description;
	List<String>? images;
	bool? inFavorites;
	bool? inCart;

	Products({this.id, this.price, this.oldPrice, this.discount, this.image, this.name, this.description, this.images, this.inFavorites, this.inCart});

	Products.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		price = json['price'];
		oldPrice = json['old_price'];
		discount = json['discount'];
		image = json['image'];
		name = json['name'];
		description = json['description'];
		images = json['images'].cast<String>();
		inFavorites = json['in_favorites'];
		inCart = json['in_cart'];
	}

	
}