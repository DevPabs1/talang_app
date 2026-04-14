import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';

class LivenessCheckScreen extends StatefulWidget {
  const LivenessCheckScreen({super.key});

  @override
  State<LivenessCheckScreen> createState() => _LivenessCheckScreenState();
}

class _LivenessCheckScreenState extends State<LivenessCheckScreen> with SingleTickerProviderStateMixin {
  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _startDetection();
  }

  void _startDetection() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) _progressController.forward();
    
    await Future.delayed(const Duration(seconds: 4));
    if (mounted) {
       Navigator.pushReplacementNamed(context, '/privacy');
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: AppColors.deepZinc),
                  ),
                  const Spacer(),
                  const Text(
                    'Liveness Check',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const Spacer(),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Posisikan Wajah Kamu',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.deepZinc),
            ),
            const SizedBox(height: 8),
            const Text(
              'Kedipkan mata kamu atau tengok ke samping.',
              style: TextStyle(color: AppColors.brandGray),
            ),
            
            const Spacer(),
            
            // Face Circle
            Stack(
              alignment: Alignment.center,
              children: [
                // Animated Progress Ring
                SizedBox(
                  width: 280,
                  height: 280,
                  child: AnimatedBuilder(
                    animation: _progressController,
                    builder: (context, child) {
                      return CircularProgressIndicator(
                        value: _progressController.value,
                        strokeWidth: 8,
                        backgroundColor: AppColors.background,
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                      );
                    },
                  ),
                ),
                
                // Mask with Circle Cutout
                Container(
                  width: 260,
                  height: 260,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.background,
                  ),
                  child: ClipOval(
                    child: Container(
                      color: Colors.grey[900],
                      child: const Center(
                        child: Icon(Icons.face_retouching_natural, size: 100, color: Colors.white12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            const Spacer(),
            
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: 0.6,
                    backgroundColor: AppColors.background,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Verifikasi Sedang Berjalan...',
                    style: TextStyle(color: AppColors.brandGray, fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
