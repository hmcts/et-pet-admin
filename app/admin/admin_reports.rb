ActiveAdmin.register_page 'Reports' do
  content do
    a href: admin_et3_reconciliation_report_path(id: :query) do
      "ET3 Reconciliation Report"
    end
  end
end
