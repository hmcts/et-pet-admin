namespace :extract_data do
  desc 'Creates a CSV file with answers from pay, pension and benefits sections of the Employment Details section'
  task employment_details: :environment do
    employment_details = []
    Claim.where(updated_at: 1.year.ago..Time.now).each do |record|
      next if record.employment_details.empty?
      employment_details << record.employment_details.symbolize_keys
                                  .slice(:net_pay,
                                         :net_pay_period_type,
                                         :gross_pay,
                                         :gross_pay_period_type,
                                         :enrolled_in_pension_scheme,
                                         :benefit_details)
    end

    CSV.open('tmp/employment_details.csv', 'wb') do |csv|
      keys = employment_details.first.keys
      csv << keys
      employment_details.each do |hash|
        csv << hash.values
      end
    end

  end

end
