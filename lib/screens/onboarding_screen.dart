import 'package:akusitumbuh/models/onboarding_model.dart';
import 'package:akusitumbuh/screens/auth/login_page.dart';
import 'package:akusitumbuh/widgets/gradient_button.dart';
import 'package:akusitumbuh/widgets/metal_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingModel> _pages = [
    OnboardingModel(
      title: 'Asupan Gizi Seimbang',
      description:
          'Penuhi kebutuhan nutrisi anak dengan makanan sehat setiap hari.',
      lottieAsset: 'assets/lottie/healthy.json',
    ),
    OnboardingModel(
      title: 'Anak Sehat, Aktif, dan Ceria',
      description: 'Pertumbuhannya berjalan dengan baik.',
      lottieAsset: 'assets/lottie/enjoying.json',
    ),
    OnboardingModel(
      title: 'Peduli Tumbuh Kembang Anak',
      description: 'Perhatian dan kasih sayang membantu anak tumbuh optimal.',
      lottieAsset: 'assets/lottie/heart-grow.json',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return _buildPage(_pages[index]);
            },
          ),

          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => _buildDot(index),
              ),
            ),
          ),

          Positioned(bottom: 40, left: 40, right: 40, child: _buildButton()),

          if (_currentPage < _pages.length - 1)
            Positioned(
              top: 50,
              right: 20,
              child: TextButton(
                onPressed: () {
                  _pageController.animateToPage(
                    _pages.length - 1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    color: Color(0xFF92A6CD),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPage(OnboardingModel data) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      color: Colors.white,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),

            Lottie.asset(
              data.lottieAsset,
              width: 280,
              height: 280,
              fit: BoxFit.contain,
            ),

            const Spacer(flex: 1),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                data.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.merienda(
                  color: Color(0xFF5B5A5A),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: MetalText(text: data.description, textAlign: TextAlign.center,),
            ),

            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: _currentPage == index ? 15 : 10,
      height: _currentPage == index ? 15 : 10,
      decoration: BoxDecoration(
        color: _currentPage == index ? Color(0xFF92A6CD) : Color(0xFFCCDDFB),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildButton() {
    final isLastPage = _currentPage == _pages.length - 1;

    return Align(
      alignment: Alignment.bottomRight,
      child: GradientButton(
        label: isLastPage ? 'Mulai' : 'Lanjut',
        onTap: () {
          if (isLastPage) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          } else {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        },
      ),
    );
  }
}
