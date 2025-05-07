class CustomContributeModel {
  final String text;
  final String image;
  final String? buttonText;
  const CustomContributeModel({
    required this.image,
    required this.text,
    this.buttonText,
  });
}

final List<CustomContributeModel> contributesList = const [
  CustomContributeModel(image: "assets/icons/addplace.svg", text: "Add place"),
  CustomContributeModel(
    image: "assets/icons/updatepalce.svg",
    text: "Update place",
  ),
  CustomContributeModel(
    image: "assets/icons/addreview.svg",
    text: "Add Review",
  ),
  CustomContributeModel(
    image: "assets/icons/updateroad.svg",
    text: "Update Road",
  ),
];

final List<CustomContributeModel> containersList = const [
  CustomContributeModel(
    image: "assets/images/answerq.png",
    text: "Answer simple yes/no\nquestions to help others",
    buttonText: "Start",
  ),
  CustomContributeModel(
    image: "assets/images/searchhistory.png",
    text: "Your Search History\nWill Show Here",
    buttonText: "Contribute Now",
  ),
];
