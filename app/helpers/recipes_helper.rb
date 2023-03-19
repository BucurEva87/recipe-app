module RecipesHelper
  def duration_in_hours_and_minutes(minutes)
    hours = minutes / 60
    minutes = minutes % 60

    duration = "#{hours} hour"
    duration << 's' if hours > 1
    duration << " #{minutes} minutes" if minutes.positive?

    duration
  end
end
