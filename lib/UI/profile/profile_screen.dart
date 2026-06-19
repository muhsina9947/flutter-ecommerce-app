import 'package:ecommerce_openfashion/UI/LoginScreen.dart';
import 'package:ecommerce_openfashion/UI/Notification/notification_screen.dart';
import 'package:ecommerce_openfashion/UI/cart_screen.dart';
import 'package:ecommerce_openfashion/UI/theme.dart';
import 'package:ecommerce_openfashion/UI/wishlist_screen.dart';
import 'package:ecommerce_openfashion/widgets/Luxe%20widgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/auth_service.dart';

import '../address/address_screen.dart';
import '../orders/my_orders_screen.dart';

const Color bg = Color(0xffF5F1EB);
const Color dark = Color(0xff161616);
const Color light = Color(0xff8E8A84);
const Color gold = Color(0xffB79A63);

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final name = user?.displayName ?? 'Maison Member';
    final email = user?.email ?? '';
    final initials = name.isNotEmpty
        ? name.trim().split(' ').map((e) => e[0]).take(2).join()
        : 'ML';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const LuxeAppBar(title: 'PROFILE'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Avatar + info
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xff161616)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xff161616)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      initials.toUpperCase(),
                      style: AppTextStyles.display(26, color: gold),
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: AppTextStyles.display(26)),
                      const SizedBox(height: 4),
                      Text(email, style: AppTextStyles.body(12, color: light)),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xff161616)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          'MAISON MEMBER',
                          style: AppTextStyles.label(8, spacing: 1.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),
          const LuxeSectionLabel('ACCOUNT'),
          const SizedBox(height: 16),

          _menuItem(
            context,
            icon: Icons.receipt_long_outlined,
            label: 'My Orders',
            subtitle: 'Track and manage your orders',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MyOrdersScreen()),
            ),
          ),
          _menuItem(
            context,
            icon: Icons.location_on_outlined,
            label: 'Saved Addresses',
            subtitle: 'Manage delivery addresses',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddressScreen()),
            ),
          ),
          _menuItem(
            context,
            icon: Icons.favorite_border_outlined,
            label: 'Wishlist',
            subtitle: 'Your curated favourites',
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WishlistScreen()),
              );
            },
          ),
          _menuItem(
            context,
            icon: Icons.favorite_border_outlined,
            label: 'Bag',
            subtitle: 'Your curated favourites',
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),

          const SizedBox(height: 28),
          const LuxeSectionLabel('PREFERENCES'),
          const SizedBox(height: 16),

          _menuItem(
            context,
            icon: Icons.notifications_none_outlined,
            label: 'Notifications',
            subtitle: 'View all updates',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationScreen()),
              );
            },
          ),
          _menuItem(
            context,
            icon: Icons.help_outline_rounded,
            label: 'Help & Support',
            subtitle: 'Get assistance',
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Text(
                    'Help & Support',
                    style: AppTextStyles.display(24),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Need assistance?',
                        style: AppTextStyles.body(14, weight: FontWeight.w600),
                      ),
                      const SizedBox(height: 12),

                      Text(
                        'Email: support@maisonluxe.com',
                        style: AppTextStyles.body(12),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Phone: +91 98765 43210',
                        style: AppTextStyles.body(12),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Working Hours:\nMon - Sat | 9:00 AM - 6:00 PM',
                        style: AppTextStyles.body(12),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'CLOSE',
                        style: AppTextStyles.label(10, color: gold),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 32),

          _logoutButton(context),

          const SizedBox(height: 24),

          Center(
            child: Text(
              'Maison Luxe · Version 1.0.0',
              style: AppTextStyles.body(11, color: light),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _menuItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xff161616)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xff161616)),
              ),
              child: Icon(icon, color: dark, size: 21),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTextStyles.body(14, weight: FontWeight.w600),
                  ),
                  const SizedBox(height: 3),
                  Text(subtitle, style: AppTextStyles.body(11, color: light)),
                ],
              ),
            ),

            const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: light),
          ],
        ),
      ),
    );
  }

  Widget _logoutButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _confirmLogout(context),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xff161616)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.logout_rounded, color: error, size: 20),
            const SizedBox(width: 10),
            Text(
              'Sign Out',
              style: AppTextStyles.body(
                14,
                color: error,
                weight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: bg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Sign Out', style: AppTextStyles.display(28)),
        content: Text(
          'Are you sure you want to sign out of Maison Luxe?',
          style: AppTextStyles.body(13, color: light),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('CANCEL', style: AppTextStyles.label(11, color: light)),
          ),
          TextButton(
            onPressed: () async {
              await AuthService.signOut();

              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
            child: Text(
              'SIGN OUT',
              style: AppTextStyles.label(11, color: error),
            ),
          ),
        ],
      ),
    );
  }
}
