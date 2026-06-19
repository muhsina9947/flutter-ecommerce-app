import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bg = Color(0xffF5F1EB);
const Color dark = Color(0xff161616);
const Color gold = Color(0xffB79A63);

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      backgroundColor: bg,

      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        centerTitle: true,

        title: Text(
          "NOTIFICATIONS",
          style: GoogleFonts.cormorantGaramond(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
            color: dark,
          ),
        ),

        iconTheme: const IconThemeData(color: dark),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('notifications')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.notifications_none, size: 70, color: gold),

                  const SizedBox(height: 20),

                  Text(
                    "No Notifications Yet",
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: dark,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Your updates will appear here",
                    style: GoogleFonts.montserrat(color: Colors.black54),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(18),
            itemCount: docs.length,

            separatorBuilder: (_, __) => const SizedBox(height: 12),

            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;

              return Container(
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),

                  border: Border.all(color: gold.withOpacity(.25)),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),

                      decoration: BoxDecoration(
                        color: gold.withOpacity(.15),
                        shape: BoxShape.circle,
                      ),

                      child: const Icon(
                        Icons.notifications,
                        color: gold,
                        size: 22,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['title'] ?? '',
                            style: GoogleFonts.cormorantGaramond(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: dark,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            data['body'] ?? '',
                            style: GoogleFonts.montserrat(
                              fontSize: 13,
                              height: 1.5,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
