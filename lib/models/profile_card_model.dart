class ProfileCardModel {
  final String title;
  final String image;
  ProfileCardModel({required this.title, required this.image});
}

List<ProfileCardModel> cards = [
  ProfileCardModel(title: "Fav Trips", image: "assets/icons/fav.svg"),
  ProfileCardModel(title: "Want to go", image: "assets/icons/wantgo.svg"),
  ProfileCardModel(title: "Saved Places", image: "assets/icons/saved.svg"),
  ProfileCardModel(title: "Labeled Places", image: "assets/icons/labeled.svg"),
  ProfileCardModel(title: "Starred  Places", image: "assets/icons/star.svg"),
  ProfileCardModel(title: "Travel Plans", image: "assets/icons/travel.svg"),
];
