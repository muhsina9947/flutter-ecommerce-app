import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bg   = Color(0xffF5F1EB);
const Color dark = Color(0xff161616);
const Color light= Color(0xff8E8A84);
const Color gold = Color(0xffB79A63);

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [

            // ── TOP BAR ──────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.search, size: 22, color: dark),
                  Text("MAISON LUXE",
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 20, letterSpacing: 4,
                      fontWeight: FontWeight.w600, color: dark)),
                  const Icon(Icons.notifications_none, size: 22, color: dark),
                ],
              ),
            ),

            Divider(height: 1, color: dark.withOpacity(.10)),

            // ── SCROLLABLE BODY ───────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    const SizedBox(height: 28),

                    // ── AVATAR ────────────────────────────────────────────
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 90, height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.white, width: 3),
                            color: const Color(0xffD9CFC4),
                          ),
                          child: ClipOval(
                            child: Icon(Icons.person,
                                size: 52, color: light),
                          ),
                        ),
                        Positioned(
                          bottom: 0, right: 0,
                          child: Container(
                            width: 26, height: 26,
                            decoration: BoxDecoration(
                              color: gold,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.white, width: 2),
                            ),
                            child: const Icon(Icons.edit,
                                size: 13, color: Colors.white),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // ── NAME ──────────────────────────────────────────────
                    Text("Julianne Moore",
                      style: GoogleFonts.cormorantGaramond(
                          fontSize: 28, color: dark)),

                    const SizedBox(height: 4),

                    Text("julianne.m@maisonluxe.com",
                      style: GoogleFonts.inter(
                          fontSize: 12, color: light)),

                    const SizedBox(height: 12),

                    // ── MEMBER BADGE ──────────────────────────────────────
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 7),
                      decoration: BoxDecoration(
                        color: gold,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star,
                              size: 13, color: Colors.white),
                          const SizedBox(width: 6),
                          Text("Maison Black Member",
                            style: GoogleFonts.inter(
                                fontSize: 11, color: Colors.white,
                                fontWeight: FontWeight.w600,
                                letterSpacing: .3)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // ── EDIT PROFILE BUTTON ───────────────────────────────
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: dark.withOpacity(.35)),
                        ),
                        child: Text("EDIT PROFILE",
                          style: GoogleFonts.inter(
                              fontSize: 10, letterSpacing: 2,
                              color: dark, fontWeight: FontWeight.w600)),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ── MAISON BLACK CARD ─────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(22),
                        color: dark,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("MAISON\nBLACK",
                              style: GoogleFonts.cormorantGaramond(
                                fontSize: 32, height: 1.05,
                                color: gold,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 14),
                            ...[
                              "Exclusive Access",
                              "Priority Delivery",
                              "Private Collection Access",
                            ].map((e) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(children: [
                                Container(
                                  width: 5, height: 5,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(e,
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: Colors.white,
                                      height: 1.6)),
                              ]),
                            )),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── QUOTE CARD ────────────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Container(
                        width: double.infinity,
                        height: 160,
                        color: const Color(0xffEFE9E1),
                        child: Row(children: [
                          // quote text side
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(18),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Text("\u201c\u201c",
                                    style: GoogleFonts.cormorantGaramond(
                                        fontSize: 28, color: gold,
                                        height: .5)),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Style is a way to say who you are without having to speak.",
                                    style: GoogleFonts.cormorantGaramond(
                                        fontSize: 15, height: 1.4,
                                        color: dark,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  const SizedBox(height: 8),
                                  Text("— RACHEL ZOE",
                                    style: GoogleFonts.inter(
                                        fontSize: 8, letterSpacing: 2,
                                        color: gold)),
                                ],
                              ),
                            ),
                          ),
                          // image side
                          Expanded(
                            flex: 4,
                            child: SizedBox(
                              height: double.infinity,
                              child: Image.asset(
                                "IMAGES/Silk Scarf.png",
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color: const Color(0xffD9CFC4)),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ── MENU ITEMS ────────────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        children: [
                          _menuItem(Icons.shopping_bag_outlined,
                              "My Orders",     () {}),
                          _menuItem(Icons.favorite_border,
                              "Wishlist",      () {}),
                          _menuItem(Icons.local_mall_outlined,
                              "Shopping Bag",  () {}),
                          _menuItem(Icons.location_on_outlined,
                              "Saved Addresses", () {}),
                          _menuItem(Icons.credit_card_outlined,
                              "Payment Methods", () {}),
                          _menuItem(Icons.visibility_outlined,
                              "Recently Viewed", () {}),
                          _menuItem(Icons.settings_outlined,
                              "Settings",      () {}),
                          _menuItem(Icons.headset_mic_outlined,
                              "Customer Support", () {}),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── LOGOUT ────────────────────────────────────────────
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.logout,
                              size: 18, color: Colors.redAccent),
                          const SizedBox(width: 8),
                          Text("Logout",
                            style: GoogleFonts.inter(
                                fontSize: 13, color: Colors.redAccent,
                                fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ── PROMO BANNER ──────────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Stack(children: [
                        // background image
                        Container(
                          height: 200,
                          width: double.infinity,
                          color: const Color(0xff3A2E28),
                          child: Image.asset(
                            "IMAGES/103106276.webp",
                            fit: BoxFit.cover,
                            color: Colors.black.withOpacity(.45),
                            colorBlendMode: BlendMode.darken,
                            errorBuilder: (_, __, ___) => Container(
                              color: const Color(0xff3A2E28)),
                          ),
                        ),
                        // overlay text
                        Positioned.fill(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("AUTUMN / WINTER 24",
                                  style: GoogleFonts.inter(
                                      fontSize: 8, letterSpacing: 3,
                                      color: Colors.white.withOpacity(.8))),
                                const SizedBox(height: 8),
                                Text("Luxury Paris\nCollection",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.cormorantGaramond(
                                      fontSize: 34, height: 1.1,
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic)),
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22, vertical: 10),
                                  color: Colors.white,
                                  child: Text("EXPLORE NOW",
                                    style: GoogleFonts.inter(
                                        fontSize: 9, letterSpacing: 2,
                                        color: dark,
                                        fontWeight: FontWeight.w700)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── menu row ────────────────────────────────────────────────────────────
  Widget _menuItem(IconData icon, String label, VoidCallback onTap) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(children: [
              Icon(icon, size: 20, color: dark),
              const SizedBox(width: 16),
              Expanded(
                child: Text(label,
                  style: GoogleFonts.inter(
                      fontSize: 13, color: dark)),
              ),
              Icon(Icons.chevron_right,
                  size: 20, color: dark.withOpacity(.4)),
            ]),
          ),
        ),
        Divider(height: 1, color: dark.withOpacity(.08)),
      ],
    );
  }
}