import 'package:intl/intl.dart';

class MovimientoContable {
  int? id;
  DateTime? fecha;
  DateTime? fechaCompra;
  String? mesAno;
  String? cuenta;
  String? clienteProveedor;
  String? numeroFactura;
  String? numeroCI;
  String? descripcion;
  DateTime? fechaPago;
  double? ingreso;
  double? egreso;
  double? saldo;
  double? total;
  double? retencion;

  MovimientoContable({
    this.id,
    this.fecha,
    this.fechaCompra,
    this.mesAno,
    this.cuenta,
    this.clienteProveedor,
    this.numeroFactura,
    this.numeroCI,
    this.descripcion,
    this.fechaPago,
    this.ingreso,
    this.egreso,
    this.saldo,
    this.total,
    this.retencion,
  });

  factory MovimientoContable.fromJson(Map<String, dynamic> json) {
    return MovimientoContable(
      id: json['id'],
      fecha: json['fecha'] != null ? DateTime.parse(json['fecha']) : null,
      fechaCompra: json['fechaCompra'] != null ? DateTime.parse(json['fechaCompra']) : null,
      mesAno: json['mesAno'],
      cuenta: json['cuenta'],
      clienteProveedor: json['clienteProveedor'],
      numeroFactura: json['numeroFactura'],
      numeroCI: json['numeroCI'],
      descripcion: json['descripcion'],
      fechaPago: json['fechaPago'] != null ? DateTime.parse(json['fechaPago']) : null,
      ingreso: json['ingreso']?.toDouble(),
      egreso: json['egreso']?.toDouble(),
      saldo: json['saldo']?.toDouble(),
      total: json['total']?.toDouble(),
      retencion: json['retencion']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return {
      'id': id,
      'fecha': fecha != null ? formatter.format(fecha!) : null,
      'fechaCompra': fechaCompra != null ? formatter.format(fechaCompra!) : null,
      'mesAno': mesAno,
      'cuenta': cuenta,
      'clienteProveedor': clienteProveedor,
      'numeroFactura': numeroFactura,
      'numeroCI': numeroCI,
      'descripcion': descripcion,
      'fechaPago': fechaPago != null ? formatter.format(fechaPago!) : null,
      'ingreso': ingreso,
      'egreso': egreso,
      'saldo': saldo,
      'total': total,
      'retencion': retencion,
    };
  }
}