require 'aasm'

class Dragon
  include AASM

  aasm do
    state :docking, initial: true
    state :launching, :coasting, :docking, :undocking, :reentering, :splashing

    event :launch do
      transitions from: :docking, to: :launching
    end

    event :deploy do
      transitions from: :launching, to: :coasting
    end

    event :dock do
      transitions from: :coasting, to: :docking
    end

    event :undock do
      transitions from: :docking, to: :undocking
    end

    event :return do
      transitions from: :undocking, to: :reentering
    end

    event :retrieve do
      transitions from: :reentering, to: :splashing
    end
  end
end
