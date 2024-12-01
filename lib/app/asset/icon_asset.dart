enum IconAsset implements Comparable<IconAsset> {
  loading(name: 'assets/images/icons/member_easy_icon.png');

  const IconAsset({
    required this.name,
  });

  final String name;

  @override
  int compareTo(IconAsset other) {
    return name.compareTo(other.name);
  }
}
