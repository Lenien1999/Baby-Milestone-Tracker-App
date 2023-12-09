class CarouselModel {
  String title;
  String image;
  String subtitle;
  CarouselModel(
      {required this.title, required this.image, required this.subtitle});
}

List<CarouselModel> carouselList = [
  CarouselModel(
      title: 'Physical Growth',
      image: 'assets/images/baby.jpg',
      subtitle:
          'Yorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.'),
  CarouselModel(
      title: 'Baby Tracker',
      image: 'assets/images/baby3.jpg',
      subtitle:
          'Yorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.'),
  CarouselModel(
      title: 'Brestfeeding',
      image: 'assets/images/baby4.jpg',
      subtitle:
          'Yorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.'),
  CarouselModel(
      title: 'Language',
      image: 'assets/images/baby1.jpg',
      subtitle:
          'Yorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.'),
];
