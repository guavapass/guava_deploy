module ApplicationHelper
  def duration_hms(obj, format = '%H:%M:%S')
    seconds = if obj.is_a?(Visit)
                (obj.end_at - obj.start_at).to_i
              else
                obj
              end

    Time.at(seconds).utc.strftime(format)
  end
end
