import 'package:ecommerce_openfashion/UI/theme.dart';
import 'package:ecommerce_openfashion/models/Address%20model%20.dart';
import 'package:ecommerce_openfashion/services/Address%20service.dart';
import 'package:ecommerce_openfashion/utils/add_edit_address_screen.dart';
import 'package:ecommerce_openfashion/widgets/Luxe%20widgets.dart';
import 'package:ecommerce_openfashion/widgets/address_card.dart';
import 'package:flutter/material.dart';
const Color bg = Color(0xffF5F1EB);
const Color dark = Color(0xff161616);
const Color light = Color(0xff8E8A84);
const Color gold = Color(0xffB79A63);

class AddressScreen extends StatelessWidget {
  /// If [selectMode] is true, tapping an address returns it to the caller.
  final bool selectMode;
  final String? selectedAddressId;

  const AddressScreen({
    super.key,
    this.selectMode = false,
    this.selectedAddressId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: LuxeAppBar(
          title: selectMode ? 'SELECT ADDRESS' : 'SAVED ADDRESSES'),
      body: StreamBuilder<List<AddressModel>>(
        stream: AddressService.addressesStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(color: gold));
          }
          final addresses = snapshot.data!;

          return Column(
            children: [
              Expanded(
                child: addresses.isEmpty
                    ? _emptyState(context)
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        itemCount: addresses.length,
                        itemBuilder: (context, i) {
                          final addr = addresses[i];
                          return AddressCard(
                            address: addr,
                            isSelected: addr.id == selectedAddressId,
                            onTap: selectMode
                                ? () => Navigator.pop(context, addr)
                                : null,
                            onEdit: () => _openAddEdit(context, addr),
                            onDelete: () =>
                                _confirmDelete(context, addr.id),
                            onSetDefault: () =>
                                AddressService.setDefault(addr.id),
                          );
                        },
                      ),
              ),
              Padding(
                padding:
                    const EdgeInsets.fromLTRB(20, 12, 20, 24),
                child: LuxeButton(
                  label: '+ ADD NEW ADDRESS',
                  onPressed: () => _openAddEdit(context, null),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _emptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('No Saved Addresses',
              style: AppTextStyles.display(28, color: light)),
          const SizedBox(height: 12),
          Text('Add your first delivery address',
              style: AppTextStyles.body(13, color: light)),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: LuxeButton(
              label: 'ADD ADDRESS',
              onPressed: () => _openAddEdit(context, null),
            ),
          ),
        ],
      ),
    );
  }

  void _openAddEdit(BuildContext context, AddressModel? existing) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddEditAddressScreen(existingAddress: existing),
      ),
    );
  }

  void _confirmDelete(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: bg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title:
            Text('Remove Address', style: AppTextStyles.display(26)),
        content: Text(
          'This address will be permanently removed.',
          style: AppTextStyles.body(13, color: light),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:
                Text('CANCEL', style: AppTextStyles.label(11, color: light)),
          ),
          TextButton(
            onPressed: () {
              AddressService.deleteAddress(id);
              Navigator.pop(context);
            },
            child: Text('REMOVE',
                style: AppTextStyles.label(11, color: error)),
          ),
        ],
      ),
    );
  }
}