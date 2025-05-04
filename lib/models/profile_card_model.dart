class ProfileCardModel {
  final String title;
  final String image;
  ProfileCardModel({required this.title, required this.image});
}

List<ProfileCardModel> cards = [
  ProfileCardModel(title: "Fav Trips", image: "images/fav.svg"),
  ProfileCardModel(title: "Want to go", image: "images/wantgo.svg"),
  ProfileCardModel(title: "Saved Places", image: "images/saved.svg"),
  ProfileCardModel(title: "Labeled Places", image: "images/labeled.svg"),
  ProfileCardModel(title: "Starred  Places", image: "images/star.svg"),
  ProfileCardModel(title: "Travel Plans", image: "images/travel.svg"),
];
