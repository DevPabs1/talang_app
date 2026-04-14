import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Daftar Akun Baru'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Text(
                  'Mulai langkah pertama\nkeuangan sosial kamu.',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 24),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Lengkap',
                    hintText: 'Sesuai KTP',
                    prefixIcon: Icon(Icons.person_outline, size: 20),
                  ),
                  validator: (value) => (value == null || value.isEmpty) ? 'Masukkan nama lengkap' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Nomor Handphone',
                    hintText: '812xxxxxx',
                    prefixIcon: Icon(Icons.phone_iphone_outlined, size: 20),
                    prefixText: '+62 ',
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) => (value == null || value.isEmpty) ? 'Masukkan nomor HP' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Kode Referral (Opsional)',
                    prefixIcon: Icon(Icons.card_giftcard_outlined, size: 20),
                  ),
                ),
                const SizedBox(height: 80), // Replaced Spacer
                Text(
                  'Dengan mendaftar, kamu menyetujui Syarat & Ketentuan dan Kebijakan Privasi Talang.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushNamed(context, '/ekyc');
                    }
                  },
                  child: const Text('Daftar Sekarang'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
