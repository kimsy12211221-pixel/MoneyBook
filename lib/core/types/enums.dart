enum TransactionType { expense, income }

enum PaymentMethod {
  cash,
  creditCard;

  String get label => switch (this) {
        PaymentMethod.cash => 'CASH',
        PaymentMethod.creditCard => 'CREDIT CARD',
      };
}

enum BudgetType {
  monthly,
  annualSpecial;

  String get label => switch (this) {
        BudgetType.monthly => 'MONTHLY',
        BudgetType.annualSpecial => 'ANNUAL SPECIAL',
      };
}

enum SpecialCategory {
  travel,
  gift,
  event,
  maintenance,
  medical,
  other;

  String get label => name.toUpperCase();
}

enum UpcomingExpenseRecurrenceType { none, weekly, monthly, custom }

enum WishlistStatus { cooling, ready, waiting, purchased, letGo }
