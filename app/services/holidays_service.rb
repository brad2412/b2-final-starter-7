class HolidaysService
  def holidays
    response = connection.get("/api/v3/PublicHolidays/2023/US")
    holidays_data = JSON.parse(response.body)
    today = Date.today
    # Filter out holidays that have already passed and select the next 3 holidays
    upcoming_holidays = holidays_data.select { |holiday_data| Date.parse(holiday_data["date"]) >= today }.first(3)
    upcoming_holidays
  end

  def connection
    Faraday.new(url: "https://date.nager.at")
  end
end