class DomisiliModel {
  final String _prov;
  final String _kab;
  final String _kec;

  DomisiliModel({
    required String prov,
    required String kab,
    required String kec,
  }) : _prov = prov,
       _kab = kab,
       _kec = kec;

  String get prov => _prov;
  String get kab => _kab;
  String get kec => _kec;


  factory DomisiliModel.fromFirestore(Map<String, dynamic> data) {
    return DomisiliModel(
      prov: data['prov'] ?? '-',
      kab: data['kab'] ?? '-',
      kec: data['kec'] ?? '-',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'prov': _prov,
      'kab': _kab,
      'kec': _kec,
    };
  }

  String get fullAlamat {
    return [
      _kec,
      _kab,
      _prov,
    ].where((e) => e.isNotEmpty).join(', ');
  }
}