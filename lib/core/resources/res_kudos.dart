import 'package:equatable/equatable.dart';

class ResKudos {
  static const ICON_8 = KudoSite('Icon8', 'https://icons8.com');

  static const List<KudoSite> all = const [
    ICON_8,
  ];
}

class KudoSite extends Equatable {
  final String name;
  final String site;

  const KudoSite(this.name, this.site);

  @override
  List<Object> get props => [name, site];
}
