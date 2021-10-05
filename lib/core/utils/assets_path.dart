class AssetPath {
  AssetPath._constructor();

  static final AssetPath _instance = AssetPath._constructor();

  factory AssetPath() {
    return _instance;
  }

  static const String svgsPath = 'assets/svgs/';
}