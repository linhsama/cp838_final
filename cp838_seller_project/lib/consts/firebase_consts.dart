import 'package:cp838_seller_project/consts/consts.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

//collection
const shopCollection = "shops";
const categoryCollection = "categories";
const userCollection = "users";
const productCollection = "products";
const previewCollection = "previews";
const cartCollection = "carts";
const chatCollection = "chats";
const messageCollection = "messages";
const orderCollection = "orders";
