import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_openfashion/models/Address%20model%20.dart';

import 'auth_service.dart';

class AddressService {
  static CollectionReference _addressRef() => FirebaseFirestore.instance
      .collection('users')
      .doc(AuthService.userId)
      .collection('addresses');

  static Stream<List<AddressModel>> addressesStream() {
    return _addressRef().snapshots().map(
          (snap) => snap.docs
              .map((doc) => AddressModel.fromDoc(doc))
              .toList(),
        );
  }

  static Future<void> addAddress(AddressModel address) async {
    if (address.isDefault) await _clearDefaults();
    await _addressRef().add(address.toMap());
  }

  static Future<void> updateAddress(AddressModel address) async {
    if (address.isDefault) await _clearDefaults();
    await _addressRef().doc(address.id).update(address.toMap());
  }

  static Future<void> deleteAddress(String addressId) async {
    await _addressRef().doc(addressId).delete();
  }

  static Future<void> setDefault(String addressId) async {
    await _clearDefaults();
    await _addressRef().doc(addressId).update({'isDefault': true});
  }

  static Future<AddressModel?> getDefaultAddress() async {
    final snap = await _addressRef()
        .where('isDefault', isEqualTo: true)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) return null;
    return AddressModel.fromDoc(snap.docs.first);
  }

  static Future<void> _clearDefaults() async {
    final snap =
        await _addressRef().where('isDefault', isEqualTo: true).get();
    for (final doc in snap.docs) {
      await doc.reference.update({'isDefault': false});
    }
  }
}