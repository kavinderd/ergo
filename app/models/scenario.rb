class Scenario

  def self.create(attrs)
    trigger = Trigger.create!(trigger_args(attrs))
  end

  private

  def self.trigger_args(attrs)
    { event_name: attrs.fetch(:event_name), user: attrs.fetch(:user), frequency: attrs.fetch(:frequency), threshold: attrs.fetch(:threshold), action: attrs.fetch(:action) }
  end
end
