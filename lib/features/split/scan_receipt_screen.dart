import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import '../../core/theme/colors.dart';
import '../../core/widgets/bouncy_button.dart';
import 'receipt_items_screen.dart';

class ScanReceiptScreen extends StatefulWidget {
  const ScanReceiptScreen({super.key});

  @override
  State<ScanReceiptScreen> createState() => _ScanReceiptScreenState();
}

class _ScanReceiptScreenState extends State<ScanReceiptScreen> with SingleTickerProviderStateMixin {
  late AnimationController _scanController;
  late Animation<double> _scanAnimation;
  final ImagePicker _picker = ImagePicker();
  final TextRecognizer _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  bool _isProcessing = false;

  static final _priceRegex = RegExp(r'(\d+[\d.,]*)$');
  static final _cleanPriceRegex = RegExp(r'[,.]');

  @override
  void initState() {
    super.initState();
    _scanController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    
    _scanAnimation = Tween<double>(begin: 0.1, end: 0.9).animate(_scanController);
  }

  @override
  void dispose() {
    _scanController.dispose();
    _textRecognizer.close();
    super.dispose();
  }

  Future<void> _processImage(XFile image) async {
    setState(() => _isProcessing = true);
    
    try {
      final inputImage = InputImage.fromFilePath(image.path);
      final recognizedText = await _textRecognizer.processImage(inputImage);
      
      List<Map<String, dynamic>> extractedItems = [];
      
      // Parser Logic
      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          final text = line.text;
          // Look for price-like patterns (numbers at the end)
          final priceMatch = _priceRegex.firstMatch(text.replaceAll(' ', ''));
          
          if (priceMatch != null) {
            final priceStr = priceMatch.group(0)!.replaceAll(_cleanPriceRegex, '');
            final price = double.tryParse(priceStr) ?? 0;
            
            if (price > 1000) { // Filter noise
              final name = text.substring(0, text.length - priceMatch.group(0)!.length).trim();
              if (name.length > 2) {
                extractedItems.add({
                  'name': name,
                  'price': price,
                  'assigned': [],
                });
              }
            }
          }
        }
      }

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ReceiptItemsScreen(
              initialItems: extractedItems.isNotEmpty ? extractedItems : null,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  Future<void> _takePhoto() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      await _processImage(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background "Receipt" Preview (Static since we pick an image)
          Center(
            child: Container(
              width: 280,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white24),
              ),
              child: const Icon(Icons.receipt_long, size: 100, color: Colors.white12),
            ),
          ),

          // Scanning Line (Only visible when processing)
          if (_isProcessing)
            AnimatedBuilder(
              animation: _scanAnimation,
              builder: (context, child) {
                return Positioned(
                  top: (MediaQuery.of(context).size.height * 0.5 - 200) + (400 * _scanAnimation.value),
                  left: MediaQuery.of(context).size.width * 0.5 - 140,
                  child: Container(
                    width: 280,
                    height: 2,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.8),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

          // HUD
          SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                    const Text(
                      'AI Receipt Scanner',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
                const Spacer(),
                if (_isProcessing)
                  const Text(
                    'AI sedang memproses struk kamu...',
                    style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 18),
                  )
                else ...[
                  const Text(
                    'Posisikan struk dalam kotak',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'AI akan membagi barang secara otomatis.',
                    style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                  ),
                ],
                const SizedBox(height: 40),
                
                // Capture Button
                Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: BouncyButton(
                    onTap: _isProcessing ? null : _takePhoto,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12, width: 2),
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            _isProcessing ? Icons.hourglass_empty : Icons.camera_alt, 
                            color: AppColors.primary, 
                            size: 32
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
