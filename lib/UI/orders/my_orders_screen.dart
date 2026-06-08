import 'package:ecommerce_openfashion/UI/theme.dart';
import 'package:ecommerce_openfashion/models/Order%20model.dart';
import 'package:ecommerce_openfashion/services/Order%20service.dart';
import 'package:ecommerce_openfashion/widgets/Luxe%20widgets.dart';
import 'package:flutter/material.dart';

import 'order_details_screen.dart';
const Color bg = Color(0xffF5F1EB);
const Color dark = Color(0xff161616);
const Color light = Color(0xff8E8A84);
const Color gold = Color(0xffB79A63);
class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return const Color(0xff2D7A4A);
      case 'shipped':
        return const Color(0xff1B5FA8);
      case 'cancelled':
        return error;
      default:
        return gold;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: const LuxeAppBar(title: 'MY ORDERS'),
      body: StreamBuilder<List<OrderModel>>(
        stream: OrderService.ordersStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(color: gold));
          }

          final orders = snapshot.data!;

          if (orders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.receipt_long_outlined,
                      size: 64, color: light),
                  const SizedBox(height: 16),
                  Text('No Orders Yet',
                      style: AppTextStyles.display(28, color: light)),
                  const SizedBox(height: 8),
                  Text('Your order history will appear here',
                      style: AppTextStyles.body(13, color: light)),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: orders.length,
            itemBuilder: (context, i) {
              final order = orders[i];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OrderDetailsScreen(order: order),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: surface,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xffD6D0C5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ORDER #${order.shortId}',
                                    style: AppTextStyles.label(10,
                                        spacing: 1.5)),
                                const SizedBox(height: 4),
                                Text(order.formattedDate,
                                    style:
                                        AppTextStyles.body(12, color: light)),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: _statusColor(order.status)
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              order.status.toUpperCase(),
                              style: AppTextStyles.label(9,
                                  color: _statusColor(order.status),
                                  spacing: 1),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      const Divider(height: 1, color: Color(0xffD6D0C5)),
                      const SizedBox(height: 14),
                      Text(
                        '${order.items.length} ${order.items.length == 1 ? 'item' : 'items'}  ·  \$${order.total.toStringAsFixed(0)}',
                        style: AppTextStyles.body(13,
                            weight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        order.items.map((e) => e.name).join(', '),
                        style: AppTextStyles.body(12, color: light),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('View Details',
                              style: AppTextStyles.label(10,
                                  spacing: 0.5)),
                          const SizedBox(width: 4),
                          const Icon(Icons.arrow_forward_ios,
                              size: 10, color: gold),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}