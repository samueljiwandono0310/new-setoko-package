class ChatUserArgument {
  final String userId;
  final String? nickname;
  final String? accessToken;

  ChatUserArgument({
    required this.userId,
    this.nickname,
    this.accessToken,
  });
}
