ActiveAdmin.register Admin::AcasCertificate, as: 'Acas Certificates' do
  menu parent: 'Acas'

  show do
    div class: 'active-admin-acas search-results-search' do
      active_admin_form_for('', url: admin_acas_certificate_url(id: 'search'), method: :get) do |f|
        f.inputs 'ACAS Search' do
          f.input :number, label: 'Please enter your ACAS Early Conciliation Certificate number', input_html: { value: params[:number] }
        end
        f.actions do
          f.action :submit, label: 'Search'
        end
      end
    end

    div class: 'search-results' do
      attributes_table title: 'Respondent' do
        row :date_of_receipt
        row :date_of_issue
        row('Difference') do |r|
          if r.date_of_issue.present? && r.date_of_receipt.present?
            "#{(r.date_of_issue.to_date - r.date_of_receipt.to_date).to_i} days"
          else
            'NA'
          end
        end
        row :method_of_issue
        row :respondent_name
      end
      attributes_table title: 'Lead Claimant' do
        row :claimant_name
      end
    end
  end
  controller do
    def find_resource
      ::Admin::AcasCertificate.find(params[:number], current_admin_user: current_admin_user)
    end

    def apply_decorations(resource)
      resource
    end

    def apply_sorting(collection)
      collection
    end

    def apply_filtering(collection)
      collection.query = params[:id]
      collection
    end

    def apply_scoping(collection)
      collection
    end

    def apply_includes(collection)
      collection
    end

    def apply_pagination(collection)
      collection
      collection.all
    end
  end
end
