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
  CustomContributeModel(image: "images/addplace.svg", text: "Add place"),
  CustomContributeModel(image: "images/updatepalce.svg", text: "Update place"),
  CustomContributeModel(image: "images/addreview.svg", text: "Add Review"),
  CustomContributeModel(image: "images/updateroad.svg", text: "Update Road"),
];

final List<CustomContributeModel> containersList = const [
  CustomContributeModel(
    image: "images/answerq.png",
    text: "Answer simple\nyes/no questions\nto help others",
    buttonText: "Start",
  ),
  CustomContributeModel(
    image: "images/searchhistory.png",
    text: "Your Search History\nWill Show Here",
    buttonText: "Contribute Now",
  ),
];
