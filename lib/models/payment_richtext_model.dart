class PaymentRichtextModel {
  final String title;
  final String subTitle;
  const PaymentRichtextModel({required this.title, required this.subTitle});
}

List<PaymentRichtextModel> texts = const [
  PaymentRichtextModel(
    title: "Today\n\n",
    subTitle: "Get full access to road guidance and\nheatmaps for free.\n",
  ),
  PaymentRichtextModel(
    title: "Trip 4\n\n",
    subTitle: "Receive a reminder that your free trips\nare almost over.\n",
  ),
  PaymentRichtextModel(
    title: "Trip 5\n\n",
    subTitle:
        "This is your last free trip! Subscribe to\ncontinue using the service.\n",
  ),
  PaymentRichtextModel(
    title: "After Trip 5\n\n",
    subTitle:
        "To continue using road guidance and\nheatmaps, subscribe to a plan.\n",
  ),
];
