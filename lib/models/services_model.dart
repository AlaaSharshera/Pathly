class ServicesModel {
  final String image;
  final String serviceName;
  ServicesModel({required this.image,required this.serviceName});
}

List<ServicesModel> servicesCoulmn1=[
  ServicesModel(image: "assets/images/must_eat.png", serviceName: "restaurant"),
  ServicesModel(image: "assets/images/car_services.png", serviceName: "gas_station"), //car_repair //car_dealer //car_wash
  ServicesModel(image: "assets/images/cafe.png", serviceName: "cafe"),
  ServicesModel(image:  "assets/images/shopping.png", serviceName: "clothing_store"),
  ServicesModel(image: "assets/images/beauty.png", serviceName: "Beauty center")
];
List <ServicesModel> servicesCoulmn2=[
  ServicesModel(image: "assets/images/best_hotel.png", serviceName: "lodging"),
  ServicesModel(image:  "assets/images/historical_places.png", serviceName: "tourist_attraction"),
  ServicesModel(image: "assets/images/hospital.png", serviceName: "hospital"),
  ServicesModel(image: "assets/images/gym.png", serviceName: "gym"),
  ServicesModel(image:  "assets/images/pharmacy.png", serviceName: "pharmacy")

];