class Shipments
  require 'csv'


  def destination_info(destination)
    @trip_count = 0
    @destination_revenue = 0
    CSV.foreach("planet_express_logs.csv", headers: true) do |row|
      if row['Destination'] == destination
        @trip_count += 1
        each_shipment_revenue = row['Money'].to_i * row['Crates'].to_i
        @destination_revenue += each_shipment_revenue
        @destination_bonus = @destination_revenue.to_i * 0.05
        if row['Destination'] == 'Earth'
          @pilot = 'Fry'
        elsif row['Destination'] == 'Mars'
          @pilot = 'Amy'
        elsif row['Destination'] == 'Bender'
          @pilot = 'Bender'
        else
          @pilot = 'Leela'
        end
      end
    end

    destination
    @pilot
    @trip_count.to_i
    @destination_revenue.to_i
    @destination_bonus.to_i
    CSV.open("planet_express_report.csv", "a") do |csv|
      csv << ["#{destination}", "#{@pilot}", "#{@trip_count}", "#{@destination_revenue}", "#{@destination_bonus}"]
    end
  end

  def write_headers_to_csv
    CSV.open("planet_express_report.csv", "wb") do |csv|
      csv << ["Destination", "Pilot", "Trip Count", "Destination Revenue", "Destination Bonus"]
    end
  end
end


s = Shipments.new
s.write_headers_to_csv
s.destination_info 'Earth'
s.destination_info 'Moon'
s.destination_info 'Mars'
s.destination_info 'Uranus'
s.destination_info 'Jupiter'
s.destination_info 'Pluto'
s.destination_info 'Saturn'
s.destination_info 'Mercury'
