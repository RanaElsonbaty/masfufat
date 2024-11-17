class PaymentModel{
  final String invoiceId;
  final String invoiceReference;
  final String paymentMethod;
  final String paymentAmount;
  final String paymentReason;
  final String? orderId;
  PaymentModel(this.invoiceId, this.invoiceReference, this.paymentMethod, this.paymentAmount, this.paymentReason, this.orderId);
}