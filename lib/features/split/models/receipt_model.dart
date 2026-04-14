class ReceiptItem {
  final String id;
  final String name;
  final double price;
  final List<String> assignedFriendIds;

  ReceiptItem({
    required this.id,
    required this.name,
    required this.price,
    this.assignedFriendIds = const [],
  });

  ReceiptItem copyWith({List<String>? assignedFriendIds}) {
    return ReceiptItem(
      id: id,
      name: name,
      price: price,
      assignedFriendIds: assignedFriendIds ?? this.assignedFriendIds,
    );
  }
}

class Friend {
  final String id;
  final String name;
  final String avatarUrl;

  Friend({required this.id, required this.name, required this.avatarUrl});
}

// Mock Friends List
final mockFriends = [
  Friend(id: '1', name: 'Budi Santoso', avatarUrl: 'BS'),
  Friend(id: '2', name: 'Ani Wijaya', avatarUrl: 'AW'),
  Friend(id: '3', name: 'Hanson', avatarUrl: 'H'),
  Friend(id: '4', name: 'Siti Aminah', avatarUrl: 'SA'),
];
