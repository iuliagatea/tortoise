class Appointment < ActiveRecord::Base
  belongs_to :service
  belongs_to :customer
  belongs_to :partner

  validates_presence_of :service, :customer, :partner, :from, :to

  before_save :to_date_after_from_date?
  before_save :same_partner_id?

  def to_date_after_from_date?
    if to < from
      errors.add :to, "date must be after from date"
    end
  end

  def same_partner_id?
    if partner_id != service.user_id
      errors.add :service, "must belong to selected partner"
    end
  end
end
