class OnboardingModel {
  final String image;
  final String title;
  final String description;
  final String buttonText;
  final bool showSkip;

  OnboardingModel({
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
    this.showSkip = true,
  });
}

final List<OnboardingModel> onboardingList = [
  OnboardingModel(
    image: 'assets/images/page_1.png',
    title: 'Analyze Your Soil Easily',
    description:
    'Take a photo of your soil or enter simple data to instantly identify soil type and condition.',
    buttonText: 'Next',
  ),
  OnboardingModel(
    image: 'assets/images/page_2.png',
    title: 'Understand pH & Moisture',
    description:
    'Get clear insights into soil acidity and moisture levels to make better planting decisions.',
    buttonText: 'Next',
  ),
  OnboardingModel(
    image: 'assets/images/page_3.png',
    title: 'Grow the Right Crops',
    description:
    'Receive smart crop recommendations based on your soil quality and analysis results.',
    buttonText: 'Start Analyzing',
    showSkip: false,
  ),
];