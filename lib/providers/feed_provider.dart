import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedItem {
  final String sender;
  final String receiver;
  final String note;
  final String time;

  FeedItem({
    required this.sender,
    required this.receiver,
    required this.note,
    required this.time,
  });
}

class FeedNotifier extends StateNotifier<List<FeedItem>> {
  FeedNotifier() : super([
    FeedItem(sender: 'Hanson', receiver: 'Kiro', note: '🍕 Dinner at PIK', time: '2h ago'),
    FeedItem(sender: 'Alya', receiver: 'Budi', note: '☕️ Coffee catchup', time: '5h ago'),
    FeedItem(sender: 'Kiro', receiver: 'Hanson', note: '🎟️ Cinema tickets', time: '1d ago'),
  ]);

  void addTransaction(String receiver, String note) {
    state = [
      FeedItem(sender: 'You', receiver: receiver, note: note, time: 'Just now'),
      ...state,
    ];
  }
}

final feedProvider = StateNotifierProvider<FeedNotifier, List<FeedItem>>((ref) {
  return FeedNotifier();
});
