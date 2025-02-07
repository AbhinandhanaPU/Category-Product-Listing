import 'dart:developer';

import 'package:category_product_listing/model/product_model.dart';
import 'package:category_product_listing/services/api_service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var categories = <Category>[].obs;
  var isLoading = false.obs;
  var selectedCategoryId = "null".obs;
  var currentPage = 1.obs;
  var totalPages = 1.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    isLoading.value = true;

    try {
      var response = await ApiService.fetchProducts(
        selectedCategoryId.value,
        currentPage.value,
      );

      if (response != null && response.data != null) {
        if (currentPage.value == 1) {
          products.assignAll(response.data!.products);
        } else {
          products.addAll(response.data!.products);
        }

        totalPages.value = response.data!.pagination!.totalPages;

        if (categories.isEmpty) {
          categories.assignAll(response.data!.categories);
        }
      }
    } catch (e) {
      log("Error fetching products: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void changeCategory(String categoryId) {
    if (selectedCategoryId.value != categoryId) {
      selectedCategoryId.value = categoryId;
      currentPage.value = 1;
      products.clear();
      fetchProducts();
    }
  }
}
