import 'package:expenses_graduation_project/src/bills/model/bill_categories_model.dart';
import 'package:expenses_graduation_project/src/bills/model/bill_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BillController {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<List<Bill>> fetchBills() async {
    final response =
        await supabase.from('bills').select('*, bill_categories(*)');

    if (response.isNotEmpty) {
      return response.map<Bill>((item) => Bill.fromJson(item)).toList();
    } else {
      return [];
    }
  }

  Future<List<BillCategory>> fetchBillsCategories() async {
    final response = await supabase
        .from('bill_categories')
        .select()
        .eq('owner_id', supabase.auth.currentUser!.id);

    if (response.isNotEmpty) {
      return response
          .map<BillCategory>((item) => BillCategory.fromJson(item))
          .toList();
    } else {
      return [];
    }
  }

  Future<void> deleteBill(int id) async {
    try {
      await supabase.from('bills').delete().eq('id', id);
    } catch (e) {
      throw Exception('Failed to delete group');
    }
  }
}
