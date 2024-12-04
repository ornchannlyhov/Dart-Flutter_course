enum PaymentStatus {
  paid ('paid'), 
  notPaid('not pay yet');

final String label;

  const PaymentStatus(this.label);

  @override
  String toString(){
    return label;
  }
}