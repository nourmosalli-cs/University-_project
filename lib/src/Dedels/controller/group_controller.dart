import 'package:expenses_graduation_project/src/Dedels/model/friends_model.dart';
import 'package:expenses_graduation_project/src/Dedels/model/group_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/group_types_model.dart';

class GroupController {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<List<Group>> fetchGroups() async {
    final response = await supabase.from('groups').select('*, group_types(*)');

    if (response.isNotEmpty) {
      return response.map<Group>((item) => Group.fromJson(item)).toList();
    } else {
      return [];
    }
  }

  Future<List<Friends>> fetchfriends() async {
    final response = await supabase
        .from('friends')
        .select()
        .eq("owner_id", supabase.auth.currentUser!.id)
        .isFilter("user_id", null);

    if (response.isNotEmpty) {
      return response.map<Friends>((item) => Friends.fromJson(item)).toList();
    } else {
      return [];
    }
  }

  Future<List<GroupType>> fetchGroupTypes() async {
    final response = await supabase
        .from('group_types')
        .select()
        .eq("owner_id", supabase.auth.currentUser!.id);

    if (response.isNotEmpty) {
      return response
          .map<GroupType>((item) => GroupType.fromJson(item))
          .toList();
    } else {
      return [];
    }
  }

  Future<List<GroupType>> fetchBillTypes() async {
    final response = await supabase
        .from('bill_categories')
        .select()
        .eq("owner_id", supabase.auth.currentUser!.id);

    if (response.isNotEmpty) {
      return response
          .map<GroupType>((item) => GroupType.fromJson(item))
          .toList();
    } else {
      return [];
    }
  }

  Future<void> deleteGroup(int id) async {
    try {
      await supabase.from('groups').delete().eq('id', id);
    } catch (e) {
      throw Exception('Failed to delete group');
    }
  }

  Future<void> deletefriends(int id) async {
    try {
      await supabase.from('friends').delete().eq('id', id);
    } catch (e) {
      throw Exception('Failed to delete group');
    }
  }

  Future<void> deleteGroupTypes(int id) async {
    try {
      await supabase.from('group_types').delete().eq('id', id);
    } catch (e) {
      throw Exception('Failed to delete group');
    }
  }

  Future<void> deleteBillTypes(int id) async {
    try {
      await supabase.from('bill_categories').delete().eq('id', id);
    } catch (e) {
      throw Exception('Failed to delete group');
    }
  }
}
