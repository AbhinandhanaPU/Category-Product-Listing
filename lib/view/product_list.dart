import 'package:category_product_listing/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListScreen extends StatelessWidget {
  ProductListScreen({super.key});
  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            // Category Tabs
            Obx(
              () {
                return SizedBox(
                  height: 125,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.categories.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 15,
                    ),
                    itemBuilder: (context, index) {
                      final category = controller.categories[index];
                      return GestureDetector(
                        onTap: () => controller.changeCategory(category.id),
                        child: Obx(
                          () => Container(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: 42,
                                  backgroundColor: category.id ==
                                          controller.selectedCategoryId.value
                                      ? Colors.teal
                                      : Colors.grey.shade200,
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors
                                        .white, // Optional: Set a default background color
                                    child: ClipOval(
                                      child: Image.network(
                                        category.image,
                                        fit: BoxFit.cover,
                                        width: 80,
                                        height: 80,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(
                                            Icons.image_not_supported,
                                            color: Colors.grey,
                                            size: 40,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  category.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: category.id ==
                                            controller.selectedCategoryId.value
                                        ? Colors.teal
                                        : Colors.black,
                                  ),
                                ),
                                category.id ==
                                        controller.selectedCategoryId.value
                                    ? Container(
                                        height: 5,
                                        width: 80,
                                        color: Colors.teal,
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),

            // Product List Grid
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return GridView.builder(
                  itemCount: controller.products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.9),
                  itemBuilder: (context, index) {
                    final product = controller.products[index];
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Image.network(
                              product.image.first.url,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: double.infinity,
                                  color: Colors.grey.shade300,
                                  child: const Icon(
                                    Icons.broken_image,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              top: 10,
                              bottom: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '₹${product.price}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.green,
                                  ),
                                ),
                                product.status
                                    ? const Text("Available",
                                        style: TextStyle(color: Colors.blue))
                                    : const Text("Out of Stock",
                                        style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
