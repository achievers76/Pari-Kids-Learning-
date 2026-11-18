import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SamsadKidsHomeScreen extends StatefulWidget {
  const SamsadKidsHomeScreen({super.key});

  @override
  State<SamsadKidsHomeScreen> createState() => _SamsadKidsHomeScreenState();
}

class _SamsadKidsHomeScreenState extends State<SamsadKidsHomeScreen> {
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  Future<void> _initTts() async {
    await _flutterTts.setLanguage("hi-IN");
    await _flutterTts.setPitch(1.2);
    await _flutterTts.setSpeechRate(0.45);
  }

  Future<void> _speakAndNavigate(String message, String className) async {
    await _flutterTts.stop();
    await _flutterTts.speak(message);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFF0D47A1),
      ),
    );
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF9C4),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 950),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.orange.shade300),
                    ),
                    child: Text(
                      "Pari Kids",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.deepOrange.shade800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Namaste Beta! Aao Seekhte Hain",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: isTablet ? 34 : 25,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0D47A1),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: isTablet
                        ? Row(children: _buildClassCards(isTablet))
                        : Column(children: _buildClassCards(isTablet)),
                  ),
                  const SizedBox(height: 16),
                  TextButton.icon(
                    onPressed: () {
                      _showParentsDialog(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.9),
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: Colors.blue.shade200, width: 1.5),
                      ),
                    ),
                    icon: const Icon(Icons.lock_outline, size: 18, color: Color(0xFF0D47A1)),
                    label: Text(
                      "Mummy Papa Ke Liye",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0D47A1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildClassCards(bool isTablet) {
    final cardsData = [
      {
        "title": "NURSERY",
        "subtitle": "3-4 Saal Ke Liye",
        "color": const Color(0xFFFFD54F),
        "textColor": const Color(0xFF4E342E),
        "lottie": "assets/lottie/apple.json",
        "fallbackIcon": Icons.apple_rounded,
        "voice": "Chalo Nursery me chalte hain",
      },
      {
        "title": "LKG",
        "subtitle": "4-5 Saal Ke Liye",
        "color": const Color(0xFF81C784),
        "textColor": const Color(0xFF1B5E20),
        "lottie": "assets/lottie/ball.json",
        "fallbackIcon": Icons.sports_soccer_rounded,
        "voice": "Chalo L K G me chalte hain",
      },
      {
        "title": "UKG",
        "subtitle": "5-6 Saal Ke Liye",
        "color": const Color(0xFF64B5F6),
        "textColor": const Color(0xFF0D47A1),
        "lottie": "assets/lottie/lion.json",
        "fallbackIcon": Icons.pets_rounded,
        "voice": "Chalo U K G me chalte hain",
      },
    ];

    return cardsData.map((data) {
      return Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: isTablet ? 16.0 : 8.0,
            horizontal: isTablet ? 10.0 : 0.0,
          ),
          child: InkWell(
            onTap: () => _speakAndNavigate(
              data["voice"] as String,
              data["title"] as String,
            ),
            borderRadius: BorderRadius.circular(24),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: data["color"] as Color,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: isTablet
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _cardContent(data, isTablet),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _cardContent(data, isTablet),
                    ),
            ),
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _cardContent(Map<String, dynamic> data, bool isTablet) {
    return [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:
            isTablet ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            data["title"],
            style: GoogleFonts.poppins(
              fontSize: isTablet ? 28 : 24,
              fontWeight: FontWeight.w800,
              color: data["textColor"],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            data["subtitle"],
            style: GoogleFonts.poppins(
              fontSize: isTablet ? 16 : 15,
              fontWeight: FontWeight.w600,
              color: (data["textColor"] as Color).withOpacity(0.85),
            ),
          ),
        ],
      ),
      if (isTablet) const SizedBox(height: 16),
      SizedBox(
        height: isTablet ? 125 : 85,
        width: isTablet ? 125 : 85,
        child: Lottie.asset(
          data["lottie"],
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              data["fallbackIcon"] as IconData,
              size: isTablet ? 80 : 60,
              color: data["textColor"],
            );
          },
        ),
      ),
    ];
  }

  void _showParentsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Parents Corner",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Text(
          "Yeh section sirf Mummy Papa ke liye hai.",
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Band Karein", style: GoogleFonts.poppins()),
          ),
        ],
      ),
    );
  }
}
