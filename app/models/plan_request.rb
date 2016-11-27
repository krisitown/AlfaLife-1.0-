class PlanRequest < ActiveRecord::Base
    validates :gender, presence: true
    validates :want_to, presence: true
    validates :unit, presence: true
    validates :user_id, presence: true

    validate :age_cannot_be_negative, :weight_validation, :height_validation

    def age_cannot_be_negative
        if age.present? && age <= 5
            errors.add(:age, "is invalid.")
        end
    end

    def weight_validation
        if weight.present? && (weight < 10 || weight > 400)
            errors.add(:weight, "is invalid.")
        end
    end

    def height_validation
        if height.present? && height <= 0
            errors.add(:height, "cannot be negative.")
        end
    end
end
