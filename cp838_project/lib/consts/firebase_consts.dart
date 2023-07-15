import 'package:cp838_project/consts/consts.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

//collection
const previewCollection = "previews";
const shopCollection = "shops";
const userCollection = "users";
const categoryCollection = "categories";
const productCollection = "products";
const cartCollection = "carts";
const chatCollection = "chats";
const messageCollection = "messages";
const orderCollection = "orders";
