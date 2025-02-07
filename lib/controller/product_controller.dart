import 'dart:developer';

import 'package:category_product_listing/model/product_model.dart';
import 'package:category_product_listing/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var categories = <Category>[].obs;
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var selectedCategoryId = "null".obs;
  var currentPage = 1.obs;
  var totalPages = 1.obs;

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        fetchMoreProducts();
      }
    });
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

  void fetchMoreProducts() {
    isLoadingMore.value = true;

    if (currentPage.value < totalPages.value) {
      currentPage.value += 1;
      fetchProducts();
    }
    isLoadingMore.value = false;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
