import 'package:ecommerce_openfashion/UI/theme.dart';
import 'package:ecommerce_openfashion/models/Address%20model%20.dart';
import 'package:ecommerce_openfashion/services/Address%20service.dart';
import 'package:ecommerce_openfashion/widgets/Luxe%20widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
const Color bg = Color(0xffF5F1EB);
const Color dark = Color(0xff161616);
const Color light = Color(0xff8E8A84);
const Color gold = Color(0xffB79A63);
class AddEditAddressScreen extends StatefulWidget {
  final AddressModel? existingAddress;

  const AddEditAddressScreen({super.key, this.existingAddress});

  @override
  State<AddEditAddressScreen> createState() => _AddEditAddressScreenState();
}

class _AddEditAddressScreenState extends State<AddEditAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _fullName;
  late final TextEditingController _phone;
  late final TextEditingController _address;
  late final TextEditingController _city;
  late final TextEditingController _state;
  late final TextEditingController _pincode;
  bool _isDefault = false;
  bool _loading = false;

  bool get _isEditing => widget.existingAddress != null;

  @override
  void initState() {
    super.initState();
    final a = widget.existingAddress;
    _fullName = TextEditingController(text: a?.fullName);
    _phone = TextEditingController(text: a?.phone);
    _address = TextEditingController(text: a?.address);
    _city = TextEditingController(text: a?.city);
    _state = TextEditingController(text: a?.state);
    _pincode = TextEditingController(text: a?.pincode);
    _isDefault = a?.isDefault ?? false;
  }

  @override
  void dispose() {
    _fullName.dispose();
    _phone.dispose();
    _address.dispose();
    _city.dispose();
    _state.dispose();
    _pincode.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    try {
      final model = AddressModel(
        id: widget.existingAddress?.id ?? '',
        fullName: _fullName.text.trim(),
        phone: _phone.text.trim(),
        address: _address.text.trim(),
        city: _city.text.trim(),
        state: _state.text.trim(),
        pincode: _pincode.text.trim(),
        isDefault: _isDefault,
      );

      if (_isEditing) {
        await AddressService.updateAddress(model);
      } else {
        await AddressService.addAddress(model);
      }

      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}',
              style: AppTextStyles.body(12, color: Colors.white)),
          backgroundColor: error,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar:
          LuxeAppBar(title: _isEditing ? 'EDIT ADDRESS' : 'NEW ADDRESS'),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const LuxeSectionLabel('DELIVERY INFORMATION'),
            const SizedBox(height: 24),
            _buildField(
              controller: _fullName,
              label: 'Full Name',
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 14),
            _buildField(
              controller: _phone,
              label: 'Phone Number',
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Required';
                if (v.trim().length < 10) return 'Enter valid phone number';
                return null;
              },
            ),
            const SizedBox(height: 14),
            _buildField(
              controller: _address,
              label: 'Address (House No, Street)',
              maxLines: 2,
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _buildField(
                    controller: _city,
                    label: 'City',
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'Required' : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildField(
                    controller: _state,
                    label: 'State',
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'Required' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _buildField(
              controller: _pincode,
              label: 'Pincode',
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Required';
                if (v.trim().length != 6) return 'Enter 6-digit pincode';
                return null;
              },
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => setState(() => _isDefault = !_isDefault),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: _isDefault ? gold : const Color(0xffD6D0C5),
                    width: _isDefault ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: _isDefault ? gold : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: _isDefault ? gold : light,
                          width: 1.5,
                        ),
                      ),
                      child: _isDefault
                          ? const Icon(Icons.check,
                              size: 14, color: Colors.white)
                          : null,
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Set as default address',
                            style: AppTextStyles.body(13,
                                weight: FontWeight.w600)),
                        Text('Used automatically at checkout',
                            style: AppTextStyles.body(11, color: light)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            LuxeButton(
              label: _isEditing ? 'SAVE CHANGES' : 'ADD ADDRESS',
              onPressed: _save,
              isLoading: _loading,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      style: AppTextStyles.body(14),
      decoration: luxeInputDecoration(label),
      validator: validator,
    );
  }
}