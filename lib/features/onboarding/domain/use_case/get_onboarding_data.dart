import 'package:zentails_wellness/features/onboarding/domain/entity/onboarding_entity.dart';

class GetOnboardingData {
  List<OnboardingEntity> call() {
    return [
      OnboardingEntity(
        title: "Welcome to\nZentails Wellness",
        subtitle: "Discover the joy of pet therapy\nand unlock a pawsitive path to\nrelaxation and healing.",
        imagePath: "assets/images/onboarding_pages/Logo.png",
      ),
      OnboardingEntity(
        title: "Discover Our\nTherapy Companions",
        subtitle: "Explore heartwarming pet\nprofiles and choose your\nperfect therapy companion.",
        imagePath: "assets/images/onboarding_pages/TherapyPets.png",
      ),
      OnboardingEntity(
        title: "Easy Booking,\nAnytime!",
        subtitle: "Select your preferred date, time,\nand duration for a seamless therapy\nsession booking experience.",
        imagePath: "assets/images/onboarding_pages/EasyBooking.jpeg",
      ),
      OnboardingEntity(
        title: "Start Your Wellness\nJourney Today",
        subtitle: "Join us today to experience the\nbenefits of personalized pet\ntherapy. Purely pawsitive, always!",
        imagePath: "assets/images/onboarding_pages/TherapySessions.jpeg",
      ),
    ];
  }
}