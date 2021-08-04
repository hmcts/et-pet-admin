ActiveAdmin.register Et3ReconciliationReport, as: 'ET3 Reconciliation Report' do
  menu parent: 'Reports',
       url: -> { admin_et3_reconciliation_report_path(id: :query) }
       permit_params :start_date, :end_date
  actions :show, :index
     
  show do
    active_admin_form_for(resource, url: admin_et3_reconciliation_report_url, method: :get) do |f|
      columns do
        column max_width: '400px' do
          f.inputs 'Date range' do
            f.input :start_date, label: 'Start date', as: :datepicker
            f.input :end_date, label: 'End date', as: :datepicker
  
          end
          f.actions do
            f.action :submit, label: 'Search'
          end
              
        end
      end
    end

    if resource.loaded?
      panel 'Results' do
        table_for resource do
          column :start_date, ->(r) { r.start_date.strftime('%d/%m/%Y') }
          column :end_date, ->(r) { r.end_date.strftime('%d/%m/%Y') }
          column 'Total ET1 Submitted', :total_claim_count
          column 'ET3 Response For ET1', :response_count
          column 'Total ET3 Responses', :total_response_count
          column 'Uptake', -> (r) { "#{(r.uptake * 100).to_i}%" }
        end        
      end  
    end
  end

  controller do
    def find_resource
      if params.key?(:et3_reconciliation_report)
        report = Et3ReconciliationReport.new(permitted_params[:et3_reconciliation_report])
        if report.valid?
          report.load
        else
          report
        end
      else
        Et3ReconciliationReport.new

      end
    end

    def index
      redirect_to action: :show, id: :query
    end
  end
end
