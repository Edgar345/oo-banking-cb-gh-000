class Transfer
  attr_accessor :sender, :receiver, :amount, :status

  def initialize sender, receiver, amount
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    self.sender.valid? && self.receiver.valid?
  end

  def execute_transaction
    if self.sender.valid? && self.receiver.valid?
      if self.status != "complete"
        self.sender.deposit(-self.amount)
        self.receiver.deposit(self.amount)
        self.status = "complete"
      end
    end

    if !self.sender.valid? || !self.receiver.valid?
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status != "reversed"
      self.sender.deposit(self.amount)
      self.receiver.deposit(-self.amount)
      self.status = "reversed"
    end
  end
end
