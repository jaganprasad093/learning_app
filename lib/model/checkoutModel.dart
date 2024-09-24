class CheckOutModel {
  String? message;
  int? cartId;
  var totalAmount;
  var discountAmount;
  var grandTotal;
  int? user;
  dynamic promoCode;

  CheckOutModel({
    this.message,
    this.cartId,
    this.totalAmount,
    this.discountAmount,
    this.grandTotal,
    this.user,
    this.promoCode,
  });

  factory CheckOutModel.fromJson(Map<String, dynamic> json) => CheckOutModel(
        message: json["message"],
        cartId: json["cart_id"],
        totalAmount: json["total_amount"],
        discountAmount: json["discount_amount"],
        grandTotal: json["grand_total"],
        user: json["user"],
        promoCode: json["promo_code"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "cart_id": cartId,
        "total_amount": totalAmount,
        "discount_amount": discountAmount,
        "grand_total": grandTotal,
        "user": user,
        "promo_code": promoCode,
      };
}
