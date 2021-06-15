class PaginationModel {
  final int limit;
  final int offset;
  final int total;

  PaginationModel(
      {required this.limit, required this.offset, required this.total});
}
