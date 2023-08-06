class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, :in_progress, :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def total_revenue_discounted
    total_discount = invoice_items.joins(item: { merchant: :discounts })
                                  .where("discounts.quantity_threshold <= invoice_items.quantity")
                                  .order("discounts.percentage_discount DESC")
                                  .sum("discounts.percentage_discount * invoice_items.unit_price * invoice_items.quantity / 100.0")
  
    total_revenue - total_discount
  end

  def bulk_discount(invoice_item)
    merchant = invoice_item.item.merchant
    merchant.discounts.where("quantity_threshold <= ?", invoice_item.quantity)
                            .order(percentage_discount: :desc)
                            .first
  end

end
