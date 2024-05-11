class ChangeIndexState {
  final int index;

  ChangeIndexState({this.index = 0});

  ChangeIndexState copyWith({
    int? index,
  }) =>
      ChangeIndexState(
        index: index ?? this.index,
      );
}
